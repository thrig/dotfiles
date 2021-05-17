#!/bin/sh
include(`m4/cf.m4')dnl
divert(-1)
asociar(`CUR_HOME', `printf "$HOME"')
asociar(`CUR_PATH', `printf "$PATH"')
divert(0)dnl
export PATH=CUR_PATH
comando(`feh', `--no-fehbg --bg-center CUR_HOME/share/imgs/commentary.png')
comando(`rm', `-rf CUR_HOME/tmp/cfu.* CUR_HOME/tmp/r-fu.*')
comando(`find', `CUR_HOME/tmp -mindepth 1 -mtime +30 -delete')
comando(`rm', `CUR_HOME/.w3m/cookie CUR_HOME/.w3m/history') 2>/dev/null
comando(`setxkbmap', `-option ctrl:nocaps')
comando(`xmodmap', `CUR_HOME/.Xmodmap')
comando(`xset', `s off -dpms')
comando(`xset', `r rate 325 250')
comando(`doas', `comando(`mixerctl', `outputs.master=82,82 outputs.hp_boost=on')') >/dev/null 2>&1
exec comando(`cwm')
