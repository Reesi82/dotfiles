#!/usr/bin/env bash

echo "Installing dotfiles"

echo "Initializing submodule(s)"
git submodule update --init --recursive

source install/link.sh

echo "creating vim directories"
mkdir -p ~/.vim-tmp

if [ $(echo $SHELL) != "/usr/bin/zsh" ]
then
    echo "Configuring zsh as default shell"
    chsh -s $(which zsh)
fi

echo "Done."
