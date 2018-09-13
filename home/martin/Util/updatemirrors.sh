if [ -f /etc/pacman.d/mirrorlist.pacnew ]; then
  sed '/#Server/ s|#|| ' -i /etc/pacman.d/mirrorlist.pacnew
  sed '/^#.*$/d' -i /etc/pacman.d/mirrorlist.pacnew
  rankmirrors -n 6 /etc/pacman.d/mirrorlist.pacnew > /etc/pacman.d/mirrorlist
  if [ $? -eq 0 ]; then
    rm /etc/pacman.d/mirrorlist.pacnew
    echo "Mirror list updated"
  else
    echo "Failed to update mirror list"
  fi
fi