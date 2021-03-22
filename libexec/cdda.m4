#!/bin/sh
include(`../m4/cf.m4')dnl
divert(-1)
asociar(`CUR_HOME', `printf "$HOME"')
divert(0)dnl
doas pkill apmd
doas apmd -H
exec comando(`solitary', `"CUR_HOME/tmp" comando(`cataclysm-tiles')')
