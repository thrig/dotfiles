include(`m4/cf.m4')dnl
divert(-1)
asociar(`CUR_HOME', `printf "$HOME"')
divert(0)dnl
autogroup 1 "XTerm"
autogroup 2 "SDL_App"
autogroup 3 "cousterm"
autogroup 4 "Xnest"
autogroup 5 "MuPDF"
bind-key C-F1 lock
color activeborder goldenrod
color inactiveborder grey11
command cous CUR_HOME/libexec/cousterm
command votcana CUR_HOME/libexec/votcana
command xnest CUR_HOME/libexec/xnest
ignore xbattery
ignore xclipboard
ignore xeyes
ignore xload
snapdist 20
wm fvwm /usr/X11R6/bin/fvwm
