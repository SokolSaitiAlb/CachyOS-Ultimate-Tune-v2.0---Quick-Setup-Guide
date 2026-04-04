#!/bin/bash
################################################################################
# CachyOS ULTIMATE GAMING TUNER v2.3
# Sync Date: 05.04.2026
################################################################################

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔧 Starting CachyOS Ultimate Tune v2.3...${NC}"

# Root Check
if [ $EUID -ne 0 ]; then
    echo -e "${RED}🚫 Please run as root (sudo ./cachyos-ultimate-tune-improved.sh)${NC}"
    exit 1
fi

REAL_USER=${SUDO_USER:-$(logname)}
USER_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)

# [Logic for feature_enabled and Zenity would go here as per your original structure]

# ===========================
# 7. CONFIGURE LIMINE BOOTLOADER (REVISED)
# ===========================
if feature_enabled "Apply Limine Bootloader (5 sec timeout)"; then
    echo -e "${BLUE}🚀 Configuring Limine Bootloader...${NC}"
    
    pacman -S --needed --noconfirm limine
    
    # Get Root UUID for the config
    ROOT_UUID=$(findmnt -n -o UUID /)

    sudo tee /boot/limine.conf > /dev/null << EOF
# CachyOS Ultimate Tune v2.3 - Automated Config
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
    
    # Install limine to the drive (Assumes /boot/efi is the mount point)
    # WARNING: This part usually requires user confirmation of the disk.
    echo -e "${YELLOW}⚠️  Limine binary installed. Remember to run 'limine install' on your drive.${NC}"
fi

# ===========================
# 8. SETUP SDDM PIXEL THEME
# ===========================
if feature_enabled "Install SDDM Pixel UI Theme"; then
    echo -e "${BLUE}💫 Installing SDDM Pixel UI Theme...${NC}"
    PIXEL_THEME_DIR="/usr/share/sddm/themes/sddm-pixel-ui"
    
    if [ ! -d "$PIXEL_THEME_DIR" ]; then
        TMP_DIR=$(mktemp -d)
        git clone -b pixel https://github.com/mahaveergurjar/sddm.git "$TMP_DIR"
        mkdir -p "$PIXEL_THEME_DIR"
        cp -r "$TMP_DIR/"* "$PIXEL_THEME_DIR/"
        rm -rf "$TMP_DIR"
        
        # Apply theme to sddm.conf
        mkdir -p /etc/sddm.conf.d
        echo -e "[Theme]\nCurrent=sddm-pixel-ui" > /etc/sddm.conf.d/theme.conf
        echo -e "${GREEN}✅ SDDM Pixel UI set as default.${NC}"
    fi
fi

# ===========================
# 19. KDE SCALE FACTOR (Sync with 1366x768)
# ===========================
echo -e "${BLUE}🖥️  Optimizing UI for 1366x768...${NC}"
# Use 0.9 as specified in README for better screen real estate
sudo -u "$REAL_USER" kwriteconfig5 --file kdeglobals --group KScreen --key ScaleFactor "0.9"
# Force Steam Scale to 0.75 for small resolution
mkdir -p "$USER_HOME/.steam/steam"
echo "STEAM_FORCE_DESKTOPUI_SCALE=0.75" | sudo -u "$REAL_USER" tee "$USER_HOME/.steam/steam/env" > /dev/null

echo -e "${GREEN}✅ Script V2.3 Complete. Reboot recommended.${NC}"
