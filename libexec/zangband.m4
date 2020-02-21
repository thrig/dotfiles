#!/bin/sh
include(`../m4/cf.m4')dnl
divert(-1)
asociar(`CUR_HOME', `printf "$HOME"')
asociar(`CUR_LAD', `localarchdir')
divert(0)dnl

set -a

ANGBAND_X11_AT_X_0=462
ANGBAND_X11_AT_Y_0=0
# TODO these not getting honored on OpenBSD
ANGBAND_X11_COLS_0=90
ANGBAND_X11_ROWS_0=30
ANGBAND_X11_FONT_0=10x20

# messages
ANGBAND_X11_AT_X_1=0
ANGBAND_X11_AT_Y_1=480
ANGBAND_X11_ROWS_1=19

# inventory/equip
ANGBAND_X11_AT_X_2=0
ANGBAND_X11_AT_Y_2=0
ANGBAND_X11_ROWS_0=23

# monster views
ANGBAND_X11_AT_X_3=0
ANGBAND_X11_AT_Y_3=363
ANGBAND_X11_FONT_3=7x13

comando(`solitary', `"CUR_HOME"/tmp comando(`pamei',
  `zangband "CUR_HOME"/usr/CUR_LAD/zangband2.74b/bin/zangband -mx11 -- -n4')')
