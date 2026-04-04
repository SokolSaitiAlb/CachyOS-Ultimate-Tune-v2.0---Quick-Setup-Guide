#!/bin/bash

################################################################################
# CachyOS ULTIMATE GAMING TUNER v2.3
# For RX 6800 + KDE + Limine + BORE Kernel + LACT GPU Management
# Optimized for 1366x768 @ 60Hz
################################################################################

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔧 Starting CachyOS Ultimate Tune v2.3...${NC}"

# 1. ROOT & USER VALIDATION
if [ $EUID -ne 0 ]; then
    echo -e "${RED}🚫 Please run as root (sudo ./tuner.sh)${NC}"
    exit 1
fi

REAL_USER=${SUDO_USER:-$(logname)}
USER_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)

# 2. AUTOMATED TOOL CHECK (Zenity)
if ! command -v zenity > /dev/null; then
    pacman -S --noconfirm zenity
fi

# 3. FEATURE SELECTION (Simplified for automation)
# In a true one-click, we assume "Yes" to all or use a checklist.
# For this script, we proceed with the core "Ultimate" optimizations.

# 4. YAY INSTALLATION (Permissions Fixed)
if ! command -v yay > /dev/null; then
    echo -e "${BLUE}📦 Installing YAY...${NC}"
    pacman -S --needed --noconfirm git base-devel
    YAY_TMP=$(mktemp -d)
    chown "$REAL_USER:$REAL_USER" "$YAY_TMP"
    sudo -u "$REAL_USER" bash <<EOF
        cd "$YAY_TMP"
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
EOF
    rm -rf "$YAY_TMP"
fi

# 5. GAMING & DEV PACKAGES
echo -e "${BLUE}🎮 Installing Core Gaming Suite...${NC}"
PKGS=(steam wine-staging lact-bin mangohud gamemode goverlay lib32-gamemode lib32-mangohud proton-ge-custom-bin)
yay -S --needed --noconfirm "${PKGS[@]}"

# 6. LIMINE BOOTLOADER (FULLY AUTOMATED)
echo -e "${BLUE}🚀 Configuring Limine Bootloader...${NC}"
pacman -S --needed --noconfirm limine
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
echo -e "${GREEN}✅ Limine configured with UUID: $ROOT_UUID${NC}"

# 7. SDDM PIXEL UI (AUTOMATED)
echo -e "${BLUE}💫 Installing SDDM Pixel UI...${NC}"
PIXEL_DIR="/usr/share/sddm/themes/sddm-pixel-ui"
if [ ! -d "$PIXEL_DIR" ]; then
    TMP_SDDM=$(mktemp -d)
    git clone -b pixel https://github.com/mahaveergurjar/sddm.git "$TMP_SDDM"
    mkdir -p "$PIXEL_DIR"
    cp -r "$TMP_SDDM/"* "$PIXEL_DIR/"
    rm -rf "$TMP_SDDM"
    # Set as default
    mkdir -p /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=sddm-pixel-ui" | tee /etc/sddm.conf.d/theme.conf > /dev/null
fi

# 8. 1366x768 UI OPTIMIZATIONS
echo -e "${BLUE}🖥️  Applying 768p Scaling Fixes...${NC}"
# KDE Scale 0.9
sudo -u "$REAL_USER" kwriteconfig5 --file kdeglobals --group KScreen --key ScaleFactor "0.9"
# Steam UI Scale 0.75 (Prevents overflow)
mkdir -p "$USER_HOME/.steam/steam"
echo "STEAM_FORCE_DESKTOPUI_SCALE=0.75" | sudo -u "$REAL_USER" tee "$USER_HOME/.steam/steam/env" > /dev/null

# 9. GPU & SYSTEM PERFORMANCE
echo -e "${BLUE}⚡ Applying Performance Tweaks...${NC}"
# 12GB Shader Cache
mkdir -p "$USER_HOME/.config/environment.d"
echo "MESA_SHADER_CACHE_MAX_SIZE=12G" | sudo -u "$REAL_USER" tee "$USER_HOME/.config/environment.d/gaming.conf" > /dev/null
# Sysctl
sudo tee /etc/sysctl.d/99-performance.conf > /dev/null << EOF
vm.swappiness=10
vm.max_map_count=2147483642
EOF
sysctl -p /etc/sysctl.d/99-performance.conf

echo -e "${GREEN}⭐ ALL DONE! REBOOT YOUR SYSTEM NOW. ⭐${NC}"
