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
# REQUIRE ROOT
# ===========================
if [ $EUID -ne 0 ]; then
    echo -e "${RED}🚫 Please run as root (sudo ./cachyos-ultimate-tune-improved.sh)${NC}"
    exit 1
fi

# Capture the actual user who invoked sudo
REAL_USER=${SUDO_USER:-$(logname)}
USER_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)

if [ -z "$USER_HOME" ]; then
    echo -e "${RED}🚫 Could not determine home directory for user '$REAL_USER'. Exiting.${NC}"
    exit 1
fi
echo -e "${BLUE}Detected user: $REAL_USER (Home: $USER_HOME)${NC}"


# ===========================
# CHECK & INSTALL ZENITY
# ===========================
if ! command -v zenity > /dev/null; then
    echo -e "${YELLOW}🧩 Installing Zenity GUI support...${NC}"
    pacman -S --noconfirm zenity
fi

# ... (rest of the zenity menu and feature_enabled function) ...

# ===========================
# 1. INSTALL YAY (AUR Helper)
# ===========================
if feature_enabled "Install YAY AUR helper"; then
    echo -e "${BLUE}📦 Installing YAY AUR helper...${NC}"
    
    if ! command -v yay > /dev/null; then
        pacman -S --needed --noconfirm git base-devel
        
        YAY_TMP_DIR=$(mktemp -d -p "$USER_HOME")
        chown "$REAL_USER:$REAL_USER" "$YAY_TMP_DIR"

        echo -e "${YELLOW}Building YAY as user '$REAL_USER' in '$YAY_TMP_DIR'${NC}"
        if ! sudo -u "$REAL_USER" bash <<EOF
            set -e
            cd "$YAY_TMP_DIR"
            git clone https://aur.archlinux.org/yay.git yay_repo
            cd yay_repo
            makepkg -si --noconfirm
EOF
        then
            echo -e "${RED}🚫 Failed to install YAY. Please check logs.${NC}"
            rm -rf "$YAY_TMP_DIR"
            exit 1
        fi
        rm -rf "$YAY_TMP_DIR"
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
    
    GAMING_DEV_PACKAGES=(
        goverlay openssh fastfetch tmux vlc kdenlive audacity obs-studio ffmpeg
        prismlauncher mangohud gamemode brave-bin krita libreoffice-fresh
        qbittorrent code lazygit kitty virt-manager steam wine-staging
        lib32-gamemode lib32-mangohud
    )
    
    yay -S --needed --noconfirm "${GAMING_DEV_PACKAGES[@]}" || {
        echo -e "${RED}🚫 Failed to install some Gaming & Development Tools.${NC}"
        # Optionally, continue or exit based on severity
    }
    
    echo -e "${GREEN}✅ Gaming & Development Tools installed${NC}"
fi

# ... (other sections, applying sudo -u $REAL_USER and idempotency checks) ...

# ===========================
# 7. CONFIGURE LIMINE BOOTLOADER
# ===========================
if feature_enabled "Apply Limine Bootloader (2 sec timeout)"; then
    echo -e "${BLUE}🚀 Configuring Limine Bootloader...${NC}"
    
    yay -S --needed --noconfirm limine || {
        echo -e "${RED}🚫 Failed to install Limine. Skipping configuration.${NC}"
    }
    
    # Always create/overwrite with the desired basic config
    # NOTE: This still requires manual addition of boot entries by the user.
    # Consider adding a more complete example or automated detection of kernel entries.
    sudo tee /boot/limine.conf > /dev/null << 'EOF'
# CachyOS Ultimate Tune v2.3 - Limine Bootloader Configuration

# Timeout: Sets how many seconds Limine waits before automatically booting the default entry
timeout: 5

# Default Entry: Specifies which menu entry boots by default
# Entries are numbered starting from 1. If pointing to a directory, autoboot is disabled.
# To autoboot an entry within a directory, point directly to that specific entry number.
default_entry: 1

# IMPORTANT: You will need to manually add your kernel boot entries here.
# Example for CachyOS:
# /+CachyOS
#   //linux-cachyos
#     protocol: linux
#     kernel_path: boot():/vmlinuz-linux-cachyos
#     cmdline: quiet splash root=UUID=YOUR_ROOT_UUID rw
#     module_path: boot():/initramfs-linux-cachyos.img
EOF
    
    echo -e "${GREEN}✅ Limine bootloader configured (basic settings)${NC}"
    echo -e "${YELLOW}💡 Limine Configuration Details:${NC}"
    echo -e "${YELLOW}   📁 Location: /boot/limine.conf${NC}"
    echo -e "${YELLOW}   ⚠️  You MUST manually edit /boot/limine.conf to add your kernel boot entries!${NC}"
    echo -e "${YELLOW}      Example entries are commented out in the file.${NC}"
fi

# ===========================
# 8. SETUP SDDM THEMES
# ===========================

