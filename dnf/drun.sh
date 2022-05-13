#!/usr/bin/env bash

sudo dnf install rofi 2>&1

rofi --help &>/dev/null
RC=$?

if [ ! $RC -eq 0 ]
then
    echo "Error installing rofi"
    exit $RC
else
    echo "Rofi installed successfully"
    echo "Configuring default settings"
    mkdir -p ~/.config/rofi
    rofi -dump-config > ~/.config/rofi/config.rasi
    echo '@theme "/usr/share/rofi/themes/Pop-Dark.rasi"' >> ~/.config/rofi/config.rasi
fi