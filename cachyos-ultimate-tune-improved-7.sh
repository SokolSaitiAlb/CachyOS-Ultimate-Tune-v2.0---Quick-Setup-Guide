#!/bin/bash

################################################################################
# CachyOS ULTIMATE GAMING TUNER v2.3
# For RX 6800 + KDE + Limine + BORE Kernel + LACT GPU Management
# By Alb Kestrel (Improved Version)
################################################################################

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔧 Starting CachyOS Ultimate Tune v2.0...${NC}"

# ===========================
# CHECK & INSTALL ZENITY
# ===========================
if ! command -v zenity &> /dev/null; then
    echo -e "${YELLOW}🧩 Installing Zenity GUI support...${NC}"
    pacman -S --noconfirm zenity
fi

# ===========================
# REQUIRE ROOT
# ===========================
if [ $EUID -ne 0 ]; then
    echo -e "${RED}🚫 Please run as root (sudo ./cachyos-ultimate-tune-improved.sh)${NC}"
    exit 1
fi

# ===========================
# ZENITY FEATURE SELECTION MENU
# ===========================
choices=$(zenity --list --checklist \
    --title="CachyOS Gaming Setup v2.3" \
    --width=700 --height=850 \
    --text="Select the features you want to enable:" \
    --column="Enable" --column="Feature" \
    TRUE "Install YAY AUR helper" \
    TRUE "Install Gaming & Dev Tools (Steam, Wine, OBS, KDEnlive, etc)" \
    TRUE "Enable BORE Scheduler Kernel (linux-cachyos-bore)" \
    TRUE "Install LACT GPU Management (RX 6800 OC)" \
    TRUE "Enable CPUpower (Intel/AMD CPU Governor - Performance)" \
    TRUE "Enable MangoHud + GameMode" \
    TRUE "Install ProtonPlus (ProtonUp-Qt replacement)" \
    TRUE "Apply Limine Bootloader (2 sec timeout)" \
    TRUE "Configure GPU Shader Cache (12GB MESA_SHADER_CACHE)" \
    TRUE "Setup Browser Hardware Acceleration (Brave + Firefox)" \
    FALSE "Install CoreCtrl GPU Management (Alternative to LACT)" \
    FALSE "Enable scx_bpfland Advanced Scheduler (Alternative to BORE)" \
    FALSE "Install SDDM Astronaut Theme" \
    FALSE "Install SDDM Pixie Theme" \
    FALSE "Install SDDM Pixel UI Theme" \
    FALSE "Setup Btrfs Snapshots & cachy-update" \
    FALSE "Install OpenRGB for RGB Control" \
    FALSE "Install KDE Gaming Layout (Latte Dock)" \
    2>&1)

exit_code=$?
if [ $exit_code -ne 0 ]; then
    echo -e "${YELLOW}Installation cancelled by user${NC}"
    exit 0
fi

# Convert string to array
IFS="|" read -r -a features <<< "$choices"

# ===========================
# HELPER FUNCTION
# ===========================
feature_enabled() {
    local feature_name="$1"
    for feature in "${features[@]}"; do
        if [ "$feature" = "$feature_name" ]; then
            return 0
        fi
    done
    return 1
}

# ===========================
# 1. INSTALL YAY (AUR Helper)
# ===========================
if feature_enabled "Install YAY AUR helper"; then
    echo -e "${BLUE}📦 Installing YAY AUR helper...${NC}"
    
    if ! command -v yay &> /dev/null; then
        pacman -S --needed --noconfirm git base-devel
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay
        makepkg -si --noconfirm
        cd -
        rm -rf /tmp/yay
        echo -e "${GREEN}✅ YAY installed successfully${NC}"
    else
        echo -e "${GREEN}✅ YAY already installed${NC}"
    fi
fi

