" http://trout.me.uk/synhi.jpg
syntax off

set mouse=

" too close to escape key, does never what I want
map <F1> <nop>
nmap <F1> <nop>
imap <F1> <esc>

" can't escape with escape from this and so rarely use
map q <nop>

map <S-K> <nop>

" arrow keys are a bad habit
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" like? need more? less?
cabbrev Wq wq

" disable annoying term blanking due to "alternate screen" (linux is
" very bad about this, unlike OpenBSD) this can also be set in tmux
" configuration or see tty/nukealtblank over in scripts repository
set t_ti= t_te=

" vim on RedHat is so annoying and non-standard that I've taken to
" compiling my own version of vim on it from scratch; various settings
" below may reflect the (ultimately futile) effort to mend RedHat vim
" back to a usable state

set noedcompatible

set timeoutlen=1000 ttimeoutlen=0

set cpoptions+=!$
set shortmess=aoOItTW

set nomodeline
set nomore
set nopaste
set noruler
set noshowmode
set noshowcmd
set notitle

set gdefault
set ignorecase
" for <C-p> completion to match case with what newly typed
set infercase
set noincsearch
set nohlsearch
set wrapscan
set wrap

set autoindent
set backspace=0
set expandtab
set nojoinspaces
set nocindent
set nosmartindent
set scrolloff=3
set shiftwidth=4
set tabstop=8
set textwidth=0

set autoread
set autowrite
set noautowriteall
set nobackup
set writeany
set uc=0

set viminfo='256,f0,<0,\"0,:0,/0,h,n~/.viminfo

set wildmenu
set wildmode=full

" kill horrible brace highlighting "feature"
let loaded_matchparen = 1
set noshowmatch

" treat all numerals (for c-a, c-x) as decimals
set nrformats=

" bracketed paste foo from http://stackoverflow.com/questions/5585129
" enabled by default for Mac OS X under iTerm.app or Terminal.app
"if &term =~ "xterm.*"
    let &t_ti = &t_ti . "\e[?2004h"
    let &t_te = "\e[?2004l" . &t_te
    function XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
    endfunction
    map <expr> <Esc>[200~ XTermPasteBegin("i")
    imap <expr> <Esc>[200~ XTermPasteBegin("")
    vmap <expr> <Esc>[200~ XTermPasteBegin("c")
    cmap <Esc>[200~ <nop>
    cmap <Esc>[201~ <nop>
"endif

map <Leader>/ /<C-r>0
map <Leader>A :.,$!autoformat
map <Leader>D :argdelete %<CR>:N<CR>
map <Leader>a :.,$!autoformat<CR>
map <Leader>ca :%!copycat<CR>
map <Leader>cl :.!copycat -n<CR>
" TODO this has problems; can instead pipe the register to copycat or
" pbcopy or what program?
map <Leader>cr :silent call system("enclippen " . shellescape("<C-r>0"))<CR>
map <Leader>g :update<CR>
map <Leader>m :update<CR>:make<CR>
map <Leader>n :cnext<CR>

nnoremap <silent> [b :N<CR>
nnoremap <silent> ]b :n<CR>
nnoremap <silent> [B :first<CR>
nnoremap <silent> ]B :last<CR>

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

iabbrev hbp #!/usr/bin/env perl<CR>use 5.24.0;<CR>use warnings;<CR><Esc>:setf perl<CR>i

if has("autocmd")
    if !exists("autocommands_loaded")
        let autocommands_loaded = 1

        autocmd VimEnter * call StartupFoo()
        filetype on

        au BufNewFile,BufRead,BufEnter *.[138] map <LocalLeader>t :update<CR>:!dmanview %<CR><CR>
        au BufNewFile,BufRead,BufEnter *.ex,*.exs setlocal shiftwidth=2 | map <LocalLeader>t :update<CR>:!feed % iex<CR><CR>
        au BufNewFile,BufRead,BufEnter *.gdb map <LocalLeader>t :update<CR>:!feed % gdb -q<CR><CR>
        au BufNewFile,BufRead,BufEnter *.ly setf lilypond
        " don't want vim guessing between Rexx, Rebol, or R
        au BufNewFile,BufRead *.r,*.R setf r
        au BufNewFile,BufRead,BufEnter *.t setlocal makeprg=prove\ --blib\ %:r
        au BufNewFile,BufRead,BufEnter *.zsh map <LocalLeader>t :update<CR>:!feed % zsh -f<CR><CR>

        autocmd FileType c map <LocalLeader>i :%!gindent -st<CR>| iabbrev PUFF fprintf(stderr, "dbg

        autocmd FileType go map <LocalLeader>i :%!gofmt<CR> | setlocal expandtab | setlocal tabstop=4 | set makeprg=go\ build\ %

        autocmd FileType lilypond setlocal shiftwidth=2 | setlocal makeprg=playit\ %\ nopager | map <LocalLeader>t :update<CR>:!playit %<CR><CR>

        autocmd FileType lisp setlocal lisp | setlocal showmatch | map <LocalLeader>t :update<CR>:!feed % sbcl --noinform<CR><CR>| iabbrev PUFF (format t "~a~%"

        autocmd FileType make setlocal noexpandtab

        autocmd FileType perl map <LocalLeader>i :%!perltidy<CR>| iabbrev DIAG use Data::Dumper; diag Dumper| iabbrev DIAC use Data::Dumper::Concise::Aligned; diag DumperA| iabbrev PUDD use Data::Dumper; warn Dumper| iabbrev PUCC use Data::Dumper::Concise::Aligned; warn DumperA

        autocmd FileType r map <LocalLeader>t :update<CR>:!feed % R -q --silent --no-save<CR><CR>

        autocmd FileType tcl map <LocalLeader>t :update<CR>:!feed % expect<CR><CR>
        autocmd FileType tex map <LocalLeader>t :!make %:r.pdf;mopen %:r.pdf<CR><CR>
    endif
endif

function StartupFoo()
    " KLUGE workaround highly annoying 'more files to edit' (E173) bug
    if(argc()>1)
        last
        rewind
    endif

    " never, ever edit a directory
    for f in argv()
        if isdirectory(f)
            echomsg "cowardly refusing to edit directory " . f
            quit
        endif
    endfor
endfunction

" reference for stuff I will hardly ever use but don't want to forget
"
" capture stuff with e.g. redir
"   :redir @b|sil let|redir end
"
"digraph n ñ
" <C-k>n? for ñ or <C-k>a' for á and ?I for ¿  and !I for ¡
" assuming utf-8 mapping
