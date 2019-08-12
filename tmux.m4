include(`m4/cf.m4')dnl
set-option -g default-command "exec comando(`ksh', `-l')"
divert(-1)
ko catra lo ratcu
divert(0)dnl
set-option -s -g mouse off
set-option -s escape-time 1
set-environment -g -r SSH_CLIENT
set-environment -g -r SSH_CONNECTION
set-environment -g -r SSH_TTY
set-option -g history-limit 1000
set-option -g status off
set-option -g status-keys vi
set-window-option -g aggressive-resize on
set-window-option -g alternate-screen off
set-window-option -g mode-keys vi
divert(-1)
disable things I do not use, which is most things especially pane related
divert(0)dnl
unbind-key t
unbind-key C-o
unbind-key '!'
unbind-key '"'
unbind-key '%'
unbind-key '\;'
unbind-key o
unbind-key q
#unbind-key x
unbind-key z
unbind-key '{'
unbind-key '}'
unbind-key 'PageUp'
unbind-key 'PageDown'
unbind-key 'Left'
unbind-key 'Right'
unbind-key 'Up'
unbind-key 'Down'
unbind-key 'M-1'
unbind-key 'M-2'
unbind-key 'M-3'
unbind-key 'M-4'
unbind-key 'M-5'
unbind-key 'M-n'
unbind-key 'M-o'
unbind-key 'M-p'
unbind-key 'C-Left'
unbind-key 'C-Right'
unbind-key 'C-Up'
unbind-key 'C-Down'
unbind-key 'M-Left'
unbind-key 'M-Right'
unbind-key 'M-Up'
unbind-key 'M-Down'
divert(-1)
behave like how I had screen configured (TODO probaby should rework this)
divert(0)dnl
set-option -g prefix C-p
unbind-key C-b
bind-key C-p last-window
divert(-1)
hmm. maybe.
divert(0)dnl
bind-key x copy-mode
unbind-key [
unbind-key p
bind-key i paste-buffer
bind-key -T copy-mode-vi C send-keys -X copy-line
divert(-1)
capture the visible stuff (will need -a for alternate screen (but I turn
that off))
divert(0)dnl
bind-key g capture-pane -eJ
divert(-1)
"grab it all"
divert(0)dnl
bind-key G capture-pane -eJ -S - -E -
divert(-1)
or ^P: save-buffer ~/... to manually put output somewhere
divert(0)dnl
unbind-key s
changequote(`{',`}')dnl
bind-key s run "tmux save-buffer - > ~/tmp/tmux-`date +%s`.out"
divert(-1)
slightly incompatible with emacs mode things (C-k in particular) but I
don't really use emacs anything (C-j is sometimes necessary after
gunktty(1) has totally trashed the terminal keys)
divert(0)dnl
bind-key -n C-j next-window
#unbind-key -n C-j
bind-key -n C-k previous-window
bind-key R source-file ~/.tmux.conf \; display-message "source-file done"
