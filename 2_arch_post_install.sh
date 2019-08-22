#!/bin/bash

echo "Installing common packages"
yes | sudo pacman -S xorg-server-xwayland

echo "Installing common applications"
echo -en "1\nyes" | sudo pacman -S chromium git openssh htop curl wget vim networkmanager

echo "Installing Material Design icons"
sudo mkdir -p /usr/share/fonts/TTF/
sudo wget -P /usr/share/fonts/TTF/ https://raw.githubusercontent.com/Templarian/MaterialDesign-Webfont/master/fonts/materialdesignicons-webfont.ttf

echo "Installing sway and additional packages"
yes | sudo pacman -S sway swaylock swayidle waybar wl-clipboard pulseaudio pavucontrol alsa-utils rofi light termite

echo "fetching base config files from repo"
cd ~
git init
git remote add origin https://github.com/munizio/minimal-arch-linux
git pull origin master -f

echo "Enabling NetworkManager"
sudo systemctl enable NetworkManager

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
