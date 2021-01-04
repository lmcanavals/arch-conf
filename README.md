My Arch Linux Installation Guide v5 2021
========================================

Starting from installation media

    loadkeys us             # in case we need to change the keyboard settings
    setfont LatArCyrHeb-16  # better fonts

Umask for group permissions http://unix.stackexchange.com/questions/75972/

Partitions
----------

Check multiboot information about having efi and mbr boot for usb drives.

https://wiki.archlinux.org/index.php/Multiboot_USB_drive

For regular installations: https://wiki.archlinux.org/index.php/Partitioning

Using **GPT fdisk** to create partitions:

    gdisk /dev/sda

Inside gdisk, ``o`` creates a GPT, ``n`` to create new partitions ``+xxG`` is
the format where xx is the size.

**BIOS Partition table**

 Dev |  Size | Mount point              | File system | gdisk type code
:---:|------:|--------------------------|:-----------:|-----------------
 SSD |  512M | EFI System Parition      | fat32       | EF00
 SSD |       | ``/``                    | ext4        | 8300
 HDD |       | ``/var``                 | btrfs       | var subvol
 HDD |       | ``/home/lmcs/archive``   | btrfs       | Archive subvol

Swap is a file, instead of a partition, so it can be resized easily. It should
be contained in the SSD. But should only be created or activated when there are
RAM issues.

Format partitions, for example:

    mkfs.fat -F32 /dev/sda1
    mkfs.ext4 /dev/sda2
    mkfs.btrfs -f -L Storage /dev/sdb
    btrfs subvolume create var
    btrfs subvolume create Archive

Mount everything te /mnt:

    mount -t ext4 /dev/sda2 /mnt
    mkdir -p /mnt/{boot/efi,home/lmcs/Archive/,var}
    mount -t vfat /dev/sda1 /mnt/boot/efi
    mount -o subvol=var /dev/sdb /mnt/var
    mount -o subvol=Archive /dev/sdb /mnt/home/lmcs/Archive

Installing and setting the base system
--------------------------------------

Install base system:

    pacstrap /mnt base linux linux-firmware base-devel

Chrooting into the new system:

    arch-chroot /mnt

Installing basic packages:

    pacman -S \
        grub \
        dosfstools \
        efibootmgr \
        intel-ucode \
        zsh \
        neovim \
        git \
        sudo \
        networkmanager \
        powertop \
        tlp # for better power management

Create the user ``lmcs``:

    useradd -m -s /bin/zsh lmcs
    chfn lmcs
    passwd lmcs
    chown -R lmcs:users /home/lmcs/Archive

Create swapfile:

    fallocate -l 5G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile

Generate ``fstab``:

    exit
    genfstab -pU /mnt >> /mnt/etc/fstab

Afterwards change to ``defaults,noatime,discard`` all ssd partitions.

Copy files and Chroot into the fresh installation:

    arch-chroot /mnt

Set zsh as the default shell for root:

    chsh -s $(which zsh)
    zsh

Set locales, uncomment en_DK.UTF8 en_US.UTF8 es_PE.UTF8 on ``/etc/locale.gen``:

    sed '/^#en_DK\.UTF-8/ s|#|| ' -i /etc/locale.gen
    sed '/^#en_US\.UTF-8/ s|#|| ' -i /etc/locale.gen
    sed '/^#es_PE\.UTF-8/ s|#|| ' -i /etc/locale.gen
    locale-gen

Set basic configuration files:

    ln -s /usr/share/zoneinfo/America/Lima /etc/localtime
    su - lmcs
    cd git
    git clone https://github.com/lmcanavals/arch-conf.git
    cd arch-conf
    zsh linkall
    exit
    cd /home/lmcs/git/arch-conf
    cp etc/hostname /etc/
    cp etc/locale.conf /etc/
    cp etc/vconsole.conf /etc/
    cp etc/mkinitcpio.conf /etc/
    cp etc/default/grub /etc/default/

Building the kernel image, don't forget copy the ``mkinitcpio.conf`` from
arch-conf.git which has the hook to support hibernation:

    mkinitcpio -p linux

Configure ``sudoers`` with ``visudo``, add:

    lmcs stella= /usr/bin/pacman

Download and install yay as user:

    su - lmcs
    cd git
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepgk -Acs

Then as root or with sudo:

    pacman -U yay<TAB>

