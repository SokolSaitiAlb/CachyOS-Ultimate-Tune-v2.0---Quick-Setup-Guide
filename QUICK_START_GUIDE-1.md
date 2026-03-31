# CachyOS Ultimate Tune v2.0 - Quick Setup Guide

**📍 Official Repository:** https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide

---

## 📥 Installation (2 minutes)

### Option 1: Direct Download with wget
```bash
wget https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide/raw/main/cachyos-ultimate-tune-improved.sh
chmod +x cachyos-ultimate-tune-improved.sh
sudo ./cachyos-ultimate-tune-improved.sh
```

### Option 2: Clone & Run
```bash
git clone https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide.git
cd CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide
chmod +x cachyos-ultimate-tune-improved.sh
sudo ./cachyos-ultimate-tune-improved.sh
```

### Option 3: One-Liner Command
```bash
sudo bash -c "$(curl -fsSL https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide/raw/main/cachyos-ultimate-tune-improved.sh)"
```

---

## 🎯 Default Installation (Recommended)

Just run the script and accept defaults for:
- ✅ YAY AUR Helper
- ✅ Gaming & Development Tools (20+)
- ✅ BORE Scheduler Kernel
- ✅ LACT GPU Management
- ✅ MangoHud + GameMode
- ✅ ProtonPlus
- ✅ Limine Bootloader (2sec)

All optional themes are disabled by default.

---

## ⏱️ Time Estimates

| Stage | Duration |
|-------|----------|
| YAY Installation | 2-3 min |
| Tool Installation | 10-15 min |
| Kernel Installation | 5-8 min |
| System Config | 2-3 min |
| **Total** | **20-30 min** |

---

## 🚀 First Boot After Installation

```bash
# 1. Reboot (prompted at end of script)
reboot

# 2. After reboot, open GPU manager
lact

# 3. Check system info
fastfetch

# 4. Update system
cachy-update

# 5. Open ProtonPlus for Proton versions
protonplus
```

---

## 🎮 Gaming Quick Start

### Steam
```bash
# Open Steam
steam

# Set Launch Options in game properties:
DXVK_ASYNC=1 PROTON_EAC_RUNTIME=proton %command%
```

### MangoHud Toggle
- **Enable**: Press Shift + F12 in-game
- **Disable**: Press Shift + F12 again

### GameMode Check
```bash
# Verify GameMode is active
systemctl status gamemode
# Should show: active (running)
```

### LACT GPU Settings
Recommended for RX 6800:
- **Core Clock**: +100 MHz
- **Memory Clock**: +150 MHz
- **Power Limit**: 280W
- **Fan**: Set custom curve (30°=20%, 80°=100%)

---

## 🔧 Common First-Time Tasks

### 1️⃣ Select BORE Kernel
```bash
# At boot, select "linux-cachyos-bore"
# Then make default:
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### 2️⃣ Choose SDDM Theme (Optional)
```bash
# Edit login theme:
sudo nano /etc/sddm.conf
# Set one of:
# Current=sddm-astronaut-theme
# Current=pixie-sddm
# Current=sddm-pixel

# Apply:
sudo systemctl restart sddm
```

### 3️⃣ Configure Proton Versions
```bash
# Open ProtonPlus GUI
protonplus

# Install game-specific Proton versions
# Set as default in Steam
```

### 4️⃣ GPU Overclocking
```bash
# Open LACT
lact

# Adjust under "GPU" tab:
# - Core/Memory clocks
# - Power limits
# - Fan curves

# Enable Performance Mode for auto-apply
```

### 5️⃣ Enable System Snapshots (Btrfs)
```bash
# Use cachy-update for safe updates
cachy-update

# Snapshots auto-saved before updates
```

---

## 📊 Performance Monitoring

### Check GPU Status
```bash
# Real-time GPU info:
lact

# Or in terminal:
watch -n 1 'rocm-smi'
```

### Monitor Gaming Performance
```bash
# FPS overlay (in games):
Shift + F12

