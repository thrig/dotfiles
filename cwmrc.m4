include(`m4/cf.m4')dnl
divert(-1)
asociar(`CUR_HOME', `printf "$HOME"')
divert(0)dnl
autogroup 1 "XTerm"
autogroup 2 "MuPDF"
autogroup 3 "SDL_App"
autogroup 4 "cousterm"
autogroup 4 "cous2term"
autogroup 5 "URxvt"
unbind-key CM-x
unbind-key M-period
unbind-key CM-Delete
bind-key C-F1 lock
color activeborder NavajoWhite
color inactiveborder grey1
command clani CUR_HOME/libexec/clani
command cous CUR_HOME/libexec/cousterm
command fancy CUR_HOME/libexec/xomb
command votcana CUR_HOME/libexec/votcana
command xnest CUR_HOME/libexec/xnest
ignore xbattery
ignore xclipboard
ignore xeyes
ignore xload
snapdist 20
wm fvwm comando(`fvwm')
