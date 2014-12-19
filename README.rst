My Arch Linux Installation Guide
================================
Starting from installation media

  loadkeys dvorak
  setfont LatArCyrHeb-16 # better fonts

Partitions
----------
https://wiki.archlinux.org/index.php/Partitioning

Using **GPT fdisk** to create partitions::

  gdisk /dev/sda

Inside gdisk, ``o`` creates a GPT, ``n`` to create new partitions ``+xxG`` is
the format where xx is the size.

**BIOS Partition table**

+-----+-------+--------------------------+-------------+-----------------+
| Dev |  Size | Mount point              | File system | gdisk type code |
+=====+=======+==========================+=============+=================+
| SSD |  512M | EFI System Parition      | fat32       | EF00            |
+-----+-------+--------------------------+-------------+-----------------+
| SSD |  128M | ``/boot``                | ext4        | 8300            |
+-----+-------+--------------------------+-------------+-----------------+
| SSD |   30G | ``/``                    | ext4        | 8300            |
+-----+-------+--------------------------+-------------+-----------------+
| SSD | >100G | ``/home``                | ext4        | 8300            |
+-----+-------+--------------------------+-------------+-----------------+
| HDD |       | ``/var``                 | btrfs       | var subvol      |
+-----+-------+--------------------------+-------------+-----------------+
| HDD |       | ``/home/martin/archive`` | btrfs       | Archive subvol  |
+-----+-------+--------------------------+-------------+-----------------+

Swap is a file, instead of a partition, so it can be resized easily. It should
be contained in the SSD.

Format partitions, for example::

  mkfs.fat -F32 /dev/sda1
  mkfs.ext4 /dev/sda2
  mkfs.ext4 /dev/sda3
  mkfs.ext4 /dev/sda4
  mkfs.btrfs -f -L Storage /dev/sdb
  btrfs subvolume create var
  btrfs subvolume create Archive

Mount everything te /mnt::

  mount -t ext4 /dev/sda3 /mnt
  mkdir -p /mnt/{boot/efi,home/martin/Archive/,var}
  mount -t ext4 /dev/sda2 /mnt/boot
  mount -t vfat /dev/sda1 /mnt/boot/efi
  mount -t ext4 /dev/sda4 /mnt/home
  mount -o subvol=var /dev/sdb /mnt/var
  mount -o subvol=Archive /dev/sdb /mnt/home/martin/Archive

Installing and setting the base system
--------------------------------------

Install base system::

  pacstrap /mnt base base-devel

Installing grub and zsh::

  arch-chroot /mnt pacman -S grub dosfstools efibootmgr intel-ucode
  arch-chroot /mnt pacman -S zsh vim git sudo networkmanager

Create the user ``martin``::

  arch-chroot /mnt useradd -m -g users -s /bin/zsh martin
  arch-chroot /mnt chfn martin
  arch-chroot /mnt passwd martin
  arch-chroot /mnt chown -R martin:users /home/martin/Archive

Create swapfile::

  arch-chroot /mnt fallocate -l 5G /home/swapfile
  arch-chroot /mnt chmod 600 /home/swapfile
  arch-chroot /mnt mkswap /home/swapfile
  arch-chroot /mnt swapon /home/swapfile

Generate ``fstab``::

  genfstab -p /mnt >> /mnt/etc/fstab
  sed '/^\/mnt\/home/ s|mnt/|| ' -i /mnt/etc/fstab

Afterwards change to ``defaults,noatime,discard`` all ssd partitions.

Copy files and Chroot into the fresh installation::

  arch-chroot /mnt

Set zsh as default shell for root::

  chsh -s $(which zsh)
  zsh

Set locales, uncomment en_DK.UTF8 en_US.UTF8 es_PE.UTF8 on ``/etc/locale.gen``::

  sed '/^#en_DK\.UTF-8/ s|#|| ' -i /etc/locale.gen
  sed '/^#en_US\.UTF-8/ s|#|| ' -i /etc/locale.gen
  sed '/^#es_PE\.UTF-8/ s|#|| ' -i /etc/locale.gen
  locale-gen

Set basic configuration files::

  ln -s /usr/share/zoneinfo/America/Lima /etc/localtime
  cd /home/martin/Archive/git/arch-conf
  cp etc/hostname /etc/
  cp etc/locale.conf /etc/
  cp etc/vconsole.conf /etc/
  cp etc/mkinitcpio.conf /etc/
  cp etc/default/grub /etc/default/
  cd usr/share

Building the kernel image, don't forget copy the ``mkinitcpio.conf`` from
arch-conf.git which has the hook to support hibernation::

  mkinitcpio -p linux

Configure ``sudoers`` with ``visudo``, add::

  martin stella= /usr/bin/pacman

Add repository for yaourt and install it::

  [archlinuxfr]
  # The French Arch Linux communities packages.
  SigLevel = Never
  Server = http://repo.archlinux.fr/$arch

