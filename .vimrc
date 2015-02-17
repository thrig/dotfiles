" The RHEL defaults (ugh) prompted many of these settings. I'd be happy with vi,
" except for the lack of multiple undos, and maintaining marks through filters.

" kill horrible brace highliting "feature"
let loaded_matchparen = 1

set noedcompatible

" http://trout.me.uk/synhi.jpg
set syntax=no
if version >= 600
  syntax off
endif

set autoread
set nobackup
set nocindent
set cpoptions+=!$
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
set notitle
set uc=0
set viminfo='10,\"100,:25,/25,n~/.vim/viminfo
set wrapscan
set wrap
set writeany

set autoindent
set nosmartindent
set nocindent

set textwidth=0

set tabstop=8

let _curfile = expand("%:t")
if _curfile =~ "Makefile" || _curfile =~ "makefile" || _curfile =~ ".*\.mk"
  set noexpandtab
else
  set expandtab
  set shiftwidth=2
endif

" more "Practical Vim" stuff
set wildmenu
set wildmode=full

" treat all numerals (for c-a, c-x) as decimals
"set nrformats=

" to disable the annoying term blanking from the "alternate screen" see also
" http://hints.macworld.com/article.php?story=20110905185128781
set t_ti= t_te=

" Avoid bad habits, keep fingers on home row.
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

" what the heck is this?
map <S-K> <nop>

" no splits.
map <C-w> <nop>

" Easy saves, habit from growing up with load shedding
map g :w!<CR>

" Easy file flipping (used to be v/V); do not like the wrap-around on
" bnext/bprev, so use next and previous (I only "argadd" to tack files onto the
" arg list, so can mostly ignore whatever superset the buffer list is of the
" arg list), and save comes from autowrite so don't have to think about whether
" or not some previous buffer is saved or not.
set autowrite
set noautowriteall
nnoremap <silent> [b :N<CR>
nnoremap <silent> ]b :n<CR>
nnoremap <silent> [B :first<CR>
nnoremap <silent> ]B :last<CR>

" code auto-formatting
" GNU indent (see .indent.pro)
map R :keepmark %!gindent -st
" Text::Autoformat
map T :keepmark .,$!autoformat
" Perl::Tidy
map t :keepmark %!perltidy

ab hbp #!/usr/bin/env perl<CR>use strict;<CR>use warnings;<CR>
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
    set shiftwidth=4
  endfunction

  function SetupForLy()
    " Show music (if not already loaded) and play it (unless speaker muted).
    " A major reason I switched to OpenBSD as primary instead of Mac OS X
    " 10.10 is that Preview.app started scrolling automatically to the blank
    " bottom of the document, forcing a scroll back up to see the notes.
    " mupdf is delightfully free of such an annoyance.
    map t :!playit<CR><CR>
  endfunction

  function VisitLastBuffer()
    if(argc()>1)
      last
      rewind
    endif
  endfunction
endif
