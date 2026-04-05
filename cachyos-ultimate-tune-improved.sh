#!/bin/bash

################################################################################
# CachyOS ULTIMATE GAMING TUNER v2.4 (PoLP Edition)
# Refactored for User-Level Execution & Security
################################################################################

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔧 Starting CachyOS Ultimate Tune v2.4...${NC}"

# 1. REVERSE VALIDATION: Block Root Execution
# From a DevOps perspective, we want the script to run as the owner of the $HOME files.
if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}🚫 ERROR: Do NOT run this script with sudo directly.${NC}"
    echo -e "${YELLOW}Run it as: ./tuner.sh (The script will ask for sudo when needed)${NC}"
    exit 1
fi

# 2. DEPENDENCY CHECK (Zenity)
# We use 'sudo' only for the specific command that needs it.
if ! command -v zenity > /dev/null; then
    echo -e "${YELLOW}Installing Zenity...${NC}"
    sudo pacman -S --noconfirm zenity
fi

# 3. YAY INSTALLATION (Fixed for AUR Standards)
if ! command -v yay > /dev/null; then
    echo -e "${BLUE}📦 Installing YAY (Building as $USER)...${NC}"
    sudo pacman -S --needed --noconfirm git base-devel
    YAY_TMP=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$YAY_TMP/yay"
    cd "$YAY_TMP/yay"
    # makepkg runs as YOU, not root. It will ask for sudo internally to install.
    makepkg -si --noconfirm
    cd - > /dev/null
    rm -rf "$YAY_TMP"
fi

# 4. GAMING & DEV PACKAGES
echo -e "${BLUE}🎮 Installing Core Gaming Suite...${NC}"
PKGS=(steam wine-staging lact-bin mangohud gamemode goverlay lib32-gamemode lib32-mangohud proton-ge-custom-bin)
# yay is called as YOU. It handles sudo prompts safely.
yay -S --needed --noconfirm "${PKGS[@]}"

# 5. SYSTEM CONFIGS (Requires Elevation)
echo -e "${BLUE}🚀 Configuring System Files...${NC}"

# Limine
sudo pacman -S --needed --noconfirm limine
ROOT_UUID=$(findmnt -n -o UUID /)

sudo tee /boot/limine.conf > /dev/null << EOF
timeout: 5
default_entry: 1

:CachyOS (BORE Kernel)
    protocol: linux
    kernel_path: boot():/vmlinuz-linux-cachyos
    cmdline: root=UUID=$ROOT_UUID rw quiet splash nvidia_drm.modeset=1
    module_path: boot():/initramfs-linux-cachyos.img
EOF

# SDDM Pixel UI
PIXEL_DIR="/usr/share/sddm/themes/sddm-pixel-ui"
if [ ! -d "$PIXEL_DIR" ]; then
    TMP_SDDM=$(mktemp -d)
    git clone -b pixel https://github.com/mahaveergurjar/sddm.git "$TMP_SDDM"
    sudo mkdir -p "$PIXEL_DIR"
    sudo cp -r "$TMP_SDDM/"* "$PIXEL_DIR/"
    rm -rf "$TMP_SDDM"
    sudo mkdir -p /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=sddm-pixel-ui" | sudo tee /etc/sddm.conf.d/theme.conf > /dev/null
fi

# 6. USER-LEVEL OPTIMIZATIONS (No Sudo Needed!)
# This is where your previous script was dangerous; it was changing root's KDE settings, not yours.
echo -e "${BLUE}🖥️  Applying User UI Fixes (Scaling/Environment)...${NC}"

# KDE Scale 0.9 (Changes YOUR config, not root's)
kwriteconfig5 --file kdeglobals --group KScreen --key ScaleFactor "0.9"

# Steam UI Scale
mkdir -p "$HOME/.steam/steam"
echo "STEAM_FORCE_DESKTOPUI_SCALE=0.75" > "$HOME/.steam/steam/env"

# Shader Cache
mkdir -p "$HOME/.config/environment.d"
echo "MESA_SHADER_CACHE_MAX_SIZE=12G" > "$HOME/.config/environment.d/gaming.conf"

# 7. KERNEL TWEAKS
sudo tee /etc/sysctl.d/99-performance.conf > /dev/null << EOF
vm.swappiness=10
vm.max_map_count=2147483642
EOF
sudo sysctl -p /etc/sysctl.d/99-performance.conf

echo -e "${GREEN}⭐ REFACTOR COMPLETE! REBOOT NOW. ⭐${NC}"
