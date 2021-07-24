!/bin/bash



sudo systemctl start NetworkManager.service
sudo systemctl enable NetworkManager.service
sudo pacman -S xf86-video-amdgpu amd-ucode
sudo pacman -S xf86-video-ati
sudo pacman -S xf86-video-intel intel-ucode
sudo pacman -S xorg-server xorg-xinit mesa mesa-demos
sudo pacman -S lxde
sudo pacman -S opera leafpad epdfview firefox firefox-i18n-es-cl file-roller smplayer deluge gnome-disk-utility
sudo pacman -S lxdm
sudo systemctl enable lxdm.servi