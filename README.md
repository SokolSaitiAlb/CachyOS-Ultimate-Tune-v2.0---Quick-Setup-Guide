🚀 CachyOS ULTIMATE GAMING TUNER v2.6
The "RDNA 2 Performance" Edition
Precision-Engineered for AMD RX 6800 + i5-12400F
This script is a fully refactored, high-performance deployment tool for CachyOS. It follows the Principle of Least Privilege (PoLP)—running in user-space and only invoking sudo for critical system changes. No more makepkg errors or permission conflicts.
⚡ One-Click Secure Installation
Run the command below as a regular user. The script will securely prompt for your password only when necessary.
DO NOT run this with sudo.
bash -c "$(curl -fsSL https://raw.githubusercontent.com/SokolSaitiAlb/[YOUR_REPO_NAME]/main/tuner.sh)"

🚀 Key v2.6 Engineered Features
🛠️ Infrastructure as Code (IaC) Approach
 * Zero-Touch Dependency Management: Leverages the native CachyOS yay and pacman repositories for maximum stability.
 * SDDM Pixel UI: Installs and activates the minimalist theme via modern /etc/sddm.conf.d/ overrides.
 * Clean Environment: Writes variables to ~/.config/environment.d/ for a standardized, modular configuration.
🎮 High-Performance Gaming Pipeline
 * Next-Gen Geometry (NGGC): Explicitly enables RADV_PERFTEST=nggc to unlock hardware-level primitive shaders on the RX 6800.
 * 12GB Shader Cache: Massive MESA_SHADER_CACHE to eliminate stuttering in AAA titles.
 * The "Pro" Stack: Installs Steam, Wine-Staging, MangoHud, Gamemode, and GE-Proton for ultimate compatibility.
 * GPU Management: Full LACT integration for RDNA 2 power profile and fan curve management.
⚡ System Kernel & Memory Tweaks
 * 16GB RAM Optimization: Set vm.swappiness=10 to prioritize physical memory over disk swap.
 * Memory Map Expansion: Set vm.max_map_count to 2147483642 for heavy titles like Star Citizen and modded Minecraft.
📋 System Target Specifications
| Component | Optimization Strategy |
|---|---|
| CPU | Intel i5-12400F (Performance Governor + Sysctl Tweaks) |
| GPU | AMD RX 6800 16GB (NGGC Enabled + 12GB Cache) |
| Monitor | 1440p Ready (Native Scaling preserved for high-DPI clarity) |
| Kernel | CachyOS Bore / LTO Optimized |
| Security | PoLP Compliant (Non-root execution) |
📹 Community & Support
 * YouTube: @ALBKESTRELYTofficial
 * GitHub: SokolSaitiAlb
> [!IMPORTANT]
> Post-Install: Reboot immediately to apply the MESA environment variables and sysctl performance parameters.
> 
