" The RHEL defaults (ugh) prompted many of these settings. I'd be happy
" with vi, except for the lack of multiple undos, and maintaining marks
" through filters.
"
" Though, "Practical Vim" has shown some nifty things vim can do...

ab hbp #!/usr/bin/env perl<CR>use 5.14.0;<CR>use warnings;<CR><Esc>:setf perl<CR>i

" XTerm*colorMode:false in ~/.Xdefaults also good for killing wacky
" colors, or if you're in a hurry try TERM=vt220 to nix them
"
" http://trout.me.uk/synhi.jpg
set syntax=no
if version >= 600
    syntax off
endif

" nope.
set mouse=

" experiment w/ timouts
set timeoutlen=1000 ttimeoutlen=0

set noedcompatible

set ignorecase

" cursed vendor defaults require many of these
set noshowmode
set notitle
set noshowcmd
set noincsearch
set nojoinspaces
set cpoptions+=!$
set nohlsearch
set writeany
set viminfo='1000,f1,<500,\"1000,:25,/25,n~/.viminfo
set shortmess=aoOItTW
set noruler
set nomodeline
set gdefault

set nobackup
"set nowritebackup

"set backspace=2
set nopaste
set wrapscan
set wrap
set uc=0
set nomore

set textwidth=0

" hmmm. 
set autoindent
set nosmartindent
set nocindent
"set cinkeys-=0#
"set indentkeys-=0#

set scrolloff=5

set tabstop=8
set expandtab
set shiftwidth=4

" more "Practical Vim" stuff
set wildmenu
set wildmode=full

" preserve flags on repeated s///, "Practical Vim" tip (that I will doubtless
" forget how to use) yep forgot how to use
"nnoremap & :&&<CR>
"xnoremap & :&&<CR>

" treat all numerals (for c-a, c-x) as decimals
set nrformats=

" disable annoying term blanking due to "alternate screen"
" (can also be nixed from the terminfo files e.g. Linux has a bad case of this)
" http://hints.macworld.com/article.php?story=20110905185128781
set t_ti= t_te=

" custom key definitions
map <Leader>/ /<C-r>0
map <Leader>A :.,$!autoformat 
map <Leader>D :argdelete %<CR>:N<CR>
map <Leader>a :.,$!autoformat<CR> 
map <Leader>c :call system("enclippen " . shellescape("<C-r>0"))<CR>
map <Leader>g :update<CR>
map <Leader>m :update<CR>:make<CR>
map <Leader>n :cnext<CR>

" don't really use this...
"map <Leader>W :set noreadonly<CR>:call system("chmod +w -- " . shellescape(expand("%")))<CR>

set autoread
set autowrite
set noautowriteall
nnoremap <silent> [b :N<CR>
nnoremap <silent> ]b :n<CR>
nnoremap <silent> [B :first<CR>
nnoremap <silent> ]B :last<CR>

" argh. hate the help popup.
map <F1> <Esc>
nmap <F1> <Esc>
imap <F1> <Esc>

map <S-K> <nop>

" arrow keys form bad habits, like moving fingers from home row
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" nope hit this by mistake and then ESC don't ESC
map <q> <nop>

" kill horrible brace highliting "feature"
"let loaded_matchparen = 1
set noshowmatch

" assume UTF-8 by default. In the rare case not, will have to remember
" to do something else.
if has("multi_byte")
    set encoding=utf-8
    setglobal fileencoding=utf-8
endif

" Use the current filename as I more often have one-off scripts that
" share the same directory rather than some huge project, or a specific
" TeX file target. (lilypond gets a build-and-play-it script, below)
set makeprg=make\ %:r

if has("autocmd")
    if !exists("autocommands_loaded")
        let autocommands_loaded = 1

        autocmd VimEnter * call StartupFoo()
        filetype on

        au BufNewFile,BufRead,BufEnter *.1 map <LocalLeader>t :update<CR>:!dmanview %<CR><CR>
        au BufNewFile,BufRead,BufEnter *.gdb map <LocalLeader>t :update<CR>:!feed % gdb -q<CR><CR>
        au BufNewFile,BufRead,BufEnter *.ly setf lilypond
        au BufNewFile,BufRead,BufEnter *.t setlocal makeprg=prove\ --blib\ %:r
        au BufNewFile,BufRead,BufEnter *.zsh map <LocalLeader>t :update<CR>:!feed % zsh -f<CR><CR>

        autocmd FileType c map <LocalLeader>i :%!gindent -st<CR>| ab PUFF fprintf(stderr, "dbg

        " NOTE gforth probably requires
        "   ln -s /dev/null ~/.gforth-history
        " to avoid spamming history with near-duplicate feed runs
        " sigh, portability, pfe no worky on OS X and gforth no worky
        " on OpenBSD
        autocmd FileType forth map <LocalLeader>t :update<CR>:!feed % ~/libexec/aforth<CR><CR>

        autocmd FileType lilypond setlocal shiftwidth=2 | setlocal makeprg=playit\ %\ nopager | map <LocalLeader>t :update<CR>:!playit %<CR><CR>

        autocmd FileType lisp setlocal lisp | setlocal showmatch | map <LocalLeader>t :update<CR>:!feed % sbcl --noinform<CR><CR>| ab PUFF (format t "~a~%"

        autocmd FileType make setlocal noexpandtab

        autocmd FileType perl map <LocalLeader>i :%!perltidy<CR>| ab DIAG use Data::Dumper; diag Dumper| ab DIAC use Data::Dumper::Concise::Aligned; diag DumperA| ab PUDD use Data::Dumper; warn Dumper| ab PUCC use Data::Dumper::Concise::Aligned; warn DumperA

        autocmd FileType tcl map <LocalLeader>t :update<CR>:!feed % expect<CR><CR>

        autocmd FileType tex map <LocalLeader>t :!make<CR><CR>
    endif
endif

function StartupFoo()
    " KLUGE workaround highly annoying 'more files to edit' (E173) bug
    if(argc()>1)
        last
        rewind
    endif
    " never, ever edit a directory.
    for f in argv()
        if isdirectory(f)
            echomsg "cowardly refusing to edit directory " . f
            quit
        endif
    endfor
endfunction
