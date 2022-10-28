#! /usr/bin/env bash

W=1920
H=1280
HZ=60
D=eDP-1
DRV=intel
CVT=$(cvt $W $H $HZ 2>&1 | sed 1d | expand | tr -s " " | cut -d " " -f3-)

{
    echo '#! /usr/bin/env bash'
    echo "xrandr --newmode ${W}x${H} ${CVT}"
    echo "xrandr --addmode ${D} ${W}x${H}"
} >~/.xprofile

sudo tee /etc/X11/xorg.conf.d/10-monitor.conf <<ENDOFFILE
Section "Monitor"
    Identifier "${D}"
    $(cvt ${W} ${H} ${HZ} | sed 1d)
    Option "PreferredMode" "${W}x${H}_${HZ}.00"
EndSection

Section "Screen"
    Identifier "Screen0"
    Monitor "${D}"
    DefaultDepth 24
    SubSection "Display"
        Modes "${W}x${H}_${HZ}.00"
    EndSubSection
EndSection

Section "Device"
    Identifier "Device0"
    Driver "${DRV}"
EndSection
ENDOFFILE
