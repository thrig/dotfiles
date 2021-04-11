#!/bin/sh
#
# xnest - isolation for feh and w3m so they have neither access to my
# main account nor to the main X11 display
include(`../m4/cf.m4')dnl
divert(-1)
asociar(`CUR_HOME', `printf "$HOME"')
asociar(`FULLSCREEN', `xgeometry')
divert(0)dnl
comando(`xdotool', `search --name Xnest windowactivate >/dev/null 2>&1 && exit 0')
cd "CUR_HOME/tmp" || exit 1
comando(`solitary', `. comando(`Xnest', `-geometry FULLSCREEN :1')')
comando(`xdotool', `search --name Xnest --sync')
comando(`solitary', `/home/ueb comando(`xterm', `-display :1 -tn xterm-256-color +bdc +cm +dc +itc -class cousterm -e "comando(`doas', `-u ueb -- comando(`ksh', `-l')')"')')
