#!/bin/sh
# or rather a shell in which xomb(1) can be run
include(`../m4/cf.m4')dnl
divert(-1)
asociar(`CUR_HOME', `printf "$HOME"')
divert(0)dnl
comando(`solitary', `"CUR_HOME" comando(`urxvt', `-ls -bg black -fg white -fn xft:Hack:pixelsize=24 -sl 0 -title xomb')')
