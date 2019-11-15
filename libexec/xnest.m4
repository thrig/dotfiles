#!/bin/sh
include(`../m4/cf.m4')dnl
divert(-1)
asociar(`CUR_HOME', `printf "$HOME"')
divert(0)dnl
cd "CUR_HOME/tmp" || exit 1
solitary . Xnest -geometry 1366x768 :1
solitary . fvwm -display :1
solitary "CUR_HOME" xterm -display :1
