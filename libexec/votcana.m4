#!/bin/sh
#
# votcana - four stations or nodes (terminals), my default layout on
# (most?) every laptop I've used. the upper left terminal is for chat
# (if online); the right hand xterms are where most development is done.
# lower left is for the connection to the work tmux (email, logs, etc).
# lojban numbers are used as they are nice and short
include(`../m4/cf.m4')dnl
divert(-1)
asociar(`CUR_HOME', `printf "$HOME"')
divert(0)dnl
comando(`solitary') "CUR_HOME" comando(`xterm') -geometry 80x24+0+0 -title pa -e 'comando(`tmn', `pa')'
comando(`solitary') "CUR_HOME" comando(`xterm') -geometry 80x24+486+0 -title re -e 'comando(`tmn', `re')'
comando(`solitary') "CUR_HOME" comando(`xterm') -geometry 80x24+486+318 -title ci -e 'comando(`tmn', `ci')'
comando(`solitary') "CUR_HOME" comando(`xterm') -geometry 80x24+0+318 -title vo -e 'comando(`ksh', `-l')'
