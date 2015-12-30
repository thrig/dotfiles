# NOTE not yet my actual ~/.zshrc, mostly example configs selected from
# what I currently have.

setopt BSD_ECHO COMPLETE_IN_WORD EXTENDED_HISTORY HASH_CMDS HIST_FIND_NO_DUPS HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS HIST_SAVE_NO_DUPS INC_APPEND_HISTORY INTERACTIVE_COMMENTS LIST_PACKED LIST_ROWS_FIRST MAGIC_EQUAL_SUBST NOFLOW_CONTROL RM_STAR_SILENT EXTENDED_GLOB BRACE_CCL RC_EXPAND_PARAM
unsetopt AUTO_NAME_DIRS AUTO_REMOVE_SLASH HIST_VERIFY MARK_DIRS promptcr

########################################################################
#
# Environment (never export *HIST* nor prompt vars nor anything else
# shell-internal-use-only)

# NOTE these must be set *before* any bindkey calls, especially if the
# editor differs from the line editing mode. Also, other applications
# (e.g. Subversion, git) may have their own editor commands, check for
# their environment variables or configuration for details.
export EDITOR=vim
export VISUAL=vim

# hopefully FTP dies one of these years: http://mywiki.wooledge.org/FtpMustDie
export FTP_PASSIVE=1

export GIT_SSH=$HOME/libexec/git_ssh

# Write a function, Makefile, or script to capture anything crazy you're
# doing on the CLI. Otherwise, toss history to avoid accumulating a
# midden of shell commands.
#
# Reviews of "what commands have typed" might be assisted with:
#   print -l $commands:t ${(k)functions} ${(k)aliases} 
# to collect the available commands, functions, and aliases.
HISTFILE=~/.zsh/history
HISTSIZE=500
SAVEHIST=1000

export LANG=en_US.UTF-8
# but then need some or all of the following to avoid e.g. setlocale failures
# when launching R, or such. This is worse under bash, as is typical:
# http://utcc.utoronto.ca/~cks/space/blog/linux/BashLocaleScriptDestruction
#   ... especially if /bin/sh is improperly bash.
export LC_COLLATE=POSIX
export LC_CTYPE=POSIX
export LC_MESSAGES=POSIX
export LC_MONETARY=POSIX
export LC_NUMERIC=POSIX
export LC_TIME=POSIX

# Nuke the annoying alternate screen banking (on a per TERM basis) via:
#
#   infocmp | sed -e 's/[sr]mcup=[^,]*,//' > blah
#   tic -o ~/.terminfo/ blah
#   rm blah
#
# See also .vimrc and .tmux.conf for more ways to ensure the alternate
# screen is never used.
export LESS="-iegX-j5"
export LESSHISTFILE=/dev/null
export LESSSECURE=1

# Paranoia, in event OS calls unaudited programs that can then be exploited.
# http://seclists.org/fulldisclosure/2014/Nov/74
unset LESSOPEN LESSCLOSE

# annoying distraction
MAILCHECK=0

# http_proxy set elsewhere
export no_proxy="127.0.0.1"

export PAGER=less
export PERLDOC_PAGER='less -R' 

# disabling as probably should fix encoding in various scripts, not force
# it to UTF-8 here (which in turn can cause DBI to fail to build)
#export PERL_UNICODE=ALS

# helps automate builds, also set
# 'prerequisites_policy' => q[follow], in ~/.cpan/CPAN/MyConfig.pm
# (or install App::cpanminus and use cpanm)
export PERL_MM_USE_DEFAULT=1

# prompt - not having the machine name on remote logins is a bit too
# minimal for my tastes.
if [[ -n $SSH_CLIENT ]]; then
  PS1='%m%# '
# these I use rarely, so a warning about the subshell is handy
elif [[ -n $PERL5_CPAN_IS_RUNNING ]]; then
  PS1='(cpan)%# '
elif [[ -n $VIM ]]; then
  PS1='(vim)%# '
else 
  PS1='%# '
fi

