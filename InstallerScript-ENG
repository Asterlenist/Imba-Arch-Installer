#!/bin/bash
# ┌──────────────────────────────┐
# │      IMBA-ARCH INSTALLER     │
# └──────────────────────────────┘

set -e

echo "🔧 Connecting to Arch Linux mirrors..."
reflector --country Japan,Russia --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

echo "⌛ Enabling NTP time sync..."
timedatectl set-ntp true

echo "💽 Disk preparation..."
DISK="/dev/sdX"
read -rp "Enter target disk (e.g., /dev/sda): " DISK
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

echo "📦 Installing base system..."
pacstrap /mnt base base-devel linux linux-lts linux-firmware linux-headers btrfs-progs neovim git networkmanager grub efibootmgr sudo reflector

echo "🧱 Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

echo "🚪 Entering chroot..."
arch-chroot /mnt /bin/bash <<EOF

echo "🌐 Setting timezone, locale, hostname..."
ln -sf /usr/share/zoneinfo/Asia/Vladivostok /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "georgy-pc" > /etc/hostname

echo "🛡️ Creating user and setting passwords..."
useradd -m -G wheel georgy
echo "georgy:archlinux" | chpasswd
echo "root:archlinux" | chpasswd
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers

echo "🚀 Installing GRUB bootloader..."
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

echo "🧠 Enabling display manager (SDDM)..."
systemctl enable sddm

echo "📡 Enabling network manager..."
systemctl enable NetworkManager

echo "🎮 Enabling multilib for 32-bit support..."
sed -i '/#\[multilib\]/,+1 s/#//' /etc/pacman.conf
pacman -Syy

echo "📦 Installing dev/gaming packages..."
pacman -Syu --noconfirm \
  xorg xorg-xinit xorg-xwayland gnome gnome-tweaks kitty firefox \
  steam lutris gamemode \
  code zsh unzip wget curl \
  pipewire pipewire-pulse pavucontrol \
  noto-fonts noto-fonts-emoji ttf-dejavu \
  lib32-gamemode lib32-vulkan-icd-loader \
  mesa vulkan-intel lib32-mesa lib32-vulkan-intel \
  base-devel git flatpak

echo "📦 Installing Flathub and LibreWolf..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub io.gitlab.librewolf-community

echo "✨ Installing paru (AUR helper)..."
sudo -u georgy bash <<EOG
cd ~
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
EOG

echo "🌈 Welcome to Arch, bro."
EOF

echo "✅ All done. Reboot and enjoy!"
