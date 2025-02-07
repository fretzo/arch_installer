#!/bin/bash
OPT="--color always -q --noprogressbar --noconfirm --logfile pacman-$0.log"

echo "--[DISK CONFIGURATION]--"
drive=$(mount|grep boot|awk -F/ '{print $3}')
boot=$(echo ${drive:0:3})

echo -e "BOOT DRIVE: $boot\n"

echo "- List of other drives:"
lsblk|grep disk|grep -v $boot

echo ""
read -p "Type name of disk to install Arch linux (the entire content will be erased) : " TARGET1
echo -e "This is the content of drive $TARGET1\n"
fdisk -l /dev/${TARGET1}
echo -e "\n\nType the drive name again to confirm the deletion "
read -p "name of drive to install ARCH (press ENTER to cancel): " TARGET2
if [ "$TARGET1" == "$TARGET2" ]; then
  TARGET=$TARGET1
  echo "- Wiping disk $TARGET"
  wipefs -a /dev/$TARGET &>/dev/null
  dd if=/dev/zero of=/dev/$TARGET bs=1M count=1024 &>/dev/null
  parted --script /dev/$TARGET -- mklabel gpt \
	  mkpart primary fat32 64d 512MiB \
	  set 1 esp on \
	  mkpart primary ext4 512MiB 100GiB \
	  mkpart primary ext4 101GiB -1MiB &>/dev/null
  #CHECK FOR NVME DRIVE, IF SO, ADJUST THE TARGET DEVICE
  if [[ -b /dev/${TARGET}p1 ]]; then echo "- NVME drive detected";TARGET=nvme0n1p;fi
  echo "- Formatting boot partition"
  mkfs.fat -F32 /dev/${TARGET}1   &>/dev/null
  echo "- Formatting Root partition"
  mkfs.ext4 /dev/${TARGET}2       &>/dev/null
  echo "- Formatting Home partition"
  mkfs.ext4 /dev/${TARGET}3       &>/dev/null
  ./pacstrap.sh /dev/$TARGET
else
  echo "Aborting due to mismatch in target drive"
  echo -e "type ./install.sh  to retry installation\n"
fi 