if [[ -n $SUDO_COMMAND ]]; then
  export TMP=$HOME/tmp
  export TMPDIR=$HOME/tmp
  # Used by various ZSH completion scripts, subject to usual local
  # malicious user games if one uses the default. If $HOME is
  # networked (you poor sap!) perhaps mktemp a directory under /tmp
  # and then use that.
  TMPPREFIX=$HOME/tmp/zsh
else
  # In event forgot to 'sudo -H' do not want to become someone else with
  # these set (which is then a risk of TMPPREFIX attacks as that user,
  # but hopefullly the 'sudo -s' bit isn't happening much if at all...
  unset TMP TMPDIR TMPPREFIX
fi

ZLE_SPACE_SUFFIX_CHARS='&|'

########################################################################
#
# Completion Foo (and some compile flags)

# NOTE this must be done before autoload
fpath=(~/.zsh/functions $fpath)

typeset -TU PKG_CONFIG_PATH pkg_config_path
typeset -TU LD_LIBRARY_PATH ld_library_path

MYSYSID=

if [[ $OSTYPE =~ "^darwin" ]]; then
  fpath=(~/.zsh/functions/darwin $fpath)

  MYSYSID=$OSTYPE-$MACHTYPE

  # for MacPorts
  pkg_config_path=(/opt/local/lib/pkgconfig $pkg_config_path)

  CC=clang

  # These either cargo-culted from elsewhere or copied in from a review
  # of the gcc/clang man pages, with an eye towards as many warnings as
  # possible. Some compiles can therefore be very warning infested,
  # which hopefully folks will clean up one day.
  CFLAGS='-O2 -std=c11 -Wall -Wglobal-constructors -Winit-self -Wmissing-include-dirs -Wextra -Wdeclaration-after-statement -Wundef -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-qual -Wcast-align -Wwrite-strings -Wconversion -Wshorten-64-to-32 -Waggregate-return -Wold-style-definition -Wmissing-prototypes -Wmissing-declarations -Wmissing-field-initializers -Wredundant-decls -Wnested-externs -Winvalid-pch -pedantic -pipe'
 # This may need to be unset when compiling certain things.
 #
 # Add -Werror to make warnings blow up so those can be looked at, e.g.
 # with :cnext in vim.

  function showscore {
    if [[ -n "$1" ]]; then
      # Not really happy with any PDF viewer thus far, but Preview.app no
      # worse than the rest. sigh. Nope, scratch that, Preview.app on Mac
      # OS X 10.10 is unusable, as it automatically scrolls down to the
      # end of the thus blank page with the new music hidden above, sigh.
      #open --background -a Preview "$@"
      #xpdf -remote music -exec "gotoLastPage" "$@"
      open "$@"
    else
      open --background -a Preview *.pdf(om[1])
    fi
  }

  zstyle ':completion:*:processes' command 'ps -A -o pid,user,command'

  # help open find just the "*.pdf" when completing on a lilypond-built file
  zstyle ':completion:*:*:open:*:all-files' ignored-patterns '*.ps' '*.ly'

elif [[ $OSTYPE =~ "openbsd" ]]; then
  fpath=(~/.zsh/functions/openbsd $fpath)

  MYSYSID=$OSTYPE-$MACHTYPE

  CC=gcc
  # NOTE with -fstack-protector-all things like 'return 0;' to exit from a
  # C program will cause aborts; use 'exit(0);' instead from <stdlib.h>.
  CFLAGS='-O2 -std=c99 -Wall -Winit-self -Wmissing-include-dirs -Wextra -Wdeclaration-after-statement -Wundef -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-qual -Wcast-align -Wwrite-strings -Wconversion -Waggregate-return -Wold-style-definition -Wmissing-prototypes -Wmissing-declarations -Wmissing-field-initializers -Wnested-externs -Winvalid-pch -pedantic -pipe -fstack-protector-all'

  function showscore {
    if [[ -n "$1" ]]; then
      open "$@"
    else
      # custom open implementation for OpenBSD, see scripts repo
      open *.pdf(om[1])
    fi
  }

  # TODO though this first required:
  #  # export SCHEME_LIBRARY_PATH=/usr/local/share/slib/
  #  # export GAMBIT_IMPLEMENTATION_PATH=/usr/local/lib/gambit-c
  #  # gsi -:s /usr/local/share/slib/gambit.init -
  #  > (require 'new-catalog)
  export GAMBIT_IMPLEMENTATION_PATH=/usr/local/lib/gambit-c
  SCHEME_LIBRARY_PATH=/usr/local/share/slib/
