#!/bin/bash

root_password=""
user_name=""
user_password=""
hostname="cbnix"
main_hdd="mmcblk0"
efi_partition=$main_hdd"p1"
root_partition=$main_hdd"p2"

echo "Updating system clock"
timedatectl set-ntp true

echo "Creating partition tables"
printf "n\n1\n4096\n+512M\nef00\nw\ny\n" | gdisk /dev/$main_hdd
printf "n\n2\n\n\n8e00\nw\ny\n" | gdisk /dev/$main_hdd

echo "Building EFI filesystem"
yes | mkfs.fat -F32 /dev/$efi_partition

echo "Building filesystems for root "
yes | mkfs.ext4 /dev/$root_partition

echo "Mounting root"
mount /dev/$root_partition /mnt

echo "Installing Arch Linux"
yes '' | pacstrap /mnt base base-devel grub efibootmgr

echo "Generating fstab"
genfstab -U -p /mnt >> /mnt/etc/fstab

echo "Configuring new system"
arch-chroot /mnt /bin/bash << EOF
echo "Setting system clock"
ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc --utc

echo "Setting locales"
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
locale-gen

echo "Setting hostname"
echo $hostname > /etc/hostname

echo "Setting hostfile"
echo "127.0.0.1 localhost $hostname" > /etc/hosts

echo "Setting root password"
echo -en "$root_password\n$root_password" | passwd

echo "Creating new user"
useradd -m -G wheel -s /bin/bash $user_name
echo -en "$user_password\n$user_password" | passwd $user_name

echo "Adding user as a sudoer"
echo '%wheel ALL=(ALL) ALL' | EDITOR='tee -a' visudo

echo "Enabling Network Manager"
systemctl enable NetworkManager

echo "Configuring GRUB"
mkdir /boot/efi
mount /dev/$efi_partition /boot/efi
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --recheck
grub-mkconfig -o /boot/grub/grub.cfg
mkdir /boot/efi/EFI/BOOT
cp /boot/efi/EFI/GRUB/grubx64.efi /boot/efi/EFI/BOOT/BOOTX64.EFI

EOF

umount -R /mnt

echo "ArchLinux is ready. You can reboot now!"
