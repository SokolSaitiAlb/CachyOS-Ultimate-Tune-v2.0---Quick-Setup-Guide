#!/bin/bash
if [[ "${1:-}" == "--rollback" ]]; then
# Rollback helper: accepts only root-owned backups created under the fixed directory.
set -euo pipefail
if [[ "$#" -ne 2 || "$1" != "--rollback" ]]; then
    echo "Usage: $0 --rollback /var/lib/cachyos-ultimate-tune/backups/TIMESTAMP" >&2
    exit 2
fi
ROLLBACK_DIR="$2"
BACKUP_ROOT="/var/lib/cachyos-ultimate-tune/backups"
case "$ROLLBACK_DIR" in "$BACKUP_ROOT"/*) ;; *) echo "Refusing path outside $BACKUP_ROOT" >&2; exit 1 ;; esac
if [[ "$(sudo stat -c '%U:%a' "$ROLLBACK_DIR" 2>/dev/null || true)" != "root:700" ||
      "$(sudo stat -c '%U:%a' "$ROLLBACK_DIR/configs.tar" 2>/dev/null || true)" != "root:600" ]]; then
    echo "Backup directory/archive missing or has unsafe ownership/permissions." >&2
    exit 1
fi
for required in existing-targets missing-targets; do
    if [[ "$(sudo stat -c '%U:%a' "$ROLLBACK_DIR/$required" 2>/dev/null || true)" != "root:600" ]]; then
        echo "Missing or unsafe backup manifest: $required" >&2
        exit 1
    fi
done
echo "This restores configuration files only; packages are not uninstalled."
read -r -p "Type ROLLBACK to restore files from $ROLLBACK_DIR: " CONFIRM
[[ "$CONFIRM" == "ROLLBACK" ]] || { echo "Cancelled."; exit 0; }
sudo tar --absolute-names -xpf "$ROLLBACK_DIR/configs.tar"
while IFS= read -r target; do
    case "$target" in
        /etc/locale.gen|/etc/sddm.conf.d/theme.conf|/usr/share/sddm/themes/sddm-pixel|/etc/sysctl.d/99-performance.conf|"$HOME/.config/environment.d/gaming.conf") ;;
        *) echo "Unexpected path in backup manifest: $target" >&2; exit 1 ;;
    esac
    sudo rm -rf -- "$target"
done < <(sudo cat "$ROLLBACK_DIR/missing-targets")
sudo sysctl --system
echo "Rollback completed. Review the restored files and reboot/log out if settings require it."

fi
#!/bin/bash
#
#  CachyOS ULTIMATE GAMING TUNER v2.3
#  Optimized for: RX 6800 + i5-12400F | Performance & DevOps Stack
#  Author: Alb Kestrel (@ALBKESTRELYTofficial)
# ---------------------------------------------------------------------------

set -euo pipefail

# Safe by default: preview only. System changes require --apply and an
# explicit interactive confirmation. This script does not modify a bootloader.
MODE="dry-run"
ROLLBACK_DIR=""
for arg in "$@"; do
    case "$arg" in
        --dry-run) MODE="dry-run" ;;
        --apply) MODE="apply" ;;
        --rollback) MODE="rollback" ;;
        --help|-h)
            cat <<'USAGE'
Usage:
  ./cachyos-ultimate-tune-improved.sh                 Preview only (default)
  ./cachyos-ultimate-tune-improved.sh --dry-run       Preview only
  ./cachyos-ultimate-tune-improved.sh --apply         Apply after confirmation and backup
  ./cachyos-ultimate-tune-improved.sh --rollback DIR  Restore backed-up configuration files

The script never edits GRUB, Limine, systemd-boot, or boot entries.
Package installation is not automatically undone by --rollback.
USAGE
            exit 0
            ;;
        *) echo "Unknown argument: $arg (use --help)" >&2; exit 2 ;;
    esac
done
if [[ "$MODE" == "rollback" ]]; then
    echo "Rollback mode requires: --rollback DIR" >&2
    exit 2
fi

detect_bootloader() {
    if [[ -e /boot/limine.conf || -e /boot/limine/limine.conf || -e /boot/EFI/limine/limine.conf ]]; then
        printf 'Limine'
    elif [[ -e /etc/default/grub || -e /boot/grub/grub.cfg || -e /boot/grub2/grub.cfg ]]; then
        printf 'GRUB'
    elif command -v bootctl >/dev/null 2>&1 && bootctl is-installed >/dev/null 2>&1; then
        printf 'systemd-boot'
    else
        printf 'unknown/not detected'
    fi
}
BOOTLOADER="$(detect_bootloader)"

if [[ "$MODE" == "dry-run" ]]; then
    echo "SAFE PREVIEW — no system changes, package commands, or sudo commands will run."
    echo "Detected OS: $(. /etc/os-release 2>/dev/null; printf '%s' "${PRETTY_NAME:-unknown}")"
    echo "Detected bootloader: $BOOTLOADER (the script will not modify bootloader files)."
    echo
    echo "Planned changes if you later run with --apply:"
    echo "  - Ensure the sq_AL.UTF-8 locale is enabled if missing."
    echo "  - Install yay if missing, then install the listed desktop, gaming and DevOps packages."
    echo "  - Install the SDDM Pixel UI theme and select it in SDDM configuration."
    echo "  - Write MESA_SHADER_CACHE_MAX_SIZE/RADV_PERFTEST user environment settings."
    echo "  - Write /etc/sysctl.d/99-performance.conf and apply those sysctl values."
    echo "  - Create a root-owned backup of affected configuration files before changing them."
    echo "  - Do not automatically add your user to the docker group or enable Ollama."
    echo
    echo "Review the script before applying. Package installation is not automatically rolled back."
    echo "To apply: ./cachyos-ultimate-tune-improved.sh --apply"
    exit 0
fi

if [[ "$EUID" -eq 0 ]]; then
    echo "Do not run this script as root; use your normal user with sudo access." >&2
    exit 1
fi
if ! grep -qi "cachyos" /etc/os-release; then
    echo "Refusing --apply: this script is intended for CachyOS only." >&2
    exit 1
fi
if [[ ! -t 0 ]]; then
    echo "Refusing non-interactive --apply. Run it in a terminal and confirm interactively." >&2
    exit 1
fi
echo "Detected bootloader: $BOOTLOADER. No bootloader configuration will be changed."
read -r -p "Type APPLY to install packages and change system configuration: " CONFIRM
if [[ "$CONFIRM" != "APPLY" ]]; then
    echo "Cancelled. No changes were made."
    exit 0
fi


# ---------------------------------------------------------------------------
#  Logging & Colors
# ---------------------------------------------------------------------------
LOG="/tmp/ultimate-tune-$(date +%Y%m%d-%H%M%S).log"
exec 3>&1
exec > "$LOG" 2>&1

if [ -t 3 ]; then
    RED='\033[0;31m' GREEN='\033[0;32m' YELLOW='\033[1;33m'
    BLUE='\033[0;34m' CYAN='\033[0;36m' BOLD='\033[1m' NC='\033[0m'
else
    RED='' GREEN='' YELLOW='' BLUE='' CYAN='' BOLD='' NC=''
fi

info()    { echo -e "${BLUE}::${NC} $1" >&3; }
success() { echo -e "${GREEN}[+]${NC} $1" >&3; }
warn()    { echo -e "${YELLOW}[!]${NC} $1" >&3; }
error()   { echo -e "${RED}[x]${NC} $1" >&3; }

# ---------------------------------------------------------------------------
#  1. Pre-Flight Checks
# ---------------------------------------------------------------------------
if [ "$EUID" -eq 0 ]; then
    error "MOS E EKZEKUTO SI ROOT. Përdor përdoruesin tënd normal."
    exit 1
fi

sudo -v || exit 1

# Snapshot every system/user configuration path this script may change before
# the first mutation. The backup directory is root-owned to prevent tampering
# with the archive before a privileged rollback.
BACKUP_ROOT="/var/lib/cachyos-ultimate-tune/backups"
BACKUP_DIR="$BACKUP_ROOT/$(date +%Y%m%d-%H%M%S)"
sudo install -d -o root -g root -m 700 "$BACKUP_DIR"
EXISTING_TMP="$(mktemp)"
MISSING_TMP="$(mktemp)"
TARGETS=(
    "/etc/locale.gen"
    "/etc/sddm.conf.d/theme.conf"
    "/usr/share/sddm/themes/sddm-pixel"
    "/etc/sysctl.d/99-performance.conf"
    "$HOME/.config/environment.d/gaming.conf"
)
for target in "${TARGETS[@]}"; do
    if sudo test -e "$target"; then
        printf '%s\n' "$target" >> "$EXISTING_TMP"
    else
        printf '%s\n' "$target" >> "$MISSING_TMP"
    fi
done
sudo install -o root -g root -m 600 "$EXISTING_TMP" "$BACKUP_DIR/existing-targets"
sudo install -o root -g root -m 600 "$MISSING_TMP" "$BACKUP_DIR/missing-targets"
sudo tar --absolute-names -cpf "$BACKUP_DIR/configs.tar" -T "$BACKUP_DIR/existing-targets"
sudo chmod 600 "$BACKUP_DIR/configs.tar"
rm -f "$EXISTING_TMP" "$MISSING_TMP"
echo "Configuration backup: $BACKUP_DIR" >&3
sudo tee "$BACKUP_DIR/rollback-limitations.txt" >/dev/null <<'LIMITS'
This backup restores tracked configuration files only.
Packages installed by pacman/yay are intentionally not uninstalled automatically.
This script does not add the user to the docker group and does not enable Ollama.
LIMITS

info "Step 1: Kontrolli i Locales..."
if ! locale -a | grep -q "sq_AL.utf8"; then
    warn "sq_AL mungon. Duke e rregulluar..."
    echo "sq_AL.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen > /dev/null
    sudo locale-gen > /dev/null
    success "Locales u rregulluan."
fi

# ---------------------------------------------------------------------------
#  2. AUR Helper (yay)
# ---------------------------------------------------------------------------
if ! command -v yay &> /dev/null; then
    info "Duke instaluar yay..."
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm && cd -
    rm -rf /tmp/yay
fi

# ---------------------------------------------------------------------------
#  3. SDDM Theme
# ---------------------------------------------------------------------------
info "Step 3: SDDM Pixel UI Theme..."
sudo pacman -S --needed --noconfirm qt6-5compat qt6-declarative

PIXEL_DIR="/usr/share/sddm/themes/sddm-pixel"
if [ ! -d "$PIXEL_DIR" ]; then
    tmp=$(mktemp -d)
    git clone -b pixel https://github.com/mahaveergurjar/sddm.git "$tmp"
    sudo mkdir -p "$PIXEL_DIR"
    sudo cp -r "$tmp/"* "$PIXEL_DIR/"
    sudo mkdir -p /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=sddm-pixel" | sudo tee /etc/sddm.conf.d/theme.conf > /dev/null
    rm -rf "$tmp"
fi

# ---------------------------------------------------------------------------
#  4. Packages
# ---------------------------------------------------------------------------
info "Step 4: Instalimi i Paketave..."

# Rifreskimi i databazës për të parandaluar gabimet 404
info "Duke rifreskuar databazën e paketave për të shmangur 404..."
sudo pacman -Syy --noconfirm

PKGS=(
     brave-bin vlc audacity kdenlive obs-studio ffmpeg
    lutris heroic-games-launcher-bin prismlauncher mangohud gamemode goverlay
    libreoffice-fresh joplin-appimage logseq-desktop-bin calibre qbittorrent 
    syncthing openrgb code fastfetch wget curl
    openssh docker podman podman-desktop kubectl terraform postman-bin virt-manager ollama
)
yay -S --needed --noconfirm "${PKGS[@]}"

warn "Docker group membership grants root-equivalent privileges; this script will not add the current user to the docker group."
info "Ollama is installed if selected, but is not automatically enabled or started."

# ---------------------------------------------------------------------------
#  5. Performance
# ---------------------------------------------------------------------------
info "Step 5: AMD Tweaks..."
mkdir -p "$HOME/.config/environment.d"
echo "MESA_SHADER_CACHE_MAX_SIZE=12G" > "$HOME/.config/environment.d/gaming.conf"
echo "RADV_PERFTEST=nggc" >> "$HOME/.config/environment.d/gaming.conf"

sudo tee /etc/sysctl.d/99-performance.conf > /dev/null << EOF
vm.swappiness=10
vm.max_map_count=2147483642
EOF
sudo sysctl -p /etc/sysctl.d/99-performance.conf

success "REFACTOR V2.3 COMPLETE."
