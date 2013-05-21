# NOTE not yet my actual ~/.zshrc, mostly example configs selected from
# what I currently have.

# as for NOMATCH, bash can be fixed via the 'failglob' option
setopt BSD_ECHO EXTENDED_HISTORY HASH_CMDS HIST_FIND_NO_DUPS HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS HIST_SAVE_NO_DUPS INC_APPEND_HISTORY INTERACTIVE_COMMENTS LIST_PACKED LIST_ROWS_FIRST MAGIC_EQUAL_SUBST NOFLOW_CONTROL RM_STAR_SILENT NOMATCH EXTENDED_GLOB
unsetopt AUTO_NAME_DIRS AUTO_REMOVE_SLASH HIST_VERIFY MARK_DIRS promptcr

########################################################################
#
# Environment (never export *HIST* nor prompt vars nor anything else
# shell-internal-use-only)

# NOTE these must be set *before* any bindkey calls, especially if the
# editor differs from the line editing mode. Also, other applications
# (e.g. Subversion, git) may have their own editor commands, check for
# their environment variables or configuration for details.
export EDITOR=vi
export VISUAL=vi

# hopefully FTP dies one of these years...
export FTP_PASSIVE=1

export GIT_SSH=$HOME/libexec/git_ssh

# Smallish history - if it was important, it should have been in a
# Makefile, or moved to a script, or put on a wiki, or whatever. No
# point in bogging each and every shell down with a massive history.
HISTFILE=~/.zsh/history
HISTSIZE=500
SAVEHIST=4000

export LANG=en_US.UTF-8

# to disable the annoying term blanking from the "alternate screen" see
# http://hints.macworld.com/article.php?story=20110905185128781
export LESS="-iegX"
export LESSHISTFILE=/dev/null
export LESSSECURE=1

# annoying distraction
MAILCHECK=0

# Default OS X list, minus tcl, which I do not use
export MANSECT=1:1p:8:2:3:3p:4:5:6:7:9:0p:l:p:o

# http_proxy set elsewhere
export no_proxy="127.0.0.1"

export PAGER=less

export PERLDOC_PAGER='less -R' 

# disabling as probably should fix encoding in various scripts, not force
# it to UTF-8 here (which in turn can cause DBI to fail to build)
#export PERL_UNICODE=ALS

# helps automate builds, also set
# 'prerequisites_policy' => q[follow], in your .cpan/CPAN/MyConfig.pm
# or use cpanm
export PERL_MM_USE_DEFAULT=1

# prompt - not having the machine name on remote logins is a bit too
# minimal for my tastes.
if [[ -n $SSH_CLIENT ]]; then
  PS1='%m%# '
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
# Completion Foo

fpath=(~/.zsh/functions $fpath)

if [[ $OSTYPE =~ "^darwin" ]]; then
  fpath=(~/.zsh/functions/darwin $fpath)
elif [[ $OSTYPE =~ "openbsd" ]]; then
  fpath=(~/.zsh/functions/openbsd $fpath)
fi

# for my _dig completion script
typeset -aU dns_servers
dns_servers=(128.95.120.1 8.8.4.4)

autoload -U compinit edit-command-line select-word-style
compinit

zstyle -e ':completion:*' hosts 'reply=($(< ~/.hosts))'

# might set this for all commands if have a large userbase
zstyle ':completion:*:(rsync|scp|ssh|telnet):*' users root $USER

zstyle ':completion:*' special-dirs ..

zstyle ':completion:*:*:lilypond:*' file-patterns '*.ly:lilypond\ files *(-/):directories'
zstyle ':completion:*:*:(pianoteq|timidity|tlymidity):*' file-patterns '*.(mid|MID|midi):MIDI\ files *(-/):directories'

zstyle ':completion:*:*:prove:*' file-patterns '*.t:test\ files *(-/):directories'

# Texty things do not need to find binary things 99.x% of time
zstyle ':completion:*:*:(bbedit|di|diff|less|vi|vim):*:all-files' ignored-patterns '*.o' '*.ps' '*.pdf' '*.midi' '*.mp3' '*.wav'

# Commands to ignore completion on as they 99.N% of the time just delay
# me getting to what I want
zstyle ':completion:*:*:-command-:*' ignored-patterns '(libtool|limit|link|linkicc|lipo|lispmtopgm|listings-ext.sh|listres|lilymidi|lilypond-book|lilypond-invoke-editor|lilysong|perlivp*|perlthanks*|perlbug*|perlcc*|perltex*|cron|*-config|libnetcfg*)'

if [[ $OSTYPE =~ "^darwin" ]]; then
  zstyle ':completion:*:processes' command 'ps -A -o pid,user,command'
  zstyle ':completion:*:*:open:*:all-files' ignored-patterns '*.ps' '*.ly'
fi

########################################################################
#
# Key Bindings

