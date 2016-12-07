# for pdksh on Mac OS X

HISTFILE="$HOME/.sh_history"
HISTSIZE=128

if [ -n "$SSH_CLIENT" ]; then
    PS1='lion$ '
fi

set -o markdirs
set -o vi-tabcomplete

set -o allexport

#no_proxy="127.0.0.1"
#http_proxy="http://127.0.0.1:@@BLAHBLAH@@"
#https_proxy="http://127.0.0.1:@@BLAHBLAH@@"

EDITOR=vim
VISUAL=vim
PAGER=less

TZ=UTC
LOCO_TZ="@@BLAHBLAH@@"

LANG="en_US.UTF-8"
LC_MESSAGES=POSIX

LESSHISTFILE="/dev/null"
LESS="-igX-j5"
LESSSECURE=1

unset LESSOPEN LESSCLOSE

MANPATH="$HOME/usr/share/man:$HOME/usr/darwin15.0-x86_64/share/man:$HOME/perl5/man:/usr/local/man:/opt/local/share/texmf-texlive/doc/man:/opt/X11/share/man:/opt/local/share/man:/usr/share/man"
# use 'man 1 printf' in the rare case need the not-C-library page
MANSECT='2:3:4:5:6:7:8:9:1p:3p:n:l:1'

PATH="$HOME/bin:$HOME/usr/darwin15.0-x86_64/bin:$HOME/perl5/bin:$HOME/usr/bin:$HOME/Library/Haskell/bin:/opt/local/libexec/perl5.24:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/X11R6/bin:/usr/bin:/usr/sbin:/bin:/sbin"

# for local::lib installed modules
PERL5LIB="$HOME/perl5/lib/perl5"
PERL_LOCAL_LIB_ROOT="$HOME/perl5"
PERL_MB_OPT="--install_base \"$HOME/perl5\""
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"
PERL_MM_USE_DEFAULT=1

PERLDOC_PAGER='less -R'

PKG_CONFIG_PATH="$HOME/usr/darwin15.0-x86_64/lib/pkgconfig:/opt/local/lib/pkgconfig"

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
    printf "\033]2;\a"
}
function dc {
    if [ -z "$1" ]; then
        command dc -e '4 k' -
    else
        command dc -e '4 k' "$@"
    fi
}
function gh {
    ssh gh "$@"
    cleanup_term
}
function ghre {
    if [[ -n "$TMUX" ]]; then
        echo >&2 not while within tmux
        false
    else
        ssh -t gh 'tmux attach'
        cleanup_term
        reset
    fi
}
function gw {
    ssh gw "$@"
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
        perl Makefile.PL && \
        make && RELEASE_TESTING=1 TEST_SIGNATURE=1 make test 2>&1 | $PAGER
    else
        false
    fi
}

alias ack='ack --nocolor'
alias anykey="getraw -o '*:+'"
alias atonal-util='atonal-util --ly --flats'
alias bat='pmset -g ps'
alias cdt="cd $TMP"
alias clisp='clisp -q -q -on-error abort -modern'
# TODO tput for this?
alias clterm='printf "\033]2;\a"'
alias cp='cp -p'
alias cursor-hide='tput civis'
alias cursor-show='tput cnorm'
alias diff='diff -u'
alias fecha="TZ=$LOCO_TZ date +'%Y-%m-%d %H:%M:%S'"
alias findin='findin -q'
alias gdb='gdb -q'
alias hangup-ssh="pkill -HUP -u $USER ssh; apple-randomize-macaddr"
alias ipcalc='ipcalc -n'
alias ldd='otool -L'
# KLUGE no colors on account of xterm TERM
alias mutt='TERM=vt220 mutt'
alias now="TZ=$LOCO_TZ now"
alias octave='octave --silent'
alias prove='prove --nocolor --blib'
alias R='R -q --silent --no-save'
alias sbcl='sbcl --noinform'
alias scp='scp -p'
# TODO tput for these?
alias term-chat='printf "\033[8;34;80t"'
alias term-norm='printf "\033[8;24;80t"'
alias term-tall='printf "\033[8;0;80t"'
alias timidity=tlymidity
alias top='top -o CPU -F; echo'
alias ttywrite='ttywrite -N'
alias vbm='VBoxManage -q'
alias vbm-showvirts='VBoxManage -q list vms'
alias wv='ow -d'