Configure grub, copy the ``/etc/default/grub`` from arch-conf.git which adds the
parameters needed for hibernation support:

    grub-install --target=x86_64-efi --efi-directory=/boot/efi \
        --bootloader-id="Arch" --recheck --debug
    grub-mkconfig -o /boot/grub/grub.cfg

Enabling Intel Microcode updates is done automatically now.

Set root password, leave chroot env, unmount and reboot:

    passwd

After the first reboot
----------------------

Start console session as ``lmcs``

Sync, update and install the rest of the good stuff:

    yay -Syu

GUI base:

    yay -S xfce4 xfce4-goodies pulseaudio sox lightdm lightdm-gtk-greeter
    yay -S slock accountsservice xorg-xmodmap xcape xsel

Fonts, utilities, etc:

    yay -S ttf-liberation gnu-free-fonts noto-fonts noto-fonts-emoji
    yay -S ttf-fira-code ttf-fira-mono ttf-fira-sans
    yay -S adobe-source-code-pro-fonts # if not installed already
    yay -S adobe-source-sans-pro-fonts
    yay -S adobe-source-serif-pro-fonts adobe-source-han-sans-otc-fonts
    yay -S arc-solid-gtk-theme papirus-icon-theme
    yay -S file-roller unrar p7zip ntp imagemagick htop
    yay -S firefox redshift mosh network-manager-applet pavucontrol
    yay -S libcanberra-pulse libcanberra-gstreamer
    yay -S libcanberra gnome-keyring haveged

Optional:

    yay -S dropbox thunar-dropbox
    yay -S steam openssh vlc
    yay -S xf86-input-synaptics # duh
    yay -S xf86-video-intel libva-intel-driver
    yay -S cdrkit # mkisofs, wodim and stuff
    yay -S glew glfw glm # for the opengl experience

Not used anymore (maybe, some come as dependencies):

    yay -S wqy-microhei wqy-zenhei wqy-bitmapsong-beta
    yay -S ttf-wqy-microhei-ibx ttf-roboto-ibx ttf-dejavu

* haveged # random number generator, can't remember what for
* livestreamer # to stream in VLC from twitch.tv and others
* mupen64plus # nintendo 64 emulator
* easytag # mp3 metadata editor
* hexedit # aoeu
* aria2 # download everything in style
* cmus # music player

Important
---------

To change avatar on lightdm, xfce4 rotating wallpapers overwrites
`/var/lib/AccountsService/users/lmcs`, be aware this interferes with avatar:

    https://wiki.archlinux.org/index.php/LightDM#The_AccountsService_way

To change base configuration files:

    hostnamectl set-hostname fia
    localectl set-locale LANG="en_US.utf8" LC_COLLATE="C" LC_TIME="en_DK.utf8"
    timedatectl set-timezone America/Lima

Set ntp time sync and enabling services:

    systemctl disable remote-fs.target
    timedatectl set-ntp 1 # this enables the ntpd daemon
    ll /sys/class/net/
    systemctl enable NetworkManager.service
    systemctl enable tlp
    systemctl enable haveged # entrophy daemon for cryptographic awesome.
    # systemctl enable dhcpcd@enp0s25.service

**Updating mirrorlists**

When Pacman mirrorlist is updated, re-generate ``/etc/pacmand.d/mirrorlist``:

    zsh /home/lmcs/git/arch-conf/home/lmcs/Util/updatemirrors.sh

**Notes**

* .xinitrc needed only for old school desktop managers like slim
* .xresources needed only when starting stuff by hand (no xfsettingsd)

Tweaks and hacks
----------------

**Caps Lock to control**

TTY was taken care with the custom keymap, now for X:

    cp git/.../home/lmcs/.Xmodmap ~/.Xmodmap

**User home directories**

Create the needed directoties, make sure ``xdg-user-dirs`` is installed and
edit the file ``.config/user-dirs.dirs`` as needed.

**Fix fonts for some applications**:

    gsettings set org.gnome.desktop.interface font-name 'Noto Sans 10'
    gsettings set org.gnome.desktop.interface monospace-font-name 'mononoki 10'

**Java**

Install preferably on ``~/Archive/usr``, rename from ``jdk-x.x.x`` to ``java``
then as root:

    ln -s /home/lmcs/Archive/usr/java /opt/java

**Android-sdk**

Needed libs from ``multilib``:
