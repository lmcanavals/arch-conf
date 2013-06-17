#!/bin/sh

if [ -z "$GTK_MODULES" ]
then
    GTK_MODULES="canberra-gtk-module"
else
    GTK_MODULES="canberra-gtk-module:$GTK_MODULES"
fi

export GTK_MODULES

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
play .local/share/sounds/Fresh\ and\ Clean/stereo/desktop-login.ogg &
xset s off &
exec startxfce4

