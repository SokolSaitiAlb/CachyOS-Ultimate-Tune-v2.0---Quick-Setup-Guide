#!/bin/bash
#
#  CachyOS ULTIMATE GAMING TUNER v2.3
#  Optimized for: RX 6800 + i5-12400F | Performance & DevOps Stack
#  Author: Alb Kestrel (@ALBKESTRELYTofficial)
# ---------------------------------------------------------------------------

set -euo pipefail

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
PKGS=(
    chromium brave-bin vlc audacity kdenlive obs-studio ffmpeg
    lutris heroic-games-launcher-bin prismlauncher mangohud gamemode goverlay
    libreoffice-fresh joplin-appimage logseq-desktop-bin calibre qbittorrent 
    syncthing openrgb code fastfetch wget curl
    openssh docker podman podman-desktop kubectl postman-bin virt-manager ollama
)
yay -S --needed --noconfirm "${PKGS[@]}"

sudo usermod -aG docker "$USER"
sudo systemctl enable --now ollama

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