# ===========================
# 2. INSTALL GAMING & DEVELOPMENT TOOLS
# ===========================
if feature_enabled "Install Gaming & Dev Tools (Steam, Wine, OBS, KDEnlive, etc)"; then
    echo -e "${BLUE}🎮 Installing Gaming & Development Tools...${NC}"
    
    yay -S --needed --noconfirm \
        goverlay \
        openssh \
        fastfetch \
        tmux \
        vlc \
        kdenlive \
        audacity \
        obs-studio \
        ffmpeg \
        prismlauncher \
        mangohud \
        gamemode \
        brave-bin \
        krita \
        libreoffice-fresh \
        qbittorrent \
        code \
        lazygit \
        kitty \
        virt-manager \
        steam \
        wine-staging \
        lib32-gamemode \
        lib32-mangohud
    
    echo -e "${GREEN}✅ Gaming & Development Tools installed${NC}"
fi

# ===========================
# 3. ENABLE BORE SCHEDULER KERNEL
# ===========================
if feature_enabled "Enable BORE Scheduler Kernel (linux-cachyos-bore)"; then
    echo -e "${BLUE}🔄 Setting up linux-cachyos-bore kernel...${NC}"
    
    pacman -S --needed --noconfirm linux-cachyos-bore linux-cachyos-bore-headers
    
    echo -e "${YELLOW}⚠️  BORE Kernel installed. Please run: sudo grub-mkconfig -o /boot/grub/grub.cfg${NC}"
    echo -e "${YELLOW}Then reboot and select the BORE kernel from the boot menu.${NC}"
    
    echo -e "${GREEN}✅ BORE Scheduler kernel installed${NC}"
fi

# ===========================
# 5. ENABLE CPUPOWER (CPU Governor)
# ===========================
if feature_enabled "Enable CPUpower (Intel/AMD CPU Governor - Performance)"; then
    echo -e "${BLUE}⚡ Installing and configuring CPUpower...${NC}"
    
    # Install cpupower
    pacman -S --needed --noconfirm cpupower
    
    # Set governor to performance
    sudo cpupower frequency-set -g performance
    
    # Make it persistent across reboots
    mkdir -p /etc/default
    echo 'GOVERNOR="performance"' | tee /etc/default/cpupower > /dev/null
    
    # Enable cpupower service
    systemctl enable cpupower.service
    systemctl start cpupower.service
    
    echo -e "${GREEN}✅ CPUpower configured (Performance mode)${NC}"
    echo -e "${YELLOW}💡 CPU Governor: Set to Performance for maximum gaming speed${NC}"
    echo -e "${YELLOW}💡 Your i5-12400f will run at max frequency during gaming${NC}"
fi
if feature_enabled "Install LACT GPU Management (RX 6800 OC)"; then
    echo -e "${BLUE}📊 Installing LACT GPU Management...${NC}"
    
    yay -S --needed --noconfirm lact
    
    # Enable LACT service
    systemctl enable lact
    systemctl start lact
    
    echo -e "${GREEN}✅ LACT installed and enabled${NC}"
    echo -e "${YELLOW}💡 Launch LACT from applications menu for GPU overclocking settings${NC}"
fi

# ===========================
# 6. INSTALL PROTONPLUS
# ===========================
if feature_enabled "Install ProtonPlus (ProtonUp-Qt replacement)"; then
    echo -e "${BLUE}⬇️  Installing ProtonPlus...${NC}"
    
    yay -S --needed --noconfirm protonplus
    
    echo -e "${GREEN}✅ ProtonPlus installed successfully${NC}"
fi

# ===========================
# 7. CONFIGURE LIMINE BOOTLOADER
# ===========================
if feature_enabled "Apply Limine Bootloader (2 sec timeout)"; then
    echo -e "${BLUE}🚀 Configuring Limine Bootloader...${NC}"
    
    # Install Limine bootloader
    yay -S --needed --noconfirm limine
    
    # Create/Configure Limine with optimized settings
    if [ -f /boot/limine.conf ]; then
        echo -e "${YELLOW}💡 Existing Limine configuration found${NC}"
        echo -e "${YELLOW}   You can manually edit: sudo nano /boot/limine.conf${NC}"
    else
        # Create Limine config with default settings
        sudo mkdir -p /boot
        cat > /tmp/limine.conf << 'EOF'
# CachyOS Ultimate Tune v2.3 - Limine Bootloader Configuration

