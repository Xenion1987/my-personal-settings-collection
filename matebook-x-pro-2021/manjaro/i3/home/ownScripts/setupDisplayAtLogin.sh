#! /usr/bin/env bash
XRANDR_OUTPUT=$(xrandr) ;
ERROR_COUNT=0 ;
ERROR_COUNT=$((ERROR_COUNT+$(grep -qE "^DP1 connected" <<< "${XRANDR_OUTPUT}";echo $?))) ;
ERROR_COUNT=$((ERROR_COUNT+$(grep -qE "^eDP1 connected" <<< "${XRANDR_OUTPUT}";echo $?))) ;

if [ $ERROR_COUNT -gt 0 ]; then
	echo "Monitor intern" ; 
	xrandr --output eDP1 --primary --mode 1920x1280 --pos 0x0 --rotate normal \
		--output DP1 --off \
		--output DP2 --off \
		--output DP3 --off \
		--output DP4 --off ;	
	feh --image-bg "#111920" --bg-fill ~/Pictures/Wallpaper/blackcat.jpg
 elif [ $ERROR_COUNT -eq 0 ] ; then
	echo "Monitor extern" ; 
	xrandr --output DP1 --primary --mode 3440x1440 --pos 0x0 --rotate normal \
		--output eDP1 --off \
		--output DP2 --off \
		--output DP3 --off \
		--output DP4 --off ;
	feh --image-bg "#111920" --bg-fill ~/Pictures/Wallpaper/blackcat.jpg
fi
