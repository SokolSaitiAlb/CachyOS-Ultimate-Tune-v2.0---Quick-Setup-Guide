# CachyOS Ultimate Tune v2.0 🎮

**Complete gaming optimization script for CachyOS with RX 6800 + KDE**

[![GitHub Release](https://img.shields.io/github/v/release/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide)](https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![CachyOS](https://img.shields.io/badge/CachyOS-Optimized-red)](https://cachyos.org)

---

## ⚡ Quick Install (One Command)

```bash
sudo bash -c "$(curl -fsSL https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide/raw/main/cachyos-ultimate-tune-improved.sh)"
```

**That's it!** The script will guide you through feature selection with an interactive menu.

---

## 📋 What This Script Does

✨ **Installs & Configures:**
- ✅ YAY AUR helper
- ✅ 20+ gaming & development tools
- ✅ BORE scheduler kernel (linux-cachyos-bore)
- ✅ LACT GPU management for AMD Radeon
- ✅ ProtonPlus for Windows games
- ✅ MangoHud + GameMode
- ✅ Limine bootloader (2-second timeout)
- ✅ Modern SDDM login themes
- ✅ Btrfs snapshots & cachy-update
- ✅ Performance system tweaks

---

## 🚀 Installation Methods

### Method 1: One-Liner (Fastest) ⚡
```bash
sudo bash -c "$(curl -fsSL https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide/raw/main/cachyos-ultimate-tune-improved.sh)"
```

### Method 2: Download & Run
```bash
wget https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide/raw/main/cachyos-ultimate-tune-improved.sh
chmod +x cachyos-ultimate-tune-improved.sh
sudo ./cachyos-ultimate-tune-improved.sh
```

### Method 3: Clone Repository
```bash
git clone https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide.git
cd CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide
sudo ./cachyos-ultimate-tune-improved.sh
```

---

## 📚 Documentation

- 📖 **[Full README](CACHYOS_TUNE_README.md)** - Comprehensive feature guide
- 🚀 **[Quick Start Guide](QUICK_START_GUIDE.md)** - Fast reference
- 🔧 **[Troubleshooting](CACHYOS_TUNE_README.md#-troubleshooting)** - Common issues

---

## ✨ Key Features

### 🎮 Gaming Tools (20+)
Steam, Wine, ProtonPlus, MangoHud, GameMode, OBS Studio, Kdenlive, Audacity, and more

### 💻 Development Tools
VS Code, lazygit, kitty terminal, tmux, git tools, base-devel

### 🖥️ System Optimization
- CPU governor set to performance
- ZRAM configuration for speed
- Sysctl performance tweaks
- Kernel scheduler (BORE)
- GPU management (LACT)

### 🌅 Beautiful Login
Choose from 3 modern SDDM themes:
- Astronaut Theme (space-inspired)
- Pixie Theme (modern minimal)
- Pixel UI Theme (futuristic)

---

## 🎯 System Requirements

| Requirement | Details |
|------------|---------|
| **Distro** | CachyOS (Arch Linux-based) |
| **Desktop** | KDE Plasma 6.x |
| **GPU** | AMD Radeon (RX 6800 optimal) |
| **RAM** | 8GB minimum, 16GB recommended |
| **Storage** | 100GB+ (for all tools) |
| **Root Access** | Required (sudo) |

---

## 🏃 Quick Start

1. **Run the script:**
   ```bash
   sudo bash -c "$(curl -fsSL https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide/raw/main/cachyos-ultimate-tune-improved.sh)"
   ```

2. **Select features** in the GUI menu (defaults are recommended)

3. **Reboot** when prompted

4. **Verify installation:**
   ```bash
   # Check GPU
   lact
   
   # View system info
   fastfetch
   
   # Update system
   cachy-update
   ```

---

## 🎮 After Installation

### GPU Management
```bash
lact  # Open LACT for GPU overclocking
```

### Proton Versions
```bash
protonplus  # Manage Windows game compatibility
```

### System Updates
```bash
cachy-update  # Safe updates with snapshots
```

### Performance Overlay
- Launch any game
- Press **Shift + F12** to toggle MangoHud FPS display

---

## 🔄 BORE Kernel Setup

To use the BORE scheduler for optimal gaming performance:

1. **At boot menu:** Select `linux-cachyos-bore`
2. **After boot:** 
   ```bash
   sudo grub-mkconfig -o /boot/grub/grub.cfg
   ```
3. **Verify:**
   ```bash
   uname -r  # Should show "-cachyos-bore"
   ```

---

## 🛠️ GPU Overclocking with LACT

Recommended for RX 6800:

1. Open **LACT** from applications
2. Go to **GPU** tab
3. Set:
   - **Core Clock:** +100 MHz
   - **Memory Clock:** +150 MHz
   - **Power Limit:** 280W
   - **Fan Curve:** Custom (30°=20%, 80°=100%)
4. Apply and reboot

---

## 📁 Repository Contents

```
.
├── cachyos-ultimate-tune-improved.sh    # Main installation script
├── CACHYOS_TUNE_README.md               # Full documentation
├── QUICK_START_GUIDE.md                 # Quick reference
└── README.md                            # This file
```

---

## 🆘 Troubleshooting

### Script won't run
```bash
chmod +x cachyos-ultimate-tune-improved.sh
sudo ./cachyos-ultimate-tune-improved.sh
```

### Zenity not found
```bash
sudo pacman -S zenity
```

### LACT won't open
```bash
sudo systemctl restart lact
sudo usermod -a -G lact $USER
# Log out and log back in
```

**More help:** See [Full Troubleshooting Guide](CACHYOS_TUNE_README.md#-troubleshooting)

---

## 📊 Performance Benchmarking

After installation, benchmark your setup:

### FPS in Games
- Enable MangoHud overlay (Shift+F12)
- Check "Avg FPS" counter

### GPU Benchmark
```bash
yay -S glxgears
glxgears
```

### CPU Performance
```bash
yay -S sysbench
sysbench cpu --cpu-max-prime=20000 run
```

---

## 🔗 Resources

### Main Repository
- **GitHub**: https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide

### Tools Used
- **LACT**: https://github.com/ilya-zlobintsev/LACT
- **BORE Scheduler**: https://github.com/firelzrd/bore-scheduler
- **ProtonPlus**: https://github.com/Vysp3r/ProtonPlus
- **cachy-update**: https://github.com/CachyOS/cachy-update
- **Limine Bootloader**: https://github.com/Limine-Bootloader/Limine

### SDDM Themes
- **Astronaut**: https://github.com/Keyitdev/sddm-astronaut-theme
- **Pixie**: https://github.com/xCaptaiN09/pixie-sddm
- **Pixel UI**: https://github.com/mahaveergurjar/sddm

### Community
- **CachyOS**: https://cachyos.org
- **CachyOS GitHub**: https://github.com/CachyOS

---

## 📝 Version History

### v2.0 (Current) ✨
- Complete rewrite with 10+ improvements
- GRUB → Limine bootloader
- CoreCtrl → LACT GPU management
- ProtonUp-Qt → ProtonPlus
- BORE kernel support
- 3 modern SDDM themes
- cachy-update integration
- 20+ gaming/dev tools installer

### v1.0 (Legacy)
- Original CachyOS gaming setup

---

## 🤝 Contributing

Found a bug or have a suggestion?

1. **Test the script**
2. **Report issues** with:
   - Error message
   - Your system specs
   - Steps to reproduce
3. **Submit pull requests** with improvements

---

## 📄 License

This project is provided as-is for CachyOS optimization purposes.

**Use at your own risk.** Always backup your system before major changes.

---

## 🎮 Happy Gaming!

**Questions?** Check the [documentation](CACHYOS_TUNE_README.md) or open an issue.

**Want to contribute?** Fork the repo and submit your improvements!

---

**Made with ❤️ for CachyOS gaming enthusiasts**

*Last updated:04.04 2026*  
By: Alb Kestrel