Installing aur utility and installing needed packages::

  pacman -Sy yaourt
  yaourt -S grub2-theme-archxion

Configure grub, copy the ``/etc/default/grub`` from arch-conf.git which adds the
parameters needed for hibernation support::

  grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id="Arch" --recheck --debug
  mkdir -p /boot/grub/locale
  cp /usr/share/locale/en@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
  grub-mkconfig -o /boot/grub/grub.cfg

Enabling Intel Microcode updates is done automatically now.

Set root password, leave chroot env, unmount and reboot::

  passwd

After the first reboot
----------------------

Start console session as ``martin``

Sync, update and install the rest of the good stuff::

  yaourt -Syua

GUI base::

  yaourt -S xfce4 xfce4-goodies pulseaudio sox lightdm lightdm-gtk3-greeter
  yaourt -S accountsservice xorg-xmodmap haveged

Fonts, utilities, etc::

  yaourt -S ttf-dejavu ttf-liberation ttf-symbola
  yaourt -S adobe-source-code-pro-fonts adobe-source-sans-pro-fonts
  yaourt -S adobe-source-serif-pro-fonts adobe-source-han-sans-otc-fonts
  yaourt -S unrar unzip p7zip ntp openssh imagemagick htop
  yaourt -S google-chrome-dev dropbox redshift python-gobject vlc
  yaourt -S xcursor-vanilla-dmz numix-themes
  yaourt -S faience-icon-theme network-manager-applet pavucontrol
  yaourt -S gvfs gvfs-mtp gvfs-gphoto2 libcanberra-pulse libcanberra-gstreamer
  yaourt -S libcanberra gnome-keyring

Optional::

  yaourt -S steam
  yaourt -S xf86-input-synaptics # duh
  yaourt -S cdrkit # mkisofs, wodim and stuff
  yaourt -S python2-dbus # systemd-analize blame and redshift
  yaourt -S glew glfw glm # for the opengl experience
  yaourt -S zip # to create stupid zip files

Not used anymore (maybe)::

  yaourt -S wqy-microhei wqy-zenhei wqy-bitmapsong-beta
  yaourt -S infinality-bundle ibfonts-meta-base # (1) add repositories
  yaourt -S ttf-wqy-microhei-ibx ttf-roboto-ibx
  yaourt -S xfce4-volumed-pulse xfce-theme-greybird
  yaourt -S xf86-video-intel libva-intel-driver
  yaourt -S gstreamer0.10-good-plugins # for xfce4-mixer to work with pulse

* livestreamer # to stream in VLC from twitch.tv and others
* mupen64plus # nintendo 64 emulator
* ext4_utils # ROMs samsung galaxy s ii
* easytag # mp3 metadata editor
* hexedit # aoeu
* aria2 # download everything in style
* cmus # music player

Important
---------

For (1) infinality-bundle (unused atm)::

  https://wiki.archlinux.org/index.php/Infinality#Custom_repository

To change avatar on lightdm::

  https://wiki.archlinux.org/index.php/LightDM#The_AccountsService_way

To change base configuration files::

  hostnamectl set-hostname ivy
  localectl set-locale LANG="en_US.utf8" LC_COLLATE="C" LC_TIME="en_DK.utf8"
  timedatectl set-timezone America/Lima

Set ntp time sync and enabling services::

  systemctl disable remote-fs.target
  timedatectl set-ntp 1 # this enables the ntpd daemon
  ll /sys/class/net/
  systemctl enable NetworkManager.service
  systemctl enable haveged # entrophy daemon for cryptographic awesome.
  # systemctl enable dhcpcd@enp0s25.service

**Updating mirrorlists**

When Pacman mirrorlist is updated, re-generate ``/etc/pacmand.d/mirrorlist``::

  sed '/#Server/ s|#|| ' -i /etc/pacman.d/mirrorlist.pacnew
  sed '/^#.*$/d' -i /etc/pacman.d/mirrorlist.pacnew
  rankmirrors -n 6 /etc/pacman.d/mirrorlist.pacnew > /etc/pacman.d/mirrorlist
  rm /etc/pacman.d/mirrorlist.pacnew

Tweaks and hacks
----------------

**Caps Lock to control**

TTY was taken care with the custom keymap, now for X::

  cp git/.../home/martin/.Xmodmap ~/.Xmodmap

**User home directories**

Create the needed directoties, make sure ``xdg-user-dirs`` is installed and
edit the file ``.config/user-dirs.dirs`` as needed.

**Fix fonts for some applications**::

  gconftool-2 --set --type string /desktop/gnome/interface/font_name "Source Sans Pro"
  gconftool-2 --set --type string /desktop/gnome/interface/monospace_font_name "Source Code Pro"

**Java**

Install preferably on ``~/Archive/usr``, rename from ``jdk-x.x.x`` to ``java``
then as root::

  ln -s /home/martin/Archive/usr/java /opt/java

**Android-sdk**

Needed libs from ``multilib``::
