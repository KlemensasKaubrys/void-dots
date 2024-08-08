#!/bin/sh

username=$(id -u -n 1000)
builddir=$(pwd)

# Check if Script is Run as Root
if [ `id -u` -ne 0 ]
  then echo Please run this script as root or using sudo!
  exit
fi

sudo xbps-install -Suy
cd $builddir
mkdir -p /home/$username/.config
chown -R $username:$username /home/$username
rm /home/$username/.bashrc
rm /home/$username/.bash_profile
ln -s /home/$username/void-dots/bashrc /home/$username/.bashrc
ln -s /home/$username/void-dots/bash_profile /home/$username/.bash_profile
ln -s /home/$username/void-dots/xinitrc /home/$username/.xinitrc
ln -s /home/$username/void-dots/wezterm.lua /home/$username/.wezterm.lua
ln -s /home/$username/void-dots/scripts /home/$username/.scripts
ln -s /home/$username/void-dots/Thunar /home/$username/.config/
ln -s /home/$username/void-dots/dunst /home/$username/.config/
ln -s /home/$username/void-dots/mpd /home/$username/.config/
ln -s /home/$username/void-dots/fastfetch /home/$username/.config/
ln -s /home/$username/void-dots/ncmpcpp /home/$username/.config/
ln -s /home/$username/void-dots/picom.conf /home/$username/.config/
ln -s /home/$username/void-dots/starship.toml /home/$username/.config/

# Fix pavucontrol theming
mkdir -p /home/$username/.config/gtk-3.0
ln -s /home/$username/.config/gtk-3.0 /home/$username/.config/gtk-4.0
chown -R $username:$username /home/$username/.config/gtk-4.0
chown -R $username:$username /home/$username/.config/gtk-3.0

# Install base system
xbps-install -S base-devel xorg libX11-devel libXft-devel libXinerama-devel freetype-devel fontconfig-devel xinit xprop picom dunst feh git btop Thunar network-manager-applet mate-polkit pipewire wireplumber picard mpd ncmpcpp yt-dlp flameshot lutris gvfs lxappearance pavucontrol arc-theme nerd-fonts font-awesome6 font-inter mesa-dri xf86-video-amdgpu mesa-vaapi mesa-vdpau vulkan-loader mesa-vulkan-radeon amdvlk firefox betterlockscreen libspa-bluetooth bluez anki syncthing wezterm mpv fastfetch curl 7zip xauth starship ffmpeg ufw 

ln -s /etc/sv/dbus /var/service/

# Disabling bitmaps because they break firefox fonts
ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/
xbps-reconfigure -f fontconfig

# Pipewire configuration
mkdir -p /etc/pipewire/pipewire.conf.d
ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

# Setting up firewall
ufw limit 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw default deny incoming
ufw default allow outgoing
ufw enable
ln -s /etc/sv/ufw /var/service/

# Building dwm, dmenu, dwmblocks
cd dwm
make clean install
cd $builddir
cd dmenu
make clean install
cd $builddir
cd dwmblocks
make clean install
cd $builddir

# Install tlp
xbps-install -S tlp tlp-rdw smartmontools ethtool
rm /etc/tlp.conf
ln -s /home/$username/void-dots/tlp.conf /etc/
sudo tlp start
ln -s /etc/sv/tlp /var/service/

# Create the swapfile
btrfs subvolume create /var/swap
truncate -s 0 /var/swap/swapfile
chattr +C /var/swap/swapfile
btrfs property set /var/swap compression none
chmod 600 /var/swap/swapfile
dd if=/dev/zero of=/var/swap/swapfile bs=1G count=20 status=progress
mkswap /var/swap/swapfile
swapon /var/swap/swapfile
echo "/var/swap/swapfile none swap sw 0 0" >> /etc/fstab

# Setting up snapper
cd /
xbps-install -S snapper grub-btrfs inotify-tools
umount /.snapshots
rm -r /.snapshots/
snapper -c root create-config /
btrfs subvolume delete /.snapshots
mkdir /.snapshots
mount -a
btrfs subvolume list / 
btrfs subvolume set-default 256 / 
vim /etc/snapper/configs/root 
chown -R :wheel /.snapshots
sudo ln -s /etc/sv/snapperd /var/service/
snapper -c root create --description 'Post install'
update-grub


echo "Done!"
