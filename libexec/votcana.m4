#!/bin/sh
include(`../m4/cf.m4')dnl
divert(-1)

votcana - four terminals, my default layout on pretty much every laptop
I've ever used. in hindsight, it should count from no and not pa

asociar(`CUR_HOME', `printf "$HOME"')
divert(0)dnl
comando(`xdotool', `search --name re windowraise') || solitary "CUR_HOME" comando(`xterm') -fn -uw-ttyp0-medium-r-normal--15-140-75-75-c-80-iso8859-1 -geometry 80x26-0+0 -title re -e comando(`tmn', `re')
comando(`xdotool', `search --name ci windowraise') || solitary "CUR_HOME" comando(`xterm') -fn -uw-ttyp0-medium-r-normal--15-140-75-75-c-80-iso8859-1 -geometry 80x24-0-0 -title ci -e comando(`tmn', `ci')
comando(`xdotool', `search --name vo windowraise') || solitary "CUR_HOME" comando(`xterm') -fn -uw-ttyp0-medium-r-normal--15-140-75-75-c-80-iso8859-1 -geometry 80x24+0-0 -title vo -e comando(`tmn', `vo')
comando(`xdotool', `search --name pa windowraise') || exec solitary "CUR_HOME" comando(`xterm') -fn -uw-ttyp0-medium-r-normal--15-140-75-75-c-80-iso8859-1 -geometry 80x26+0+0 -title pa -e comando(`tmn', `pa')
