#!/bin/bash
#
#  ████████╗██╗   ██╗██╗  ██╗███╗   ███╗ █████╗ ████████╗███████╗
#  ╚══██╔══╝██║   ██║╚██╗██╔╝████╗ ████║██╔══██╗╚══██╔══╝██╔════╝
#     ██║   ██║   ██║ ╚███╔╝ ██╔████╔██║███████║   ██║   █████╗
#     ██║   ██║   ██║ ██╔██╗ ██║╚██╔╝██║██╔══██║   ██║   ██╔══╝
#     ██║   ╚██████╔╝██╔╝ ██╗██║ ╚═╝ ██║██║  ██║   ██║   ███████╗
#     ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝
#
#  CachyOS ULTIMATE GAMING TUNER v2.7 (Tuxmate Refactor)
#  Optimized for: RX 6800 + i5-12400F | Performance & DevOps Stack
# ---------------------------------------------------------------------------

set -euo pipefail

# Standardize Path and Security
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export LC_ALL=C
umask 077

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
#  Core Functions
# ---------------------------------------------------------------------------

is_installed() { pacman -Qi "$1" &>/dev/null; }

install_pkg() {
    local name=$1 pkg=$2 cmd=$3
    if is_installed "$pkg"; then
        echo -e "${NC}  - $name (already present)" >&3
        return 0
    fi
    info "Installing $name..."
    if $cmd -S --needed --noconfirm "$pkg" >/dev/null 2>&1; then
        success "$name installed."
    else
        error "Failed to install $name."
    fi
}

# ---------------------------------------------------------------------------
#  The Execution
# ---------------------------------------------------------------------------

[ "$EUID" -eq 0 ] && { error "Do not run as root."; exit 1; }

info "Starting CachyOS Ultimate Tune v2.7..."
sudo -v || exit 1

# 1. AMD Performance Environment (The Core Logic)
info "Applying AMD Performance Variables (NGGC + 12GB Cache)..."
mkdir -p "$HOME/.config/environment.d"
{
    echo "MESA_SHADER_CACHE_MAX_SIZE=12G"
    echo "RADV_PERFTEST=nggc" 
} > "$HOME/.config/environment.d/gaming.conf"

# 2. Kernel/Sysctl Tweaks
info "Applying System Performance Tweaks..."
sudo tee /etc/sysctl.d/99-performance.conf > /dev/null << EOF
vm.swappiness=10
vm.max_map_count=2147483642
EOF
sudo sysctl -p /etc/sysctl.d/99-performance.conf

# 3. SDDM Theme
info "Configuring SDDM Theme..."
PIXEL_DIR="/usr/share/sddm/themes/sddm-pixel-ui"
if [ ! -d "$PIXEL_DIR" ]; then
    sudo pacman -S --noconfirm git >/dev/null 2>&1
    tmp=$(mktemp -d)
    git clone -b pixel https://github.com/mahaveergurjar/sddm.git "$tmp" >/dev/null 2>&1
    sudo mkdir -p "$PIXEL_DIR"
    sudo cp -r "$tmp/"* "$PIXEL_DIR/"
    echo -e "[Theme]\nCurrent=sddm-pixel-ui" | sudo tee /etc/sddm.conf.d/theme.conf > /dev/null
    rm -rf "$tmp"
fi

# 4. Package Installation (Your New Stack)
info "Deploying Applications..."

# Graphics/Gaming
install_pkg "Steam" "steam" "sudo pacman"
install_pkg "MangoHud" "mangohud" "sudo pacman"
install_pkg "GameMode" "gamemode" "sudo pacman"
install_pkg "GOverlay" "goverlay" "sudo pacman"
install_pkg "LACT" "lact-bin" "yay"
install_pkg "VLC" "vlc" "sudo pacman"
install_pkg "OBS Studio" "obs-studio" "sudo pacman"

# DevOps & Tools
install_pkg "Docker" "docker" "sudo pacman"
install_pkg "Podman" "podman" "sudo pacman"
install_pkg "kubectl" "kubectl" "sudo pacman"
install_pkg "VS Code" "code" "sudo pacman"
install_pkg "Kitty" "kitty" "sudo pacman"
install_pkg "tmux" "tmux" "sudo pacman"
install_pkg "Ollama" "ollama" "sudo pacman"

# Browser/Work
install_pkg "Brave" "brave-bin" "yay"
install_pkg "LibreOffice" "libreoffice-fresh" "sudo pacman"

# ---------------------------------------------------------------------------
success "V2.7 REFACTOR COMPLETE."
warn "Reboot immediately to apply all changes."
echo -e "${NC}Detailed log: $LOG" >&3
