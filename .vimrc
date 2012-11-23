let loaded_matchparen = 1

set noedcompatible

" Cursed vendor defaults require many of these, or otherwise turning off all
" the bling vim is infested with (I'd be happy with BSD vi, except for the
" lack of multiple undos, and maintaining marks through filters).
set noshowmode
set notitle
set autoread
set noshowcmd
set autowrite
set noautowriteall
set syntax=no
if version >= 600
  syntax off
  "highlight MatchParen NONE
endif
set noincsearch
set ignorecase
set shiftwidth=2
set nojoinspaces
set tabstop=8
set cpoptions+=!$
set nohlsearch
"set nowritebackup
set writeany
set viminfo='10,\"100,:25,/25,n~/.vim/viminfo
set shortmess=aoOItTW
set noruler
set nomodeline
set gdefault
set nobackup
"set backspace=2
set nopaste
set wrapscan
set wrap
set uc=0
set nomore
set showmatch

set noautoindent
set nosmartindent
set nocindent

set scrolloff=5

ab hbp #!/usr/bin/env perluse strict;use warnings;
ab PUDD use Data::Dumper; warn Dumper

" custom key definitions
map T :keepmark .,$!autoformat
map t :keepmark %!perltidy
map v :w!:n
map V :w!:N
map g :w!

" argh. hate the help popup.
map <F1> <Esc>
nmap <F1> <Esc>
imap <F1> <Esc>

" more things I hit by mistake
map <C-c> <nop>
" hmm, except qi still pops up that damn 'recording' thing. sigh.
map <q> <nop>
map <S-K> <nop>

" arrow keys form bad habits, purge
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

if !exists("autocommands_loaded")
  let autocommands_loaded = 1

  " Workaround highly annoying 'more files to edit' (E173) bug
  au VimEnter * call VisitLastBuffer()

  " TODO mixing Perl, Perl tests, C then gets wacky, but whatevs, not
  " often a problem.
  au BufNewFile,BufRead *.c call SetupForC()
  au BufNewFile,BufRead *.h call SetupForC()
  au BufNewFile,BufRead *.t call SetupForPerlTests()

  function SetupForC()
    map t :keepmark %!gnuindent -st
    set autoindent
    set smartindent
    set cindent
  endfunction

  function SetupForPerlTests()
    ab PUDD use Data::Dumper; diag Dumper
  endfunction

  function VisitLastBuffer()
    if(argc()>1)
      last
      rewind
    endif
  endfunction
endif
