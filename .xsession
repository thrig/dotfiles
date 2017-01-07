#!/bin/sh

/usr/local/bin/feh --bg-center $HOME/imgs/forth-bg-longer.png

# hmm, tricky to balance random mp3 files against timidity with -A90a or
# somesuch set
/usr/bin/mixerctl outputs.master=131,131 outputs.hp_boost=on >/dev/null 2>&1

# DIE CAPS DIE
/usr/X11R6/bin/setxkbmap -option ctrl:nocaps

/usr/X11R6/bin/xmodmap $HOME/.Xmodmap

/usr/X11R6/bin/xset s off -dpms
/usr/X11R6/bin/xset r rate 175 50

#$HOME/libexec/xbattery &

while read d; do
  [ -d "$d" ] && /usr/X11R6/bin/xset +fp "$d"
done << EOD
/usr/local/share/fonts/ghostscript
/usr/local/share/fonts/Liberation
$HOME/.fonts
EOD
#/usr/X11R6/bin/xset +fp $HOME/.fonts
# TODO may also need to run in custom dir:
#   /usr/X11R6/bin/mkfontscale 
#   /usr/X11R6/bin/mkfontdir  
# rescan needed if new dir seen:
#   /usr/X11R6/bin/fc-cache -v

/usr/X11R6/bin/xidle -timeout 1097 -program '/usr/X11R6/bin/xlock -mode blank -lockdelay 3 -timeout 31' &

/usr/X11R6/bin/xterm -geometry 80x34+0+0 &
/usr/X11R6/bin/xterm -geometry 80x24+0-0 &
/usr/X11R6/bin/xterm -geometry 80x34-0+0 &
/usr/X11R6/bin/xterm -geometry 80x24-0-0 &

/usr/X11R6/bin/cwm
