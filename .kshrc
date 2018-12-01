HISTFILE=
HISTSIZE=64
[[ -z "$SSH_CLIENT" ]] && PS1='$ '
set -o ignoreeof -o markdirs -o vi -o allexport
# huzzah! https://no-color.org
NO_COLOR=1
PATH="@@HOME@@/usr/OpenBSD6.4-amd64/bin:@@HOME@@/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin:/usr/games"
MANPATH="@@HOME@@/usr/share/man:@@HOME@@/usr/OpenBSD6.4-amd64/share/man:@@HOME@@/perl5/man:/usr/X11R6/man:/usr/local/man:/usr/share/man:/usr/local/lib/tcl/tcl8.5/man:/usr/local/lib/tcl/tk8.5/man"
EDITOR=vim
VISUAL=vim
PAGER=less
PERLDOC_PAGER="less -R"
GIT_CEILING_DIRECTORIES=@@HOME@@
LANG="en_US.UTF-8"
LC_CTYPE=en_US.UTF-8
LC_MESSAGES=POSIX
unset LC_ALL
LESSHISTFILE="/dev/null"
LESS="-igX-j5"
LESSSECURE=1
unset LESSOPEN LESSCLOSE
PERL5LIB="@@HOME@@/perl5/lib/perl5"
PERL_LOCAL_LIB_ROOT="@@HOME@@/perl5"
PERL_MB_OPT="--install_base \"@@HOME@@/perl5\""
PERL_MM_OPT="INSTALL_BASE=@@HOME@@/perl5"
PERL_MM_USE_DEFAULT=1
PKG_CONFIG_PATH="@@HOME@@/usr/OpenBSD6.4-amd64/lib/pkgconfig"
R_LIBS_USER=@@HOME@@/lib/R
R_LIBS=@@HOME@@/lib/R
ROGUEHOME=@@HOME@@/share/rogue
ROGUEOPTS="name=Thrig,file=@@HOME@@/share/rogue/rogue36.sav,askme,flush,jump"
RSYNC_RSH='ssh -ax -o PreferredAuthentications=hostbased,publickey -o ClearAllForwardings=yes'
TMP=@@HOME@@/tmp
TMPDIR=@@HOME@@/tmp
set +o allexport
alias anykey="getraw -o '*:0';: "
alias ascii='man 7 ascii;: '
alias atonal-util='atonal-util --ly --flats'
alias commit='git commit -a'
alias cp='cp -p'
alias cursor-hide='tput civis;: '
alias cursor-show='tput cnorm;: '
alias di='git diff'
alias diff='diff -u'
alias ipcalc='ipcalc -n'
alias mitysisku='mitysisku -e'
alias mutt='TERM=vt220 mutt'
alias newshell='exec ksh -l'
alias perldoc='perldoc -t'
alias prove='prove --nocolor --blib'
alias R='R -q --silent --no-save'
alias scp='scp -p'
alias st='git status -sb'
alias timidity=tlymidity
alias todo='EDITOR=ed todo'
alias xeyes='solitary / xeyes -geometry 150x100+710-0;: '
alias xload='solitary / xload -geometry 390x50+488+1;: '
alias xpquery='xpquery -E UTF-8'
alias xsel='xsel -l /dev/null'
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
function j { /usr/bin/pgrep -u "$USER" -lf '(^|/)'vi '(^|/)'vim; jobs -l; }
function newdir {
   if [[ -n "$1" ]]; then
      mkdir -p "$1"
      builtin cd "$1"
      pwd
   else
      false
   fi
}
function perl-deparse { perl -MO=Deparse,-p,-sCi2 -e "$@"; }
function pm-version { perl -M"$1" -le "print \$$1::VERSION"; }
function pm-path { perl -M"$1" -le "print \$INC{\"${1//::/\/}.pm\"}"; }
function pmt {
   if [ -r Makefile.PL ]; then
      make clean;
      perl Makefile.PL && make && \
      RELEASE_TESTING=1 TEST_SIGNATURE=1 make test 2>&1 | less
   elif [ -r Build.PL ]; then
      ./Build clean >/dev/null 2>&1
    ( perl Build.PL && ./Build && \
      RELEASE_TESTING=1 TEST_SIGNATURE=1 ./Build test ) 2>&1 | "$PAGER"
   else
      false
   fi
}
function sbcl {
   if [ $# -eq 0 ]; then
      RLWRAP_HOME=~/.rlwrap rlwrap -D 2 /usr/local/bin/sbcl --noinform
      print
   elif [[ -f "$1" ]]; then
      /usr/local/bin/sbcl --script "$1"
   else
      RLWRAP_HOME=~/.rlwrap rlwrap -D 2 /usr/local/bin/sbcl "$@"
   fi
}
function ssh { stty sane; /usr/bin/ssh "$@"; }
