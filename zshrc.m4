include(`m4/cf.m4')dnl
divert(-1)
asociar(`CUR_HOME', `printf "$HOME"')
asociar(`CUR_LAD', `localarchdir')
asociar(`CUR_MANPATH', `printf "$MANPATH"')
asociar(`CUR_PATH', `printf "$PATH"')
asociar(`CUR_USER', `printf "$USER"')
divert(0)dnl
export NO_COLOR=1
setopt BSD_ECHO HASH_CMDS HIST_FIND_NO_DUPS HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS HIST_SAVE_NO_DUPS INC_APPEND_HISTORY INTERACTIVE_COMMENTS LIST_PACKED LIST_ROWS_FIRST MAGIC_EQUAL_SUBST NOFLOW_CONTROL RM_STAR_SILENT BRACE_CCL RC_EXPAND_PARAM AUTO_LIST EXTENDED_GLOB IGNORE_EOF
unsetopt AUTO_NAME_DIRS AUTO_REMOVE_SLASH HIST_VERIFY MARK_DIRS NO_LIST_AMBIGUOUS EXTENDED_HISTORY
unset HISTFILE
HISTSIZE=64
[[ -z $SSH_CLIENT ]] && PS1='%# '
KEYTIMEOUT=1
MAILCHECK=0
export PATH=CUR_PATH
export MANPATH=CUR_MANPATH
export no_proxy="127.0.0.1,localhost,*.local"
export http_proxy=http://127.0.0.1:7981
export https_proxy=http://127.0.0.1:7981
export ENV=CUR_HOME/.kshrc
export EDITOR=comando(`vi')
export VISUAL=comando(`vi')
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=POSIX
unset LC_ALL
export GIT_CEILING_DIRECTORIES=CUR_HOME
export LESS=-igXR-j5
export LESSHISTFILE=/dev/null
export LESSSECURE=1
unset LESSOPEN LESSCLOSE
export PAGER=comando(`less')
export PERLDOC_PAGER='comando(`less', `-R')'
export PERL5LIB=CUR_HOME/perl5/lib/perl5
export PERL_LOCAL_LIB_ROOT=CUR_HOME/perl5
export PERL_MB_OPT='--install_base "CUR_HOME/perl5"'
export PERL_MM_OPT=INSTALL_BASE=CUR_HOME/perl5
export PERL_MM_USE_DEFAULT=1
export PKG_CONFIG_PATH=CUR_HOME/usr/CUR_LAD/lib/pkgconfig:/usr/local/lib/pkgconfig
export R_LIBS_USER=CUR_HOME/lib/R
export R_LIBS=CUR_HOME/lib/R
export RSYNC_RSH='comando(`ssh', `-ax -o PreferredAuthentications=hostbased,publickey -o ClearAllForwardings=yes')'
export TMP=CUR_HOME/tmp
export TMPDIR=CUR_HOME/tmp
export TMPPREFIX=CUR_HOME/tmp/zsh
export TZ=UTC
alias anykey="comando(`getraw', `-o ''`*:0''`;: "')
alias ascii='comando(`man', `7 ascii;: ')'
alias atonal-util='comando(`atonal-util', `--ly --flats')'
alias commit='comando(`git', `commit -a;: ')'
alias di='comando(`git', `diff')'
alias diff='comando(`diff', `-u')'
alias st='comando(`git', `status -sb')'
alias cp='comando(`cp', `-p')'
alias scp='comando(`scp', `-p')'
alias cursor-hide='comando(`tput', `civis;: ')'
alias cursor-show='comando(`tput', `cnorm;: ')'
alias ipcalc='comando(`ipcalc', `-n')'
alias mitysisku='comando(`mitysisku', `-e')'
alias mutt='TERM=vt220 comando(`mutt')'
alias newshell='exec comando(`zsh', `-l')'
alias ow='comando(`ow', `-C CUR_HOME/tmp')'
alias perldoc='perldoc -t'
alias play='comando(`play', `--buffer=32768')'
alias pm-path='perldoc -l'
alias prove='comando(`prove', `--nocolor --blib')'
alias rlwrap='RLWRAP_HOME=CUR_HOME/.rlwrap comando(`rlwrap')'
alias R='comando(`R', `-q --silent --no-save')'
alias timidity='comando(`tlymidity')'
alias todo='VISUAL=ed comando(`todo')'
alias xeyes='comando(`solitary', `/ comando(`xeyes', `-geometry 150x100+710-0;: ')')'
alias xload='comando(`solitary', `/ comando(`xload', `-geometry 390x50+488+1;: ')')'
alias xmahjongg='comando(`solitary', `/ comando(`xmahjongg', `--tileset real --bg green ;: ')')'
alias xpquery='comando(`xpquery', `-E UTF-8')'
alias xsel='comando(`xsel', `-l /dev/null')'
function cd {
   if [[ -z $1 ]]; then
      builtin cd
   elif [[ -f $1 ]]; then
      builtin cd ${1:h}
   elif [[ $1 == - ]]; then
      builtin cd -
   elif [[ ! -e $1 ]]; then
      echo >&2 "cd: no such file or directory: $1"
      return 1
   else
      builtin cd $1
   fi
}
function cmdindir {
   local cmd; cmd=$1; shift
   local dir; dir=$2; shift
   shift 2
   comando(`mkdir', `-p -- $dir') && $cmd -- "$@" $dir && builtin cd $dir && pwd
}
function cpinto {
   if [[ $# -lt 2 ]]; then
      print -u 2 'Usage: cpinto dir file [..]'; false
   else
      cmdindir comando(`cp', `"$@"')
   fi
}
function mvinto {
   if [[ $# -lt 2 ]]; then
      print -n 2 'Usage: mvinto dir file [..]'; false
   else
      cmdindir comando(`mv', `"$@"')
   fi
}
function dc {
   if [[ -z $1 ]]; then
      comando(`dc', `-e ''`4 k''` -')
   else
      comando(`dc', `-e ''`4 k''` "$@"')
   fi
}
function newdir {
   if [[ -n $1 ]]; then
      comando(`mkdir', `-p -- "$1"') && builtin cd -- $1 && pwd
   else
      false
   fi
}
function info { comando(`info', `"$@"') 2>/dev/null | $PAGER; }
function sbcl {
   if [[ $# -eq 0 ]]; then
      RLWRAP_HOME=CUR_HOME/.rlwrap comando(`rlwrap', `-D 2 comando(`sbcl', `--noinform')')
   elif [[ -f "$1" ]]; then
      comando(`sbcl', `--script "$1"')
   else
      RLWRAP_HOME=CUR_HOME/.rlwrap comando(`rlwrap', `-D 2 comando(`sbcl', `"$@"')')
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
fpath=(CUR_HOME/.zsh/functions/openbsd CUR_HOME/.zsh/functions $fpath)
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
zstyle ':completion:*:(scp|ssh|rsync|telnet):*' users root CUR_USER
zstyle ':completion:*:*:(midi-util|timidity|tlymidity):*' file-patterns '*.midi:all-files *(-/):directories'
zstyle ':completion:*:*:(ccl|clisp|sbcl):*' file-patterns '*.lisp:all-files *(-/):directories'
zstyle ':completion:*:*:dmanview:*:*' file-patterns '*.[1-9]:all-files *(-/):directories'
zstyle ':completion:*:*:less:*:*' ignored-patterns '*.midi' '*.pdf' '*.fasl' '*.o'
zstyle ':completion:*:*:vim:*:*' ignored-patterns '*.midi' '*.pdf' '*.fasl' '*.o'
zstyle ':completion:*:*:feed:*:commands' ignored-patterns '*'
zstyle ':completion:*:*:feed:*:commands' fake-always expect gdb perl sbcl zsh
zstyle ':completion:*:*:mpg123:*:*' file-patterns '*.mp3:all-files *(-/):directories'
zstyle ':completion:*:*:(lilypond|playit):*:*' file-patterns '*.ly:all-files *(-/):directories'
zstyle ':completion:*:*:mopen:*:*' file-patterns '*.pdf:all-files *(-/):directories'
zstyle ':completion:*:*:prove:*:*' file-patterns '*.t:all-files *(-/):directories'
zstyle ':completion:*:prefix:*' add-space true
zstyle -e ':completion:*' hosts 'reply=($(< CUR_HOME/.hosts))'
zstyle ':completion:*' file-sort links
zmodload zsh/mathfunc
alias -g ,ch='*.{c,h}'
alias -g ,c='*.c'
alias -g ,lisp='**/*.lisp'
alias -g ,pm='**/*.pm~blib/*'
alias -g ,yml='**/*.yml'
# because ignored-patterns for -command- no worky for me
(){
  local c p
  while read p; do
    for c in $commands[(I)$p]; do
      unset "commands[$c]"
    done
  done <<EOF
cfftot1
cfscores
debinhex*
halt
hangman
lily*~lilypond
mopprobe
moptrace
mopd
mopchk
mopa.out
mupdf-x11
mupdf-x11-curl
mupdf-gl
py*
sb
EOF
}
unset zle_bracketed_paste
#print -z
