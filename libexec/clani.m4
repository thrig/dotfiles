#!/bin/sh
include(`../m4/cf.m4')dnl
divert(-1)

clani - a "long" (tall) terminal

asociar(`CUR_HOME', `printf "$HOME"')
divert(0)dnl
comando(`xdotool', `search --name clani windowraise windowfocus') && exit 0
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
exec comando(`solitary', `"CUR_HOME" comando(`urxvt', `-fn 8x13 -geometry 80x58+0+0 -title clani')')
