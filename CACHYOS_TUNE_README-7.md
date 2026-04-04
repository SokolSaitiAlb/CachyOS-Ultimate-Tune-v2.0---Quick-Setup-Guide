# CachyOS Ultimate Gaming Tune v2.3 🎮

**A comprehensive system optimization script for CachyOS with RX 6800 + KDE Gaming Setup**

**📍 Repository:** https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide

**📺 YouTube:** [@ALBKESTRELYTofficial](https://youtube.com/@albkestrelytofficial)

**🚀 One-Click Installation:**
```bash
# Bash Shell (Recommended):
sudo bash -c "$(curl -fsSL https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide/raw/main/cachyos-ultimate-tune-improved.sh)"

# Python One-Liner:
python3 -c "import subprocess; subprocess.run(['bash', '-c', 'sudo $(curl -fsSL https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide/raw/main/cachyos-ultimate-tune-improved.sh)'])"
```

---

## 🎯 v2.3 New Features

### ✨ Enhanced Limine Bootloader Configuration

#### Timeout Setting (NEW v2.3)
```bash
# /boot/limine.conf
timeout: 5  # Seconds before automatic boot
```

- Sets how many seconds Limine waits before booting
- Configurable value in seconds (default: 5)
- User can interrupt and select different entry

#### Default Entry Setting (NEW v2.3)
```bash
# /boot/limine.conf
default_entry: 2  # Boot the second entry by default
```

- Specifies which menu entry to boot by default
- Entries numbered starting from 1
- Must point directly to entry (not directory) for autoboot

#### Important Autoboot Tip (NEW v2.3)
⚠️ **If `default_entry` points to a directory (e.g., `/+CachyOS`), autoboot is disabled.**

To enable autoboot for entry within directory, `default_entry` must point to specific entry number.

#### Complete Example Configuration (NEW v2.3)
```conf
# /boot/limine.conf
timeout: 5
default_entry: 2  # Boot second entry (linux-cachyos)

/+CachyOS              # Entry 1: Directory
//linux-cachyos        # Entry 2: Bootable kernel
    protocol: linux
    kernel_path: boot():/vmlinuz-linux-cachyos
    cmdline: quiet splash root=UUID=... rw
    module_path: boot():/initramfs-linux-cachyos.img
```

### ✨ Pixel UI SDDM Theme Installation (Improved v2.3)

Modern minimalist login screen with:
- Futuristic monochrome design
- Dot-matrix aesthetic
- Perfect for gaming systems
- One-click installation via script

**Manual Installation:**
```bash
git clone -b pixel https://github.com/mahaveergurjar/sddm.git
sudo mv sddm /usr/share/sddm/themes/
sudo nano /etc/sddm.conf
# Set: [Theme] Current=sddm
sudo systemctl restart sddm
```

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

#### 5. **CoreCtrl** (Optional Alternative)
   - **Profile-based GPU control utility**
   - Excellent for custom GPU profiles
   - Lightweight alternative to LACT
   - AUR Package: https://archlinux.org/packages/extra/x86_64/corectrl/
   - Source: https://gitlab.com/corectrl/corectrl
   - Optional installation (disabled by default)

#### 6. **ProtonPlus** (Replaces ProtonUp-Qt)
   - Modern Proton version manager
   - Better compatibility tracking
   - Improved UI
   - Available as `protonplus` command

#### 8. **GPU Shader Cache Optimization** ⭐ NEW
   ```bash
   # Increases shader cache to avoid stuttering and long load times:
   - MESA_SHADER_CACHE_MAX_SIZE=12G
   - Significantly reduces game load times
   - Prevents stuttering during shader compilation
   - Auto-configured during setup
   ```

#### 9. **CPUpower CPU Governor** ⭐ NEW
   ```bash
   # Optimal CPU performance for gaming:
   - Automatically sets CPU governor to Performance mode
   - Maximizes CPU frequency during gaming/workload
   - Works with Intel & AMD processors
   - Persistent across reboots
   - Perfect for i5-12400f and similar CPUs
   ```

#### 10. **Browser Hardware Acceleration** ⭐ NEW
   ```bash
   # GPU acceleration for Brave & Firefox:
   - Vulkan-based acceleration via ANGLE
   - VA-API video decoding
   - Improved video playback performance
   - Zero-copy rendering
   - Supports Brave, Firefox, Chrome, Edge, Chromium
   ```

#### 11. **scx_bpfland Scheduler** ⭐ NEW (Optional Advanced)
   ```bash
   # Advanced sched_ext scheduler (alternative to BORE):
   - Cache-aware core selection (L2/L3 optimization)
   - Multiple scheduler modes:
     * Performance: Low latency for gaming/desktop
     * Power Save: Power efficiency
     * Server: Throughput optimization
   - Better interactivity during intensive workloads
   - More flexible than traditional schedulers
   ```

#### 10. **Multiple SDDM Login Themes**
   - **Astronaut Theme**: Beautiful space-themed login screen
   - **Pixie Theme**: Sleek, modern login interface
   - **Pixel UI Theme**: Minimalist, futuristic design
   - Choose which to install during setup

#### 11. **cachy-update Integration**
   ```bash
   # Arch-friendly update manager with:
   - Pre/post update notifications
   - Btrfs snapshot support
   - System tray applet
   - Run: cachy-update
   ```

#### 12. **Btrfs Snapshot Support**
   ```bash
   # Full snapshot management:
   - Subvolume layout for easy rollbacks
   - limine-snapper-sync support
   - Transparent compression
   - Safe system updates
   ```

#### 13. **OpenRGB Support**
   - Control RGB lighting across hardware
   - System-wide RGB synchronization
   - Hardware compatibility for gaming rigs

#### 14. **Enhanced System-Wide Tools**
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
| CPUpower | CPU governor set to Performance for max speed |
| MangoHud + GameMode | FPS overlay + gaming optimization |
| ProtonPlus | Manage Proton versions for Windows games |
| Limine Bootloader | Fast 2-second boot (replaces GRUB) |
| GPU Shader Cache | 12GB MESA cache (faster load times, less stutter) |
| Browser Acceleration | Brave + Firefox GPU hardware acceleration |

### Disabled by Default (Optional) ☐

| Feature | Purpose |
|---------|---------|
| CoreCtrl GPU Tool | Alternative GPU management (profile-based) |
| scx_bpfland Scheduler | Advanced sched_ext scheduler (alternative to BORE) |
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
# Option 1: LACT (default)
lact

# Option 2: CoreCtrl (if installed)
corectrl
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
- At boot menu, select `linux-cachyos-bore`
- Press Enter
- After boot, update boot loader:
```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### 7. **Verify Browser Acceleration**
```bash
# Open brave://gpu or brave://gpu in Brave
# Or about:support in Firefox
# Check "Hardware accelerated" status
```

### 8. **Test GPU Shader Cache**
```bash
# Launch any game
# Observe faster load times and smoother gameplay
# Cache is persistent across sessions
```

---

---

## ⚡ CPU Performance with CPUpower

CPUpower is automatically configured during setup to set your CPU governor to **Performance mode** for maximum gaming speed.

### What is CPUpower?
- Simple tool to manage CPU frequency scaling
- Works with Intel & AMD processors
- Sets CPU governor (frequency scaling policy)
- Makes changes persistent across reboots

### Performance Mode (Default)
Maximizes CPU frequency for optimal gaming performance.

**Benefits:**
- ⚡ Maximum CPU frequency always available
- 🎮 No throttling during gaming
- 🚀 Improved frame times
- ✅ Optimal for i5-12400f (your CPU)

### Check Current Governor
```bash
# View current CPU governor
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
# Should show: performance

# Or use cpupower command
sudo cpupower frequency-info

# Monitor CPU frequency during gaming
watch -n 0.1 'cat /proc/cpuinfo | grep MHz'
```

### Manual Adjustment (if needed)
```bash
# Change governor manually
sudo cpupower frequency-set -g performance   # Performance mode
sudo cpupower frequency-set -g powersave     # Power saving mode

# View available governors
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors

# Make changes persist
echo 'GOVERNOR="performance"' | sudo tee /etc/default/cpupower
sudo systemctl restart cpupower
```

### CPU Temperature Monitoring
```bash
# Install and monitor temps
yay -S lm_sensors

# Check CPU temps
sensors

# Or use system monitor:
systemctl start lm_sensors  # One-time setup
watch sensors              # Monitor in real-time
```

**For your i5-12400f:**
- Base Clock: 2.5 GHz
- Boost Clock: 4.4 GHz
- Performance mode keeps boost active
- Typical gaming temp: 50-70°C (safe range)
- Maximum safe temp: 100°C (Intel spec)

---

## 🎮 PC-Specific Optimization Guide (i5-12400f + RX6800)

Your system specs are excellent for gaming! Here's the optimized setup:

### Your System
```
CPU:       Intel i5-12400f (12 cores, E+P cores)
GPU:       AMD RX6800 16GB VRAM
RAM:       16GB DDR4 3200MHz (XMP enabled)
Storage:   512GB NVMe + 1TB HDD
PSU:       650W Gold 80+ (sufficient for this setup)
Mobo:      Gigabyte B660M DS3H DDR4
Display:   Samsung 32" @ 1366x768 @ 60Hz
```

### Recommended Settings for Your Setup

**BORE Kernel (instead of default)**
- ✅ Highly recommended for your i5-12400f
- Better handling of E-cores
- Improved latency for gaming

**LACT GPU Management (RX6800)**
Recommended settings:
```
Core Clock:     +100 MHz (conservative, stable)
Memory Clock:   +150 MHz
Power Limit:    280-300W (your 650W PSU handles easily)
Fan Curve:      30°C=20%, 50°C=40%, 70°C=60%, 85°C=100%
```

**CPUpower (i5-12400f)**
- ✅ Set to Performance (enabled by default)
- Your CPU will run at 4.4 GHz boost constantly in games
- Safe with your cooling setup

**GPU Shader Cache**
- ✅ Set to 12GB (perfect for your setup)
- Reduces load times significantly
- No performance penalty

**Browser Acceleration**
Brave and Firefox will use GPU for:
- Video playback (YouTube, streaming)
- Hardware-accelerated rendering
- Better responsiveness

### Gaming Performance Expectations

**With this optimized setup, expect:**
- 🎮 60+ FPS in most games at 1366x768
- ⚡ Minimal stuttering with shader cache
- 🔥 Stable temps (50-70°C CPU, 50-75°C GPU)
- 🚀 Smooth frame times
- ⌨️ Responsive input (low latency)

**Test Games:**
```bash
# Install and test
yay -S glxgears       # Simple GPU test

# Run tests
glxgears              # GPU benchmark
sysbench cpu --cpu-max-prime=20000 run  # CPU benchmark
```

### Power Consumption
Your 650W PSU is excellent:
- CPU TDP: 65W (i5-12400f)
- GPU TDP: ~250-300W (RX6800 at boost)
- System Total: ~450-500W peak
- Headroom: 150-200W (very safe)

No power issues whatsoever!

### RAM Optimization
Your 16GB @ 3200MHz is perfect:
- ✅ XMP Profile 1 enabled (good!)
- DDR4-3200 provides optimal bandwidth
- 16GB is sweet spot for gaming
- No upgrades needed

### Storage Tips
**512GB NVMe (Main OS):**
- Install: CachyOS + games
- Keep 20-30% free for optimal performance
- Monitor with: `df -h`

**1TB HDD (Backups):**
- Use for older games
- Backup important data
- Create system snapshots (if using Btrfs)

### XMP/DOCP Settings Verification
```bash
# Check if XMP is working
sudo dmidecode -t memory | grep -i speed

# Should show: 3200 MHz
```

### Thermal Management
Your cooling setup (tower ventilation):
- ✅ Adequate for this system
- CPU temps under gaming: 50-70°C
- GPU temps under gaming: 50-75°C
- Normal and safe

**Monitor temps:**
```bash
# Real-time monitoring
watch -n 1 'sensors && echo "---" && radeontop'
```

### Recommended Game Settings
Since your display is 1366x768:

**Vulkan Games** (Preferred)
```bash
# Proton + Vulkan is ideal
DXVK_ASYNC=1 %command%
```

**High-Demand Games** (AAA Titles)
```bash
# DXVK settings for stability
DXVK_DEVICE_MEMORY_GB=12 DXVK_ASYNC=1 %command%
```

**Older Games / Compatibility**
```bash
# Use different Proton versions via ProtonPlus
# Test compatibility through ProtonDB
```

### Network Optimization (Optional)
```bash
# Check internet speed
yay -S speedtest-cli
speedtest-cli

# For competitive gaming, consider:
# - Wired Ethernet (not WiFi)
# - Low-latency ISP
# - Reduce Discord/YouTube background usage
```

### Final Optimization Checklist
- ✅ BORE kernel enabled
- ✅ CPUpower set to Performance
- ✅ LACT GPU management configured
- ✅ GPU shader cache at 12GB
- ✅ Browser acceleration enabled
- ✅ MangoHud + GameMode active
- ✅ Limine bootloader (2sec)
- ✅ XMP profile active in BIOS
- ✅ Temps monitored and normal
- ✅ PSU providing stable power

Your system is ready for excellent gaming performance!

---

The script automatically configures shader cache to **12GB** to prevent stuttering and long load times.

**Location:** `~/.config/environment.d/gaming.conf`

**Contents:**
```bash
MESA_SHADER_CACHE_MAX_SIZE=12G
MESA_SHADER_CACHE_DIR=$HOME/.cache/mesa
```

**Manual Configuration (if needed):**
```bash
# Create directory
mkdir -p ~/.config/environment.d

# Edit configuration
nano ~/.config/environment.d/gaming.conf

# Add these lines:
MESA_SHADER_CACHE_MAX_SIZE=12G
MESA_SHADER_CACHE_DIR=$HOME/.cache/mesa

# Restart system for changes to take effect
reboot
```

**Benefits:**
- ⚡ Significantly faster game load times
- 🎮 Reduced stuttering during shader compilation
- 💾 Shader cache persists between sessions
- 🔄 Auto-compiled shaders are reused

---

## 🌐 Browser Hardware Acceleration Setup (Brave + Firefox)

### 🔥 Brave Browser Configuration
Acceleration is enabled automatically via `~/.config/brave-flags.conf`

**File Location:**
```bash
~/.config/brave-flags.conf
```

**Recommended Flags for RX6800:**
```
--use-gl=angle
--use-angle=vulkan
--enable-features=Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,AcceleratedVideoDecodeLinuxZeroCopyGL,AcceleratedVideoEncoder,VaapiIgnoreDriverChecks,UseMultiPlaneFormatForHardwareVideo
--ozone-platform-hint=x11
--enable-zero-copy
--enable-raw-draw
```

**Verify acceleration:**
1. Open `brave://gpu` in address bar
2. Look for "Hardware accelerated" status (should be YES)
3. Check "Graphics Feature Status" section
4. Verify "Video Acceleration Information" shows Vulkan

**If not working:**
```bash
# Verify flags file
cat ~/.config/brave-flags.conf

# Restart Brave completely
pkill -9 brave
# Reopen Brave
brave &
```

### 🦊 Firefox Configuration
Acceleration configured via user.js in your profile directory.

**File Location:**
```bash
~/.mozilla/firefox/[YOUR-PROFILE].default-release/user.js
```

**Recommended Settings for RX6800:**
```javascript
// Hardware Acceleration & Performance
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.hardware-video-decoding.enabled", true);
user_pref("gfx.webrender.enabled", true);
user_pref("gfx.webrender.all", true);
user_pref("layers.acceleration.force-enabled", true);
user_pref("media.rpi-audioserver.enabled", false);

// VA-API Settings
user_pref("media.av1.enabled", true);
user_pref("media.vp9.enabled", true);

// H.264 Hardware Decoding
user_pref("media.ffmpeg.enabled", true);
```

**Verify acceleration:**
1. Type `about:support` in address bar
2. Scroll to "Graphics" section
3. Check:
   - "Hardware accelerated windows: 1/1" ✅
   - "GPU accelerated windows: 1/1" ✅
4. Look for Vulkan or OpenGL in rendering info

**Manual Setup (if auto-config fails):**
```bash
# Find your Firefox profile
ls ~/.mozilla/firefox/

# Look for .default-release folder, copy the name

# Create user.js
nano ~/.mozilla/firefox/[YOUR-PROFILE].default-release/user.js

# Paste the settings above
# Save (Ctrl+X, Y, Enter)

# Restart Firefox
pkill -9 firefox
firefox &
```

### 📊 Verify Video Hardware Acceleration

**Real-time GPU Monitoring:**
```bash
# Install if not present
yay -S amdgpu_top

# Monitor GPU usage
amdgpu_top

# In another terminal, play a YouTube video
# Watch the "media" row in amdgpu_top
# Should show non-zero % when video plays
```

**Expected Output:**
```
GPU: [████░░░░░] 40%
  GFX:  [████░░░░] 20%
  MM:   [░░░░░░░░░] 0%
  UVD:  [████░░░░] 40%   ← Video decoder active!
  VCE:  [░░░░░░░░░] 0%
```

If `UVD` (Unified Video Decoder) shows 0% during video playback:
- Hardware acceleration not working
- Check browser settings above
- Try different Firefox profile
- Ensure drivers are up-to-date

**Browser Flags Contribution (Your Setup):**
```
Brave Browser - AMD RX6800 (Contributed by Alb Kestrel / SokolSaitiAlb)
Browser: Brave
GPU: AMD Radeon RX6800 16GB
CPU: Intel i5-12400f
Flags File: ~/.config/brave-flags.conf

--use-gl=angle
--use-angle=vulkan
--enable-features=Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,AcceleratedVideoDecodeLinuxZeroCopyGL,AcceleratedVideoEncoder,VaapiIgnoreDriverChecks,UseMultiPlaneFormatForHardwareVideo
--ozone-platform-hint=x11
--enable-zero-copy
--enable-raw-draw

Notes: Full Vulkan acceleration for video decoding and rendering. Works excellently with RX6800. Zero-copy enabled for reduced memory bandwidth usage. Tested on 1366x768 display.
```

---

## ⚡ scx_bpfland Scheduler (Optional Advanced)

For advanced users who want even better gaming performance than BORE.

### What is scx_bpfland?
- **sched_ext** scheduler using BPF (Berkeley Packet Filter)
- Cache-aware scheduling (optimizes L2/L3 cache usage)
- Vruntime-based scheduling for interactive workloads
- Production-ready for gaming and desktop use

### Installation
```bash
# Via script selection (optional feature)
# Or manually:
yay -S scx_bpfland
```

### Scheduler Modes

**1. Performance Mode** (Recommended for Gaming)
```bash
scx_bpfland -m performance -w
```
- Minimizes latency
- Best for gaming and real-time tasks
- Default when installed via script

**2. Power Save Mode**
```bash
scx_bpfland -s 20000 -m powersave -I 100 -t 100
```
- Prioritizes energy efficiency
- Favors less performant cores
- Good for laptops

**3. Server Mode**
```bash
scx_bpfland -s 20000 -S
```
- Optimizes for throughput
- Prioritizes strict task affinity
- For server workloads

### Enable/Disable
```bash
# Check status
sudo systemctl status scx-bpfland

# Enable at boot
sudo systemctl enable scx-bpfland

# Start immediately
sudo systemctl start scx-bpfland

# Stop
sudo systemctl stop scx-bpfland

# Disable at boot
sudo systemctl disable scx-bpfland
```

### Performance Benefits
- 🎮 Lower input latency
- ⚡ Better responsiveness
- 🔄 Improved cache efficiency
- 📊 Reduced frame time variance

---

## 🎯 GPU Overclocking with LACT or CoreCtrl

### LACT (Recommended - Modern UI)

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

### CoreCtrl (Optional - Profile-Based)

1. **Open CoreCtrl**
   - Applications → CoreCtrl

2. **Create Profiles**
   - Gaming profile
   - Productivity profile
   - Power saving profile

3. **Set Parameters**
   - Core/Memory frequencies
   - Voltage levels
   - Power limits

4. **Apply Profiles**
   - Switch between profiles easily
   - Auto-apply on launch

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

## 🚀 Limine Bootloader Configuration (v2.2 NEW)

The script automatically configures Limine bootloader with optimized settings.

### Configuration File
**Location:** `/boot/limine.conf`

### Default Settings
```bash
default @saved
timeout 2
#console-mode keep
```

### Configuration Explanation

**`default @saved`**
- Remembers your last boot selection
- Automatically selects the kernel you used previously
- Speeds up boot process by eliminating menu selection

**`timeout 2`**
- 2-second boot delay before default selection
- Quick boot without freezing screen
- Time enough to press key to change selection if needed

**`#console-mode keep`**
- Maintains console display during boot
- Commented out (disabled) by default
- Can be uncommented for specific needs

### Manual Configuration
If you need to adjust bootloader settings:

```bash
# Edit Limine configuration
sudo nano /boot/limine.conf

# Make changes to timeout, console mode, etc.

# Reboot to test changes
reboot
```

### Verify Bootloader
```bash
# Check if Limine is installed
ls -la /boot/limine.conf

# View current configuration
cat /boot/limine.conf

# Check if Limine is active
efibootmgr | grep -i limine
```

### Troubleshooting Limine

**If bootloader won't start:**
1. Check `/boot/limine.conf` syntax
2. Ensure timeout value is > 0
3. Verify `default @saved` is correct
4. Reboot and select kernel manually if needed

**If timeout is too short/long:**
```bash
# Edit and change timeout value
sudo nano /boot/limine.conf
# Change "timeout 2" to desired seconds
```

---

## 🖼️ Pixel UI SDDM Theme (v2.2 NEW)

Modern, minimalist login screen theme for KDE Plasma and Hyprland.

### What is Pixel UI SDDM?

**Features:**
- Minimalist, futuristic design
- Monochrome aesthetic
- Dot-matrix inspired elements
- Perfect for gaming systems
- Works great with KDE Plasma 6
- Optimized for both X11 and Wayland

### Installation (via Script)

The script can install it automatically. Just select **"Install SDDM Pixel UI Theme"** in the menu.

### Manual Installation

**Option 1: Clone & Install**
```bash
# Clone the theme repository
git clone -b pixel https://github.com/mahaveergurjar/sddm.git /tmp/sddm-pixel

# Move to SDDM themes directory
sudo mkdir -p /usr/share/sddm/themes/
sudo mv /tmp/sddm-pixel/sddm /usr/share/sddm/themes/sddm

# Enable the theme
sudo nano /etc/sddm.conf

# Find [Theme] section and set:
# Current=sddm

# Save and restart SDDM
sudo systemctl restart sddm
```

**Option 2: Direct Installation**
```bash
# One-liner installation
git clone -b pixel https://github.com/mahaveergurjar/sddm.git && sudo mv sddm /usr/share/sddm/themes/ && sudo sed -i 's/Current=.*/Current=sddm/' /etc/sddm.conf && sudo systemctl restart sddm
```

### Configuration

**Edit SDDM Config:**
```bash
sudo nano /etc/sddm.conf
```

**Settings for Pixel UI:**
```ini
[General]
Session=plasmawayland

[Theme]
Current=sddm
```

### Enable/Disable Theme

**To use Pixel UI:**
```bash
# Edit config
sudo nano /etc/sddm.conf

# Change to:
Current=sddm

# Restart
sudo systemctl restart sddm
```

**To switch back to default:**
```bash
sudo nano /etc/sddm.conf

# Change to:
Current=breeze

# Restart
sudo systemctl restart sddm
```

### Test Theme (Without Restart)

```bash
# Preview theme without restarting SDDM
sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/sddm
```

### Dependencies

The theme requires:
- `qt6-declarative`
- `qt6-svg`
- `sddm-greeter-qt6`

Install if missing:
```bash
sudo pacman -S qt6-declarative qt6-svg sddm-greeter-qt6
```

### Troubleshooting Pixel UI

**"Module is not installed" error:**
```bash
# Install required packages
sudo pacman -S qt6-5compat qt6-declarative qt6-svg
sudo systemctl restart sddm
```

**Theme doesn't appear:**
```bash
# Verify theme installation
ls -la /usr/share/sddm/themes/sddm

# Check SDDM config
cat /etc/sddm.conf | grep -A5 "\[Theme\]"

# Restart SDDM
sudo systemctl restart sddm
```

**Restore default theme:**
```bash
sudo nano /etc/sddm.conf
# Set Current=breeze
sudo systemctl restart sddm
```

### Compare SDDM Themes

| Theme | Style | Best For |
|-------|-------|----------|
| **Pixel UI** | Minimalist, futuristic | Modern gaming systems |
| **Astronaut** | Space-inspired, colorful | Creative users |
| **Pixie** | Modern, sleek | Minimal aesthetic |
| **Breeze** | Default KDE theme | Compatibility |

---

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

### CoreCtrl won't open
```bash
# Ensure polkit rules are set
sudo nano /etc/polkit-1/rules.d/90-corectrl.rules
# Add wheel group to rules if missing
```

### GPU not detected
```bash
# Check GPU drivers:
sudo pacman -S --noconfirm amdgpu-pro-libs

# Verify GPU:
glxinfo | grep -i radeon
```

### BORE kernel missing from boot menu
```bash
# Reinstall and update:
sudo pacman -S linux-cachyos-bore linux-cachyos-bore-headers
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### Browser acceleration not working
```bash
# Brave: Verify brave://gpu
# Firefox: Check about:support in Graphics section

# Reinstall GPU drivers:
sudo pacman -S vulkan-radeon opencl-mesa lib32-vulkan-radeon
```

### scx_bpfland won't start
```bash
# Check for conflicts with BORE
sudo systemctl disable scx-bpfland
sudo systemctl enable BORE  # Use one scheduler

# Or check service status:
sudo systemctl status scx-bpfland
sudo journalctl -u scx-bpfland -n 50
```

---

## 🔄 Version History

### v2.3 (Current) ⭐
- ✨ Enhanced Limine bootloader configuration with timeout and default_entry
- ✨ Detailed bootloader entry selection guide with directory tips
- ✨ Improved Pixel UI SDDM theme installation
- ✨ One-click Bash shell installation
- ✨ Python one-liner installation method
- ✨ Complete v2.3 comprehensive guide
- ✨ Better YouTube integration and tutorials
- ✅ Full v2.3 feature documentation

### v2.2 (Previous)
- ✨ Added Limine bootloader configuration guide
- ✨ Added Pixel UI SDDM theme installation
- ✨ Added Python one-liner installation method
- ✨ Enhanced bootloader configuration steps
- ✨ Improved documentation
- ✨ Added YouTube channel reference

### v2.0 (Earlier)
- ✨ Complete rewrite with 10+ major improvements
- 🔄 GRUB → Limine bootloader
- 🔄 CoreCtrl → LACT GPU management (CoreCtrl now optional)
- 🔄 ProtonUp-Qt → ProtonPlus
- ➕ BORE scheduler kernel support
- ➕ Multiple SDDM themes
- ➕ cachy-update integration
- ➕ Btrfs snapshot support
- ➕ GPU Shader Cache 12GB optimization
- ➕ Browser Hardware Acceleration
- ➕ scx_bpfland Advanced Scheduler (optional)
- ➕ CoreCtrl as optional GPU management tool
- ➕ 20+ gaming/dev tools installer

### v1.0 (Legacy)
- Original CachyOS gaming setup script
- **Repository**: https://github.com/SokolSaitiAlb/cachyos-ultimate-tune.sh
- [View v1.0 Repository](https://github.com/SokolSaitiAlb/cachyos-ultimate-tune.sh)

---

## 📚 Resources

**Main Repositories:**
- **CachyOS Ultimate Tune v2.0** (Current): https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide
  - Script: `cachyos-ultimate-tune-improved.sh`
  - Documentation: `CACHYOS_TUNE_README.md`
  - Quick Guide: `QUICK_START_GUIDE.md`

- **CachyOS Ultimate Tune v1.0** (Legacy): https://github.com/SokolSaitiAlb/cachyos-ultimate-tune.sh
  - Original implementation
  - Archived for reference

**GPU Management Tools:**
- **LACT (Modern)**: https://github.com/ilya-zlobintsev/LACT
- **CoreCtrl (Profile-Based)**: https://gitlab.com/corectrl/corectrl
  - AUR Package: https://archlinux.org/packages/extra/x86_64/corectrl/

**Kernel & Schedulers:**
- **BORE Scheduler**: https://github.com/firelzrd/bore-scheduler
- **scx_bpfland**: https://github.com/arighi/scx

**Proton & Gaming:**
- **ProtonPlus**: https://github.com/Vysp3r/ProtonPlus
- **ProtonPlus AUR**: https://aur.archlinux.org/packages/protonplus

**System Updates:**
- **cachy-update**: https://github.com/CachyOS/cachy-update
- **Limine Bootloader**: https://github.com/Limine-Bootloader/Limine

**SDDM Themes:**
- **Astronaut**: https://github.com/Keyitdev/sddm-astronaut-theme
- **Pixie**: https://github.com/xCaptaiN09/pixie-sddm
- **Pixel UI**: https://github.com/mahaveergurjar/sddm

**CachyOS Wiki:**
- **Main**: https://wiki.cachyos.org
- **Gaming Configuration**: https://wiki.cachyos.org/configuration/gaming/
- **Browser Acceleration**: https://wiki.cachyos.org/configuration/enabling_hardware_acceleration_in_google_chrome/

**Official CachyOS:**
- **CachyOS Website**: https://cachyos.org
- **CachyOS GitHub**: https://github.com/CachyOS

---

## 🎥 About The Creator

**Alb Kestrel** - Linux Content Creator

Specializing in CachyOS gaming optimization and Linux gaming performance.

### YouTube Channel

📺 **Alb Kestrel** (@ALBKESTRELYTofficial)

**Subscribe for:**
- Complete CachyOS setup tutorials
- GPU overclocking guides (RX6800)
- Gaming performance benchmarks
- Linux gaming optimization tips
- Limine bootloader configuration
- SDDM theme installations
- Hardware review & testing

**Direct Link:** https://youtube.com/@albkestrelytofficial

### Social & Links

- **GitHub:** [SokolSaitiAlb](https://github.com/SokolSaitiAlb)
- **YouTube:** [@ALBKESTRELYTofficial](https://youtube.com/@albkestrelytofficial)
- **Repository:** [CachyOS-Ultimate-Tune-v2.0](https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide)

### Latest Projects

- **CachyOS Ultimate Tune v2.2** - Complete gaming optimization
- **Prayer Times Notifier** - Islamic practice tool for Linux
- **PipeWire Audio Fixer** - Audio configuration utility
- **Various Linux utilities** - Open-source tools on GitHub

### Contact & Feedback

- Subscribe to YouTube channel for updates
- Open GitHub issues for bug reports
- Fork and contribute improvements
- Share your setup results!

---

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

*Last updated: 2025*  
*By: Alb Kestrel (Improved v2.0)*
