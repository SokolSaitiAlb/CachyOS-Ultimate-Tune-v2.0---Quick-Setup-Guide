```python
import os
import subprocess

def run_setup():
    print("🚀 Starting CachyOS Ultimate Tune v2.3 via Python...")
    script_url = "https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide/raw/main/cachyos-ultimate-tune-improved.sh"
    os.system(f"curl -fsSL {script_url} | bash")

if __name__ == "__main__":
    run_setup()
