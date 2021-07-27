!/bin/bash

#LOCALE_CONF=("LANG=es_ES.UTF-8" "LANGUAGE=es_ES:es:en_US:en")
#KEYMAP="KEYMAP=es"
#KEYLAYOUT="es"
#pico 
#localectl set-x11-keymap latam pc105



loadkeys latam
mkfs.ext4 /dev/sda3
mount /dev/sda3 /mnt
pacstrap /mnt linux-lts linux-firmware base nano os-prober ntfs-3g grub networkmanager dhcpcd 
genfstab /mnt >> /mnt/etc/fstab


#arch-chroot /mnt
arch-chroot /mnt echo aaalinux-pc > /mnt/etc/hostname

arch-chroot /mnt ln -sf /usr/share/zoneinfo/America/Santiago /etc/localtime

echo "modificar idioma sistema"

arch-chroot /mnt sed -i 's/#es_CL.UTF-8 UTF-8/es_CL.UTF-8 UTF-8/' /etc/locale.gen

#sed -i "es_ES.UTF-8 UTF-8" /etc/locale.gen
#sed -i "es_ES ISO-8859-1" /etc/locale.gen

arch-chroot /mnt locale-gen

arch-chroot /mnt hwclock -w


arch-chroot /mnt echo KEYMAP=latam > /mnt/etc/vconsole.conf
arch-chroot /mnt echo LANG=es_CL.UTF8 > /etc/locale.conf


#arch-chroot /mnt pacman -Syu --noconfirm --needed grub-install mnt/dev/sda
#arch-chroot /mnt grub-mkconfig -o mnt/boot/grub/grub.cfg


arch-chroot /mnt grub-install --target=i386-pc --recheck /dev/sda

arch-chroot /mnt os-prober

arch-chroot /mnt grub-mkconfig -o boot/grub/grub.cfg





# if [ "$ROOT_PASSWORD" == "ask" ]; then
#        PASSWORD_TYPED="false"
#        while [ "$PASSWORD_TYPED" != "true" ]; do
#            read -sp 'Type root password: ' ROOT_PASSWORD
#            echo ""
#            read -sp 'Retype root password: ' ROOT_PASSWORD_RETYPE
#            echo ""
#            if [ "$ROOT_PASSWORD" == "$ROOT_PASSWORD_RETYPE" ]; then
#                PASSWORD_TYPED="true"
#            else
#                echo "Root password don't match. Please, type again."
#            fi
#
#        done
#    fi




#function create_user_useradd() {
#    USER=$1
#    PASSWORD=$2
#    arch-chroot /mnt useradd -m -G wheel,storage,optical -s /bin/bash $USER
#    printf "$PASSWORD\n$PASSWORD" | arch-chroot /mnt passwd $USER
#}






#arch-chroot /mnt #systemctl start NetworkManager.service
arch-chroot /mnt systemctl enable NetworkManager.service
#systemctl enable NetworkManager.service


#arch-chroot /mnt pacman -Syu --noconfirm --needed xf86-video-amdgpu amd-ucode
arch-chroot /mnt pacman -Syu --noconfirm --needed xf86-video-ati
#pacman -S xf86-video-intel intel-ucode
arch-chroot /mnt pacman -Syu --noconfirm --needed xorg-server xorg-xinit mesa mesa-demos
arch-chroot /mnt pacman -Syu --noconfirm --needed lxde
arch-chroot /mnt pacman -Syu --noconfirm --needed opera leafpad epdfview firefox firefox-i18n-es-cl file-roller
arch-chroot /mnt pacman -Syu --noconfirm --needed gnome-themes-extra sudo gnome-disk-utility xdg-user-dirs

arch-chroot /mnt pacman -Syu --noconfirm --needed lxdm
arch-chroot /mnt systemctl enable lxdm.service



echo "ingrese paasword root"
arch-chroot /mnt passwd



arch-chroot /mnt useradd -m aaalinux
echo "ingrese paasword usuario"
arch-chroot /mnt passwd aaalinux

