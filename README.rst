My Arch Linux Installation Guide
================================
Starting from installation media

**Git**::

  wget https://raw.github.com/martincanaval/arch-conf/master/usr/share/kbd/keymaps/i386/dvorak/dvorak-la2.map
  loadkeys dvorak-la2.map
  setfont LatArCyrHeb-16

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
| SSD |    2M | BIOS Boot partition      | none        | EF02            |
+-----+-------+--------------------------+-------------+-----------------+
| SSD |  128M | ``/boot``                | ext4        | 8300            |
+-----+-------+--------------------------+-------------+-----------------+
| SSD |   30G | ``/``                    | ext4        | 8300            |
+-----+-------+--------------------------+-------------+-----------------+
| SSD | >100G | ``/home``                | ext4        | 8300            |
+-----+-------+--------------------------+-------------+-----------------+
| SSD |    1M | GPT secondary table      | none        | none            |
+-----+-------+--------------------------+-------------+-----------------+
| HDD |   15G | ``/var``                 | ext4        | 8300            |
+-----+-------+--------------------------+-------------+-----------------+
| HDD | >100G | ``/home/martin/archive`` | ext4        | 8300            |
+-----+-------+--------------------------+-------------+-----------------+

Swap is a file, instead of a partition, so it can be resized easily. It should
be contained in the SSD.

Format partitions, for example::

  mkfs.ext4 /dev/sda6
  mkfs.ext4 /dev/sda7
  mkfs.ext4 /dev/sda8
  mkfs.ext4 /dev/sdb5
  mkfs.ext4 /dev/sdb6

Mount everything te /mnt::

  mount -t ext4 /dev/sda7 /mnt
  mkdir -p /mnt/{boot,home/martin/archive/,var}
  mount -t ext4 /dev/sda6 /mnt/boot
  mount -t ext4 /dev/sda8 /mnt/home
  mount -t ext4 /dev/sdb5 /mnt/var
  mount -t ext4 /dev/sdb6 /mnt/home/martin/archive

Installing and setting the base system
--------------------------------------

Install base system::

  pacstrap /mnt base base-devel

Installing grub and zsh::

  arch-chroot /mnt pacman -S grub-bios zsh vim git sudo networkmanager

Create the user ``martin``::

  arch-chroot /mnt useradd -m -g users -s /bin/zsh martin
  arch-chroot /mnt chfn martin
  arch-chroot /mnt passwd martin
  arch-chroot /mnt chown 1000:100 /home/martin/archive

Create swapfile::

  arch-chroot /mnt fallocate -l 5G /swapfile
  arch-chroot /mnt chmod 600 /swapfile
  arch-chroot /mnt mkswap /swapfile
  arch-chroot /mnt swapon /swapfile

Generate ``fstab``::

  genfstab -p /mnt >> /mnt/etc/fstab
  sed '/^\/mnt\/swapfile/ s|mnt/|| ' -i /mnt/etc/fstab

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

Building the kernel image::

  mkinitcpio -p linux

Configure ``sudoers``, add::

  martin ivy= /usr/bin/pacman

Add repository for yaourt and install it::

  [archlinuxfr]
  # The French Arch Linux communities packages.
  SigLevel = Never
  Server = http://repo.archlinux.fr/$arch

Installing aur utility and installing needed packages::

  pacman -Sy yaourt
  yaourt -S grub2-theme-archxion

Configure grub::

  modprobe dm-mod
  grub-install --target=i386-pc --recheck --debug /dev/sda
  mkdir -p /boot/grub/locale
  cp /usr/share/locale/en@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
  grub-mkconfig -o /boot/grub/grub.cfg

Set root password, leave chroot env, unmount and reboot::

  passwd

After the first reboot
----------------------

Start console session as ``martin``

Sync, update and install the rest of the good stuff::

  yaourt -Syua

GUI base::

  yaourt -S kde nvidia xorg-xinit sox yakuake oxygen-gtk2
  yaourt -S oxygen-gtk3 gtk-theme-switch2 kde-gtk-config steam

Fonts, utilities, etc::

  yaourt -S wqy-microhei wqy-zenhei wqy-bitmapsong-beta ttf-monaco
  yaourt -S unrar unzip p7zip ntp openssh imagemagick htop
  yaourt -S freetype2-infinality fontconfig-infinality
  yaourt -S google-chrome-dev dropbox google-talkplugin

Optional::

  yaourt -S python2-dbus python2-gobject # opcional (systemd-analize blame)
  yaourt -S glew glfw glm # for the opengl experience

Not installed at the moment::

  yaourt -S network-manager-applet networkmanager-dispatcher-ntpd
  yaourt -S catalyst archlinux-artwork terminus-font

* ext4_utils # ROMs samsung galaxy s ii
* xvidcap
* easytag # mp3 metadata editor
* hexedit # aoeu
* aria2 # download everything in style
* cmus # music player

Important
---------

To change base configuration files::

  hostnamectl set-hostname ivy
  localectl set-locale LANG="en_US.utf8" LC_COLLATE="C" LC_TIME="en_DK.utf8"
  timedatectl set-timezone America/Lima

Set ntp time sync and enabling services::

  systemctl disable remote-fs.target
  timedatectl set-ntp 1 # this enables the ntpd daemon
  ll /sys/class/net/
  systemctl enable NetworkManager.service
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

  gconftool-2 --set --type string /desktop/gnome/interface/font_name Sans
  gconftool-2 --set --type string \
    /desktop/gnome/interface/monospace_font_name Cousine

**Java**

Install preferably on ``~/Archive/usr``, rename from ``jdk-x.x.x`` to ``java``
then as root::

  ln -s /home/martin/Archive/usr/java /opt/java

**Android-sdk**

Needed libs from ``multilib``::

Packages keept locally
----------------------