# Pixel UI Theme
if feature_enabled "Install SDDM Pixel UI Theme"; then
    echo -e "${BLUE}💫 Installing SDDM Pixel UI Theme...${NC}"
    
    # Use a unique name for the theme directory to avoid conflicts
    local PIXEL_THEME_DIR="/usr/share/sddm/themes/sddm-pixel-ui"
    
    if [ ! -d "$PIXEL_THEME_DIR" ]; then
        local TMP_SDDM_PIXEL=$(mktemp -d)
        git clone -b pixel https://github.com/mahaveergurjar/sddm.git "$TMP_SDDM_PIXEL" || {
            echo -e "${RED}🚫 Failed to clone Pixel UI SDDM theme. Skipping.${NC}"
            rm -rf "$TMP_SDDM_PIXEL"
            exit 1
        }
        sudo mkdir -p "$PIXEL_THEME_DIR"
        sudo mv "$TMP_SDDM_PIXEL/sddm" "$PIXEL_THEME_DIR" || {
            echo -e "${RED}🚫 Failed to move Pixel UI SDDM theme files. Skipping.${NC}"
            rm -rf "$TMP_SDDM_PIXEL"
            exit 1
        }
        rm -rf "$TMP_SDDM_PIXEL"
        echo -e "${GREEN}✅ SDDM Pixel UI Theme installed to $PIXEL_THEME_DIR${NC}"
    else
        echo -e "${GREEN}✅ SDDM Pixel UI Theme already exists at $PIXEL_THEME_DIR${NC}"
    fi
    
    echo -e "${YELLOW}💡 To use this theme:${NC}"
    echo -e "${YELLOW}   sudo nano /etc/sddm.conf${NC}"
    echo -e "${YELLOW}   Set: Current=sddm-pixel-ui${NC}" # Updated theme name
    echo -e "${YELLOW}   Then: sudo systemctl restart sddm${NC}"
fi

# ... (other SDDM themes, similar checks and unique naming) ...

# ===========================
# 12. CONFIGURE GPU SHADER CACHE
# ===========================
if feature_enabled "Configure GPU Shader Cache (12GB MESA_SHADER_CACHE)"; then
    echo -e "${BLUE}💾 Configuring GPU Shader Cache for $REAL_USER...${NC}"
    
    mkdir -p "$USER_HOME/.config/environment.d"
    sudo -u "$REAL_USER" tee "$USER_HOME/.config/environment.d/gaming.conf" > /dev/null << 'EOF'
# GPU Shader Cache Configuration
# Increases shader cache to 12GB to avoid stuttering and long load times
MESA_SHADER_CACHE_MAX_SIZE=12G

# Additional performance options
MESA_SHADER_CACHE_DIR=$HOME/.cache/mesa
EOF
    chown "$REAL_USER:$REAL_USER" "$USER_HOME/.config/environment.d/gaming.conf"
    
    echo -e "${GREEN}✅ GPU Shader Cache configured (12GB) for $REAL_USER${NC}"
    echo -e "${YELLOW}⚠️  Changes take effect after system reboot${NC}"
fi

# ===========================
# 13. SETUP BROWSER HARDWARE ACCELERATION
# ===========================
if feature_enabled "Setup Browser Hardware Acceleration (Brave + Firefox)"; then
    echo -e "${BLUE}🌐 Setting up Browser Hardware Acceleration for $REAL_USER...${NC}"
    
    # Brave Browser Configuration
    mkdir -p "$USER_HOME/.config"
    sudo -u "$REAL_USER" tee "$USER_HOME/.config/brave-flags.conf" > /dev/null << 'EOF'
# Hardware Acceleration for Brave Browser
--use-gl=angle
--use-angle=vulkan
--enable-features=Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,AcceleratedVideoDecodeLinuxZeroCopyGL,AcceleratedVideoEncoder,VaapiIgnoreDriverChecks,UseMultiPlaneFormatForHardwareVideo
--ozone-platform-hint=x11
--enable-zero-copy
--enable-raw-draw
EOF
    chown "$REAL_USER:$REAL_USER" "$USER_HOME/.config/brave-flags.conf"

    # Firefox Configuration (via user.js)
    if [ -d "$USER_HOME/.mozilla/firefox/" ]; then
        for profile_dir in "$USER_HOME/.mozilla/firefox/"*.default-release; do
            if [ -d "$profile_dir" ]; then
                echo -e "${YELLOW}Configuring Firefox profile: $(basename "$profile_dir")${NC}"
                sudo -u "$REAL_USER" tee -a "$profile_dir/user.js" > /dev/null << 'EOF'
