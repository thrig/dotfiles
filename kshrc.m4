include(`m4/cf.m4')dnl
divert(-1)

asociar(`CUR_HOME', `printf "$HOME"')
asociar(`CUR_LAD', `localarchdir')
asociar(`CUR_MANPATH', `printf "$MANPATH"')
asociar(`CUR_PATH', `printf "$PATH"')

asociar(`FULLSCREEN', `xgeometry')

no history; use Makefile or scripts instead (unless you need a log for
work purposes, in which case you probably want zsh with history epoch
dates or something even more complicated)
divert(0)dnl
unset HISTFILE
HISTSIZE=64
[[ -z "$SSH_CLIENT" ]] && PS1='$ '
set -o ignoreeof -o markdirs -o vi -o allexport
divert(-1)
https://no-color.org
divert(0)dnl
NO_COLOR=1
PATH=CUR_PATH
MANPATH=CUR_MANPATH
no_proxy="127.0.0.1,localhost,*.local"
http_proxy=http://127.0.0.1:7981
https_proxy=http://127.0.0.1:7981
divert(-1)
I dropped emacs a few decades ago. emacs mode in the shell took rather
longer to get rid of
divert(0)dnl
EDITOR=comando(`vi')
VISUAL=comando(`vi')
GIT_CEILING_DIRECTORIES=CUR_HOME
PAGER=comando(`less')
TZ=UTC
LANG=en_US.UTF-8
LC_CTYPE=en_US.UTF-8
LC_MESSAGES=POSIX
unset LC_ALL
LESSHISTFILE=-
LESS=-cFigXR-j5
LESSSECURE=1
divert(-1)
avoid linux "helper" scripts
http://seclists.org/fulldisclosure/2014/Nov/74
divert(0)dnl
unset LESSOPEN LESSCLOSE
divert(-1)
perldoc local::lib
divert(0)dnl
PERL5LIB=CUR_HOME/perl5/lib/perl5
PERL_LOCAL_LIB_ROOT=CUR_HOME/perl5
PERL_MB_OPT='--install_base "CUR_HOME/perl5"'
PERL_MM_OPT=INSTALL_BASE=CUR_HOME/perl5
PERL_MM_USE_DEFAULT=1
divert(-1)
setup pkg-config(1) (avoid LD_LIBRARY_PATH with rpath compiles)
divert(0)dnl
PKG_CONFIG_PATH=CUR_HOME/usr/CUR_LAD/lib/pkgconfig:/usr/local/lib/pkgconfig
R_LIBS_USER=CUR_HOME/lib/R
R_LIBS=CUR_HOME/lib/R
RSYNC_RSH='comando(`ssh', `-ax -o PreferredAuthentications=hostbased,publickey -o ClearAllForwardings=yes')'
TMP=CUR_HOME/tmp
TMPDIR=CUR_HOME/tmp
set +o allexport
divert(-1)
the funny ;: thing on some of these aliases is to prevent accidental
subsequent text from doing who knows what
divert(0)dnl
alias anykey="comando(`getraw', `-o ''`*:0''`;: "')
alias atonal-util='comando(`atonal-util', `--ly --flats')'
alias commit='comando(`git', `commit -a;: ')'
alias di='comando(`git', `diff')'
alias diff='comando(`diff', `-u')'
alias cp='comando(`cp', `-p')'
alias scp='comando(`scp', `-p')'
alias cursor-hide='comando(`tput', `civis;: ')'
alias cursor-show='comando(`tput', `cnorm;: ')'
alias ipcalc='comando(`ipcalc', `-n')'
alias gdb='comando(`egdb', `-q')'
alias egdb='comando(`egdb', `-q')'
alias man='comando(`man', `-T ascii')'
alias ascii='comando(`man', `-T ascii 7 ascii;: ')'
alias mutt='TERM=vt220 comando(`mutt')'
alias newshell='exec comando(`ksh', `-l')'
alias node='CUR_HOME/libexec/node'
alias ow='comando(`ow', `-C CUR_HOME/tmp')'
alias perl6='RAKUDO_ERROR_COLOR=0 comando(`perl6')'
divert(-1)
these are not fully qualified so that alternate installations of perl
(e.g. with perl-build or perlbrew) can be supported by changing PATH
divert(0)dnl
alias perldoc='perldoc -t'
alias pm-path='perldoc -l'
alias prove='prove --nocolor --blib'
alias play='comando(`play', `--buffer=32768')'
alias rlwrap='RLWRAP_HOME=CUR_HOME/.rlwrap comando(`rlwrap')'
alias R='comando(`R', `-q --silent --no-save')'
alias timidity='comando(`tlymidity')'
alias todo='VISUAL=ed comando(`todo', `;:')'
alias xeyes='comando(`solitary', `/ comando(`xeyes', `-geometry 150x100+710-0;: ')')'
alias xload='comando(`solitary', `/ comando(`xload', `-geometry 390x50+488+1;: ')')'
alias xmahjongg='comando(`solitary', `/ comando(`xmahjongg', `--tileset real --bg green --geometry FULLSCREEN;: ')')'
alias xpquery='comando(`xpquery', `-E UTF-8')'
alias xsel='comando(`xsel', `-l /dev/null')'
divert(-1)
functions are rare (better to have something more portable and more
testable in PATH) so are only used where shell builtins are involved, or
where a command is being changed for some reason

being able to cd to a file is probably bad, but it's a habit by now
divert(0)dnl
function cd {
   if [[ -z "$1" ]]; then
      builtin cd
   elif [[ -f "$1" ]]; then
      builtin cd -- "$(dirname "$1")"
   else
      builtin cd "$@"
   fi
}
function dc {
divert(-1)
NOTE dc(1) on OpenBSD does not then read from STDIN if given "-e ...";
must give it a file
divert(0)dnl
   if [[ -z "$1" ]]; then
      comando(`dc', `-e ''`4 k''` /dev/stdin')
   else
      comando(`dc', `-e ''`4 k''` "$@"')
   fi
}
function info { comando(`info', `"$@"') 2>/dev/null | $PAGER; }
function newdir {
   if [[ -n "$1" ]]; then
      comando(`mkdir', `-p -- "$1"') && builtin cd -- "$1" && pwd
   else
      false
   fi
}
function sbcl {
   if [[ $# -eq 0 ]]; then
      RLWRAP_HOME=CUR_HOME/.rlwrap comando(`rlwrap', `-D 2 comando(`sbcl', `--noinform')')
   elif [[ -f "$1" ]]; then
      comando(`sbcl', `--script "$1"')
   else
      RLWRAP_HOME=CUR_HOME/.rlwrap comando(`rlwrap', `-D 2 comando(`sbcl', `"$@"')')
   fi
}
