include(`m4/cf.m4')dnl
divert(-1)
asociar(`CUR_HOME', `printf "$HOME"')
divert(0)dnl
autogroup 1 "XTerm"
autogroup 2 "ZAngband"
autogroup 3 "cousterm"
autogroup 4 "wrterm"
autogroup 5 "MuPDF"
bind-key C-/ menu-window
bind-key C-F1 lock
color activeborder goldenrod
color inactiveborder grey11
command cous CUR_HOME/libexec/cousterm
command rouge CUR_HOME/libexec/rogueterm
command votcana CUR_HOME/libexec/votcana
command zangband CUR_HOME/libexec/zangband
ignore xbattery
ignore xclipboard
ignore xeyes
ignore xload
wm fvwm /usr/X11R6/bin/fvwm
