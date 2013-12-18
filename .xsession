#!/bin/sh
#
# for OpenBSD laptop
/usr/X11R6/bin/xterm -geometry 80x34+0+0 &
/usr/X11R6/bin/xterm -geometry 80x24+0-0 &
/usr/X11R6/bin/xterm -geometry 80x34-0+0 &
/usr/X11R6/bin/xterm -geometry 80x24-0-0 &

/usr/X11R6/bin/xset s off -dpms
/usr/X11R6/bin/xset r rate 150 50

/usr/X11R6/bin/xidle -timeout 987 -program '/usr/X11R6/bin/xlock -mode blank -lockdelay 3 -timeout 31' &

/usr/X11R6/bin/cwm
