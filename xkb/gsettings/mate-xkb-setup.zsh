#!/bin/zsh

gsettings set org.mate.peripherals-keyboard-xkb.general group-per-window false

gsettings set org.mate.peripherals-keyboard-xkb.kbd layouts "['jp\tjp_us', 'jp']"

gsettings set org.mate.peripherals-keyboard-xkb.kbd options "['caps\tcaps:ctrl_modifier', 'japan\tjapan:hztg_escape']"

