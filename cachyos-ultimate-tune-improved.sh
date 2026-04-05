#!/bin/bash

################################################################################
# CachyOS ULTIMATE GAMING TUNER v2.6 (Performance Focus)
# Optimized for: AMD RX 6800 + 1440p High-Refresh
# Changes: Fixed RADV conflict, removed forced scaling, removed redundant yay build
################################################################################

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔧 Starting CachyOS Ultimate Tune v2.6...${NC}"

# 1. REVERSE VALIDATION: Block Root Execution
if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}🚫 ERROR: Do NOT run this script with sudo directly.${NC}"
    echo -e "${YELLOW}Run it as: ./tuner.sh${NC}"
    exit 1
fi

# 2. DEPENDENCY CHECK (Zenity & YAY)
# CachyOS includes yay by default; we only install Zenity if missing
if ! command -v zenity > /dev/null; then
    echo -e "${YELLOW}Installing Zenity for GUI support...${NC}"
    sudo pacman -S --noconfirm zenity
fi

if ! command -v yay > /dev/null; then
    echo -e "${RED}⚠️  Warning: yay not found. Using pacman as fallback...${NC}"
    AUR_HELPER="sudo pacman"
else
    AUR_HELPER="yay"
fi

# 3. GAMING & AMD PACKAGES
echo -e "${BLUE}🎮 Installing AMD Gaming Suite...${NC}"
PKGS=(steam wine-staging lact-bin mangohud gamemode goverlay lib32-gamemode lib32-mangohud proton-ge-custom-bin lib32-mesa vulkan-radeon lib32-vulkan-radeon)
$AUR_HELPER -S --needed --noconfirm "${PKGS[@]}"

# 4. SYSTEM CONFIGS (Elevated Access)
echo -e "${BLUE}🚀 Configuring System Performance...${NC}"

# SDDM Pixel UI Theme
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

# 5. AMD GRAPHICS OPTIMIZATION (Frames Focus)
echo -e "${BLUE}🖥️  Applying AMD Performance Variables...${NC}"
mkdir -p "$HOME/.config/environment.d"
{
    echo "MESA_SHADER_CACHE_MAX_SIZE=12G"
    # NGGC is Next-Gen Geometry. Huge for the RX 6800.
    # Removed nonggc conflict to prioritize raw speed.
    echo "RADV_PERFTEST=nggc" 
} > "$HOME/.config/environment.d/gaming.conf"

# 6. KERNEL & PERFORMANCE TWEAKS
echo -e "${BLUE}⚡ Applying Sysctl Tweaks...${NC}"
sudo tee /etc/sysctl.d/99-performance.conf > /dev/null << EOF
# Lower swappiness for NVMe/16GB RAM setups
vm.swappiness=10
# Essential for heavy games like Star Citizen or modded Minecraft
vm.max_map_count=2147483642
EOF
sudo sysctl -p /etc/sysctl.d/99-performance.conf

echo -e "---"
echo -e "${GREEN}⭐ PERFORMANCE TUNE COMPLETE! ⭐${NC}"
echo -e "${YELLOW}KDE Scaling was left to default to protect your future 1440p display.${NC}"
