# CachyOS Ultimate Gaming Tune v2.0 🎮

**A comprehensive system optimization script for CachyOS with RX 6800 + KDE Gaming Setup**

**📍 Repository:** https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide

---

## 🎯 What's New in v2.0

### ✨ Major Improvements

#### 1. **YAY AUR Helper Integration**
   - Automatically installs and configures YAY
   - Enables access to AUR packages with a single command
   - Installs 20+ gaming and development tools in one go

#### 2. **Limine Bootloader** (Replaces GRUB)
   ```bash
   # Features:
   - Modern bootloader with 2-second timeout
   - Better performance than GRUB
   - Cleaner boot experience
   ```

#### 3. **BORE Scheduler Kernel** (linux-cachyos-bore)
   - **BORE**: Burst-Oriented Response Enhancer
   - Optimal for gaming with better responsiveness
   - Alternative to standard CachyOS kernel
   - Provides smoother gameplay during intensive workloads
   
#### 4. **LACT GPU Management** (Replaces CoreCtrl)
   ```bash
   # Advanced GPU overclocking and monitoring:
   - Real-time GPU metrics
   - Fan curve management
   - Power limit adjustment
   - Better UI/UX than CoreCtrl
   - Launch from applications menu
   ```

#### 5. **ProtonPlus** (Replaces ProtonUp-Qt)
   - Modern Proton version manager
   - Better compatibility tracking
   - Improved UI
   - Available as `protonplus` command

#### 6. **Multiple SDDM Login Themes**
   - **Astronaut Theme**: Beautiful space-themed login screen
   - **Pixie Theme**: Sleek, modern login interface
   - **Pixel UI Theme**: Minimalist, futuristic design
   - Choose which to install during setup

#### 7. **cachy-update Integration**
   ```bash
   # Arch-friendly update manager with:
   - Pre/post update notifications
   - Btrfs snapshot support
   - System tray applet
   - Run: cachy-update
   ```

#### 8. **Btrfs Snapshot Support**
   ```bash
   # Full snapshot management:
   - Subvolume layout for easy rollbacks
   - limine-snapper-sync support
   - Transparent compression
   - Safe system updates
   ```

#### 9. **OpenRGB Support**
   - Control RGB lighting across hardware
   - System-wide RGB synchronization
   - Hardware compatibility for gaming rigs

#### 10. **Enhanced System-Wide Tools**
   - **fastfetch**: Fast system info display
   - **lazygit**: Terminal-based Git management
   - **kitty**: GPU-accelerated terminal
   - **virt-manager**: Virtual machine management
   - And 15+ more tools!

---

## 📦 Complete Tool Installation List

When you select "Install Gaming & Dev Tools", you get:

### 🎮 Gaming
- `steam` - Steam game platform
- `prismlauncher` - Minecraft launcher
- `wine-staging` - Windows compatibility layer
- `gamemode` + `mangohud` - Gaming optimization & performance overlay

### 📹 Content Creation
- `obs-studio` - Streaming/recording software
- `kdenlive` - Video editor
- `audacity` - Audio editor
- `ffmpeg` - Video/audio processing

### 💻 Development
- `code` - VS Code
- `lazygit` - Git management
- `kitty` - Terminal emulator
- `tmux` - Terminal multiplexer
- `base-devel` - Build tools

### 🎨 Creative
- `krita` - Digital painting
- `libreoffice-fresh` - Office suite
- `blender` - 3D modeler (optional addition)

### 🛠️ Utilities
- `fastfetch` - System info
- `openssh` - SSH utilities
- `vlc` - Media player
- `qbittorrent` - Torrent client
- `brave-bin` - Privacy browser
- `goverlay` - Game overlay manager

---

## 🚀 Installation Instructions

### Prerequisites
- CachyOS installation with KDE Plasma
- Root/sudo access
- Internet connection
- ~5GB free disk space (for all tools)

---

## 📥 Installation Steps

### **Step 1: Download the Script**

**Option A - Download with wget:**
```bash
wget https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide/raw/main/cachyos-ultimate-tune-improved.sh
```