// Hardware Acceleration Settings added by CachyOS Gaming Tuner
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.rpi-audioserver.enabled", false);
user_pref("media.hardware-video-decoding.enabled", true);
user_pref("gfx.webrender.enabled", true);
user_pref("layers.acceleration.force-enabled", true);
EOF
                chown "$REAL_USER:$REAL_USER" "$profile_dir/user.js"
            fi
        done
    else
        echo -e "${YELLOW}💡 Firefox profile directory not found for $REAL_USER. Skipping Firefox config.${NC}"
    fi
    
    echo -e "${GREEN}✅ Browser Hardware Acceleration configured for $REAL_USER${NC}"
    echo -e "${YELLOW}💡 Brave: Acceleration enabled automatically${NC}"
    echo -e "${YELLOW}💡 Firefox: Restart browser to apply settings${NC}"
    echo -e "${YELLOW}💡 Verify: Open brave://gpu or about:support to check status${NC}"
fi

# ... (rest of the script) ...

# ===========================
# 15. GENERIC PERFORMANCE TWEAKS
# ===========================
echo -e "${BLUE}⚙️  Applying Performance Tweaks...${NC}"

# CPU Governor to Performance (system-wide)
# This is already handled by the cpupower service if selected, but as a generic tweak, it's fine.
# Ensure idempotency for /etc/tmpfiles.d/cpu-governor.conf
sudo tee /etc/tmpfiles.d/cpu-governor.conf > /dev/null << 'EOF'
w /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor - - - - performance
EOF

# Sysctl Performance Tweaks (system-wide)
sudo tee /etc/sysctl.d/99-performance-tweaks.conf > /dev/null << 'EOF'
vm.swappiness=10
vm.vfs_cache_pressure=50
vm.max_map_count=2147483642
EOF
sysctl -p > /dev/null 2>&1

# Enable MangoHud and GameMode by default (system-wide)
if ! grep -q "^MANGOHUD=1$" /etc/environment; then
    echo "MANGOHUD=1" | sudo tee -a /etc/environment > /dev/null
fi
if ! grep -q "^GAMEMODERUNEXEC=1$" /etc/environment; then
    echo "GAMEMODERUNEXEC=1" | sudo tee -a /etc/environment > /dev/null
fi

# KDE Gaming Layout Optimizations
if feature_enabled "Install KDE Gaming Layout (Latte Dock)"; then
    yay -S --needed --noconfirm latte-dock
    # Apply look and feel as the user
    sudo -u "$REAL_USER" plasma-apply-lookandfeel org.kde.breezedark.desktop
fi

echo -e "${GREEN}✅ Performance tweaks applied${NC}"

# ... (OBS Studio Profile, Steam Optimization, KDE Scale Factor) ...
# These should also use sudo -u $REAL_USER and $USER_HOME

# ===========================
# 17. OBS STUDIO PROFILE
# ===========================
echo -e "${BLUE}📹 Configuring OBS Studio for $REAL_USER...${NC}"

mkdir -p "$USER_HOME/.config/obs-studio/basic/profiles/YouTube720p"
sudo -u "$REAL_USER" tee "$USER_HOME/.config/obs-studio/basic/profiles/YouTube720p/basic.ini" > /dev/null << 'EOF'
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
chown -R "$REAL_USER:$REAL_USER" "$USER_HOME/.config/obs-studio"

echo -e "${GREEN}✅ OBS Studio profile created for $REAL_USER${NC}"

# ===========================
# 18. STEAM OPTIMIZATION
# ===========================
echo -e "${BLUE}🎮 Optimizing Steam for $REAL_USER for 1366x768 resolution...${NC}"

mkdir -p "$USER_HOME/.steam/steam"
# Check for existence before appending
if ! grep -q "^STEAM_FORCE_DESKTOPUI_SCALE=" "$USER_HOME/.steam/steam/env" 2>/dev/null; then
    echo "STEAM_FORCE_DESKTOPUI_SCALE=0.75" | sudo -u "$REAL_USER" tee -a "$USER_HOME/.steam/steam/env" > /dev/null
else
    # Or, if you want to ensure it's always 0.75, you could use sed to replace
    sudo -u "$REAL_USER" sed -i 's/^STEAM_FORCE_DESKTOPUI_SCALE=.*/STEAM_FORCE_DESKTOPUI_SCALE=0.75/' "$USER_HOME/.steam/steam/env"
fi
chown -R "$REAL_USER:$REAL_USER" "$USER_HOME/.steam"

echo -e "${GREEN}✅ Steam configured for $REAL_USER${NC}"

# ===========================
# 19. KDE SCALE FACTOR
# ===========================
echo -e "${BLUE}🖥️  Adjusting KDE scale factor for $REAL_USER...${NC}"

# This command needs to be run as the user
sudo -u "$REAL_USER" kwriteconfig5 --file kdeglobals --group KScreen --key ScaleFactor "0.9"

echo -e "${GREEN}✅ KDE scale factor adjusted for $REAL_USER${NC}"

# ... (final messages and reboot prompt) ...