fi

if [[ -z $MYSYSID ]]; then
  echo >&2 warning MYSISID not set on this platform
else
  # for a local software depot of sorts under my home dir (where the C
  # stuff goes that is not in OS or ports/packages space)
  pkg_config_path+=( ~/usr/$MYSYSID/lib/pkgconfig )
  ld_library_path+=( ~/usr/$MYSYSID/lib )
fi

export CC CFLAGS PKG_CONFIG_PATH LD_LIBRARY_PATH SCHEME_LIBRARY_PATH

# for my _dig completion script over in zsh-compdef
typeset -aU dns_servers
dns_servers=('\:\:1' 8.8.4.4)

# always switch to command mode on ^R search
function myvi-inc-search {
  zle -K vicmd;
  zle history-incremental-search-backward
}

zle -N myvi-inc-search
# TODO url-quote-magic going away in recent zsh?
autoload -U compinit edit-command-line select-word-style url-quote-magic
compinit
zle -N edit-command-line
zle -N self-insert url-quote-magic
# bad habits die hard
select-word-style bash

# Some tests from the "Bash to Z Shell" book
zstyle ':completion:*' format %d
zstyle ':completion:*' group-name ''
zstyle ':completion:*:-command-:*:(commands|builtins|reserved-words|aliases)' group-name commands
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:warnings' format 'No matches: %d'
# test no dups to these
zstyle ':completion::*:(cvs-add|less|rm|vi*):*' ignore-line true
# meh? (though good to document the fashions of the time of the book)
#zstyle ':completion:*:*:cd:*' ignored-patterns '(*/|)(CVS|SCCS)'
zstyle ':completion:*' ignore-parents parent pwd

# Make this exist for completion even if unset
zstyle ':completion::*:(-command-|export):*' fake-parameters LD_LIBRARY_PATH:scalar

# perhaps good for /:cygdrive or for automount, if you have those
#zstyle ':completion:*' fake-files '/somedir'

# custom list, not from whatever inappropriate randomness is in the system
# hosts file or whatever SSH dragged home
zstyle -e ':completion:*' hosts 'reply=($(< ~/.hosts))'

# might set this for all commands if have a large userbase
zstyle ':completion:*:(rsync|scp|ssh|telnet):*' users root $USER

zstyle ':completion:*' special-dirs ..

zstyle ':completion:*:*:lilypond:*' file-patterns '*.ly:lilypond\ files *(-/):directories'
zstyle ':completion:*:*:(midiutil*:pianoteq|timidity|tlymidity):*' file-patterns '*.(mid|MID|midi):MIDI\ files *(-/):directories'

zstyle ':completion:*:*:prove:*' file-patterns '*.t:test\ files *(-/):directories'

zstyle ':completion:*:*:showscore:*' file-patterns '*.pdf:PDF\ files *(-/):directories'

# Texty things do not need to find binary things 99.x% of time
zstyle ':completion:*:*:(ack|bbedit|di|diff|*grep|less|vi|vim):*:all-files' ignored-patterns '*.core' '*.o' '*.ps' '*.pdf' '*.midi' '*.mp3' '*.wav' '*.t2d' '*.eps' '*.aux' '*.bbl' '*.blg' '*.log' '*.toc'

# Commands to ignore completion on as they 99.N% of the time just delay
# me getting to what I want
zstyle ':completion:*:*:-command-:*' ignored-patterns '(libtool|limit|link|linkicc|lipo|lispmtopgm|listings-ext.sh|listres|lilymidi|lilypond-book|lilypond-invoke-editor|lilysong|perlivp*|perlthanks*|perlbug*|perlcc*|perltex*|cron|*-config|libnetcfg*|pbm*)'

########################################################################
#
# Key Bindings

KEYTIMEOUT=1

# or you can be explicit instead of relying on EDITOR peeks
bindkey -v

