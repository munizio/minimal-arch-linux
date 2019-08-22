#!/bin/bash

echo "Installing common packages"
yes | sudo pacman -S xorg-server-xwayland

echo "Installing common applications"
echo -en "1\nyes" | sudo pacman -S chromium git openssh htop curl wget

echo "Installing fonts"
yes | sudo pacman -S ttf-droid ttf-opensans ttf-dejavu ttf-liberation ttf-hack ttf-fira-code noto-fonts gsfonts powerline-fonts adobe-source-code-pro-fonts

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

echo "misc config changes"
cat >> ~/.bash_profile << EOF
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  XKB_DEFAULT_LAYOUT=us exec sway
fi
EOF

cat >> ~/.bashrc << EOF
alias vi='vim'

alias ls='ls --color=auto'
alias ll='ls -alF'
EOF

echo "Your setup is ready. You can reboot now!"