# Never did figure out how to get along with vi mode in shell, despite
# only using vi to edit things. go figure. NOTE this must be set *after*
# any EDITOR/VISUAL settings. (And then any customized bindkeys after
# this mode setting.)
bindkey -e

zle -N edit-command-line
# no, I don't use "VISUAL" or whatever ^v does by default (if I needed
# to I would `zsh -f` and then use it there)
bindkey "^v" edit-command-line
bindkey "^t" push-line-or-edit

# lets me know whether I'm in tmux (formerly screen) or not
bindkey "^P" up-history

# bad habits die hard
select-word-style bash

########################################################################
#
# Functions

function cd {
  if [[ -z "$1" ]]; then
    builtin cd
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

# ugh, both GNU license spam, and then lack of echo when ^D out. bleh.
function gdb {
  command gdb -q "$@"
  echo
}

# "go home" or "go work" being the two most common places I SSH to...
# (there's a ~/.ssh/config entry that include 'gh' or 'gw' as a 'Host'
# option, and then 'Hostname' of the IP address of the actual server)
function gh {
  ssh gh "$@"
  if [ -t 1 ]; then
    # some vendors put crap in the title bar, clear it
    echo -ne "\e]2;\a"
    clear
    stty sane
  fi
}

function ghre {
  ssh -t gh tmux attach
  if [ -t 1 ]; then
    echo -ne "\e]2;\a"
    clear
    stty sane
  fi
}

function gw {
  ssh gw "$@"
  if [ -t 1 ]; then
    echo -ne "\e]2;\a"
    clear
    stty sane
  fi
}

function gwre {
  ssh -t gw tmux attach
  if [ -t 1 ]; then
    echo -ne "\e]2;\a"
    clear
    stty sane
  fi
}

function lilypond {
  if [[ -n "$1" ]]; then
    command lilypond --silent -dno-point-and-click "$@"
  else
    # \include files trip this up, so name those with an extra .
    # somewhere in the filename, e.g. voice1.inc.ly
    command lilypond --silent -dno-point-and-click "$(glf --exclude='[.](?!ly$)' '\.ly' .)"
  fi
}

function ndir {
  NDIR=`buildir -p "$@" | tail -1`
  [[ $? -ne 0 ]] && exit $?
  builtin cd "$NDIR"
}

function pmr {
  pianoteq --preset D4\ Spacious --midi "$(glf .midi)"
}

function pmt {
  make realclean; perl Makefile.PL && make && make test |& less
}

function showscore {
  if [[ -n "$1" ]]; then
    # Not really happy with any PDF viewer thus far, but Preview.app no
    # worse than the rest. sigh.
    open --background -a Preview "$@"
#   xpdf -remote music -exec "gotoLastPage" "$@"
  else
    open --background -a Preview "$(glf '\.pdf' .)"
  fi
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
    command tlymidity "$(glf '\.midi' .)"
  fi
}

########################################################################
#
# Aliases

alias ,,="clear; cd"

alias ack='ack --nocolor'

alias anykey="getraw -o '*:+'"

alias arp='arp -n'

alias atonal-util='atonal-util --ly --flats'

# GNU license spam :(
alias clisp='clisp --quiet -on-error abort -modern'

# preserve permissions by default
alias cp='cp -p'

alias diff='diff -u'

alias dig='dig +nocmd +nostats'

alias findin='findin -q'

# "history share"
alias hs='fc -RI'

# NOTE this will fail on Linux, which places GNU indent as indent
alias indent='gnuindent'

alias ipcalc='ipcalc -n'

alias j='jobs -l'

unalias ls 2>/dev/null          # in event vendor set color crap somehow

# but in the event I want to see the local time... (another bad habit)
alias mydate="TZ=US/Pacific mydate -dt"

alias netstat='netstat -n'

# GNU license spam :(
alias octave='octave --silent'

alias prove='prove --nocolor --blib'

alias psql='psql -A -q -S'

# R license spam :(
alias R='R --silent'

alias scp='scp -p'

alias sudo='sudo -H'

alias tcpdump='tcpdump -n'

# as typing CamelCase sucks
alias vbm='VBoxManage -q'

alias warlock='which'

alias xmllint="xmllint --encode utf8"

if [[ $OSTYPE =~ "^darwin" ]]; then
  alias bbedit="bbedit -b"
  alias ldd='otool -L'
  alias top='top -o CPU -F'
  # rm means rm. -- except gnawing away at laptop HD, le sigh
  #alias rm='srm -s -z'

  function tagit {
    =tagit -ndi | pbcopy
  }

  # clear titlebar spam, if any
  echo -ne "\e]2;\a"

elif [[ $OSTYPE =~ "openbsd" ]]; then
  alias pbcopy='xclip -in'
  alias pbpaste='xclip -out'

  function tagit {
    =tagit -ndi | xclip -in
  }

  # for ly-fu
  export SCORE_VIEWER=zathura
fi
