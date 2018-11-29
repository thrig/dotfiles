#!/bin/sh

@@HOME@@/libexec/xbattery &

# DIE CAPS DIE
/usr/X11R6/bin/setxkbmap -option ctrl:nocaps

/usr/X11R6/bin/xmodmap @@HOME@@/.Xmodmap

/usr/X11R6/bin/xset s off -dpms
/usr/X11R6/bin/xset r rate 325 250

while read d; do
   [ -d "$d" ] && /usr/X11R6/bin/xset +fp "$d"
done << EOD
/usr/local/share/fonts/ghostscript
/usr/local/share/fonts/Liberation
/usr/local/share/fonts/noto
@@HOME@@/.fonts
EOD
#/usr/X11R6/bin/xset +fp $HOME/.fonts
# TODO may also need to run in custom dir:
#   /usr/X11R6/bin/mkfontscale 
#   /usr/X11R6/bin/mkfontdir  
# rescan needed if new dir seen:
#   /usr/X11R6/bin/fc-cache -v

/usr/bin/mixerctl outputs.master=131,131 outputs.hp_boost=on >/dev/null 2>&1

/usr/local/bin/feh --bg-tile /home/jmates/co/turtledance/samples/ehargdgc.png &

#/usr/X11R6/bin/xidle -timeout 1097 -program '/usr/X11R6/bin/xlock -mode blank -lockdelay 3 -timeout 31' &

/usr/X11R6/bin/xterm -vb -geometry 80x24+0-0 &
/usr/X11R6/bin/xterm -vb -geometry 80x34-0+0 &
/usr/X11R6/bin/xterm -vb -geometry 80x24-0-0 &
/usr/X11R6/bin/xterm -vb -geometry 80x34+0+0 &

/usr/X11R6/bin/cwm
