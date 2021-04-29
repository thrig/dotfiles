#!/bin/sh
include(`../m4/cf.m4')dnl
divert(-1)

xomb - or rather a shell in which xomb(1) can be run (xterm(1) flickers
too much due to the redraws used by that game)

asociar(`CUR_HOME', `printf "$HOME"')
divert(0)dnl
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
comando(`solitary', `"CUR_HOME" comando(`urxvt', `-ls -bg black -fg white -fn xft:Hack:pixelsize=24 -sl 0 -title fancy')')
