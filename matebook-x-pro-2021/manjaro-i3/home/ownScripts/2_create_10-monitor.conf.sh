#! /usr/bin/env bash

echo "Needs sudo to work as expected"

### Define new resolution here ###
WIDTH=1920; HEIGHT=1280; HZ=60; DP='eDP1'
##################################
CVT_OUTPUT=$(cvt ${WIDTH} ${HEIGHT} ${HZ}|sed 's/Modeline // ; 1d');
#MODENAME_FULL=$(awk '{print $1}'<<<"${CVT_OUTPUT}"|tr -d '"');
MODENAME_SHORT=$(awk '{print $1}'<<<"${CVT_OUTPUT}"|tr -d '"'|sed -r 's/_.*//');
MODELINE=$(sed -r 's/^[\"\.0-9x_]*([[:space:]]+)/\1/'<<<"${CVT_OUTPUT}");

cat > /etc/X11/xorg.conf.d/10-monitor.conf << _EOF
Section "Monitor"
	Identifier "${DP}"
	Modeline ${MODENAME_SHORT}${MODELINE}
	Option "PreferredMode" "${MODENAME_SHORT}"
EndSection
_EOF
