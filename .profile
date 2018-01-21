# for mksh on Mac OS X

# if it's important put it in a Makefile or script or function or alias
#HISTFILE="$HOME/.sh_history"
HISTFILE=
HISTSIZE=64

if [ -n "$SSH_CLIENT" -o -n "$TMUX" ]; then
    PS1='lion$ '
fi

# NOTE markdirs may influence what rsync copies; related ZSH option is
# the MARK_DIRS setopt
set -o markdirs

set -o vi

set -o allexport

no_proxy="127.0.0.1,localhost,*.local"
#http_proxy="http://127.0.0.1:@@BLAHBLAH@@"
#https_proxy="http://127.0.0.1:@@BLAHBLAH@@"

# unset this if something needs or assumes clang
CC=gcc

EDITOR=vim
VISUAL=vim
PAGER=less

GOPATH="$HOME/src/go"

TZ=UTC
LOCO_TZ="@@BLAHBLAH@@"

LANG="en_US.UTF-8"
LC_MESSAGES=POSIX
# default UTF-8 insufficient to work-make w3m on Mac OS X
LC_CTYPE=en_US.UTF-8
unset LC_ALL

LESSHISTFILE="/dev/null"
LESS="-igX-j5"
LESSSECURE=1

unset LESSOPEN LESSCLOSE

MANPATH="$HOME/usr/share/man:$HOME/usr/Darwin15.6.0-x86_64/share/man:$HOME/perl5/man:/usr/local/man:/Applications/Xcode.app/Contents/Developer/usr/share/man:/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/share/man:/opt/local/share/texmf-texlive/doc/man:/opt/X11/share/man:/opt/local/share/man:/usr/share/man"
# use 'man 1 printf' in the rare case need the not-C-library page
MANSECT='2:3:4:5:6:7:8:9:1p:3p:n:l:1'

# I've disabled path_helper on Mac OS X so instead of that program being
# run alot I run it now and then and update this (and MANPATH) as needed
PATH="$HOME/bin:$HOME/usr/Darwin15.6.0-x86_64/bin:$HOME/perl5/bin:$HOME/usr/bin:/opt/local/libexec/perl5.26:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/X11R6/bin:/usr/bin:/usr/sbin:/bin:/sbin"

# for local::lib installed modules
PERL5LIB="$HOME/perl5/lib/perl5"
PERL_LOCAL_LIB_ROOT="$HOME/perl5"
PERL_MB_OPT="--install_base \"$HOME/perl5\""
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"
PERL_MM_USE_DEFAULT=1

PERLDOC_PAGER='less -R'

# my $HOME software depot and also MacPorts
PKG_CONFIG_PATH="$HOME/usr/Darwin15.6.0-x86_64/lib/pkgconfig:/opt/local/lib/pkgconfig"

R_LIBS_USER=$HOME/lib/R
R_LIBS=$HOME/lib/R

RSYNC_RSH='ssh -ax -o PreferredAuthentications=hostbased,publickey -o ClearAllForwardings=yes'

TMP=$HOME/tmp
TMPDIR=$TMP

set +o allexport

function cd {
    if [[ -z "$1" ]]; then
        builtin cd
    elif [[ -f "$1" ]]; then
        builtin cd "$(dirname "$1")"
    else
        builtin cd "$1"
    fi
}
function cleanup_term {
    print "\e]2;\a"
}
function dc {
    if [ -z "$1" ]; then
        command dc -e '4 k' -
    else
        command dc -e '4 k' "$@"
    fi
}
function gh {
    command ssh gh "$@"
    cleanup_term
}
function ghre {
    if [[ -n "$TMUX" ]]; then
        echo >&2 not while within tmux
        false
    else
        command ssh -t gh 'tmux attach'
        cleanup_term
        reset
    fi
}
function gw {
    command ssh gw "$@"
    cleanup_term
}
function info {
    command info "$@" 2>/dev/null | $PAGER
}
function j {
    pgrep -u $USER -lf '(^|/)'vi '(^|/)'$EDITOR
    jobs -l
}
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
function ssh {
    command ssh "$@"
    # because linux systems spam the title bar by default
    cleanup_term
}

# the ";: " in aliases is to ensure that nothing can follow an alias
# where nothing should follow

alias ack='ack --nocolor'
alias anykey="getraw -o '*:0';: "
alias atonal-util='atonal-util --ly --flats'
alias bat='pmset -g ps;: '
alias cdt="cd $TMP;: "
alias cdc='cd;print -n "\ec";: '
# using SBCL instead
#alias clisp='clisp -q -q -on-error abort -modern'
alias commit='git commit -a'
alias cp='cp -p'
alias cursor-hide='tput civis;: '
alias cursor-show='tput cnorm;: '
alias diff='diff -u'
alias findin='findin -q'
alias gdb='gdb -q'
alias hangup-ssh="pkill -HUP -u $USER ssh; apple-randomize-macaddr"
alias ipcalc='ipcalc -n'
# NOTE otool also does disassemble, try `otool -tv`
alias ldd='otool -L'
alias lldb='lldb -X'
# KLUGE no colors on account of xterm TERM
alias mutt='TERM=vt220 mutt'
alias newshell='exec mksh -l'
alias now="TZ=$LOCO_TZ now"
alias octave='octave --silent'
alias prove='prove --nocolor --blib'
alias R='R -q --silent --no-save'
alias sbcl='sbcl --noinform'
alias scp='scp -p'
# TODO tput for these? (but on laptop hardly ever move windows sooooo...)
#alias term-chat='printf "\033[8;34;80t"'
#alias term-norm='printf "\033[8;24;80t"'
#alias term-tall='printf "\033[8;0;80t"'
alias timidity=tlymidity
alias top='top -o CPU -F'
alias ttywrite='ttywrite -N'
alias vbm='VBoxManage -q'
alias showvirts='VBoxManage -q list vms;: '
alias runningvirts='VBoxManage -q list runningvms;: '
#alias xmltidy='xmllint --nsclean --encode UTF-8 --format'
alias xpquery='xpquery -E UTF-8'
