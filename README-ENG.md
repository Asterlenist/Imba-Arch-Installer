# 💻 IMBA-ARCH INSTALLER

> 🧠 A script for **fully automated Arch Linux installation** — includes Btrfs, GNOME, SDDM, Flatpak, AUR helper, dev/gaming stack and Wayland.  
> ⚠️ Not for the faint of heart. It wipes everything and installs like a boss. **Pure Arch magic.**

---

## 🧨 Warning

‼️ **This script COMPLETELY ERASES the selected disk!**  
It won't ask twice. It will format. It will delete. With love. 🧽

> **PLEASE CUSTOMIZE THE SCRIPT TO YOUR NEEDS BEFORE USING IT.**  
> This is not a demo. It's a real installer. Like `rm -rf /`, but intentional.

---

## 📦 What does it do?

- Wipes the target disk and sets up:
  - `Btrfs` with `@` subvolume
  - `GRUB` as bootloader
  - `GNOME` with **Wayland**
  - `SDDM` as display manager
  - `paru` (AUR helper)
  - `Steam`, `Lutris`, `Gamemode`
  - `VSCode`, `Firefox`, `LibreWolf` (via Flatpak)
  - Fonts, audio (PipeWire), networking, dev tools and more

---

## 💿 How to use?

1. Boot into any Arch Linux Live ISO
2. Make sure you're connected to the internet
3. Download the script:
   ```bash
   curl -O https://raw.githubusercontent.com/Asterlenist/Imba-Arch-Installer/main/install.sh
   chmod +x install.sh