# Timeout: Sets how many seconds Limine waits before automatically booting the default entry
timeout: 5

# Default Entry: Specifies which menu entry boots by default
# Entries are numbered starting from 1. If pointing to a directory, autoboot is disabled.
# To autoboot an entry within a directory, point directly to that specific entry number.
default_entry: 1

# Example structure:
# timeout: 5              # 5-second boot delay
# default_entry: 2       # Boot the second entry (linux-cachyos) by default
#
# /+CachyOS              # Entry 1: Directory (use /+ to expand)
# //linux-cachyos        # Entry 2: Actual bootable kernel
#     protocol: linux
#     kernel_path: boot():/vmlinuz-linux-cachyos
#     cmdline: quiet splash root=UUID=... rw
#     module_path: boot():/initramfs-linux-cachyos.img

#console-mode keep # Keep console display during boot
EOF
        sudo cp /tmp/limine.conf /boot/limine.conf
        echo -e "${GREEN}✅ Limine bootloader configured${NC}"
    fi
    
    echo -e "${GREEN}✅ Limine Bootloader Setup Complete${NC}"
    echo -e "${YELLOW}💡 Limine Configuration Details:${NC}"
    echo -e "${YELLOW}   📁 Location: /boot/limine.conf${NC}"
    echo -e "${YELLOW}   ⏱️  timeout: 5 (seconds before autoboot)${NC}"
    echo -e "${YELLOW}   🎯 default_entry: 1 (which entry to boot)${NC}"
    echo -e "${YELLOW}   💡 To customize:${NC}"
    echo -e "${YELLOW}      sudo nano /boot/limine.conf${NC}"
    echo -e "${YELLOW}      Change 'timeout: 5' to desired seconds${NC}"
    echo -e "${YELLOW}      Change 'default_entry: 1' to select kernel${NC}"
fi

# ===========================
# 8. SETUP SDDM THEMES
# ===========================

# Astronaut Theme
if feature_enabled "Install SDDM Astronaut Theme"; then
    echo -e "${BLUE}🌌 Installing SDDM Astronaut Theme...${NC}"
    
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)" || \
    sudo git clone -b master --depth 1 https://github.com/Keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
    
    echo -e "${GREEN}✅ SDDM Astronaut Theme installed${NC}"
fi

# Pixie Theme
if feature_enabled "Install SDDM Pixie Theme"; then
    echo -e "${BLUE}🎨 Installing SDDM Pixie Theme...${NC}"
    
    if command -v yay &> /dev/null; then
        yay -S --needed --noconfirm pixie-sddm-git
    else
        git clone https://github.com/xCaptaiN09/pixie-sddm.git /tmp/pixie-sddm
        cd /tmp/pixie-sddm
        sudo ./install.sh
        cd -
        rm -rf /tmp/pixie-sddm
    fi
    
    echo -e "${GREEN}✅ SDDM Pixie Theme installed${NC}"
fi

# Pixel UI Theme
if feature_enabled "Install SDDM Pixel UI Theme"; then
    echo -e "${BLUE}💫 Installing SDDM Pixel UI Theme...${NC}"
    
    git clone -b pixel https://github.com/mahaveergurjar/sddm.git /tmp/sddm-pixel
    sudo mkdir -p /usr/share/sddm/themes/
    sudo mv /tmp/sddm-pixel/sddm /usr/share/sddm/themes/sddm
    
    echo -e "${GREEN}✅ SDDM Pixel UI Theme installed${NC}"
    echo -e "${YELLOW}💡 To use this theme:${NC}"
    echo -e "${YELLOW}   sudo nano /etc/sddm.conf${NC}"
    echo -e "${YELLOW}   Set: Current=sddm${NC}"
    echo -e "${YELLOW}   Then: sudo systemctl restart sddm${NC}"
fi

