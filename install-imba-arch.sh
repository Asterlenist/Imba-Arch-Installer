
#!/bin/bash
# ┌──────────────────────────────┐
# │  IMBA-ARCH: LINUX УСТАНОВКА  │
# └──────────────────────────────┘

set -e

echo "🔧 Подключаем зеркало от Arch'а..."
reflector --country Germany,Russia --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

echo "⌛ Синхронизация времени..."
timedatectl set-ntp true

echo "💽 Подготовка диска..."
DISK="/dev/sdX"
read -rp "Введите диск для установки (например /dev/sda): " DISK
wipefs -af "$DISK"
sgdisk -Z "$DISK"
sgdisk -n 1::+512M -t 1:ef00 -c 1:"EFI" "$DISK"
sgdisk -n 2::-0 -t 2:8300 -c 2:"ROOT" "$DISK"

mkfs.fat -F32 "${DISK}1"
mkfs.btrfs "${DISK}2"

mount "${DISK}2" /mnt
btrfs subvolume create /mnt/@
umount /mnt
mount -o compress=zstd,subvol=@ "${DISK}2" /mnt
mkdir /mnt/boot
mount "${DISK}1" /mnt/boot

echo "📦 Устанавливаем базу системы..."
pacstrap /mnt base base-devel linux linux-firmware linux-headers btrfs-progs neovim git networkmanager grub efibootmgr sudo reflector

echo "🧱 Настраиваем fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

echo "🚪 chroot внутрь!"
arch-chroot /mnt /bin/bash <<EOF

echo "🌐 Устанавливаем часовой пояс, язык, хостнейм..."
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "imba-arch" > /etc/hostname

echo "🛡️ Устанавливаем sudo и юзера..."
useradd -m -G wheel gamer
echo "gamer:archlinux" | chpasswd
echo "root:archlinux" | chpasswd
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers

echo "🚀 Настройка загрузчика (GRUB)..."
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

echo "📡 Включаем сеть..."
systemctl enable NetworkManager

echo "📦 Устанавливаем dev/gamer пакеты..."
pacman -Syu --noconfirm \
  xorg xorg-xinit i3-gaps kitty firefox \
  steam lutris gamemode \
  code zsh unzip wget curl \
  pipewire pipewire-pulse pavucontrol \
  noto-fonts noto-fonts-emoji ttf-dejavu \
  lib32-gamemode lib32-vulkan-icd-loader \
  mesa vulkan-intel lib32-mesa lib32-vulkan-intel \
  base-devel git

echo "🎮 Подключаем multilib для 32-бит игр..."
sed -i '/#\[multilib\]/,+1 s/#//' /etc/pacman.conf
pacman -Syy

echo "✨ Установка paru (AUR помощник)..."
sudo -u gamer bash <<EOG
cd ~
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
EOG

echo "🌈 Добро пожаловать в Arch, бро."
EOF

echo "✅ Готово. Перезагружайся и кайфуй!"
