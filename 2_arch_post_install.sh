#!/bin/bash

echo "Installing common packages"
yes | sudo pacman -S xorg-server-xwayland

echo "Installing common applications"
echo -en "1\nyes" | sudo pacman -S chromium git openssh htop curl wget vim networkmanager

echo "Installing fonts"
yes | sudo pacman -S ttf-droid ttf-opensans ttf-dejavu ttf-liberation ttf-hack ttf-fira-code noto-fonts gsfonts powerline-fonts

echo "Setting up icon theme"
git clone https://github.com/vinceliuice/Qogir-icon-theme.git
cd Qogir-icon-theme
sudo mkdir -p /usr/share/icons
sudo ./install.sh -d /usr/share/icons
cd ..
rm -rf Qogir-icon-theme

echo "Installing Material Design icons"
sudo mkdir -p /usr/share/fonts/TTF/
sudo wget -P /usr/share/fonts/TTF/ https://raw.githubusercontent.com/Templarian/MaterialDesign-Webfont/master/fonts/materialdesignicons-webfont.ttf

echo "Installing sway and additional packages"
yes | sudo pacman -S sway swaylock swayidle waybar wl-clipboard pulseaudio pavucontrol alsa-utils rofi light termite
mkdir -p ~/.config/sway
wget -P ~/.config/sway/ https://raw.githubusercontent.com/exah-io/minimal-arch-linux/master/configs/sway/config

echo "Ricing waybar"
mkdir -p ~/.config/waybar
wget -P ~/.config/waybar https://raw.githubusercontent.com/exah-io/minimal-arch-linux/master/configs/waybar/config
wget -P ~/.config/waybar https://raw.githubusercontent.com/exah-io/minimal-arch-linux/master/configs/waybar/style.css

echo "Ricing rofi"
mkdir -p ~/.config/rofi
wget -P ~/.config/rofi https://raw.githubusercontent.com/exah-io/minimal-arch-linux/master/configs/rofi/base16-material-darker.rasi
wget -P ~/.config/rofi https://raw.githubusercontent.com/exah-io/minimal-arch-linux/master/configs/rofi/config

echo "Set .bash_profile"
rm ~/.bash_profile
wget -P ~/ https://raw.githubusercontent.com/munizio/minimal-arch-linux/master/.bash_profile

cat >> ~/.bashrc << EOF
alias vi='vim'

alias ls='ls --color=auto'
alias ll='ls -alF'
EOF

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
