#!/bin/sh
include(`../m4/cf.m4')dnl
divert(-1)

cdda - launch Cataclysm DDA (or first try to raise it)

asociar(`CUR_HOME', `printf "$HOME"')
divert(0)dnl
comando(`xdotool', `search --name Cataclysm windowraise') && exit 0
divert(-1)
default ampd is low (800 Mhz, yeah baby yeah!) which is perhaps not so
good should CDDA need to CPU a bit, or a lot
divert(0)dnl
doas pkill apmd
doas apmd -H
exec comando(`solitary', `"CUR_HOME/tmp" comando(`cataclysm-tiles')')
