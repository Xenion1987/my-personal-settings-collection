#!/usr/bin/env bash

# https://github.com/Chrysostomus/bmenu

DP_NAME_INTERN='eDP-1'  #Name of internal Display
DP_NAME_EXTERN='DP-3'   #Name of external Display


function checkDependencies() {
    if ! wlr-randr &> /dev/null ; then 
        echo "'wlr-randr' seems not to be installed."
        echo "Please install it to use this script."
        echo ""
        echo "EXIT - Press any key"
        read -rs -n1
        exit 255
    fi
}

function getConnectedDisplays() {
    DISPLAYS=$(swaymsg -t get_outputs | jq -r '.[].name')
}

function main {

    #while true ; do
        clear
        echo -e "       ┌──────┐"
        echo -e "       |intern|"
        echo -e "       └──────┘"
        echo -e "         [1]"
        echo -e "--------------------"
        echo -e "     ┌──────────┐"
        echo -e "     |  extern  |"
        echo -e "     └──────────┘"
        echo -e "         [2]"
        echo -e "--------------------"
        echo -e "     ┌──────────┐"
        echo -e "     |  extern  |"
        echo -e "     └──────────┘"
        echo -e "       ┌──────┐"
        echo -e "       |intern|"
        echo -e "       └──────┘"
        echo -e "         [3]"
        echo -e "--------------------"
        echo -e "┌──────┐┌──────────┐"
        echo -e "|intern||  extern  |"
        echo -e "└──────┘└──────────┘"
        echo -e "         [4]"
        echo -e "--------------------"

        read -rs -n1 CHOICE
                
        case $CHOICE in

            1)
                if swaymsg output ${DP_NAME_INTERN} enable scale 2 pos 0 0; then
                    swaymsg output ${DP_NAME_EXTERN} disable
                fi

                #wlr-randr --output ${DP_NAME_INTERN} --on --preferred --scale 2.0 --pos 0,0 \
                #    --output ${DP_NAME_EXTERN} --off ;
                ;;
            2)
                if swaymsg output ${DP_NAME_EXTERN} enable scale 1 pos 0 0; then
                    swaymsg output ${DP_NAME_INTERN} disable
                fi
                
                #wlr-randr --output ${DP_NAME_INTERN} --on --preferred --scale 2.0 --pos 0,0 \
                #    --output ${DP_NAME_EXTERN} --off ;
                #sleep 1 ;
                #wlr-randr --output ${DP_NAME_EXTERN} --on --preferred --scale 1.0 --pos 0,0 \
                #    --output ${DP_NAME_INTERN} --off ;
                ;;
            3)
                if swaymsg output ${DP_NAME_EXTERN} enable scale 1 pos 0 0; then
                    swaymsg output ${DP_NAME_INTERN} enable scale 2 pos 1024 1440
                fi

                #wlr-randr --output ${DP_NAME_INTERN} --on --preferred --scale 2.0 --pos 0,0 \
                #    --output ${DP_NAME_EXTERN} --off ;
                #sleep 1 ;
                #wlr-randr --output ${DP_NAME_EXTERN} --on --preferred --scale 1.0 --pos 0,0 \
                #    --output ${DP_NAME_INTERN} --on --preferred --scale 2.0 --pos 3440,0 ;
                ;;
            0|q)
                clear && exit
                ;;
            #*)
            #    echo -e "Wrong choice"
            #    read -rs -n1;
            #    clear;
            #    ;;
        esac

    #done
}

#checkDependencies;
main;
