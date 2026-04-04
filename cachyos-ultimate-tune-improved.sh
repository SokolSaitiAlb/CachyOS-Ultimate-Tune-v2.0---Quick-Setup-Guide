#!/bin/bash

################################################################################
# CachyOS ULTIMATE GAMING TUNER v2.2 (STABLE)
# Optimized for: i5-12400f | RX 6800 | CachyOS
# Fixes: Wine Conflicts, YAY Root Errors, Zenity Logic, Limine Safety
################################################################################

# Exit on error (except for handled conflicts)
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' 

# 1. ROOT CHECK
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}🚫 Please run as root: sudo ./$0${NC}"
    exit 1
fi

# Get the real username for AUR/YAY tasks
REAL_USER=${SUDO_USER:-$USER}

echo -e "${BLUE}🔧 Starting CachyOS Ultimate Tune v2.2...${NC}"

# 2. ENSURE ZENITY
if ! command -v zenity &> /dev/null; then
    echo -e "${YELLOW}🧩 Installing Zenity for GUI support...${NC}"
    pacman -S --noconfirm zenity
fi

# 3. INTERACTIVE MENU
choices=$(zenity --list --checklist \
    --title="CachyOS Gaming Setup v2.2" \
    --width=700 --height=800 \
    --text="Select features to install or enable:" \
    --column="Enable" --column="Feature" \
    TRUE "Install YAY and Base Tools" \
    TRUE "Install Gaming & Dev Tools (Steam, OBS, etc)" \
    TRUE "Install Wine-Staging (Performance)" \
    TRUE "Enable BORE Scheduler Kernel" \
    TRUE "Install LACT GPU Management (RX 6800)" \
    TRUE "Enable CPUpower (Performance Governor)" \
    TRUE "Apply 2-Second Limine Timeout" \
    TRUE "Apply Performance Tweaks (Sysctl/GPU Cache)" \
    FALSE "Install SDDM Themes" \
    2>&1)

if [ $? -ne 0 ]; then
    echo -e "${YELLOW}Installation cancelled.${NC}"
    exit 0
fi

echo "-----------------------------------"
echo "Choices selected: $choices"
echo "-----------------------------------"

# ===========================
# 1. YAY & BASE DEVELOPMENT
# ===========================
if [[ $choices == *"Install YAY"* ]]; then
    echo -e "${BLUE}📦 Setting up YAY AUR helper...${NC}"
    if ! command -v yay &> /dev/null; then
        pacman -S --needed --noconfirm git base-devel
        # AUR packages cannot be built as root
        sudo -u "$REAL_USER" bash -c "cd /tmp && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm"
        rm -rf /tmp/yay
    fi
    echo -e "${GREEN}✅ YAY is ready.${NC}"
fi

# ===========================
# 2. WINE-STAGING (Conflict Fix)
# ===========================
if [[ $choices == *"Install Wine-Staging"* ]]; then
    echo -e "${BLUE}🍷 Installing Wine-Staging...${NC}"
    # Remove standard wine first to prevent pacman lock-up
    pacman -Rns --noconfirm wine &> /dev/null || true
    pacman -S --needed --noconfirm wine-staging lib32-wine
    echo -e "${GREEN}✅ Wine-Staging installed (Conflicts resolved).${NC}"
fi

# ===========================
# 3. GAMING & DEV TOOLS
# ===========================
if [[ $choices == *"Gaming & Dev Tools"* ]]; then
    echo -e "${BLUE}🎮 Installing software suite...${NC}"
    pacman -S --needed --noconfirm \
        goverlay fastfetch tmux vlc kdenlive audacity obs-studio ffmpeg \
        prismlauncher mangohud gamemode brave-bin krita qbittorrent code \
        lazygit kitty virt-manager steam lib32-gamemode lib32-mangohud
fi

# ===========================
# 4. KERNEL & BOOTLOADER
# ===========================
if [[ $choices == *"BORE Scheduler"* ]]; then
    echo -e "${BLUE}🔄 Installing BORE Kernel...${NC}"
    pacman -S --needed --noconfirm linux-cachyos-bore linux-cachyos-bore-headers
    # Update GRUB automatically if it exists
    if [ -f /boot/grub/grub.cfg ]; then
        grub-mkconfig -o /boot/grub/grub.cfg
    fi
fi

# ===========================
# 5. LIMINE 2-SEC TIMEOUT (Safety Check)
# ===========================
if [[ $choices == *"Limine Timeout"* ]]; then
    echo -e "${BLUE}🚀 Checking Limine configuration...${NC}"
    if [ -f /boot/limine.conf ]; then
        sed -i 's/^TIMEOUT=.*/TIMEOUT=2/' /boot/limine.conf
        echo -e "${GREEN}✅ Limine timeout set to 2 seconds.${NC}"
    else
        echo -e "${YELLOW}⚠️  Limine.conf not found. Skipping timeout tweak.${NC}"
    fi
fi

# ===========================
# 6. GPU & CPU PERFORMANCE
# ===========================
if [[ $choices == *"LACT GPU"* ]]; then
    echo -e "${BLUE}📊 Installing LACT for RX 6800...${NC}"
    sudo -u "$REAL_USER" yay -S --needed --noconfirm lact
    systemctl enable --now lact
fi

if [[ $choices == *"Performance Governor"* ]]; then
    pacman -S --needed --noconfirm cpupower
    systemctl enable --now cpupower
    echo 'GOVERNOR="performance"' > /etc/default/cpupower
fi

if [[ $choices == *"Performance Tweaks"* ]]; then
    echo -e "${BLUE}⚡ Applying System Tweaks...${NC}"
    # GPU Cache for RX 6800
    echo "MESA_SHADER_CACHE_MAX_SIZE=12G" >> /etc/environment
    # Sysctl
    cat > /etc/sysctl.d/99-performance.conf << 'EOF'
vm.swappiness=10
vm.max_map_count=2147483642
dev.amdgpu.gpu_recovery=1
EOF
    sysctl -p /etc/sysctl.d/99-performance.conf
fi

# ===========================
# FINAL REBOOT
# ===========================
zenity --question --title="Setup Complete" --width=300 \
    --text="All optimizations applied! Reboot now?" \
    --ok-label="Reboot" --cancel-label="Later"

if [ $? -eq 0 ]; then
    reboot
fi