**Option B - Clone the repository:**
```bash
git clone https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide.git
cd CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide
```

---

### **Step 2: Make Executable**

```bash
chmod +x cachyos-ultimate-tune-improved.sh
```

---

### **Step 3: Run with Root**

```bash
sudo ./cachyos-ultimate-tune-improved.sh
```

---

### Step 4: Select Features
A GUI window will appear showing all available features. Check the boxes for what you want:
- ✅ Enabled by default (recommended)
- ☐ Disabled by default (optional)

### Step 5: Watch the Magic
The script will:
1. Install YAY if needed
2. Install all selected tools
3. Configure your system
4. Apply performance tweaks
5. Prompt you to reboot

---

## ⚙️ Feature Descriptions

### Enabled by Default ✅

| Feature | Purpose |
|---------|---------|
| YAY AUR Helper | Access to thousands of AUR packages |
| Gaming & Dev Tools | 20+ essential gaming and development applications |
| BORE Scheduler | Better game responsiveness |
| LACT GPU Mgmt | Advanced AMD GPU overclocking |
| MangoHud + GameMode | FPS overlay + gaming optimization |
| ProtonPlus | Manage Proton versions for Windows games |
| Limine Bootloader | Fast 2-second boot (replaces GRUB) |

### Disabled by Default (Optional) ☐

| Feature | Purpose |
|---------|---------|
| SDDM Astronaut | Beautiful space-themed login screen |
| SDDM Pixie | Modern minimal login theme |
| SDDM Pixel UI | Futuristic pixel art login |
| Btrfs Snapshots | System backup & recovery |
| OpenRGB | Control RGB lighting |
| KDE Gaming Layout | Optimized KDE for gaming |

---

## 🎮 After Installation: Quick Start

### 1. **Reboot**
```bash
reboot
```

### 2. **Verify GPU Management**
```bash
# Open LACT GUI
lact
```

### 3. **Check System Info**
```bash
fastfetch
```

### 4. **Run System Updates**
```bash
cachy-update
```

### 5. **Manage Proton Versions**
```bash
# Open ProtonPlus GUI
protonplus
```

### 6. **Boot Kernel Selection** (if BORE installed)
- At GRUB boot menu, select `linux-cachyos-bore`
- Press Enter
- After boot, update GRUB:
```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

---

## 🎯 GPU Overclocking with LACT

1. **Open LACT**
   - Applications → LACT

2. **GPU Tab Settings**
   - Core Clock: +50-150 MHz (depending on silicon)
   - Memory Clock: +100-300 MHz
   - Power Limit: 250-310W (for RX 6800)

3. **Fan Curve**
   - Set custom temperature thresholds
   - LACT automatically applies on system reboot

4. **Monitoring**
   - Real-time GPU usage
   - Temperature tracking
   - Power consumption display

---

## 📊 BORE Scheduler Kernel Setup

### Enable BORE Kernel

1. **In bootloader menu:**
   - Select `linux-cachyos-bore` entry
   - Press Enter

2. **Make it default:**
```bash
sudo nano /etc/default/grub
# Change: GRUB_DEFAULT=0  to  GRUB_DEFAULT="CachyOS on ... linux-cachyos-bore"
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

3. **Verify active kernel:**
```bash
uname -r
# Should show: something-cachyos-bore
```

### Performance Benefits
- ⚡ Better responsiveness during gaming
- 📊 Reduced frame time variance
- 🎮 Smoother gameplay
- 💾 Optimized for intensive workloads

---

## 🖼️ SDDM Theme Configuration

### Astronaut Theme
```bash
sudo nano /etc/sddm.conf
# Set: Current=sddm-astronaut-theme
sudo systemctl restart sddm
```

### Pixie Theme
```bash
sudo nano /etc/sddm.conf
# Set: Current=pixie-sddm
sudo systemctl restart sddm
```

### Pixel UI Theme
```bash
sudo nano /etc/sddm.conf
# Set: Current=sddm-pixel
sudo systemctl restart sddm
```

---

## 🔧 Manual Adjustments

