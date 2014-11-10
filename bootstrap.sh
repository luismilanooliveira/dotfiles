#!/bin/bash

# curl -L http://install.ohmyz.sh | sh
# curl -o - https://raw.githubusercontent.com/begriffs/haskell-vim-now/master/install.sh | bash
programs = zsh vim tmux
for i in */.[a-z]*; do
    ln -s "dotfiles/$i" ~/
done