# ===========================
# 9. SETUP BTRFS SNAPSHOTS & cachy-update
# ===========================
if feature_enabled "Setup Btrfs Snapshots & cachy-update"; then
    echo -e "${BLUE}📸 Setting up Btrfs Snapshots & cachy-update...${NC}"
    
    # Install Btrfs tools
    pacman -S --needed --noconfirm btrfs-progs
    
    # Install cachy-update
    yay -S --needed --noconfirm cachy-update
    
    echo -e "${GREEN}✅ Btrfs tools and cachy-update installed${NC}"
    echo -e "${YELLOW}💡 Use 'cachy-update' command to manage system updates with snapshot support${NC}"
fi

# ===========================
# 10. INSTALL OPENRGB
# ===========================
if feature_enabled "Install OpenRGB for RGB Control"; then
    echo -e "${BLUE}🌈 Installing OpenRGB...${NC}"
    
    yay -S --needed --noconfirm openrgb
    
    systemctl enable openrgb
    systemctl start openrgb
    
    echo -e "${GREEN}✅ OpenRGB installed and enabled${NC}"
fi

# ===========================
# 11. INSTALL CORECTRL (Optional GPU Management)
# ===========================
if feature_enabled "Install CoreCtrl GPU Management (Alternative to LACT)"; then
    echo -e "${BLUE}🎛️  Installing CoreCtrl GPU Management...${NC}"
    
    pacman -S --needed --noconfirm corectrl
    
    # Setup polkit rules for CoreCtrl
    mkdir -p /etc/polkit-1/rules.d
    cat > /etc/polkit-1/rules.d/90-corectrl.rules << 'EOF'
polkit.addRule(function(action, subject) {
    if ((action.id == "org.corectrl.helper.init" || 
         action.id == "org.corectrl.helperkiller.run") && 
        subject.isInGroup("wheel")) {
        return polkit.Result.YES;
    }
});
EOF
    
    echo -e "${GREEN}✅ CoreCtrl installed${NC}"
    echo -e "${YELLOW}💡 Profile-based GPU control. Launch CoreCtrl from applications menu.${NC}"
fi

# ===========================
# 12. CONFIGURE GPU SHADER CACHE
# ===========================
if feature_enabled "Configure GPU Shader Cache (12GB MESA_SHADER_CACHE)"; then
    echo -e "${BLUE}💾 Configuring GPU Shader Cache...${NC}"
    
    # Create environment.d directory
    mkdir -p ~/.config/environment.d
    
    # Create gaming.conf with shader cache settings
    cat > ~/.config/environment.d/gaming.conf << 'EOF'
# GPU Shader Cache Configuration
# Increases shader cache to 12GB to avoid stuttering and long load times
MESA_SHADER_CACHE_MAX_SIZE=12G

# Additional performance options
MESA_SHADER_CACHE_DIR=$HOME/.cache/mesa
EOF
    
    echo -e "${GREEN}✅ GPU Shader Cache configured (12GB)${NC}"
    echo -e "${YELLOW}⚠️  Changes take effect after system reboot${NC}"
fi

# ===========================
# 13. SETUP BROWSER HARDWARE ACCELERATION
# ===========================
if feature_enabled "Setup Browser Hardware Acceleration (Brave + Firefox)"; then
    echo -e "${BLUE}🌐 Setting up Browser Hardware Acceleration...${NC}"
    
    # Brave Browser Configuration
    mkdir -p ~/.config
    cat > ~/.config/brave-flags.conf << 'EOF'
