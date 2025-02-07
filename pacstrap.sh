#!/bin/bash
echo "--[MOUNTING FILESYSTEM]--"

TARGET=$1
umount -R /mnt &>/dev/null
echo "- mount /"
echo "TARGET: $TARGET"

# STANDARD
mount ${TARGET}2 /mnt  ;
mkdir /mnt/boot  
mount ${TARGET}1 /mnt/boot;
mkdir /mnt/home
mount ${TARGET}3 /mnt/home;
echo "- refreshing repositories"
pacman -Syy &>/dev/null
echo "- Installing base packages"
# pacstrap /mnt base pacman-contrib linux linux-firmware - EDIT
pacstrap /mnt base pacman-contrib linux linux-firmware &>/dev/null
echo "- Installing extra utilities"
pacstrap /mnt zip unzip vim nmon ncdu htop syslog-ng lsb-release bash-completion exfat-utils usb_modeswitch neofetch  &>/dev/null
echo "- Installing custom fonts"
pacstrap /mnt terminus-font &>/dev/null
echo "- Installing SSH and sudo"
pacstrap /mnt openssh sudo &>/dev/null
echo '- chroot to new install'
mkdir /mnt/scripts
cp *.sh /mnt/scripts &>/dev/null
cp font.txt /mnt/scripts &>/dev/null
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt /scripts/post-chroot.sh
