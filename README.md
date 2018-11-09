My Arch Linux Installation Guide
================================
Starting from installation media

    # loadkeys dvorak # old
    loadkeys us
    setfont LatArCyrHeb-16 # better fonts

Must check!! http://unix.stackexchange.com/questions/75972/

Partitions
----------
https://wiki.archlinux.org/index.php/Partitioning

Using **GPT fdisk** to create partitions::

    gdisk /dev/sda

Inside gdisk, ``o`` creates a GPT, ``n`` to create new partitions ``+xxG`` is
the format where xx is the size.

**BIOS Partition table**

| Dev |  Size | Mount point              | File system | gdisk type code |
|:---:|------:|--------------------------|:-----------:|-----------------|
| SSD |  512M | EFI System Parition      | fat32       | EF00            |
| SSD |  128M | ``/boot``                | ext4        | 8300            |
| SSD |   30G | ``/``                    | ext4        | 8300            |
| SSD | >100G | ``/home``                | ext4        | 8300            |
| HDD |       | ``/var``                 | btrfs       | var subvol      |
| HDD |       | ``/home/martin/archive`` | btrfs       | Archive subvol  |

Swap is a file, instead of a partition, so it can be resized easily. It should
be contained in the SSD. But should only be created or activated when there are
ram issues.

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
    arch-chroot /mnt pacman -S zsh neovim git sudo networkmanager
    arch-chroot /mnt pacman -S powertop tlp # for better power management

Create the user ``martin``::

    arch-chroot /mnt useradd -m -s /bin/zsh martin
    arch-chroot /mnt chfn martin
    arch-chroot /mnt passwd martin
    arch-chroot /mnt chown -R martin:users /home/martin/Archive

Create swapfile::

    arch-chroot /mnt fallocate -l 5G /home/swapfile
    arch-chroot /mnt chmod 600 /home/swapfile
    arch-chroot /mnt mkswap /home/swapfile
    arch-chroot /mnt swapon /home/swapfile

Generate ``fstab``::

    genfstab -pU /mnt >> /mnt/etc/fstab
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

Download and install yay as user::

    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepgk -Acs

Then as root or with sudo::

    pacman -U yay<TAB>

Installing aur utility and installing needed packages::

    yay -S deepin-grub2-theme

Configure grub, copy the ``/etc/default/grub`` from arch-conf.git which adds the
parameters needed for hibernation support::

    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id="Arch" --recheck --debug
    # mkdir -p /boot/grub/locale
    # cp /usr/share/locale/en@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
    grub-mkconfig -o /boot/grub/grub.cfg

Enabling Intel Microcode updates is done automatically now.

Set root password, leave chroot env, unmount and reboot::

    passwd

After the first reboot
----------------------

Start console session as ``martin``

Sync, update and install the rest of the good stuff::

    yay -Syu

GUI base::

    yay -S xfce4 xfce4-goodies pulseaudio sox lightdm lightdm-gtk-greeter
    yay -S slock accountsservice xorg-xmodmap xcape

Fonts, utilities, etc::

    yay -S ttf-liberation ttf-freefont
    yay -S adobe-source-code-pro-fonts adobe-source-sans-pro-fonts
    yay -S adobe-source-serif-pro-fonts adobe-source-han-sans-otc-fonts
    yay -S arc-solid-gtk-theme papirus-icon-theme
    yay -S unrar unzip p7zip ntp imagemagick htop
    yay -S google-chrome redshift
    yay -S network-manager-applet pavucontrol
    yay -S libcanberra-pulse libcanberra-gstreamer
    yay -S libcanberra gnome-keyring thunar-dropbox

Optional::

    yay -S dropbox
    yay -S python-gobject python-xdg # for redshift-gtk
    yay -S steam openssh vlc
    yay -S xf86-input-synaptics # duh
    yay -S xf86-video-intel libva-intel-driver
    yay -S cdrkit # mkisofs, wodim and stuff
    yay -S glew glfw glm # for the opengl experience
    yay -S zip # to create stupid zip files

Not used anymore (maybe, some come as dependencies)::

    yay -S wqy-microhei wqy-zenhei wqy-bitmapsong-beta
    yay -S ttf-wqy-microhei-ibx ttf-roboto-ibx ttf-dejavu
    yay -S xfce-theme-greybird
    yay -S xcursor-vanilla-dmz faience-icon-theme

* haveged # random number generator, can't remember what for
* livestreamer # to stream in VLC from twitch.tv and others
* mupen64plus # nintendo 64 emulator
* ext4_utils # ROMs samsung galaxy s ii
* easytag # mp3 metadata editor
* hexedit # aoeu
* aria2 # download everything in style
* cmus # music player

Important
---------

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
    systemctl enable tlp
    systemctl enable haveged # entrophy daemon for cryptographic awesome.
    # systemctl enable dhcpcd@enp0s25.service

**Updating mirrorlists**

When Pacman mirrorlist is updated, re-generate ``/etc/pacmand.d/mirrorlist``::

    sed '/#Server/ s|#|| ' -i /etc/pacman.d/mirrorlist.pacnew
    sed '/^#.*$/d' -i /etc/pacman.d/mirrorlist.pacnew
    rankmirrors -n 6 /etc/pacman.d/mirrorlist.pacnew > /etc/pacman.d/mirrorlist
    rm /etc/pacman.d/mirrorlist.pacnew

**Notes**

* .xinitrc needed only for old school desktop managers like slim
* .xresources needed only when starting stuff by hand (no xfsettingsd)

Tweaks and hacks
----------------

**Caps Lock to control**

TTY was taken care with the custom keymap, now for X::

    cp git/.../home/martin/.Xmodmap ~/.Xmodmap

**User home directories**

Create the needed directoties, make sure ``xdg-user-dirs`` is installed and
edit the file ``.config/user-dirs.dirs`` as needed.

**Fix fonts for some applications**::

    gsettings set org.gnome.desktop.interface font-name 'Noto Sans 10'
    gsettings set org.gnome.desktop.interface monospace-font-name 'mononoki 10'

**Java**

Install preferably on ``~/Archive/usr``, rename from ``jdk-x.x.x`` to ``java``
then as root::

    ln -s /home/martin/Archive/usr/java /opt/java

**Android-sdk**

Needed libs from ``multilib``::

