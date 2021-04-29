#!/bin/sh
include(`../m4/cf.m4')dnl
divert(-1)

votcana - four terminals, my default layout on pretty much every laptop
I've ever used. in hindsight, it should count from no and not pa

asociar(`CUR_HOME', `printf "$HOME"')
divert(0)dnl
comando(`xdotool', `search --name pa windowraise') || comando(`solitary') "CUR_HOME" comando(`xterm') -fn 8x13 -geometry 80x34+0+0 -title pa -e 'comando(`tmn', `pa')'
comando(`xdotool', `search --name re windowraise') || comando(`solitary') "CUR_HOME" comando(`xterm') -fn 8x13 -geometry 80x34+720+0 -title re -e 'comando(`tmn', `re')'
comando(`xdotool', `search --name ci windowraise') || comando(`solitary') "CUR_HOME" comando(`xterm') -fn 8x13 -geometry 80x24+720+450 -title ci -e 'comando(`tmn', `ci')'
comando(`xdotool', `search --name vo windowraise') || comando(`solitary') "CUR_HOME" comando(`xterm') -fn 8x13 -geometry 80x24+0+450 -title vo -e 'comando(`tmn', `vo')'
