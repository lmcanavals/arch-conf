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

  arch-chroot /mnt pacman -S grub-bios zsh vim git sudo

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
  cp etc/mkinitcpio.conf /ect/
  cp etc/default/grub /etc/default/
  cd usr/share
  cp kbd/keymaps/i386/dvorak/dvorak-la2.map /usr/share/kbd/keymaps/i386/dvorak/
  cp X11/xkb/symbols/latam /usr/share/X11/xkb/symbols/

Add consolefont keymap at the end of hook to ``/etc/mkinitcpio.conf``::

  mkinitcpio -p linux

Configure grub::

  modprobe dm-mod
  grub-install --target=i386-pc --recheck --debug /dev/sda
  mkdir -p /boot/grub/locale
  cp /usr/share/locale/en@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
  grub-mkconfig -o /boot/grub/grub.cfg

Configure ``sudoers``, add::

  martin ivy= /usr/bin/pacman

Add repository for yaourt and install it::

  [archlinuxfr]
  # The French Arch Linux communities packages.
  Server = http://repo.archlinux.fr/$arch
  pacman -S yaourt

Set root password, leave chroot env, unmount and reboot::

  passwd

After the first reboot
----------------------

Start console session as ``martin``

Sync, update and install the rest of the good stuff::

  yaourt -Syua

GUI base::

  yaourt -S xorg-server xorg-xmodmap xorg-xrdb xorg-xprop xdg-user-dirs
  yaourt -S xfce4 xfce4-goodies xfce4-volumed xdg-utils libxss xorg-xrandr

Sound stuff::

  yaourt -S pulseaudio pulseaudio-alsa ffmpeg pavucontrol paprefs sox
  yaourt -S gstreamer0.10-plugins
  yaourt -S libcanberra libcanberra-pulse libcanberra-gstreamer

Themes, fonts,  etc.::

  yaourt -S wqy-microhei wqy-zenhei wqy-bitmapsong-beta
  yaourt -S ttf-droid ttf-dejavu ttf-monaco
  yaourt -S gtk-engine-unico gtk-engine-murrine faenza-icon-theme
  yaourt -S xcursor-vanilla-dmz xfce-theme-greybird
  yaourt -S grub2-theme-archxion

Utilities::

  yaourt -S file-roller unrar unzip p7zip ntp openssh imagemagick htop
  yaourt -S networkmanager freetype2-infinality fontconfig-infinality
  yaourt -S google-chrome-dev
  yaourt -S dropbox thunar-dropbox gvfs gvfs-afc gvfs-gphoto2 # removable stuff

Optional::

  yaourt -S python2-dbus python2-gobject # opcional (systemd-analize blame)
  yaourt -S glew glfw glm # for the opengl experience

Not installed at the moment::

  yaourt -S network-manager-applet networkmanager-dispatcher-ntpd
  yaourt -S catalyst google-talkplugin archlinux-artwork terminus-font
  yaourt -S ttf-ubuntu-font-family

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
  localectl set-locale LANG="en_US.utf8"
  localectl set-locale LC_COLLATE="C"
  localectl set-locale LC_TIME="en_DK.utf8"
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

**Dvorak ES_LA**::

  cp git/.../latam /usr/share/X11/xkb/symbols/

Set keyboard to ``Español Latino América`` variation ``dvla``

**Icons for thunar plugins**::

  cd .local/share/icons/Faience/apps/16/
  ln -s dropbox.png thunar-dropbox.png
  ln -s file-roller.png tap-create.png
  ln -s ../../places/16/folder-download.png tap-extract.png
  ln -s ../../places/16/folder-saved-search.png tap-extract-to.png

**User home directories**

Create the needed directoties, make sure ``xdg-user-dirs`` is installed and
edit the file ``.config/user-dirs.dirs`` as needed.

**Fix fonts for some applications**::

  gconftool-2 --set --type string /desktop/gnome/interface/font_name Sans
  gconftool-2 --set --type string \
    /desktop/gnome/interface/monospace_font_name Cousine

**Fix google chrome with preferred applications**

Make sure ``xorg-xprop`` is installed::

  cp /usr/share/applications/google-chrome.desktop ~/.local/share/xfce4/helpers/

Make the following changes::

  Type=X-XFCE-Helper
  X-XFCE-Category=WebBrowser
  X-XFCE-Commands=/opt/google/chrome/google-chrome
  X-XFCE-CommandsWithParameter=/opt/google/chrome/google-chrome "%s"

**Sound control keys on Xfce**

Settings » Settings Editor » xfce-mixer

* Set ``active-card`` to the same value as ``sound-card``

**Event sounds for Xfce**

Settings » Appearance » Settings

* Activate ``Enable event sounds`` and ``Enable input feedback sounds``

Settings » Settings Editor » xsettings » net

* Set ``SoundThemeName`` to ``Fresh and Clean``

**Android-sdk**

Needed libs from ``multilib``::

  yaourt -S lib32-alsa-lib lib32-openal lib32-libstdc++5 lib32-libxv
  yaourt -S lib32-ncurses lib32-sdl lib32-zlib lib32-libxrandr lib32-libpulse
  yaourt -S lib32-alsa-plugins lib32-catalyst-utils

Packages keept locally
----------------------

* extra/grml-zsh-config **0.7.1-3**
* Equinox Evolution Light **1.50**
* Faience Icons **0.5.1**
* Faience Theme **0.5.3**

**Theme Faience**

murrine-statusbar::

  font_name = 9

murrine_separator_menu_item::

  xthickness = 2
  ythickness = 2
  contrast = 0.4

murrine-menu-item::

  xthickness = 3
  ythickness = 4

murrine-scrollbar::

  roundness = 2

**Theme greybird**

Cool separators::

  separatorstyle = 1

Scrollbars parameters::

  GtkScrollbar    ::slider-width         = 6
  GtkScrollbar    ::trough-border        = 1
  GtkScrollbar    ::has-backward-stepper = 0
  GtkScrollbar    ::has-forward-stepper  = 0

Scrollbar style::

  style "scrollbar"
  {
    bg[SELECTED]        = shade (0.6, @base_color)
    bg[ACTIVE]          = @base_color

    engine "murrine" {
      roundness         = 2
      gradient_shades   = {1.0,1.0,1.0,1.0}
      highlight_shade   = 1.0
      glow_shade        = 1.0
      reliefstyle       = 0
      gradient_colors   = FALSE
      lightborder_shade = 1.0
      lightborderstyle  = 0
      trough_shades     = { 1.3, 1.3}
      border_shades     = { 2.0, 2.0}
      contrast          = 0.0
    }
  }


**Unused Stuff**

Add repository to ``/etc/pacman.conf`` for *ATI RADEON HD 5xxx series* drivers
before core::

  [catalyst]
  Server = http://catalyst.apocalypsus.net/repo/catalyst/$arch

Sync clock::

  ntpd -qg

Fix gtk themes for QT::

 gconftool-2 --set --type string /desktop/gnome/interface/gtk_theme greybird-git

