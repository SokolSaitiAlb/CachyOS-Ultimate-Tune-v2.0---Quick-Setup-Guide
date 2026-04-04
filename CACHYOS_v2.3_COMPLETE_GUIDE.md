# CachyOS Ultimate Gaming Tune v2.3 - Complete Guide 🎮

**Enhanced Limine Bootloader Configuration & Pixel UI SDDM Theme**

---

## 🚀 Quick Install - One Click!

### Bash Shell (Recommended):
```bash
sudo bash -c "$(curl -fsSL https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide/raw/main/cachyos-ultimate-tune-improved.sh)"
```

### Python One-Liner:
```python
python3 -c "import subprocess; subprocess.run(['bash', '-c', 'sudo $(curl -fsSL https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide/raw/main/cachyos-ultimate-tune-improved.sh)'])"
```

---

## 📝 v2.3 New Features

### 1. Enhanced Limine Bootloader Configuration

**Location:** `/boot/limine.conf`

#### Timeout Setting
```bash
timeout: 5
```

**What it does:**
- Sets how many seconds Limine waits before automatically booting the default entry
- Value in seconds (5 = 5 second delay)
- If set to 0, disables auto-boot menu
- User can press key to interrupt and select different entry

**Examples:**
```bash
timeout: 2   # Boot after 2 seconds
timeout: 5   # Boot after 5 seconds (recommended)
timeout: 10  # Boot after 10 seconds (more time to choose)
```

#### Default Entry Setting
```bash
default_entry: 2
```

**What it does:**
- Specifies which menu entry boots by default
- Entries are numbered starting from 1
- If not set, default value is 1
- Must point directly to entry (not a directory) for autoboot

**Examples:**
```bash
default_entry: 1  # Boot first entry
default_entry: 2  # Boot second entry (linux-cachyos)
default_entry: 3  # Boot third entry
```

#### Important: Directory vs Entry Autoboot

⚠️ **Critical Tip:**
If `default_entry` points to a directory (e.g., `/+CachyOS`), **autoboot will be disabled**.

To enable autoboot for an entry within a directory, `default_entry` must point directly to that specific entry number.

#### Complete Example Configuration

**File:** `/boot/limine.conf`

```conf
# CachyOS Ultimate Gaming Tune v2.3 - Limine Bootloader

# Timeout: Seconds before automatic boot
timeout: 5

# Default Entry: Which entry to boot by default
# Points directly to the 'linux-cachyos' entry (entry 2) below
default_entry: 2

# Entry 1: CachyOS Directory (expanded with /+)
/+CachyOS

# Entry 2: Linux CachyOS Kernel (bootable entry)
//linux-cachyos
    protocol: linux
    kernel_path: boot():/vmlinuz-linux-cachyos
    cmdline: quiet splash root=UUID=abc123def456 rw
    module_path: boot():/initramfs-linux-cachyos.img

# Entry 3: Linux CachyOS (Fallback)
//linux-cachyos-fallback
    protocol: linux
    kernel_path: boot():/vmlinuz-linux-cachyos
    cmdline: quiet splash root=UUID=abc123def456 rw
    module_path: boot():/initramfs-linux-cachyos-fallback.img
```

**Explanation:**
- `timeout: 5` → Wait 5 seconds before booting
- `default_entry: 2` → Boot the second entry (linux-cachyos) by default
- `/+CachyOS` → Entry 1: Directory (use /+ to expand by default)
- `//linux-cachyos` → Entry 2: Actual bootable kernel
- `protocol: linux` → Use Linux boot protocol
- `kernel_path:` → Path to kernel file
- `cmdline:` → Kernel parameters (quiet, splash, root UUID, etc)
- `module_path:` → Path to initramfs image

### How to Edit Limine Configuration

```bash
# Open configuration file
sudo nano /boot/limine.conf

# Make desired changes:
# - Change "timeout: 5" to different value
# - Change "default_entry: 2" to different entry
# - Customize kernel parameters

# Save (Ctrl+O, Enter, Ctrl+X in nano)

# Reboot to test changes
reboot
```

### Verify Limine Configuration

```bash
# View current configuration
cat /boot/limine.conf

# Check if Limine is installed
ls -la /boot/limine.conf

# Check Limine version
limine --version
```

