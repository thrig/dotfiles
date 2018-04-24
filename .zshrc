setopt BSD_ECHO HASH_CMDS HIST_FIND_NO_DUPS HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS HIST_SAVE_NO_DUPS INC_APPEND_HISTORY INTERACTIVE_COMMENTS LIST_PACKED LIST_ROWS_FIRST MAGIC_EQUAL_SUBST NOFLOW_CONTROL RM_STAR_SILENT BRACE_CCL RC_EXPAND_PARAM AUTO_LIST EXTENDED_GLOB IGNORE_EOF
unsetopt AUTO_NAME_DIRS AUTO_REMOVE_SLASH HIST_VERIFY MARK_DIRS NO_LIST_AMBIGUOUS EXTENDED_HISTORY
[[ -z "$SSH_CLIENT" ]] && PS1='%# '
HISTSIZE=64
KEYTIMEOUT=1
MAILCHECK=0
export MANPATH="@@HOME@@/usr/share/man:@@HOME@@/usr/Darwin15.6.0-x86_64/share/man:@@HOME@@/perl5/man:/usr/local/man:/Applications/Xcode.app/Contents/Developer/usr/share/man:/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/share/man:/opt/local/share/texmf-texlive/doc/man:/opt/X11/share/man:/opt/local/share/man:/usr/share/man:/Applications/Wireshark.app/Contents/Resources/share/man"
no_proxy="127.0.0.1,localhost,*.local"
export CC=gcc
export EDITOR=vim
export VISUAL=vim
export LANG="en_US.UTF-8"
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=POSIX
unset LC_ALL
export GIT_CEILING_DIRECTORIES=@@HOME@@
export GOPATH=@@HOME@@/src/go
export LESS="-igX-j5"
export LESSHISTFILE=/dev/null
export LESSSECURE=1
unset LESSOPEN LESSCLOSE
export PAGER=less
export PERLDOC_PAGER="less -R"
export PERL_MM_USE_DEFAULT=1
export PKG_CONFIG_PATH="@@HOME@@/usr/Darwin15.6.0-x86_64/lib/pkgconfig:/opt/local/lib/pkgconfig"
export R_LIBS_USER=@@HOME@@/lib/R
export R_LIBS=@@HOME@@/lib/R
export RSYNC_RSH='ssh -ax -o PreferredAuthentications=hostbased,publickey -o ClearAllForwardings=yes'
export SCORE_VIEWER=mupdf
export TMP=@@HOME@@/tmp
export TMPDIR=@@HOME@@/tmp
export TZ=UTC
alias di='git diff'
alias ketchup='git status -sb'
alias cal="LC_TIME=es_ES.UTF-8 cal"
alias date="LC_TIME=es_ES.UTF-8 date"
alias mycal="LC_TIME=es_ES.UTF-8 mycal"
alias now="LC_TIME=es_ES.UTF-8 now"
alias ack='ack --nocolor'
alias anykey="getraw -o '*:0';: "
alias ascii='man 7 ascii;: '
alias atonal-util='atonal-util --ly --flats'
alias bat='pmset -g ps;: '
alias cdt="cd @@HOME@@/tmp;: "
alias cdc='cd;print -n "\ec";: '
alias commit='git commit -a'
alias cp='cp -p'
alias cursor-hide='tput civis;: '
alias cursor-show='tput cnorm;: '
alias diff='diff -u'
alias diss='otool -dtv'
alias ipcalc='ipcalc -n'
alias ldd='otool -L'
alias lldb='lldb -X'
alias mitysisku='mitysisku -e'
alias mutt='TERM=vt220 mutt'
alias newshell='exec zsh -l'
alias perldoc='perldoc -t'
alias prove='prove --nocolor --blib'
alias R='R -q --silent --no-save'
alias scp='scp -p'
alias timidity=tlymidity
alias top='top -o CPU -F;print;: '
alias ttywrite='ttywrite -N'
alias vbm='VBoxManage -q'
alias showvirts='VBoxManage -q list vms;: '
alias runningvirts='VBoxManage -q list runningvms;: '
alias xpquery='xpquery -E UTF-8'
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
function cleanup_term { print "\e]2;\a"; }
function dc {
   if [ -z "$1" ]; then
      /usr/bin/dc -e '4 k' -
   else
      /usr/bin/dc -e '4 k' "$@"
   fi
}
function info { command info "$@" 2>/dev/null | less; }
function j { pgrep -u @@USER@@ -lf '(^|/)'vi '(^|/)'vim; jobs -l; }
function lpass { LPASS_DISABLE_PINENTRY=1 =lpass "$@" --color=never }
function perl-deparse { perl -MO=Deparse,-p,-sCi2 -e "$@"; }
function pm-version { perl -M$1 -le "print \$$1::VERSION"; }
function pm-path { perl -M$1 -le "print \$INC{\"${1//::/\/}.pm\"}"; }
function pmt {
   if [ -r Makefile.PL ]; then
      make clean;
      perl Makefile.PL && make && \
      RELEASE_TESTING=1 TEST_SIGNATURE=1 make test 2>&1 | $PAGER
   elif [ -r Build.PL ]; then
      ./Build clean >/dev/null 2>&1
    ( perl Build.PL && ./Build && \
      RELEASE_TESTING=1 TEST_SIGNATURE=1 ./Build test ) 2>&1 | $PAGER 
   else
      false
   fi
}
function sbcl {
   if [ $# -eq 0 ]; then
      # interactive, drop a newline on exit
      /opt/local/bin/sbcl --noinform
      print
   else
      /opt/local/bin/sbcl --noinform "$@"
   fi
}
function vagrant {
   (
      unset TMP TMPDIR
      VAGRANT_NO_COLOR=1 command vagrant "$@"
   )
}
autoload -U compinit edit-command-line
compinit
typeset -aU dns_servers
dns_servers=('\:\:1' 8.8.4.4)
zle -N edit-command-line
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
bindkey -rpM viins '^['
bindkey -rpM vicmd '^['
bindkey -M vicmd -- "-" vi-beginning-of-line
zstyle ':completion:*:processes' command 'ps -A -o pid,user,command'
zstyle ':completion:*:*:open:*:all-files' ignored-patterns '*.ps' '*.ly'
zstyle ':completion:*' special-dirs ..
zstyle ':completion:*:(scp|ssh|rsync|telnet):*' users root @@USER@@
zstyle ':completion:*:*:(ack|bbedit|di|diff|*grep|less|vi|vim):*:all-files' ignored-patterns '*.o' '*.ps' '*.pdf' '*.midi' '*.mp3' '*.wav' '*.t2d' '*.eps' '*.fas' '*.lib'
zstyle ':completion:*:*:(midi-util|pianoteq|timidity|tlymidity):*' file-patterns '*.midi:MIDI' '*(-/):directories'
zstyle ':completion:*:*:-command-:*' ignored-patterns '(debinhex*|escputil|coproc|ilbmtoppm|libtool|limit|link|linkicc|lipo|lispmtopgm|listings-ext.sh|listres|link-parser|lilymidi|lilypond-book|lilypond-invoke-editor|lilysong|lily-glyph-commands|lily-image-commands|lily-rebuild-pdfs|perlivp*|perlthanks*|perlbug*|perlcc*|perltex*|cron|*-config*|libnetcfg*|showchar|showfont|showmount|showrgb|*pbm|midi2ly|mupdf-x11|port-tclsh|getmapdl)'
zstyle ':completion:*:*:dmanview:*' file-patterns '*.[1-9]:man\ files *(-/):directories'
zstyle ':completion:*:*:feed:*:commands' ignored-patterns '*'
zstyle ':completion:*:*:feed:*:commands' fake-always expect gdb perl sbcl tclsh tinyrepl wish zsh
zstyle ':completion:*:*:lilypond:*' file-patterns '*.ly:lilypond\ files *(-/):directories'
zstyle ':completion:*:*:mopen:*:all-files' file-patterns '*.pdf:PDF *(-/):directories'
zstyle ':completion:*:*:prove:*' file-patterns '*.t:test\ files *(-/):directories'
zstyle ':completion:*:prefix:*' add-space true
zstyle -e ':completion:*' hosts 'reply=($(< @@HOME@@/.hosts))'
zmodload zsh/mathfunc
#unset zle_bracketed_paste
#print -z
