#!/bin/sh

if [ -z "$GTK_MODULES" ]
then
    GTK_MODULES="canberra-gtk-module"
else
    GTK_MODULES="canberra-gtk-module:$GTK_MODULES"
fi

export GTK_MODULES

xset s off
exec startxfce4

