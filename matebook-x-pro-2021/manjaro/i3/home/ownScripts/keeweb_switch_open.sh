#! /usr/bin/env bash

if pgrep -f /usr/lib/keeweb &>/dev/null; then
	i3-msg workspace 9 &> /dev/null;
 else
	keeweb &
	i3-msg workspace 9 &> /dev/null;
fi