local mode
for mode in vicmd viins; do
  bindkey -M $mode "^v" edit-command-line
  bindkey -M $mode "^t" push-line-or-edit
  # bad habit from back when I used emacs
  bindkey -M $mode "^R" myvi-inc-search

  # lets me know whether I'm in tmux or not
  bindkey -M $mode "^P" up-history
done

# probably a bit extreme, as it nixes the arrow keys and such, but even
# with KEYTIMEOUT at min value, that delay is still annoying.
bindkey -rpM viins '^['

# lets me know whether I'm in tmux (formerly screen) or not
bindkey "^P" up-history

########################################################################
#
# Functions

function cd {
  if [[ -z "$1" ]]; then
    builtin cd
  # steal from osse/dotfiles
  elif [[ $1 = :/ ]]; then
    builtin cd "$(git rev-parse --show-toplevel)"
  elif [[ -f "$1" ]]; then
    builtin cd "${1:h}"
  elif [[ "$1" = "-" ]]; then
    builtin cd -
  elif [[ ! -e "$1" ]]; then
    echo >&2 cd: no such file or directory: $1
    return 1
  else
    builtin cd "$1"
  fi
}

# Except no gdb on Mac OS X so...
if [[ ! $OSTYPE =~ "^darwin" ]]; then
  # ugh, both GNU license spam, and then lack of echo when ^D out. bleh.
  function gdb {
    command gdb -q "$@"
    echo
  }
fi

function lldb {
  command lldb "$@"
  echo
}

# "go home" or "go work" being the two most common places I SSH to...
# (there's a ~/.ssh/config entry that include 'gh' or 'gw' as a 'Host'
# option, and then 'Hostname' of the IP address of the actual server)
function gh {
  command ssh gh "$@"
  if [[ $? -ne 0 ]]; then
    # help log timing info on any network burps
    logger -- ssh non-zero exit $? for "$@"
  fi
  if [ -t 1 ]; then
    # some vendors put crap in the title bar, clear it
    echo -ne "\e]2;\a"
    clear
    stty sane
  fi
}

function ghre {
  command ssh -t gh tmux attach
  if [[ $? -ne 0 ]]; then
    # help log timing info on any network burps
    logger -- ssh non-zero exit $? for "$@"
  fi
  if [ -t 1 ]; then
    echo -ne "\e]2;\a"
    clear
    stty sane
  fi
}

function gw {
  command ssh gw "$@"
  if [[ $? -ne 0 ]]; then
    # help log timing info on any network burps
    logger -- ssh non-zero exit $? for "$@"
  fi
  if [ -t 1 ]; then
    echo -ne "\e]2;\a"
    clear
    stty sane
  fi
}

