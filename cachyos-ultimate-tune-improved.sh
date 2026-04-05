#!/bin/bash

################################################################################
# CachyOS ULTIMATE GAMING TUNER v2.5 (Clean Edition)
# Removed: Automataic Bootloader Overwriting (Safety First)
# Added: Correct AMD Environment Variables
################################################################################

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔧 Starting CachyOS Ultimate Tune v2.5...${NC}"

# 1. REVERSE VALIDATION: Block Root Execution
if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}🚫 ERROR: Do NOT run this script with sudo directly.${NC}"
    echo -e "${YELLOW}Run it as: ./tuner.sh${NC}"
    exit 1
fi

# 2. DEPENDENCY CHECK (Zenity)
if ! command -v zenity > /dev/null; then
    echo -e "${YELLOW}Installing Zenity for GUI support...${NC}"
    sudo pacman -S --noconfirm zenity
fi

# 3. YAY INSTALLATION
if ! command -v yay > /dev/null; then
    echo -e "${BLUE}📦 Installing YAY (Building as $USER)...${NC}"
    sudo pacman -S --needed --noconfirm git base-devel
    YAY_TMP=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$YAY_TMP/yay"
    cd "$YAY_TMP/yay"
    makepkg -si --noconfirm
    cd - > /dev/null
    rm -rf "$YAY_TMP"
fi

# 4. GAMING & AMD PACKAGES
echo -e "${BLUE}🎮 Installing AMD Gaming Suite...${NC}"
# Removed nvidia-specific bins, added AMD specific LACT for your RX 6800
PKGS=(steam wine-staging lact-bin mangohud gamemode goverlay lib32-gamemode lib32-mangohud proton-ge-custom-bin lib32-mesa vulkan-radeon lib32-vulkan-radeon)
yay -S --needed --noconfirm "${PKGS[@]}"

# 5. SYSTEM CONFIGS (Elevated Access)
echo -e "${BLUE}🚀 Configuring System Performance...${NC}"

# SDDM Pixel UI Theme
PIXEL_DIR="/usr/share/sddm/themes/sddm-pixel-ui"
if [ ! -d "$PIXEL_DIR" ]; then
    TMP_SDDM=$(mktemp -d)
    git clone -b pixel https://github.com/mahaveergurjar/sddm.git "$TMP_SDDM"
    sudo mkdir -p "$PIXEL_DIR"
    sudo cp -r "$TMP_SDDM/"* "$PIXEL_DIR/"
    rm -rf "$TMP_SDDM"
    # Fixed path error from v2.4
    sudo mkdir -p /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=sddm-pixel-ui" | sudo tee /etc/sddm.conf.d/theme.conf > /dev/null
fi

# 6. USER-LEVEL OPTIMIZATIONS
echo -e "${BLUE}🖥️  Applying User UI Fixes...${NC}"

# KDE Scale 0.9
if command -v kwriteconfig6 > /dev/null; then
    kwriteconfig6 --file kdeglobals --group KScreen --key ScaleFactor "0.9"
elif command -v kwriteconfig5 > /dev/null; then
    kwriteconfig5 --file kdeglobals --group KScreen --key ScaleFactor "0.9"
fi

# AMD Specific Environment Variables
mkdir -p "$HOME/.config/environment.d"
{
    echo "MESA_SHADER_CACHE_MAX_SIZE=12G"
    echo "RADV_PERFTEST=nggc" # Enable Next-Gen Geometry for your RX 6800
    echo "AMD_DEBUG=nonggc" # Stability fallback
} > "$HOME/.config/environment.d/gaming.conf"

# 7. KERNEL & PERFORMANCE TWEAKS
echo -e "${BLUE}⚡ Applying Sysctl Tweaks...${NC}"
sudo tee /etc/sysctl.d/99-performance.conf > /dev/null << EOF
vm.swappiness=10
vm.max_map_count=2147483642
EOF
sudo sysctl -p /etc/sysctl.d/99-performance.conf

echo -e "---"
echo -e "${GREEN}⭐ REFACTOR COMPLETE! ⭐${NC}"
echo -e "${YELLOW}Limine was NOT touched. Manage your bootloader manually for safety.${NC}"
