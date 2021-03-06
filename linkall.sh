#!/bin/sh

linkall() {
    local githome
    local archome
    local lshare
    local here
    home="/home/lmcs"
    githome="/home/lmcs/git"
    archome="/home/lmcs/git/arch-conf/home/lmcs"
    lshare=".local/share"

    if (( EUID != 0 )); then
        mkdir -p ~/$lshare/xfce4
        ln -sf $archome/$lshare/xfce4/terminal ~/$lshare/xfce4/
        ln -sf $archome/.Xmodmap ~/
        if [[ ! -d $githome/zsh-syntax-highlighting ]]; then
            here=$(pwd)
            cd $githome
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
            cd $here
            unset here
        else
            echo "No need to clone zsh-syntax-highlighting"
        fi
    fi
    if [[ ! -f ~/$lshare/nvim/site/autoload/plug.vim ]]; then
        curl -fLo ~/$lshare/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        echo "No need to download vim-plug"
    fi

    mkdir -p ~/.config
    ln -sf $archome/.gitconfig ~/
    ln -sf $archome/.gitignore_global ~/
    ln -sf $archome/.zshrc ~/
    ln -sf $archome/.config/zsh ~/.config/
    ln -sf $archome/.profile ~/
    ln -sf $archome/.config/fontconfig ~/.config/
    ln -sf $archome/.config/nvim ~/.config/
    ln -sf $archome/.config/redshift.conf ~/.config/
    #ln -sf $githome/zsh-syntax-highlighting ~/.zsh/plugins/
    #ln -sf $archome/.vim ~/
    #ln -sf $archome/.vimrc ~/
    ln -sf $archome/.tmux.conf ~/
}
linkall
