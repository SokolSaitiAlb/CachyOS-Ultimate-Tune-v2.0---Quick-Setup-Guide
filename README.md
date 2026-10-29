# CachyOS Ultimate Gaming Tune v10.0

Automatizim opsional për CachyOS me paketa gaming/DevOps dhe konfigurime të performancës. Instalimi i temës SDDM Pixel UI nga një branch i jashtëm i pa-pinuar është çaktivizuar. Skripti ka privilegje administrative, prandaj mënyra e parazgjedhur është **preview pa ndryshime**.

## Përdorim i sigurt

Mos ekzekuto një skript administrativ direkt nga `curl | bash`. Klonoje dhe inspektoje përpara ekzekutimit:

```bash
git clone https://github.com/SokolSaitiAlb/CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide.git
cd CachyOS-Ultimate-Tune-v2.0---Quick-Setup-Guide
less cachyos-ultimate-tune-improved.sh
bash -n cachyos-ultimate-tune-improved.sh
```

### 1. Preview — nuk ndryshon sistemin

```bash
bash cachyos-ultimate-tune-improved.sh --dry-run
```

Pa argumente, skripti bën të njëjtin preview. Nuk nis `sudo`, pacman/yay ose shërbime në këtë mënyrë.

### 2. Aplikim me konfirmim

```bash
bash cachyos-ultimate-tune-improved.sh --apply
```

Skripti refuzon ekzekutimin `--apply` si root, në mënyrë jo-interaktive dhe jashtë CachyOS. Para ndryshimeve, kërkon të shkruash saktësisht `APPLY` dhe ruan një kopje root-owned të skedarëve të konfigurimit që mund të ndryshojë nën:

`/var/lib/cachyos-ultimate-tune/backups/TIMESTAMP`

Skripti zbulon nëse duket se përdoret Limine, GRUB apo systemd-boot, por **nuk ndryshon bootloader-in ose hyrjet e nisjes**. Kontrolli është informues; nëse zbulimi thotë unknown, kontrolloje vetë para aplikimit.

### 3. Rikthim konfigurimesh

Përdor direktorinë reale të krijuar gjatë aplikimit:

```bash
bash cachyos-ultimate-tune-improved.sh --rollback /var/lib/cachyos-ultimate-tune/backups/TIMESTAMP
```

Rikthimi kërkon konfirmim `ROLLBACK`, kontrollon pronësinë/lejet e backup-it dhe rikthen skedarët e mbështetur nga arkivi. Pastaj rikarikon sysctl. **Nuk çinstalon automatikisht paketat** e instaluara nga pacman/yay; kontrolloji veçmas para heqjes.

## Çfarë ndryshon aplikimi

- Aktivizon locale `sq_AL.UTF-8` nëse mungon.
- Instalon paketat e listuara për gaming, mjete DevOps dhe desktop.
- Nuk instalon automatikisht temë SDDM nga branch i jashtëm i pa-pinuar; inspekto dhe pin një commit të caktuar përpara instalimit manual.
- Shkruan `~/.config/environment.d/gaming.conf`.
- Shkruan dhe aplikon `/etc/sysctl.d/99-performance.conf`.

Për të ulur rrezikun, skripti **nuk** e shton automatikisht përdoruesin në grupin `docker` (që jep privilegje praktikisht ekuivalente me root) dhe nuk e aktivizon automatikisht shërbimin Ollama. Paketat instalohen vetëm pas konfirmimit të qartë.

## Kufizime të rëndësishme

- Backup/rollback mbulon vetëm skedarët e konfigurimit të listuar nga skripti, jo çinstalimin e paketave ose çdo efekt anësor të sistemit.
- Përpara ekzekutimit në sistemin kryesor, provoje në VM ose krijo një snapshot të plotë.
- Mos e përdor në një shpërndarje tjetër pa auditim të veçantë.
- Skripti nuk është mjet universal për “tuning”; çdo ndryshim i sysctl ose i SDDM duhet të vlerësohet për makinën konkrete.

## Për autorin

Alb Kestrel — Linux, CachyOS, gaming dhe automatizim DevOps.
YouTube: https://www.youtube.com/@ALBKESTRELYTofficial
