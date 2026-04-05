# 🚀 CachyOS ULTIMATE GAMING TUNER v2.6
### **The "RDNA 2 Performance" Edition**
**Precision-Engineered for AMD RX 6800 + i5-12400F**

This script is a fully refactored, high-performance deployment tool for **CachyOS**. It follows the **Principle of Least Privilege (PoLP)**—running in user-space and only invoking `sudo` for critical system changes.

---

## ⚡ One-Click Secure Installation
Run the command below as a regular user. The script will securely prompt for your password only when necessary.
**DO NOT run this with sudo.**

```bash
bash -c "$(curl -fsSL [https://raw.githubusercontent.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide/main/cachyos-ultimate-tune-improved.sh](https://raw.githubusercontent.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide/main/cachyos-ultimate-tune-improved.sh))"

🚀 Key v2.6 Engineered Features
🛠️ Infrastructure as Code (IaC) Approach
 * Zero-Touch Dependency Management: Leverages native CachyOS yay and pacman repositories.
 * SDDM Pixel UI: Modern /etc/sddm.conf.d/ overrides for a clean login experience.
 * Clean Environment: Modular variables written to ~/.config/environment.d/.
🎮 High-Performance Gaming Pipeline
 * Next-Gen Geometry (NGGC): Unlocks RDNA 2 hardware-level primitive shaders via RADV_PERFTEST=nggc.
 * 12GB Shader Cache: Massive MESA_SHADER_CACHE to eliminate stuttering.
 * The "Pro" Stack: Steam, Wine-Staging, MangoHud, Gamemode, GE-Proton, and LACT.
⚡ System Kernel & Memory Tweaks
 * 16GB RAM Optimization: vm.swappiness=10 for better NVMe responsiveness.
 * Memory Map Expansion: vm.max_map_count optimized for AAA titles and modded servers.
📋 System Target Specifications
| Component | Optimization Strategy |
|---|---|
| CPU | Intel i5-12400F (Performance Governor) |
| GPU | AMD RX 6800 16GB (NGGC + 12GB Cache) |
| Monitor | 1440p Ready (Native Scaling preserved) |
| Kernel | CachyOS Bore / LTO Optimized |
| Security | PoLP Compliant |
📹 Community & Support
 * YouTube: @ALBKESTRELYTofficial
 * GitHub: SokolSaitiAlb
> [!IMPORTANT]
> Post-Install: Reboot immediately to apply the MESA environment variables and sysctl parameters.
> 