### Troubleshooting Limine

**If bootloader won't boot default entry:**
1. Check syntax in `/boot/limine.conf`
2. Verify `default_entry` number is valid
3. Ensure entry is not a directory (if autoboot needed)
4. Increase `timeout` value for debugging

**If kernel doesn't boot:**
1. Verify `kernel_path:` is correct
2. Check `root=UUID=...` matches your partition
3. Verify `module_path:` (initramfs) is correct
4. Try fallback entry for testing

**If timeout is too short/long:**
```bash
# Edit and adjust
sudo nano /boot/limine.conf
# Change "timeout: 5" to desired seconds
```

---

## 🖼️ Pixel UI SDDM Theme Installation (v2.3)

### What is Pixel UI SDDM?

**Features:**
- Sleek, minimalist login screen design
- Monochrome aesthetic with dot-matrix elements
- Futuristic, clean appearance
- Inspired by Pixel OS UI
- Perfect for gaming systems
- Works with KDE Plasma & Hyprland

### Installation via Script

The easiest way: Just select **"Install SDDM Pixel UI Theme"** in the setup menu!

### Manual Installation

#### Step 1: Clone Repository
```bash
git clone -b pixel https://github.com/mahaveergurjar/sddm.git
```

#### Step 2: Move to SDDM Themes Directory
```bash
sudo mv sddm /usr/share/sddm/themes/
```

**Verify installation:**
```bash
ls -la /usr/share/sddm/themes/sddm
```

#### Step 3: Enable the Theme
```bash
# Edit SDDM configuration
sudo nano /etc/sddm.conf

# Find the [Theme] section and set:
[Theme]
Current=sddm

# Save (Ctrl+O, Enter, Ctrl+X)
```

#### Step 4: Restart SDDM
```bash
sudo systemctl restart sddm

# Or reboot to see login screen
reboot
```

### One-Liner Installation

```bash
git clone -b pixel https://github.com/mahaveergurjar/sddm.git && sudo mv sddm /usr/share/sddm/themes/ && sudo sed -i 's/Current=.*/Current=sddm/' /etc/sddm.conf && sudo systemctl restart sddm
```

### Preview Theme (Without Restart)

```bash
# Test theme without restarting SDDM
sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/sddm
```

### Troubleshooting Pixel UI Theme

**Error: "module is not installed"**

Solution: Install required packages
```bash
sudo pacman -S qt6-5compat qt6-declarative qt6-svg sddm-greeter-qt6
```

**Theme doesn't appear after restart:**

```bash
# Verify installation
ls -la /usr/share/sddm/themes/sddm

# Check SDDM config
cat /etc/sddm.conf | grep -A5 "\[Theme\]"

# Should show: Current=sddm

# Restart SDDM
sudo systemctl restart sddm
```

**Switch back to default theme:**

```bash
sudo nano /etc/sddm.conf

# Change to:
[Theme]
Current=breeze

# Save and restart
sudo systemctl restart sddm
```

### SDDM Theme Comparison

| Theme | Style | Best For |
|-------|-------|----------|
| **Pixel UI** | Minimalist, futuristic | Modern gaming |
| **Astronaut** | Space-inspired | Creative users |
| **Pixie** | Modern, sleek | Minimal aesthetic |
| **Breeze** | Default KDE | Compatibility |

---

## 🎯 Complete Setup Steps

### 1. Download & Run Script

**Bash (Recommended):**
```bash
sudo bash -c "$(curl -fsSL https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide/raw/main/cachyos-ultimate-tune-improved.sh)"
```

**Python:**
```python
python3 -c "import subprocess; subprocess.run(['bash', '-c', 'sudo $(curl -fsSL https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide/raw/main/cachyos-ultimate-tune-improved.sh)'])"
```

### 2. Select Features in Menu
- Keep defaults (all TRUE)
- Or customize as needed
- **Recommended:** Enable "Install SDDM Pixel UI Theme"

### 3. Wait for Installation
- Takes 5-10 minutes
- Downloads and installs 20+ tools
- Configures system optimizations

### 4. Reboot When Prompted
```bash
reboot
```

### 5. Configure Limine Bootloader (Optional)
```bash
sudo nano /boot/limine.conf

# Customize if desired:
# timeout: 5           # Change boot delay
# default_entry: 2    # Change default kernel
```

