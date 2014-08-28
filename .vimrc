" Cursed vendor defaults require many of these, or otherwise turning off
" all the bling vim is infested with. I'd be happy with vi, except for the
" lack of multiple undos, and maintaining marks through filters.

" If I wanted to play Pachinko, I would move to Japan. Instead, kill the
" horrible brace highliting "feature"
let loaded_matchparen = 1

set noedcompatible

set syntax=no
if version >= 600
  syntax off
endif

set noautoindent
set autoread
set autowrite
set nobackup
set nocindent
set cpoptions+=!$
set noautowriteall
set gdefault
set ignorecase
set nohlsearch
set noincsearch
set nojoinspaces
set nomodeline
set nomore
set nopaste
set noruler
set scrolloff=5
set shiftwidth=2
set shortmess=aoOItTW
set noshowcmd
set showmatch
set noshowmode
set nosmartindent
set tabstop=8
set notitle
set uc=0
set viminfo='10,\"100,:25,/25,n~/.vim/viminfo
set wrapscan
set wrap
set writeany

" to disable the annoying term blanking from the "alternate screen" see 
" http://hints.macworld.com/article.php?story=20110905185128781
set t_ti= t_te=

" To really learn the home row keys, perhaps play Dungeon Crawl Stone Soup
" using just the keyboard (character died because you hit the wrong key?
" that just means they aren't motor memory yet).
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" argh. hate the help popup.
map <F1> <Esc>
nmap <F1> <Esc>
imap <F1> <Esc>
" more things I hit by mistake
map <C-c> <nop>
map q <nop>
" what the heck is this?
map <S-K> <nop>

" easy saves, habit from growing up with load shedding
map g :w!

" easy file flipping
map v :w!:n
map V :w!:N

" code auto-formatting
" GNU indent (see .indent.pro)
map R :keepmark %!gindent -st
" Text::Autoformat
map T :keepmark .,$!autoformat
" Perl::Tidy
map t :keepmark %!perltidy

ab hbp #!/usr/bin/env perluse strict;use warnings;
ab DIAG use Data::Dumper; diag Dumper
ab DIAC use Data::Dumper::Concise::Aligned; diag DumperA
ab PUFF fprintf(stderr, "dbg
ab PUDD use Data::Dumper; warn Dumper
ab PUCC use Data::Dumper::Concise::Aligned; warn DumperA

if !exists("autocommands_loaded")
  let autocommands_loaded = 1

  " Workaround highly annoying 'more files to edit' (E173) bug
  au VimEnter * call VisitLastBuffer()

  " TODO mixing Perl, Perl tests, C then gets wacky, but whatevs, not
  " often a problem.
  au BufNewFile,BufRead *.c  call SetupForC()
  au BufNewFile,BufRead *.h  call SetupForC()

  au BufNewFile,BufRead *.ly call SetupForLy()

  function SetupForC()
    set autoindent
    set smartindent
    set cindent
  endfunction

  function SetupForLy()
    map t :!playit
  endfunction

  function VisitLastBuffer()
    if(argc()>1)
      last
      rewind
    endif
  endfunction
endif
