" The RHEL defaults (ugh) prompted many of these settings. I'd be happy
" with vi, except for the lack of multiple undos, and maintaining marks
" through filters.
"
" Though, "Practical Vim" has shown some nifty things vim can do...

ab hbp #!/usr/bin/env perl<CR>use 5.14.0;<CR>use warnings;<CR>
ab DIAG use Data::Dumper; diag Dumper
ab DIAC use Data::Dumper::Concise::Aligned; diag DumperA
ab PUDD use Data::Dumper; warn Dumper
ab PUCC use Data::Dumper::Concise::Aligned; warn DumperA

" kill horrible brace highliting "feature"
let loaded_matchparen = 1

set noedcompatible

" http://trout.me.uk/synhi.jpg
set syntax=no
if version >= 600
  syntax off
endif

" nope.
set mouse=

" experiment w/ timouts
set timeoutlen=1000 ttimeoutlen=0

set ignorecase

set autoread
set nobackup
set nocindent
set cpoptions+=!$
set gdefault
set nohlsearch
set noincsearch
set nojoinspaces
set nomodeline
set nomore
set nopaste
set noruler
set scrolloff=5
set shortmess=aoOItTW
set noshowcmd
set showmatch
set noshowmode
set nosmartindent
set notitle
set uc=0
" may need mkdir ~/.vim at some point on new systems
set viminfo='1000,f1,<500,\"1000,:25,/25,n~/.vim/viminfo
set wrapscan
set wrap
set writeany

set autoindent
set nosmartindent
set nocindent

set textwidth=0

set tabstop=8
set expandtab
set shiftwidth=2

" more "Practical Vim" stuff
set wildmenu
set wildmode=full

" preserve flags on repeated s///, "Practical Vim" tip (that I will doubtless
" forget how to use)
" yep, no idea what these do, haven't used them.
"nnoremap & :&&<CR>
"xnoremap & :&&<CR>

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

" custom key definitions (prefix these with \ to obtain)
map <Leader>a :keepmark .,$!autoformat<CR> 
map <Leader>A :keepmark .,$!autoformat 
map <Leader>t :keepmark %!perltidy<CR>

map <Leader>D :argdelete %<CR>:N<CR>

" Easy saves, habit from growing up with load shedding
map <Leader>g :w!<CR>

" this opens a search on whatever is in the default register (mostly to avoid
" needing to type in the <C-r>0 bit)
map <Leader>/ /<C-r>0

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

" KLUGE assume UTF-8 by default
if has("multi_byte")
  "if &termencoding == ""
  "  let &termencoding = &encoding
  "endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
endif

" Use the current filename as I more often have one-off scripts that
" share the same directory rather than some huge project, or a specific
" TeX file target. (lilypond gets a build-and-play-it script, below)
" TODO warning messages getting picked up by :cnext ??
set makeprg=make\ %:r

if !exists("autocommands_loaded")
  let autocommands_loaded = 1

  if has("autocmd")
    filetype on
    autocmd FileType make setlocal noexpandtab
    autocmd FileType perl call SetupForPerl()
  endif

  " Workaround highly annoying 'more files to edit' (E173) bug
  au VimEnter * call VisitLastBuffer()

  au BufNewFile,BufRead,BufEnter *.c call SetupForC()
  au BufNewFile,BufRead,BufEnter *.ino call SetupForC()
  au BufNewFile,BufRead,BufEnter *.h call SetupForC()
  au BufNewFile,BufRead,BufEnter *.lisp call SetupForLISP()
  au BufNewFile,BufRead,BufEnter *.ly call SetupForLy()
  au BufNewFile,BufRead,BufEnter *.t call SetupForPerlTests()
  au BufNewFile,BufRead,BufEnter *.tex call SetupForTex()

  function SetupForC()
    setlocal shiftwidth=4
    " see .indent.pro
    map <Leader>i :keepmark %!gindent -st<CR>
    ab PUFF fprintf(stderr, "dbg
  endfunction

  function SetupForLISP()
    setlocal lisp
    " makes a temporary repl following the execution of the current document,
    " simpler if less featureful than a slime-like emulation.
    map <Leader>t :w!<CR>:!clisp -on-error abort -modern -q -q -repl %<CR><CR>
  endfunction

  function SetupForLy()
    " Show music (if not already loaded) and play it (unless speaker muted).
    " A major reason I switched to OpenBSD as primary instead of Mac OS X
    " 10.10 is that Preview.app started scrolling automatically to the blank
    " bottom of the document, forcing a scroll back up to see the notes.
    " mupdf is delightfully free of such an annoyance.
    map t :w!<CR>:!playit %<CR><CR>
    setlocal makeprg=playit\ %
  endfunction

  function SetupForPerl()
    " hmm, "i" for indent (gindent in c, or ...) and "t" for "try it out" ?
    map <Leader>i :keepmark %!perltidy<CR>
    map <Leader>t :keepmark %!perltidy<CR>
  endfunction

  function SetupForPerlTests()
    call SetupForPerl()
    setlocal makeprg=prove\ --blib\ --nocolor\ %:r
  endfunction

  function SetupForTex()
    map <Leader>t :w!<CR>:!dotex %<CR><CR>
  endfunction

  function VisitLastBuffer()
    if(argc()>1)
      last
      rewind
    endif
  endfunction
endif
