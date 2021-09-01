#! /usr/bin/env bash

### Define new resolution here ###
WIDTH=1920; HEIGHT=1280; HZ=60; DISPLAY='eDP1'
##################################
#XRANDR_OUTPUT=$(xrandr);
#DISPLAYS_CONNECTED=$(grep -Eo '^[eE]?DP[-]?[0-9]+ [(dis)]?connected'<<<"${XRANDR_OUTPUT}");
#DISPLAY_NAMES=$(grep -Eo '^[eE]?DP[-]?[0-9]+'<<<"${DISPLAYS_CONNECTED}");
#MONITORS_ACTIVE=$(grep -Eo '[eE]?DP[-]?[0-9]+'< <(xrandr --listactivemonitors)|head -n1);
#[[ -z "$DISPLAY" ]] && DISPLAY=$(grep -Eo '[e]?DP[-]?1$'<<<"${XRANDR_OUTPUT}");

CVT_OUTPUT=$(cvt ${WIDTH} ${HEIGHT} ${HZ}|sed 's/Modeline // ; 1d');
#MODENAME_FULL=$(awk '{print $1}'<<<"${CVT_OUTPUT}"|tr -d '"');
MODENAME_SHORT=$(awk '{print $1}'<<<"${CVT_OUTPUT}"|tr -d '"'|sed -r 's/_.*//');
MODELINE=$(sed -r 's/^[\"\.0-9x_]*([[:space:]]+)/\1/'<<<"${CVT_OUTPUT}");
NEWMODE=${MODENAME_SHORT}${MODELINE};
cat > ~/.xprofile << _EOF
#! /usr/bin/env bash
xrandr --newmode ${NEWMODE}
xrandr --addmode ${DISPLAY} ${MODENAME}
_EOF
#shellcheck disable=SC1090
source ~/.xprofile;
