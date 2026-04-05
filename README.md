🔧 CachyOS ULTIMATE GAMING TUNER v2.4
Precision-Engineered for RX 6800 + i5-12400F | Optimized for 768p High-Performance Gaming
v2.4 "PoLP" Edition: Fully refactored for security. This script now follows the Principle of Least Privilege, running in user-space and only invoking sudo for critical system changes. No more makepkg errors or permission conflicts.
⚡ One-Click Secure Installation
Run the command below as a regular user. The script will securely prompt for your password only when necessary (e.g., installing packages or updating bootloaders).
Do NOT run this with sudo.
bash -c "$(curl -fsSL https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide/raw/main/cachyos-ultimate-tune-improved.sh)"

🚀 Key v2.4 Engineered Features
🛠️ Infrastructure as Code (IaC) Approach
 * Automated Limine Config: Detects your Root UUID and generates a bootable limine.conf automatically. No manual editing.
 * SDDM Pixel UI: Installs and activates the minimalist theme via drop-in /etc/sddm.conf.d/ overrides.
 * User-Centric Scaling: Applies KDE and Steam scaling directly to your user profile without touching root’s environment.
🎮 High-Performance Gaming Pipeline
 * 12GB Shader Cache: Pre-configured MESA_SHADER_CACHE to eliminate stuttering on the RX 6800.
 * The "Pro" Stack: Installs Steam, Wine-Staging, Mangohud, Gamemode, and proton-ge-custom-bin via a secured yay build process.
 * GPU Management: Full LACT integration for AMD power profile management.
🖥️ 1366x768 "High-Res" Simulation
 * KDE Global Scale (0.9x): Recovers critical screen real estate on 768p displays.
 * Steam UI Force (0.75x): Fixes the "New Big Picture" overflow issues common on lower resolutions.
📋 System Target Specifications
| Component | Optimization Strategy |
|---|---|
| CPU | Intel i5-12400F (Performance Governor + Sysctl Tweaks) |
| GPU | AMD RX 6800 16GB (Max Shader Cache + BORE Scheduler) |
| Monitor | 1366x768 @ 60Hz (Custom 0.9x UI Scaling) |
| Bootloader | Limine (Fully Automated UUID Injection) |
| Security | PoLP Compliant (Non-root execution) |
📹 Community & Support
See the benchmarks and setup guides in action:
 * YouTube: @ALBKESTRELYTofficial
https://youtube.com/@albkestrelytofficial
 * GitHub: SokolSaitiAlb
https://github.com/SokolSaitiAlb
> [!IMPORTANT]
> Post-Install: Reboot immediately to apply the new Limine bootloader configuration and kernel performance parameters.
> 
Last updated: 05.04.2026 — v2.4 (Security & Permission Refactor)


