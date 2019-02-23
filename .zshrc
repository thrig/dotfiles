# huzzah! https://no-color.org
export NO_COLOR=1
setopt BSD_ECHO HASH_CMDS HIST_FIND_NO_DUPS HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS HIST_SAVE_NO_DUPS INC_APPEND_HISTORY INTERACTIVE_COMMENTS LIST_PACKED LIST_ROWS_FIRST MAGIC_EQUAL_SUBST NOFLOW_CONTROL RM_STAR_SILENT BRACE_CCL RC_EXPAND_PARAM AUTO_LIST EXTENDED_GLOB IGNORE_EOF
unsetopt AUTO_NAME_DIRS AUTO_REMOVE_SLASH HIST_VERIFY MARK_DIRS NO_LIST_AMBIGUOUS EXTENDED_HISTORY
[[ -z $SSH_CLIENT ]] && PS1='%# '
HISTSIZE=64
KEYTIMEOUT=1
MAILCHECK=0
path=(@@HOME@@/bin @@HOME@@/usr/OpenBSD6.5-amd64/bin @@HOME@@/perl5/bin /bin /sbin /usr/bin /usr/sbin /usr/X11R6/bin /usr/local/bin /usr/local/sbin /usr/games)
export MANPATH="@@HOME@@/usr/share/man:@@HOME@@/usr/OpenBSD6.5-amd64/share/man:@@HOME@@/perl5/man:/usr/X11R6/man:/usr/local/man:/usr/share/man:/usr/local/lib/tcl/tcl8.5/man:/usr/local/lib/tcl/tk8.5/man"
export ENV=@@HOME@@/.kshrc
export CC=egcc
export EDITOR=vim
export VISUAL=vim
export LANG="en_US.UTF-8"
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=POSIX
unset LC_ALL
export GIT_CEILING_DIRECTORIES=@@HOME@@
export LESS="-igX-j5"
export LESSHISTFILE=/dev/null
export LESSSECURE=1
unset LESSOPEN LESSCLOSE
export PAGER=less
export PERLDOC_PAGER="less -R"
export PERL_MM_USE_DEFAULT=1
export PERL5LIB="@@HOME@@/perl5/lib/perl5"
export PERL_LOCAL_LIB_ROOT="@@HOME@@/perl5"
export PERL_MB_OPT="--install_base @@HOME@@/perl5"
export PERL_MM_OPT="INSTALL_BASE=@@HOME@@/perl5"
export PKG_CONFIG_PATH="@@HOME@@/usr/OpenBSD6.5-amd64/lib/pkgconfig:/usr/local/lib/pkgconfig"
export R_LIBS_USER=@@HOME@@/lib/R
export R_LIBS=@@HOME@@/lib/R
export ROGUEHOME=@@HOME@@/share/rogue
export ROGUEOPTS="name=Thrig,file=@@HOME@@/share/rogue/rogue36.sav,askme,flush,jump"
export RSYNC_RSH='ssh -ax -o PreferredAuthentications=hostbased,publickey -o ClearAllForwardings=yes'
export SCORE_VIEWER=mupdf
export TMP=@@HOME@@/tmp
export TMPDIR=@@HOME@@/tmp
export TMPPREFIX=@@HOME@@/tmp/zsh
alias di='git diff'
alias anykey="getraw -o '*:0';: "
alias ascii='man 7 ascii;: '
alias atonal-util='atonal-util --ly --flats'
alias commit='git commit -a'
alias cp='cp -p'
alias cursor-hide='tput civis;: '
alias cursor-show='tput cnorm;: '
alias diff='diff -u'
alias ipcalc='ipcalc -n'
alias lilypond='lilypond -dno-point-and-click --silent'
alias mitysisku='mitysisku -e'
alias mutt='TERM=vt220 mutt'
alias newshell='exec zsh -l'
alias perldoc='perldoc -t'
alias prove='prove --nocolor --blib'
alias R='R -q --silent --no-save'
alias scp='scp -p'
alias st='git status -sb'
alias timidity=tlymidity
alias todo='EDITOR=ed todo'
alias xeyes='xeyes -geometry 150x100+710-0 &| : '
alias xload='xload -geometry 390x50+488+1 &| : '
alias xpquery='xpquery -E UTF-8'
alias xsel='xsel -l /dev/null'
function cd {
   if [[ -z $1 ]]; then
      builtin cd
   elif [[ -f $1 ]]; then
      builtin cd ${1:h}
   elif [[ $1 == - ]]; then
      builtin cd -
   elif [[ ! -e $1 ]]; then
      echo >&2 "cd: no such file or directory: $1"
      false
   else
      builtin cd $1
   fi
}
function cleanup_term { print "\033]2;\007"; }
function dc {
   if [ -z "$1" ]; then
      /usr/bin/dc -e '4 k' -
   else
      /usr/bin/dc -e '4 k' "$@"
   fi
}
function info { command info "$@" 2>/dev/null | less; }
function j { pgrep -u $USER -lf '(^|/)'vi '(^|/)'vim; jobs -l; }
function newdir {
   if [[ -n $1 ]]; then
      mkdir -p $1
      builtin cd $1
      pwd
   else
      false
   fi
}
function perl-deparse { perl -MO=Deparse,-p,-sCi2 -e "$@"; }
function pm-version { perl -M$1 -le "print \$$1::VERSION"; }
function pm-path { perl -M$1 -le "print \$INC{\"${1//::/\/}.pm\"}"; }
function sbcl {
   if [[ $# -eq 0 ]]; then
      RLWRAP_HOME=~/.rlwrap =rlwrap -D 2 =sbcl --noinform
   elif [[ -f $1 ]]; then
      =sbcl --script $1
   else
      RLWRAP_HOME=~/.rlwrap =rlwrap -D 2 =sbcl "$@"
   fi
}
function zbouncecompdef { unfunction _$1; autoload -U _$1; }
function my-history-search-backward {
   zle vi-history-search-backward
   CURSOR=0
}
function my-history-search-forward {
   zle vi-history-search-forward
   CURSOR=0
}
typeset -aU dns_servers
dns_servers=(localhost 8.8.4.4)
fpath=(@@HOME@@/.zsh/functions/openbsd @@HOME@@/.zsh/functions $fpath)
autoload -U compinit edit-command-line my-history-search-backward my-history-search-forward
compinit
zle -N edit-command-line
zle -N my-history-search-backward
zle -N my-history-search-forward
ZLE_SPACE_SUFFIX_CHARS='&|'
bindkey -v
local mode
for mode in vicmd viins; do
   bindkey -M $mode "^e" edit-command-line
   bindkey -M $mode "^t" push-line-or-edit
   bindkey -M $mode "^P" up-history
done
unset mode
bindkey -M vicmd "j" vi-down-line-or-history
bindkey -M vicmd "k" vi-up-line-or-history
bindkey -M vicmd "/" my-history-search-backward
bindkey -M vicmd "?" my-history-search-forward
bindkey -rpM viins '^['
bindkey -rpM vicmd '^['
bindkey -rpM vicmd ':'
bindkey -M vicmd -- "-" vi-beginning-of-line
zstyle ':completion:*' special-dirs ..
zstyle ':completion:*:(scp|ssh|rsync|telnet):*' users root $USER
zstyle ':completion:*:*:(midi-util|pianoteq|timidity|tlymidity):*' file-patterns '*.midi:all-files *(-/):directories'
zstyle ':completion:*:*:(ccl|sbcl):*' file-patterns '*.lisp:all-files *(-/):directories'
zstyle ':completion:*:*:dmanview:*:*' file-patterns '*.[1-9]:all-files *(-/):directories'
zstyle ':completion:*:*:less:*:*' ignored-patterns '*.midi' '*.pdf' '*.fasl' '*.o'
zstyle ':completion:*:*:vim:*:*' ignored-patterns '*.midi' '*.pdf' '*.fasl' '*.o'
zstyle ':completion:*:*:feed:*:commands' ignored-patterns '*'
zstyle ':completion:*:*:feed:*:commands' fake-always expect gdb perl sbcl zsh
zstyle ':completion:*:*:lilypond:*:*' file-patterns '*.ly:all-files *(-/):directories'
zstyle ':completion:*:*:mopen:*:*' file-patterns '*.pdf:all-files *(-/):directories'
zstyle ':completion:*:*:prove:*:*' file-patterns '*.t:all-files *(-/):directories'
zstyle ':completion:*:prefix:*' add-space true
zstyle -e ':completion:*' hosts 'reply=($(< @@HOME@@/.hosts))'
zstyle ':completion:*' file-sort links
zmodload zsh/mathfunc
alias -g ,ch='*.{c,h}'
alias -g ,c='*.c'
alias -g ,lisp='**/*.lisp'
alias -g ,pm='**/*.pm~blib/*'
alias -g ,yml='**/*.yml'
# keep trash out of $PATH, because ignored-patterns for -command- no worky
(){
   local c p
   while read p; do
      for c in $commands[(I)$p]; do
         unset "commands[$c]"
      done
   done <<EOF
cfftot1
debinhex*
halt
hangman
lily*~lilypond
mupdf-x11
mupdf-x11-curl
mupdf-gl
py*
sb
EOF
}
unset zle_bracketed_paste
#print -z
