# 💻 IMBA-ARCH INSTALLER

> 🧠 Скрипт для **автоматической установки Arch Linux** — с Btrfs, GNOME, SDDM, Flatpak, AUR, dev/gamer пакетом и Wayland.  
> ⚠️ НЕ ДЛЯ СЛАБОНЕРВНЫХ. Всё снесёт, всё поставит, всё сделает. **Настоящая Arch магия**.

---

## 🧨 Предупреждение

‼️ **Этот скрипт ПОЛНОСТЬЮ УНИЧТОЖАЕТ выбранный диск!**  
Он не спрашивает дважды. Он форматирует. Жёстко. С любовью. 🧽

> **НАДЕЮСЬ, ВЫ СНАЧАЛА ПОД СЕБЯ ЕГО НАСТРОИТЕ, А УЖЕ ПОТОМ ЗАПУСКАЕТЕ.**  
> Это не шутка. Не тестовая установка. Это — как `rm -rf /` на стероидах.

---

## 📦 Что он делает?

- Удаляет всё на выбранном диске и ставит:
  - `Btrfs` с `@` подтомом
  - `GRUB` загрузчик
  - `GNOME` с **Wayland**
  - `SDDM` как дисплей-менеджер
  - `paru` (AUR)
  - `Steam`, `Lutris`, `Gamemode`
  - `Visual Studio Code`, `Firefox`, `LibreWolf` (Flatpak)
  - Шрифтосы, PipeWire, NetworkManager, Flatpak и пр.

---

## 💿 Как использовать?

1. Загрузись с любого Arch Live ISO
2. Подключись к интернету (Wi-Fi или Ethernet)
3. Скачай скрипт:
   ```bash
   curl -O https://raw.githubusercontent.com/Asterlenist/Imba-Arch-Installer/main/install.sh
   chmod +x install.sh