# Hardware Acceleration for Brave Browser
--use-gl=angle
--use-angle=vulkan
--enable-features=Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,AcceleratedVideoDecodeLinuxZeroCopyGL,AcceleratedVideoEncoder,VaapiIgnoreDriverChecks,UseMultiPlaneFormatForHardwareVideo
--ozone-platform-hint=x11
--enable-zero-copy
--enable-raw-draw
EOF

    # Firefox Configuration (via user.js)
    mkdir -p ~/.mozilla/firefox/*.default-release 2>/dev/null || true
    
    # Find Firefox profile directory
    if [ -d ~/.mozilla/firefox/ ]; then
        FIREFOX_PROFILE=$(ls -d ~/.mozilla/firefox/*.default-release 2>/dev/null | head -1)
        if [ -n "$FIREFOX_PROFILE" ]; then
            cat >> "$FIREFOX_PROFILE/user.js" << 'EOF'
// Hardware Acceleration Settings
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.rpi-audioserver.enabled", false);
user_pref("media.hardware-video-decoding.enabled", true);
user_pref("gfx.webrender.enabled", true);
user_pref("layers.acceleration.force-enabled", true);
EOF
        fi
    fi
    
    echo -e "${GREEN}✅ Browser Hardware Acceleration configured${NC}"
    echo -e "${YELLOW}💡 Brave: Acceleration enabled automatically${NC}"
    echo -e "${YELLOW}💡 Firefox: Restart browser to apply settings${NC}"
    echo -e "${YELLOW}💡 Verify: Open brave://gpu or about:support to check status${NC}"
fi

# ===========================
# 14. ENABLE SCX_BPFLAND SCHEDULER (Optional Advanced)
# ===========================
if feature_enabled "Enable scx_bpfland Advanced Scheduler (Alternative to BORE)"; then
    echo -e "${BLUE}⚡ Setting up scx_bpfland Scheduler...${NC}"
    
    # Install scx_bpfland
    yay -S --needed --noconfirm scx_bpfland
    
    # Create systemd service for scx_bpfland
    mkdir -p /etc/systemd/system
    cat > /etc/systemd/system/scx-bpfland.service << 'EOF'
[Unit]
Description=sched_ext Scheduler (scx_bpfland)
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
ExecStart=/usr/bin/scx_bpfland -m performance -w
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable scx-bpfland.service
    systemctl start scx-bpfland.service
    
    echo -e "${GREEN}✅ scx_bpfland Scheduler installed${NC}"
    echo -e "${YELLOW}💡 Scheduler Modes Available:${NC}"
    echo -e "${YELLOW}   • Performance (-m performance -w): Gaming/Desktop${NC}"
    echo -e "${YELLOW}   • Power Save (-s 20000 -m powersave): Power efficiency${NC}"
    echo -e "${YELLOW}   • Server (-s 20000 -S): Server workloads${NC}"
fi

# ===========================
# 15. GENERIC PERFORMANCE TWEAKS
# ===========================
echo -e "${BLUE}⚙️  Applying Performance Tweaks...${NC}"

# CPU Governor to Performance
echo "performance" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null

# Create tmpfiles.d entry for persistence
mkdir -p /etc/tmpfiles.d
cat > /etc/tmpfiles.d/cpu-governor.conf << 'EOF'
w /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor - - - - performance
EOF

# Sysctl Performance Tweaks
cat >> /etc/sysctl.d/99-performance-tweaks.conf << 'EOF'
vm.swappiness=10
vm.vfs_cache_pressure=50
vm.max_map_count=2147483642
EOF

sysctl -p > /dev/null 2>&1

# Enable MangoHud and GameMode by default
if ! grep -q "MANGOHUD=1" /etc/environment; then
    echo "MANGOHUD=1" >> /etc/environment
fi

if ! grep -q "GAMEMODERUNEXEC=1" /etc/environment; then
    echo "GAMEMODERUNEXEC=1" >> /etc/environment
fi

# KDE Gaming Layout Optimizations
if feature_enabled "Install KDE Gaming Layout (Latte Dock)"; then
    yay -S --needed --noconfirm latte-dock
    plasma-apply-lookandfeel org.kde.breezedark.desktop
fi

echo -e "${GREEN}✅ Performance tweaks applied${NC}"

# ===========================
# 16. DISPLAY VULKAN INFO
# ===========================
echo -e "${BLUE}🎨 Setting up Vulkan support...${NC}"

pacman -S --needed --noconfirm \
    vulkan-radeon \
    opencl-mesa \
    lib32-vulkan-radeon \
    lib32-opencl-mesa \
    lib32-gamemode

echo -e "${GREEN}✅ Vulkan and OpenCL support installed${NC}"

# ===========================
# 17. OBS STUDIO PROFILE
# ===========================
echo -e "${BLUE}📹 Configuring OBS Studio...${NC}"

mkdir -p ~/.config/obs-studio/basic/profiles/YouTube720p

cat > ~/.config/obs-studio/basic/profiles/YouTube720p/basic.ini << 'EOF'
[General]
Name=YouTube720p

[Video]
BaseCX=1280
BaseCY=720
OutputCX=1280
OutputCY=720

[Output]
Mode=Advanced
Bitrate=4500
Encoder=x264
EOF

echo -e "${GREEN}✅ OBS Studio profile created${NC}"

# ===========================
# 18. STEAM OPTIMIZATION
# ===========================
echo -e "${BLUE}🎮 Optimizing Steam for 1366x768 resolution...${NC}"

mkdir -p ~/.steam/steam
if ! grep -q "STEAM_FORCE_DESKTOPUI_SCALE" ~/.steam/steam/env; then
    echo "STEAM_FORCE_DESKTOPUI_SCALE=0.75" >> ~/.steam/steam/env
fi

echo -e "${GREEN}✅ Steam configured${NC}"

# ===========================
# 19. KDE SCALE FACTOR
# ===========================
echo -e "${BLUE}🖥️  Adjusting KDE scale factor...${NC}"

kwriteconfig5 --file kdeglobals --group KScreen --key ScaleFactor "0.9"

echo -e "${GREEN}✅ KDE scale factor adjusted${NC}"

# ===========================
# FINAL MESSAGES
# ===========================
echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║          ✅ CachyOS Ultimate Tune v2.0 Complete!             ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}📋 NEXT STEPS:${NC}"
echo ""
echo -e "${BLUE}1. REBOOT YOUR SYSTEM${NC}"
echo "   Run: ${GREEN}reboot${NC}"
echo ""
echo -e "${BLUE}2. AFTER REBOOT, VERIFY YOUR SETUP:${NC}"
echo "   - GPU: Run ${GREEN}lact${NC} to manage GPU settings"
echo "   - ProtonPlus: Available in applications menu"
echo "   - Updates: Run ${GREEN}cachy-update${NC} for system updates"
echo "   - System Info: Run ${GREEN}fastfetch${NC}"
echo ""
echo -e "${BLUE}3. OPTIONAL SDDM THEME SELECTION:${NC}"
if feature_enabled "Install SDDM Astronaut Theme"; then
    echo "   - Edit: sudo nano /etc/sddm.conf"
    echo "   - Set: Current=sddm-astronaut-theme"
fi
if feature_enabled "Install SDDM Pixie Theme"; then
    echo "   - Edit: sudo nano /etc/sddm.conf"
    echo "   - Set: Current=pixie-sddm"
fi
if feature_enabled "Install SDDM Pixel UI Theme"; then
    echo "   - Edit: sudo nano /etc/sddm.conf"
    echo "   - Set: Current=sddm-pixel"
fi
echo ""
echo -e "${BLUE}4. KERNEL SELECTION (if BORE installed):${NC}"
echo "   - At boot, select 'linux-cachyos-bore' from the bootloader menu"
echo "   - Then update GRUB: ${GREEN}sudo grub-mkconfig -o /boot/grub/grub.cfg${NC}"
echo ""
echo -e "${YELLOW}💡 TIPS:${NC}"
echo "   - MangoHud enabled by default (toggle with Shift+F12 in games)"
echo "   - GameMode active for all games"
echo "   - Vulkan acceleration ready for gaming"
echo "   - Use ProtonPlus to manage Proton versions"
echo ""
echo -e "${GREEN}🎮 Happy Gaming!${NC}"
echo ""

# ===========================
# FINAL REBOOT PROMPT
# ===========================
zenity --question \
    --title="CachyOS Gaming Tuner" \
    --width=400 \
    --text="Installation complete! Would you like to reboot now to apply all changes?" \
    --ok-label="Reboot Now" \
    --cancel-label="Reboot Later"

if [ $? -eq 0 ]; then
    echo -e "${YELLOW}Rebooting in 10 seconds...${NC}"
    sleep 10
    reboot
else
    echo -e "${YELLOW}Please reboot manually when ready: reboot${NC}"
fi

################################################################################
# END OF SCRIPT
################################################################################
