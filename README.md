# Minimal Arch Linux setup - Install scripts

Clean | Busy
:-------------------------:|:-------------------------:
![screenshot](https://raw.githubusercontent.com/munizio/minimal-arch-linux/master/screenshot.png) | ![screenshot_2](https://raw.githubusercontent.com/munizio/minimal-arch-linux/master/screenshot_2.png)

### Partitions
| Name | Type | Mountpoint |
| - | :-: | :-: |
| mmcblk0 | disk | |
| ├─mmcblk0p1 | part | /boot |
| ├─mmcblk0p2 | part | / |

## Post install script
* swaywm:
   * autostart on tty1
   * waybar: onclick pavucontrol (volume control) and nmtui (ncli network manager)
   * swayidle and swaylock: automatic sleep and lock
   * rofi as application launcher
* Other applications: chromium git openssh htop curl wget vim termite light rofi

## Detailed installation guide
1. Download and boot into the latest [Arch Linux iso](https://www.archlinux.org/download/)
2. Connect to the internet. If using wifi, you can use `wifi-menu` to connect to a network
3. Clear all existing partitions (see below: MISC - How to clear all partitions)
5. `wget https://raw.githubusercontent.com/munizio/minimal-arch-linux/master/1_arch_install.sh`
6. Change the variables at the top of the file (lines 3 through 9)
7. Make the script executable: `chmod +x 1_arch_install.sh`
8. Run the script: `./1_arch_install.sh`
9. Reboot into Arch Linux
10. Connect to wifi with `nmtui`
10. `wget https://raw.githubusercontent.com/munizio/minimal-arch-linux/master/2_arch_post_install.sh`
11. Make the script executable: `chmod +x 2_arch_post_install.sh`
12. Run the script: `./2_arch_post_install.sh`

## Misc guides
### How to clear all partitions
```
gdisk /dev/nvme0n1
x
z
y
y
```

## References
* Original Fork: [exah-io/minimal-arch-linux](https://github.com/exah-io/minimal-arch-linux)
