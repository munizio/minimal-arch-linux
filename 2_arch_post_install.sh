#!/bin/bash

echo "Installing common packages"
yes | sudo pacman -S xorg-server-xwayland

echo "Installing common applications"
echo -en "1\nyes" | sudo pacman -S chromium git openssh htop curl wget vim networkmanager fzf bmon

echo "Installing Material Design icons"
sudo mkdir -p /usr/share/fonts/TTF/
sudo wget -P /usr/share/fonts/TTF/ https://raw.githubusercontent.com/Templarian/MaterialDesign-Webfont/master/fonts/materialdesignicons-webfont.ttf

echo "Installing sway and additional packages"
yes | sudo pacman -S sway swaylock swayidle waybar wl-clipboard pulseaudio pavucontrol alsa-utils rofi light termite grim

echo "Fetching Custom Config Files from Repo"
cd ~
git init
git remote add origin https://github.com/munizio/minimal-arch-linux
git pull origin master -f

echo "Blacklisting bluetooth"
sudo touch /etc/modprobe.d/nobt.conf
sudo tee /etc/modprobe.d/nobt.conf << END
blacklist btusb
blacklist bluetooth
END
sudo mkinitcpio -p linux-lts
sudo mkinitcpio -p linux

echo "Fixing Audio"
mkdir ~/tmp
git clone https://github.com/munizio/UCM ~/tmp/UCM
sudo cp -rv ~/tmp/UCM/chtmax98090 /usr/share/alsa/ucm
alsactl kill quit
alsactl init
pulseaudio --kill
pulseaudio --start
sudo rm -rf ~/tmp/UCM

echo "Your setup is ready. You can reboot now!"