# Or use goverlay:
goverlay

# Terminal monitoring:
fastfetch
```

### CPU Performance
```bash
# Check CPU governor:
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
# Should show: performance

# Monitor CPU:
htop
```

---

## 🐛 Quick Troubleshooting

| Issue | Fix |
|-------|-----|
| Script won't run | `chmod +x cachyos-ultimate-tune-improved.sh` |
| Permission denied | Use `sudo ./script.sh` |
| LACT won't open | `sudo systemctl restart lact` |
| GPU not detected | `sudo pacman -S amdgpu-pro-libs` |
| Games stutter | Check GameMode: `systemctl status gamemode` |
| Wrong resolution | Adjust in KDE Settings → Display |
| SDDM theme broken | Reset: `sudo nano /etc/sddm.conf` → `Current=breeze` |

---

## 🎯 Benchmark Your Setup

### Frame Rate Test
```bash
# Use MangoHud in any game (Shift+F12)
# Look for "Avg FPS" counter
```

### GPU Benchmark
```bash
# Install:
yay -S glxgears

# Run:
glxgears
```

### CPU Performance
```bash
# Install:
yay -S sysbench

# Test:
sysbench cpu --cpu-max-prime=20000 run
```

---

## 📚 File Locations

```
~/.config/obs-studio/          # OBS profiles
~/.config/corectrl/            # GPU profiles (legacy)
~/.steam/steam/env             # Steam settings
~/.config/sddm.conf            # Login manager config
/etc/sddm.conf                 # System SDDM config
/usr/share/sddm/themes/        # Installed themes
/boot/limine.conf              # Bootloader config
/etc/sysctl.d/                 # System tweaks
```

---

## 🔄 Updating After Setup

### System Updates
```bash
# New safe way:
cachy-update

# Or traditional:
sudo pacman -Syu
```

### Proton Versions
```bash
# Via ProtonPlus GUI:
protonplus

# Or CLI:
yay -S protonplus-bin --needed
```

### AUR Packages
```bash
# Update all AUR packages:
yay -Syu

# Or just check:
yay -Qua
```

---

## 🎮 Recommended Game Settings

### Vulkan Games
```bash
# Force Vulkan rendering:
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.x86_64.json
```

### DXVK Games (DirectX → Vulkan)
```bash
# In Steam launch options:
DXVK_ASYNC=1 %command%
```

### High-Demand Games
```bash
# Increase VRAM allocation:
DXVK_DEVICE_MEMORY_GB=12 %command%

# Enable async present:
DXVK_ASYNC=1 DXVK_HUD=fps %command%
```

---

## 💾 Backup & Recovery

### Create System Snapshot
```bash
# If using Btrfs:
sudo btrfs subvolume snapshot /mnt/@ /mnt/@snapshots/before-games

# Or via cachy-update (auto):
cachy-update
```

### Rollback Before Update
```bash
# cachy-update auto-creates snapshots
# Rollback in boot menu if needed
```

---

## ✨ Final Tips

1. **Test after each major change** - Reboot and verify
2. **Monitor temps** - GPU should stay <85°C
3. **Back up** - Use cachy-update for snapshots
4. **Update regularly** - Use cachy-update for safety
5. **Join community** - Get help on CachyOS forums

---

## 🆘 Need Help?

### Check Logs
```bash
# System logs:
journalctl -xe

# GPU logs:
dmesg | grep -i "amd\|gpu"

# Game logs:
cat ~/.steam/steam/logs/*
```

### Common Resources
- CachyOS Discord
- Arch Linux Forum
- GitHub Issues (this script)
- r/archlinux (Reddit)

---

## 🎉 You're All Set!

Your CachyOS gaming machine is now:
- ✅ Optimized for gaming
- ✅ GPU overclocked & managed
- ✅ Latest Proton/Wine support
- ✅ System snapshot-protected
- ✅ Performance-tuned
- ✅ Beautiful login screen

**Happy Gaming!** 🎮

---

*Next: Run your first game and enjoy the performance! 🚀*
