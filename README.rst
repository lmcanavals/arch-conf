My Arch Linux Installation Guide
================================
Starting from installation media

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
  mkdir /mnt/boot
  mkdir /mnt/var
  mkdir -p /mnt/home/martin/archive
  mount -t ext4 /dev/sda6 /mnt/boot
  mount -t ext4 /dev/sda8 /mnt/home
  mount -t ext4 /dev/sdb5 /mnt/var
  mount -t ext4 /dev/sdb6 /mnt/home/martin/archive

Installing and setting the base system
--------------------------------------

Install base system::

  pacstrap /mnt base base-devel

Installing grub and zsh::

  arch-chroot /mnt pacman -S grub-bios zsh vim jshon git sudo

Create the user ``martin`` make sure it uses ``/bin/zsh`` as shell  and owns
``/home/martin`` as well as ``/home/martin/archive``::

  arch-chroot /mnt adduser
  arch-chroot /mnt chown 1000:100 /home/martin/archive

Generate ``fstab``::

  genfstab -p /mnt >> /mnt/etc/fstab

Copy files and Chroot into the fresh installation::

  cp /etc/zsh/zshrc /mnt/etc/zsh/ # TODO fix
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

  echo "ivy" >> /etc/hostname
  ln -s /usr/share/zoneinfo/America/Lima /etc/localtime
  echo "LANG=en_US.UTF-8" >> /etc/locale.conf
  echo "LC_COLLATE=C" >> /etc/locale.conf
  echo "LC_TIME=en_DK.UTF-8" >> /etc/locale.conf
  echo "KEYMAP=dvorak-la2" >> /etc/vconsole.conf
  echo "FONT=" >> /etc/vconsole.conf
  echo "FONT_MAP=" >> /etc/vconsole.conf
  curl https://dl.dropbox.com/u/11788734/dvorak-la2.map.gz > dvorak-la2.map.gz

Add consolefont keymap at the end of hook to ``/etc/mkinitcpio.conf``::

  sed '/^HOOKS.*\"$/ s|"$| consolefont keymap\"| ' -i /etc/mkinitcpio.conf
  mkinitcpio -p linux

Configure grub::

  modprobe dm-mod
  grub-install --target=i386-pc --recheck --debug /dev/sda
  mkdir -p /boot/grub/locale
  cp /usr/share/locale/en@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
  grub-mkconfig -o /boot/grub/grub.cfg

Add repository to ``/etc/pacman.conf`` for *ATI RADEON HD 5xxx series* drivers
before core::

  [catalyst]
  Server = http://catalyst.apocalypsus.net/repo/catalyst/$arch

Configure ``sudoers``, add::

  Defaults setenv
  martin ivy= /usr/bin/pacman

Set root password, leave chroot env, unmount and reboot::

  passwd

After the first reboot
----------------------

Start console session as ``martin``

Sync, update and install the rest of the good stuff::

  packer -Syu
  packer -S ntp xorg-server xorg-xmodmap xorg-xrdb xorg-xprop xdg-user-dirs
  packer -S catalyst grub2-theme-archxion
  packer -S xfce4 xfce4-goodies xfce4-volumed glew gstreamer0.10-plugins
  packer -S pulseaudio pulseaudio-alsa ffmpeg pavucontrol paprefs sox
  packer -S libcanberra libcanberra-pulse libcanberra-gstreamer
  packer -S networkmanager networkmanager-dispatcher-ntpd network-manager-applet
  packer -S ttf-droid ttf-dejavu ttf-ms-webfonts ttf-chromeos-fonts
  packer -S wqy-microhei ttf-unifont wqy-zenhei wqy-bitmapsong-beta
  packer -S google-chrome-dev google-talkplugin # revisar reemplazo html5
  packer -S dropbox thunar-dropbox gvfs gvfs-afc gvfs-gphoto2 # removable stuff
  packer -S file-roller unrar unzip p7zip
  packer -S gtk-engine-unico gtk-engine-murrine faenza-icon-theme
  packer -S openssh xcursor-vanilla-dmz imagemagick
  packer -S python2-dbus python2-gobject # opcional (systemd-analize blame)


Important
---------

To change base configuration files::

  hostnamectl set-hostname ivy
  localectl set-locale LANG="en_US.utf8"
  localectl set-locale LC_COLLATE="C"
  localectl set-locale LC_TIME="en_DK.utf8"
  timedatectl set-timezone America/Lima

Set ntp time sync and enabling services::

  timedatectl set-ntp 1 # this enables the ntpd daemon
  systemctl enable NetworkManager.service

https://wiki.archlinux.org/index.php/Automatic_login_to_virtual_console

**Updating mirrorlists**

When Pacman mirrorlist is updated, re-generate ``/etc/pacmand.d/mirrorlist``::

  sed '/#Server/ s|#|| ' -i /etc/mirrorlist.pacnew
  sed '/^#.*$/d' -i /etc/mirrorlist.pacnew
  rankmirrors -n 6 /etc/pacman.d/mirrorlist.pacnew > /etc/pacman.d/mirrorlist
  rm /etc/pacman.d/mirrorlist.pacnew

Install only if needed

* ext4_utils # ROMs samsung galaxy s ii
* xvidcap
* easytag # mp3 metadata editor
* hexedit # aoeu
* aria2 # download everything in style
* v86d # uvesafb, framebuffer text vconsoles

  * agregar v86d a HOOKS despues de base y udev en mkinitcpio.conf
  * Agregar /etc/modprobe.d/uvesafb.conf a FILES en mkinitcpio.conf

Tweaks and hacks
----------------

**Caps Lock to control**

TTY was taken care with the custom keymap, now for X::

  cp Dropbox/Config/Linux/Xmodmap ~/.Xmodmap

**Dvorak ES_LA**::

  cp Dropbox/Config/Linux/latam /usr/share/X11/xkb/symbols/

Set keyboard to ``Español Latino América`` variation ``dvla``

**Icons for thunar plugins**::

  cd .icons/Faience/app/16/
  ln -s dropbox.png thunar-dropbox.png
  ln -s file-roller.png tap-create.png
  ln -s ../../places/16/folder-download.png tap-extract.png
  ln -s ../../places/16/folder-saved-search.png tap-extract-to.png

**User home directories**

Create the needed directoties, make sure ``xdg-user-dirs`` is installed and
edit the file ``.config/user-dirs.dirs`` as needed.

**Fix fonts for some applications**::

  gconftool-2 --set --type string /desktop/gnome/interface/font_name Arimo
  gconftool-2 --set --type string \
    /desktop/gnome/interface/monospace_font_name Cousine

**Fix google chrome with preferred applications**

Make sure ``xorg-xprop`` is installed::

  cp /usr/share/applications/google-chrome.desktop ~/.local/share/xfce4/helpers/

Make the following changes::

  Type=X-XFCE-Helper
  X-XFCE-Category=WebBrowser
  X-XFCE-Commands=/opt/google/chrome/google-chrome
  X-XFCE-CommandsWithParameter=/opt/google/chrome/google-chrome “%s”.

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

  packer -S lib32-alsa-lib lib32-openal lib32-libstdc++5 lib32-libxv
  packer -S lib32-ncurses lib32-sdl lib32-zlib lib32-libxrandr lib32-libpulse
  packer -S lib32-alsa-plugins lib32-catalyst-utils

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

Sync clock::

  ntpd -qg

Fix gtk themes for QT::

 gconftool-2 --set --type string /desktop/gnome/interface/gtk_theme greybird-git

