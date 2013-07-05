#!/bin/sh

# for OpenBSD laptop
xterm -geometry 80x33+0+0 &
xterm -geometry 80x33-0+0 &
xterm -geometry 80x24-0-0 &
xterm -geometry 80x24+0-0 &

/usr/X11R6/bin/xsetroot -solid red &
/usr/X11R6/bin/cwm
