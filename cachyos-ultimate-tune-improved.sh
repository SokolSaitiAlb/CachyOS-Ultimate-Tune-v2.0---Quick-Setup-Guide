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
#  1. Pre-Flight Checks (Locale & Permissions)
# ---------------------------------------------------------------------------
[ "$EUID" -eq 0 ] && { error "Do not run as root."; exit 1; }
sudo -v || exit 1

info "Step 1: Checking System Hygiene (Locales)..."
if ! locale -a | grep -q "sq_AL.utf8"; then
    warn "sq_AL locale missing. Fixing..."
    echo "sq_AL.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen > /dev/null
    sudo locale-gen > /dev/null
    success "Locales fixed."
fi

# ---------------------------------------------------------------------------
#  2. AUR Helper (yay) Installation
# ---------------------------------------------------------------------------
if ! command -v yay &> /dev/null; then
    info "Installing yay (AUR Helper)..."
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm && cd -
    rm -rf /tmp/yay
fi

# ---------------------------------------------------------------------------
#  3. SDDM Pixel UI Theme Installation
# ---------------------------------------------------------------------------
info "Step 3: Installing Pixel UI SDDM Theme..."
# Install dependencies for Qt6 themes
sudo pacman -S --needed --noconfirm qt6-5compat qt6-declarative

PIXEL_DIR="/usr/share/sddm/themes/sddm-pixel"
if [ ! -d "$PIXEL_DIR" ]; then
    tmp=$(mktemp -d)
    git clone -b pixel https://github.com/mahaveergurjar/sddm.git "$tmp"
    sudo mkdir -p "$PIXEL_DIR"
    sudo cp -r "$tmp/"* "$PIXEL_DIR/"
    
    # Configure SDDM
    sudo mkdir -p /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=sddm-pixel" | sudo tee /etc/sddm.conf.d/theme.conf > /dev/null
    success "SDDM Theme installed."
    rm -rf "$tmp"
fi

# ---------------------------------------------------------------------------
#  4. Package Deployment (The Massive Stack)
# ---------------------------------------------------------------------------
info "Step 4: Deploying Software Stack..."

PKGS=(
    # Browsers & Media
    chromium brave-bin vlc audacity kdenlive obs-studio ffmpeg
    # Gaming
    lutris heroic-games-launcher-bin prismlauncher mangohud gamemode goverlay
    # Productivity & Tools
    libreoffice-fresh joplin-appimage logseq-desktop-bin calibre qbittorrent 
    syncthing openrgb code fastfetch wget curl
    # DevOps & Virtualization
    openssh docker podman podman-desktop kubectl postman-bin virt-manager ollama
)

yay -S --needed --noconfirm "${PKGS[@]}"

# ---------------------------------------------------------------------------
#  5. System Performance Tweaks
# ---------------------------------------------------------------------------
info "Step 5: Applying Performance Tweaks (AMD + Sysctl)..."
# AMD Shader Cache
mkdir -p "$HOME/.config/environment.d"
echo "MESA_SHADER_CACHE_MAX_SIZE=12G" > "$HOME/.config/environment.d/gaming.conf"
echo "RADV_PERFTEST=nggc" >> "$HOME/.config/environment.d/gaming.conf"

# Virtual Memory
sudo tee /etc/sysctl.d/99-performance.conf > /dev/null << EOF
vm.swappiness=10
vm.max_map_count=2147483642
EOF
sudo sysctl -p /etc/sysctl.d/99-performance.conf

# ---------------------------------------------------------------------------
success "V2.3 INSTALLATION COMPLETE."
warn "Please reboot to apply SDDM changes and Performance Tweaks."
info "YouTube: Alb Kestrel (@ALBKESTRELYTofficial)"
