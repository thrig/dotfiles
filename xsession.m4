#!/bin/sh
include(`m4/cf.m4')dnl
divert(-1)
asociar(`CUR_HOME', `printf "$HOME"')
asociar(`CUR_PATH', `printf "$PATH"')
include scripts and custom local software depot
divert(0)dnl
export PATH=CUR_PATH
rm CUR_HOME/.w3m/cookie CUR_HOME/.w3m/history 2>/dev/null
CUR_HOME/libexec/xbattery &
divert(-1)
DIE CAPS DIE
divert(0)dnl
comando(`setxkbmap', `-option ctrl:nocaps')
comando(`xmodmap', `CUR_HOME/.Xmodmap')
comando(`xset', `s off -dpms')
comando(`xset', `r rate 325 250')
divert(-1)
while read d; do
   [ -d "$d" ] && /usr/X11R6/bin/xset +fp "$d"
done << EOD
/usr/local/share/fonts/ghostscript
/usr/local/share/fonts/Liberation
/usr/local/share/fonts/noto
CUR_HOME/.fonts
EOD
comando(`xset', `+fp CUR_HOME/.fonts')
TODO may also need to run in custom dir:
   /usr/X11R6/bin/mkfontscale 
   /usr/X11R6/bin/mkfontdir  
 rescan needed if new dir seen:
   /usr/X11R6/bin/fc-cache -v
divert(0)dnl
comando(`mixerctl', `outputs.master=121,121 outputs.hp_boost=on') >/dev/null 2>&1
divert(-1)
this now being done in /etc/X11/xenodm/Xsetup_0
/usr/local/bin/feh --bg-tile CUR_HOME/co/turtledance/samples/ehargdgc.png &
/usr/X11R6/bin/xidle -timeout 1097 -program '/usr/X11R6/bin/xlock -mode blank -lockdelay 3 -timeout 31' &
divert(0)dnl
exec comando(`cwm')