# because I pretty much always forget to supply the device
function midiplay {
  if [[ $# -eq 1 ]]; then
    =midiplay -f rmidi/0 $1
  else
    =midiplay "$@"
  fi
}

function ssh {
  command ssh $@
  if [[ $? -ne 0 ]]; then
    # help log timing info on any network burps
    logger -- ssh non-zero exit $? for "$@"
  fi
  if [[ -t 1 ]]; then
    stty sane
    # clear any title bar spam and ensure cursor is visible subsequent
    # (civis hides the cursor)
    echo -ne "\e]2;\a$terminfo[cvvis]"
  fi
}

# ENOTUSED
#function h {
#  history -$(($LINES-3))
#}

function j {
  pgrep -u $USER -lf '(^|/)'vi '(^|/)'$EDITOR
  jobs -l
}

function lilypond {
  local MRF MRP

  if [[ -n "$1" ]]; then
    command lilypond --silent -dno-point-and-click "$@"
  else
    # \include files trip this up, so name those with an extra .
    # somewhere in the filename, e.g. voice1.inc.ly (or hide them in
    # a subdir)
    MRF="$(glf --exclude='[.](?!ly$)' '\.ly' .)"

    if [[ -z $MRF ]]; then
      echo >&2 "no *.ly found (or glf problem)"
      return 1
    fi

    MRP=${MRF%%ly}pdf

    [[ ! -e $MRP || $MRF -nt $MRP ]] && {
      command lilypond --silent -dno-point-and-click $MRF
    }
  fi
}

function pmr {
  local -a midi_file

  if [[ -n "$1" ]]; then
    if [[ $1 == *.ly || -e $1.ly ]]; then
      lilypond $1
    elif [[ -f ${1:r}.ly ]]; then
      lilypond ${1:r}.ly
    else
      midi_file=($1)
    fi
  fi

  (( $#midi_file )) || midi_file=(*.midi(om[1]))

  ~/libexec/player $midi_file
}

function pmt {
  # no, I don't use Module::Build nor dzil
  make realclean; perl Makefile.PL && make && make test |& less
}

# ^D out of sqlite3 not clean (don't want to waste brain space on .q)
function sqlite3 {
  command sqlite3 "$@"
  echo
}

# Play most recently modified MIDI if nothing passed (via custom wrapper
# that inspects *.ly if available and reads timidity options from
# special comment therein)
function timidity {
  if [[ -n "$1" ]]; then
    command tlymidity "$@"
  else
    command tlymidity *.midi(om[1])
  fi
}

function vagrant {
  # KLUGE no option to de-colorize the output, so hide terminal :(
  command vagrant "$@" | cat
}

########################################################################
#
# Aliases

alias ack='ack --nocolor'

alias anykey="getraw -o '*:+'"

alias arp='arp -n'

alias atonal-util='atonal-util --ly --flats'

# GNU license spam :(
alias clisp='clisp -q -q -on-error abort -modern'

# preserve permissions by default (also for scp, below)
alias cp='cp -p'

alias diff='diff -u'

alias dig='dig +nocmd +nostats'

# part of the "tl;dr" toolkit.
alias dr=:

alias findin='findin -q'

# "history share"
alias hs='fc -RI'

alias ipcalc='ipcalc -n'

#unalias grep 2>/dev/null        # in event vendor set color crap somehow
#unalias ls 2>/dev/null          # "

# but in the event I want to see the local time... (another bad habit)
alias mydate="TZ=US/Pacific mydate -dt"

# As I'm usually running netstat when things are broken, and then it stalls
# trying to lookup broken things, and then you're C-cing and swearing and
# loosing time on troubleshooting...
alias netstat='netstat -n'

# but do need local timezone when reading labels off of bottles
alias now='TZ=US/Pacific now'

# GNU license spam :(
alias octave='octave --silent'

alias prove='prove --nocolor --blib'

alias psql='psql -A -q -S'

# R license spam :(
alias R='R --silent'

alias sbcl='sbcl --noinform'

alias scp='scp -p'

# from 'Bash to Z Shell' book (`stty tostop` might also be handy to halt
# anything backgrounded if it tries to spam the console)
alias stop='kill -TSTP'
# TODO need hammertime
#
# Another fun thing for terminal foo:
#   printf '%q\n' "$(tput cup 3 10)"

alias sudo='sudo -H'

alias xmllint="xmllint --encode utf8"

if [[ $OSTYPE == darwin* ]]; then
  alias bbedit="bbedit -b"
  alias ldd='otool -L'
  alias top='top -o CPU -F'

  # as typing CamelCase sucks
  alias vbm='VBoxManage -q'

  # over in scripts repository -- jmates@ 2014-07-04
  # handy means for marking config files/wiki so folks know the who/when
  # directly and do not have to delve back through version control or whatnot
  function tagit {
    =tagit -id | pbcopy
  }

  # for ly-fu (install from MacPorts)
  export SCORE_VIEWER=mupdf-x11

  # clear titlebar spam, if any
  echo -ne "\e]2;\a"

elif [[ $OSTYPE =~ "openbsd" ]]; then
  alias pbcopy='xclip -in'
  alias pbpaste='xclip -out'

  # which is just a shell `exec xclip -in` wrapper (or fiddle with copycat.c)
  export CLIPBOARD=~/libexec/pbcopy

  function tagit {
    =tagit -id | xclip -in
  }

  zstyle ':completion:*:*:open:*' file-patterns '*.pdf:PDF\ files *(-/):directories'

  # for ly-fu
  export SCORE_VIEWER=mupdf
fi
