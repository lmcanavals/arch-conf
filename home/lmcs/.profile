#!/bin/sh

QT_STYLE_OVERRIDE="gtk"
export QT_STYLE_OVERRIDE

XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"
XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME
export XDG_CACHE_HOME
export XDG_DATA_HOME
export NO_AT_BRIDGE=1

play .local/share/sounds/Fresh\ and\ Clean/stereo/desktop-login.ogg &

