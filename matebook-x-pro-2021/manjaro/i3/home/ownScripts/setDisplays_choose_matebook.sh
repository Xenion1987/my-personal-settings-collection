#! /usr/bin/env bash

# https://github.com/Chrysostomus/bmenu

BACKGROUND_IMAGE=/usr/share/backgrounds/blackcat.jpg
PORT_0=eDP1
PORT_A=DP3
PORT_B=DP1
PORT_C=DP2
PORT_D=DP4
function get_port_names() {
    while read -r PORT_NAME CONNECT_STATUS; do
        PORTS_CONNECTED+=("${PORT_NAME}" "${CONNECT_STATUS}")
    done < <(grep -E "^([e]?DP[-]?[0-9] connected)|^HDMI[-]?[0-9] connected" < <(xrandr) | awk '{print $1,$2}')
}
function get_display_resolutions() {
    set -x
    for ((i = 0; i < ${#PORTS_CONNECTED[@]}; i++)); do
        #e=$((i + 2))
        xrandr | awk '/start1/{flag=1}/"${PORT_D}"/{flag=0}flag' start1="${PORTS_CONNECTED[${i}]}"
        #echo -e " [${COUNT}] ${PORTS_CONNECTED[${i}]}"
        ((++i))
    done
}
function print_displays() {
    COUNT=1
    for ((i = 0; i < ${#PORTS_CONNECTED[@]}; i++)); do
        #for i in ${#PORTS_CONNECTED[@]}; do
        echo -e " [${COUNT}] ${PORTS_CONNECTED[${i}]}"
        ((++i))
        ((++COUNT))
    done
}
function main {
    clear
    cat <<ENDOFFILE
     ┌───┐
     └───┘
      [1]
---------------
    ┌────┐
    └DP-1┘
      [2]
---------------
    ┌────┐
    └DP-1┘
     ┌──┐
     └──┘
      [3]
---------------
ENDOFFILE
    #  ┌────┐┌────┐
    #  └DP-0┘└DP-1┘
    #       [4]
    # ---------------
    #  ┌────┐┌────┐
    #  └DP-0┘└DP-1┘
    #      ┌──┐
    #      └──┘
    #       [5]
    # ---------------
    #       ┌──┐
    #      ┌──┐┘
    #      └──┘
    #       [6]
    # ---------------

    read -rs -n1 CHOICE

    case $CHOICE in
    1)
        xrandr --output "${PORT_0}" --primary --mode 1920x1280 --rotate normal \
            --output "${PORT_A}" --off \
            --output "${PORT_B}" --off \
            --output "${PORT_C}" --off \
            --output "${PORT_D}" --off
        feh --image-bg "#111920" --bg-fill ${BACKGROUND_IMAGE}
        ;;
    2)
        xrandr --output "${PORT_0}" --primary --mode 1920x1280 --rotate normal \
            --output "${PORT_A}" --off \
            --output "${PORT_B}" --off \
            --output "${PORT_C}" --off \
            --output "${PORT_D}" --off
        sleep 1
        xrandr --output "${PORT_A}" --primary --mode 3440x1440 --rotate normal \
            --output "${PORT_0}" --off \
            --output "${PORT_B}" --off \
            --output "${PORT_C}" --off \
            --output "${PORT_D}" --off
        feh --image-bg "#111920" --bg-fill ${BACKGROUND_IMAGE}
        ;;
    3)
        xrandr --output "${PORT_0}" --primary --mode 1920x1280 --rotate normal \
            --output "${PORT_A}" --off \
            --output "${PORT_B}" --off \
            --output "${PORT_C}" --off \
            --output "${PORT_D}" --off
        sleep 1
        xrandr --output "${PORT_A}" --primary --mode 3440x1440 --rotate normal \
            --output "${PORT_0}" --mode 1920x1280 --below "${PORT_A}" --rotate normal \
            --output "${PORT_B}" --off \
            --output "${PORT_C}" --off \
            --output "${PORT_D}" --off
        feh \
            --image-bg "#111920" --bg-fill ${BACKGROUND_IMAGE} \
            --image-bg "#111920" --bg-fill ${BACKGROUND_IMAGE}
        ;;
    0 | q)
        clear && exit
        ;;
    *)
        echo -e "Wrong choice"
        read -rs -n1
        clear
        ;;
    esac
}

if main; then
    sleep 5
    i3-msg restart
fi