### 6. Configure GPU (LACT)
```bash
lact

# Set:
# - Core Clock: +100 MHz
# - Memory Clock: +150 MHz  
# - Power Limit: 280-300W
```

### 7. Verify Installation
```bash
# Check system info
fastfetch

# Verify CPU governor
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
# Should show: performance

# Check GPU
lact --version

# View Limine config
cat /boot/limine.conf
```

---

## 📊 v2.3 Feature List

✅ **Core Gaming**
- BORE Scheduler Kernel
- LACT GPU Management
- MangoHud + GameMode
- ProtonPlus
- CPUpower

✅ **Optimizations**
- 12GB Shader Cache
- Browser GPU Acceleration
- Limine Bootloader (Enhanced v2.3)
- Pixel UI SDDM Theme
- Btrfs Snapshots

✅ **Tools (20+)**
- Steam, Wine, OBS, Kdenlive
- VS Code, lazygit, kitty
- Development suite

---

## 🎥 YouTube Tutorial

**Watch complete setup video:**

📺 **Alb Kestrel** (@ALBKESTRELYTofficial)

Channel: https://youtube.com/@albkestrelytofficial

Topics covered:
- Complete installation guide
- Limine bootloader configuration
- Pixel UI SDDM setup
- GPU overclocking (LACT)
- Performance optimization
- Troubleshooting tips

**Subscribe for more CachyOS gaming content!**

---

## 🎮 System Performance After Setup

Your i5-12400f + RX6800 system will have:

✅ **Boot:**
- Limine bootloader (5 second timeout)
- Default CachyOS kernel selected
- Pixel UI beautiful login screen

✅ **CPU:**
- CPUpower Performance mode
- i5-12400f @ 4.4 GHz constant
- Low latency for gaming

✅ **GPU:**
- LACT GPU management ready
- RX6800 +100MHz core capable
- 12GB shader cache

✅ **Gaming:**
- 60+ FPS at 1366x768
- Smooth, stable performance
- Low input latency

---

## 📞 About The Creator

**Alb Kestrel** (Sokol Saiti)

Linux content creator specializing in CachyOS gaming optimization.

### YouTube Channel
📺 **@ALBKESTRELYTofficial**

Direct link: https://youtube.com/@albkestrelytofficial

### Content
- CachyOS gaming setup tutorials
- GPU overclocking guides
- Performance benchmarking
- Limine bootloader configuration
- SDDM theme installations
- Hardware optimization tips

### Other Projects
- **Prayer Times Notifier** - Islamic practice tool
- **PipeWire Audio Fixer** - Audio utility
- **Linux Utilities** - Open-source tools on GitHub

### Links
- **GitHub:** https://github.com/SokolSaitiAlb
- **YouTube:** https://youtube.com/@albkestrelytofficial
- **Repository:** https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide

---

## 🤝 Contributing & Support

### Report Issues
```bash
# Visit GitHub repository
https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide

# Click "Issues" → "New Issue"
# Describe your problem with:
# - Error message
# - System specs
# - Steps to reproduce
```

### Subscribe & Follow
- 📺 YouTube: [@ALBKESTRELYTofficial](https://youtube.com/@albkestrelytofficial)
- 💻 GitHub: [SokolSaitiAlb](https://github.com/SokolSaitiAlb)
- ⭐ Star the repository

### Fork & Contribute
```bash
# Fork on GitHub
# Make improvements
# Submit pull request
```

---

## 📄 License

MIT License - Use at your own risk. Always backup system before major changes.

---

## 🎉 Summary

**v2.3 Includes:**
- ✅ Enhanced Limine bootloader with detailed timeout/entry config
- ✅ Pixel UI SDDM theme (modern login screen)
- ✅ One-click bash installation
- ✅ Python one-liner option
- ✅ Complete documentation
- ✅ Troubleshooting guides
- ✅ YouTube tutorial reference

**Your system is ready for optimal CachyOS gaming!** 🚀

---

*CachyOS Ultimate Gaming Tune v2.3*  
*By: Alb Kestrel (@ALBKESTRELYTofficial)*  
*YouTube: https://youtube.com/@albkestrelytofficial*  
*Last Updated: 2025*
