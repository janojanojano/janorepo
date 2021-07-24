!/bin/bash

#LOCALE_CONF=("LANG=es_ES.UTF-8" "LANGUAGE=es_ES:es:en_US:en")
#KEYMAP="KEYMAP=es"
#KEYLAYOUT="es"





loadkeys la-latin1
mkfs.ext4 /dev/sda3
mount /dev/sda3 /mnt
pacstrap /mnt linux-lts linux-firmware base nano os-prober ntfs-3g grub networkmanager dhcpcd 
genfstab /mnt >> /mnt/etc/fstab
arch-chroot /mnt
echo aaalinux-pc > /etc/hostname
ln -sf /usr/share/zoneinfo/America/Santiago /etc/localtime

echo "modificar idioma sistema"
#nano /etc/locale.gen


LOCALES=("es_ES.UTF-8 UTF-8")
sed -i "s/#$LOCALES/$LOCALES/" /etc/locale.gen


#sed -i "es_ES.UTF-8 UTF-8" /etc/locale.gen
#sed -i "es_ES ISO-8859-1" /etc/locale.gen





locale-gen

hwclock -w

echo KEYMAP=la-latin1 > /etc/vconsole.conf
echo LANG=es_ES.UTF8 > /etc/locale.conf
grub-install /dev/sda
os-prober
grub-mkconfig -o /boot/grub/grub.cfg


echo "paasword root"
passwd

useradd -m aaalinux
echo "paasword usuario"
passwd aaalinux



exit
reboot






#systemctl start NetworkManager.service
#systemctl enable NetworkManager.service
#pacman -S xf86-video-amdgpu amd-ucode
#pacman -S xf86-video-ati
#pacman -S xf86-video-intel intel-ucode
#pacman -S xorg-server xorg-xinit mesa mesa-demos
#pacman -S lxde
#pacman -S opera leafpad epdfview firefox firefox-i18n-es-cl file-roller
#pacman -S lxdm
#systemctl enable lxdm.service
















