#! /usr/bin/env bash

# https://github.com/Chrysostomus/bmenu

function main {

    #while true ; do
        clear
        echo -e "     ┌──┐"
        echo -e "     └──┘"
        echo -e "      [1]"
        echo -e "---------------"
        echo -e "    ┌────┐"
        echo -e "    └DP-1┘"
        echo -e "      [2]"
        echo -e "---------------"
        echo -e "    ┌────┐"
        echo -e "    └DP-1┘"
        echo -e "     ┌──┐"
        echo -e "     └──┘"
        echo -e "      [3]"
        echo -e "---------------"
        # echo -e " ┌────┐┌────┐"
        # echo -e " └DP-0┘└DP-1┘"
        # echo -e "      [4]"
        # echo -e "---------------"
        # echo -e " ┌────┐┌────┐"
        # echo -e " └DP-0┘└DP-1┘"
        # echo -e "     ┌──┐"
        # echo -e "     └──┘"
        # echo -e "      [5]"
        # echo -e "---------------"
        # echo -e "      ┌──┐"
        # echo -e "     ┌──┐┘"
        # echo -e "     └──┘"
        # echo -e "      [6]"
        # echo -e "---------------"
        read -rs -n1 CHOICE
        
        case $CHOICE in

            1)
                xrandr --output eDP1 --primary --mode 1920x1280 --rotate normal \
                    --output DP1 --off \
                    --output DP2 --off \
                    --output DP3 --off \
                    --output DP4 --off ;	
                feh --image-bg "#111920" --bg-fill ~/Pictures/Wallpaper/blackcat.jpg
                ;;
            2)
                xrandr --output eDP1 --primary --mode 1920x1280 --rotate normal \
                    --output DP1 --off \
                    --output DP2 --off \
                    --output DP3 --off \
                    --output DP4 --off ;
                sleep 1;
                xrandr --output DP1 --primary --mode 3440x1440 --rotate normal \
                    --output eDP1 --off \
                    --output DP2 --off \
                    --output DP3 --off \
                    --output DP4 --off ;	
                feh --image-bg "#111920" --bg-fill ~/Pictures/Wallpaper/blackcat.jpg
                ;;
            3)
                xrandr --output eDP1 --primary --mode 1920x1280 --rotate normal \
                    --output DP1 --off \
                    --output DP2 --off \
                    --output DP3 --off \
                    --output DP4 --off ;
                sleep 1;
                xrandr --output DP1 --primary --mode 3440x1440 --rotate normal \
                    --output eDP1 --mode 1920x1280 --below DP1 --rotate normal \
                    --output DP2 --off \
                    --output DP3 --off \
                    --output DP4 --off ;
                feh \
                    --image-bg "#111920" --bg-fill ~/Pictures/Wallpaper/blackcat.jpg \
                    --image-bg "#111920" --bg-fill ~/Pictures/Wallpaper/blackcat.jpg
                ;;
            0|q)
                clear && exit
                ;;
            *)
                echo -e "Wrong choice"
                read -rs -n1;
                clear;
                ;;
        esac
    #done
}

if main; then sleep 5 ; i3-msg restart; fi
