HISTFILE=
HISTSIZE=64
[[ -n "$SSH_CLIENT" ]] && PS1='@@HOST@@$ '
set -o ignoreeof -o markdirs -o vi -o allexport
PATH="@@HOME@@/bin:@@HOME@@/usr/Darwin15.6.0-x86_64/bin:@@HOME@@/perl5/bin:/opt/local/libexec/perl5.26:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/X11R6/bin:/usr/bin:/usr/sbin:/bin:/sbin:/Applications/Wireshark.app/Contents/MacOS"
MANPATH="@@HOME@@/usr/share/man:@@HOME@@/usr/Darwin15.6.0-x86_64/share/man:@@HOME@@/perl5/man:/usr/local/man:/Applications/Xcode.app/Contents/Developer/usr/share/man:/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/share/man:/opt/local/share/texmf-texlive/doc/man:/opt/X11/share/man:/opt/local/share/man:/usr/share/man:/Applications/Wireshark.app/Contents/Resources/share/man"
MANSECT='2:3:1:4:5:7:1p:3p:n:l:6:8:9'
no_proxy="127.0.0.1,localhost,*.local"
CC=gcc
EDITOR=vim
VISUAL=vim
LANG="en_US.UTF-8"
LC_CTYPE=en_US.UTF-8
LC_MESSAGES=POSIX
unset LC_ALL
GOPATH=@@HOME@@/src/go
LESS="-igX-j5"
LESSHISTFILE="/dev/null"
LESSSECURE=1
unset LESSOPEN LESSCLOSE
PAGER=less
PERL5LIB="@@HOME@@/perl5/lib/perl5"
PERLDOC_PAGER="less -R"
PERL_LOCAL_LIB_ROOT="@@HOME@@/perl5"
PERL_MB_OPT="--install_base \"@@HOME@@/perl5\""
PERL_MM_OPT="INSTALL_BASE=@@HOME@@/perl5"
PERL_MM_USE_DEFAULT=1
PKG_CONFIG_PATH="@@HOME@@/usr/Darwin15.6.0-x86_64/lib/pkgconfig:/opt/local/lib/pkgconfig"
RSYNC_RSH='ssh -ax -o PreferredAuthentications=hostbased,publickey -o ClearAllForwardings=yes'
R_LIBS=@@HOME@@/lib/R
R_LIBS_USER=@@HOME@@/lib/R
TMP=@@HOME@@/tmp
TMPDIR=@@HOME@@/tmp
TZ=UTC
set +o allexport
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
alias newshell='exec mksh -l'
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
   if [[ -z "$1" ]]; then
      builtin cd
   elif [[ -f "$1" ]]; then
      builtin cd "$(dirname "$1")"
   else
      builtin cd "$@"
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
function j { /usr/bin/pgrep -u jmates -lf '(^|/)'vi '(^|/)'vim; jobs -l; }
function perl-deparse { perl -MO=Deparse,-p,-sCi2 -e "$@"; }
function pm-version { perl -M$1 -le "print \$$1::VERSION"; }
function pm-path { perl -M$1 -le "print \$INC{\"${1//::/\/}.pm\"}"; }
function pmt {
   if [ -r Makefile.PL ]; then
      make clean;
      perl Makefile.PL && make && \
      RELEASE_TESTING=1 TEST_SIGNATURE=1 make test 2>&1 | less
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
function ssh { stty sane; /opt/local/bin/ssh "$@"; }
function vagrant {
   (
      unset TMP TMPDIR
      VAGRANT_NO_COLOR=1 command vagrant "$@"
   )
}
