#!/usr/bin/env bash

sudo dnf install vim 2>&1

vim --help &>/dev/null
RC=$?

if [ ! $RC -eq 0 ]
then
    echo "Error installing vim"
    exit $RC
else
    echo "vim installed successfully"
    echo "Creating .vimrc file"
    echo "autocmd FileType yaml setlocal ai et sw=2 ts=2" > ~/.vimrc
    echo "set nu" >> ~/.vimrc
    echo "vim installation complete"
fi
