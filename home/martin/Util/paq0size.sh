#!/bin/zsh

for paq in $(pacman -Qqs); do
  yaourt -Qi $paq | grep "Installed Size  : 0"
  if [ $? -eq 0 ]; then
    echo $paq
  fi
done