### Steam Scale Factor
```bash
# Edit if resolution is wrong:
nano ~/.steam/steam/env
# Change: STEAM_FORCE_DESKTOPUI_SCALE=0.75
```

### OBS Resolution
```bash
# Edit OBS profile:
nano ~/.config/obs-studio/basic/profiles/YouTube720p/basic.ini
# Change BaseCX and OutputCX/OutputCY values
```

### KDE Scale Factor
```bash
# Adjust for your monitor:
kwriteconfig5 --file kdeglobals --group KScreen --key ScaleFactor "1.0"
# Values: 0.8, 0.9, 1.0, 1.1, 1.25, 1.5
```

---

## 📋 System Requirements

- **Distro**: CachyOS (Arch Linux-based)
- **CPU**: Any (optimized for modern AMD)
- **GPU**: AMD Radeon (RX 6800 preferred, others compatible)
- **RAM**: 8GB minimum, 16GB recommended
- **Storage**: 100GB (for full installation with tools)
- **Desktop**: KDE Plasma 6.x

---

## ⚠️ Troubleshooting

### Script Permission Denied
```bash
chmod +x cachyos-ultimate-tune-improved.sh
sudo ./cachyos-ultimate-tune-improved.sh
```

### Zenity not found
```bash
sudo pacman -S zenity
```

### LACT won't start
```bash
sudo systemctl restart lact
sudo usermod -a -G lact $USER
# Log out and log back in
```

### GPU not detected in LACT
```bash
# Check GPU drivers:
sudo pacman -S --noconfirm amdgpu-pro-libs
```

### BORE kernel missing from boot menu
```bash
# Reinstall and update:
sudo pacman -S linux-cachyos-bore linux-cachyos-bore-headers
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

---

## 🔄 Version History

### v2.0 (Current)
- ✨ Complete rewrite with 10+ major improvements
- 🔄 GRUB → Limine bootloader
- 🔄 CoreCtrl → LACT GPU management
- 🔄 ProtonUp-Qt → ProtonPlus
- ➕ BORE scheduler kernel support
- ➕ Multiple SDDM themes
- ➕ cachy-update integration
- ➕ Btrfs snapshot support
- ➕ 20+ gaming/dev tools installer

### v1.0 (Legacy)
- Original CachyOS gaming setup script

---

## 📚 Resources

**Main Repository:**
- **CachyOS Ultimate Tune v2.0**: https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide
  - Script: `cachyos-ultimate-tune-improved.sh`
  - Documentation: `CACHYOS_TUNE_README.md`
  - Quick Guide: `QUICK_START_GUIDE.md`

**Tool Repositories:**
- **LACT GPU Manager**: https://github.com/ilya-zlobintsev/LACT
- **BORE Scheduler**: https://github.com/firelzrd/bore-scheduler
- **ProtonPlus**: https://github.com/Vysp3r/ProtonPlus
- **ProtonPlus AUR**: https://aur.archlinux.org/packages/protonplus
- **cachy-update**: https://github.com/CachyOS/cachy-update
- **Limine Bootloader**: https://github.com/Limine-Bootloader/Limine

**SDDM Themes:**
- **Astronaut**: https://github.com/Keyitdev/sddm-astronaut-theme
- **Pixie**: https://github.com/xCaptaiN09/pixie-sddm
- **Pixel UI**: https://github.com/mahaveergurjar/sddm

**Official CachyOS:**
- **CachyOS Website**: https://cachyos.org
- **CachyOS GitHub**: https://github.com/CachyOS

---

## 🤝 Contributing

Found a bug? Have a suggestion?

1. Test the script
2. Report issues with:
   - Error messages
   - System specs
   - Steps to reproduce

3. Submit improvements via GitHub

---

## 📝 License

This script is provided as-is for CachyOS optimization purposes.
Use at your own risk. Always backup your system before major changes.

---

## 🎮 Happy Gaming! 

**Questions?** Check the troubleshooting section or open an issue on GitHub.

**Want to contribute?** Fork the repository and submit your improvements!

---

*Last updated: 01.04.2026  
*By: Alb Kestrel (Improved v2.0)*
