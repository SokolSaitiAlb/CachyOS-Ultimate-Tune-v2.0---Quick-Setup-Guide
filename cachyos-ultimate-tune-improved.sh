#!/bin/bash

################################################################################
# CachyOS ULTIMATE GAMING TUNER v2.4 (PoLP Edition)
# Refactored for User-Level Execution, Security & Plasma 6 Support
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
# This ensures AUR builds (makepkg) don't fail and user configs go to the right $HOME.
if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}🚫 ERROR: Do NOT run this script with sudo directly.${NC}"
    echo -e "${YELLOW}Run it as: ./tuner.sh (The script will ask for sudo when needed)${NC}"
    exit 1
fi

# 2. DEPENDENCY CHECK (Zenity)
if ! command -v zenity > /dev/null; then
    echo -e "${YELLOW}Installing Zenity for GUI support...${NC}"
    sudo pacman -S --noconfirm zenity
fi

# 3. YAY INSTALLATION (AUR Standard Compliance)
if ! command -v yay > /dev/null; then
    echo -e "${BLUE}📦 Installing YAY (Building as $USER)...${NC}"
    sudo pacman -S --needed --noconfirm git base-devel
    YAY_TMP=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$YAY_TMP/yay"
    cd "$YAY_TMP/yay"
    # Runs as user; sudo is invoked internally by makepkg for the final install.
    makepkg -si --noconfirm
    cd - > /dev/null
    rm -rf "$YAY_TMP"
fi

# 4. GAMING & DEV PACKAGES
echo -e "${BLUE}🎮 Installing Core Gaming Suite...${NC}"
PKGS=(steam wine-staging lact-bin mangohud gamemode goverlay lib32-gamemode lib32-mangohud proton-ge-custom-bin)
# yay handles the user -> root transition safely.
yay -S --needed --noconfirm "${PKGS[@]}"

# 5. SYSTEM CONFIGS (Elevated Access)
echo -e "${BLUE}🚀 Configuring System Files...${NC}"

# Limine Bootloader
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

:CachyOS (Fallback)
    protocol: linux
    kernel_path: boot():/vmlinuz-linux-cachyos
    cmdline: root=UUID=$ROOT_UUID rw
    module_path: boot():/initramfs-linux-cachyos-fallback.img
EOF

# SDDM Pixel UI Theme
PIXEL_DIR="/usr/share/sddm/themes/sddm-pixel-ui"
if [ ! -d "$PIXEL_DIR" ]; then
    TMP_SDDM=$(mktemp -d)
    git clone -b pixel https://github.com/mahaveergurjar/sddm.git "$TMP_SDDM"
    sudo mkdir -p "$PIXEL_DIR"
    sudo cp -r "$TMP_SDDM/"* "$PIXEL_DIR/"
    rm -rf "$TMP_SDDM"
    # Enable theme via drop-in config
    sudo mkdir -p /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=sddm-pixel-ui" | sudo tee /etc/etc/sddm.conf.d/theme.conf > /dev/null
fi

# 6. USER-LEVEL OPTIMIZATIONS (The "No-Sudo" Zone)
echo -e "${BLUE}🖥️  Applying User UI Fixes (Scaling/Environment)...${NC}"

# KDE Scale 0.9 (Plasma 6 & 5 Support)
if command -v kwriteconfig6 > /dev/null; then
    kwriteconfig6 --file kdeglobals --group KScreen --key ScaleFactor "0.9"
    echo -e "${GREEN}✅ Applied Plasma 6 scaling (0.9x)${NC}"
elif command -v kwriteconfig5 > /dev/null; then
    kwriteconfig5 --file kdeglobals --group KScreen --key ScaleFactor "0.9"
    echo -e "${GREEN}✅ Applied Plasma 5 scaling (0.9x)${NC}"
else
    echo -e "${YELLOW}⚠️  KDE config tool not found. Skipping scaling fix.${NC}"
fi

# Steam UI Scaling for 768p
mkdir -p "$HOME/.steam/steam"
echo "STEAM_FORCE_DESKTOPUI_SCALE=0.75" > "$HOME/.steam/steam/env"

# MESA Shader Cache (12GB)
mkdir -p "$HOME/.config/environment.d"
echo "MESA_SHADER_CACHE_MAX_SIZE=12G" > "$HOME/.config/environment.d/gaming.conf"

# 7. KERNEL & PERFORMANCE TWEAKS
echo -e "${BLUE}⚡ Applying Performance Tweaks (Sysctl)...${NC}"
sudo tee /etc/sysctl.d/99-performance.conf > /dev/null << EOF
vm.swappiness=10
vm.max_map_count=2147483642
EOF
sudo sysctl -p /etc/sysctl.d/99-performance.conf

echo -e "---"
echo -e "${GREEN}⭐ REFACTOR COMPLETE! ⭐${NC}"
echo -e "${YELLOW}Your system is now optimized for the RX 6800 at 768p.${NC}"
echo -e "${RED}PLEASE REBOOT NOW TO APPLY CHANGES.${NC}"
