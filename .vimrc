syntax off
let loaded_matchparen = 1

set autoread autowrite
set backspace=0
set cpoptions+=!$
set expandtab
set gdefault
set ignorecase infercase
set makeprg=make\ %:r
set mouse=
set nojoinspaces nomodeline nomore noshowmode
set nrformats=
set scrolloff=2
set shiftwidth=4
set shortmess=aoOItTWS
set pastetoggle=<F2>
set t_Co=0
set tabstop=4
set ttimeoutlen=0
set updatecount=0
set viminfo='256,f0,<0,\"0,:0,/0,h,n~/.viminfo
set writeany

cabbrev Argedit argedit
cabbrev Redo redo
cabbrev Set set
cabbrev Setf setf
cabbrev Q q
cabbrev W w
cabbrev Wq wq

iabbrev hbp #!/usr/bin/env perl<CR>use 5.28.0;<CR>use warnings;<CR><Esc>:setf perl<CR>i
iabbrev hbt #!/usr/bin/env tclsh8.6<CR><Esc>:setf tcl<CR>i

map <F1> <nop>
nmap <F1> <nop>
imap <F1> <esc>

map q <nop>
map <S-K> <nop>

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

map <Leader>/ /<C-r>0
map <Leader>A :.,$!autoformat
map <Leader>a :.,$!autoformat<CR>
map <Leader>D :argdelete %<CR>:N<CR>
map <Leader>ca :%!copycat<CR>
map <Leader>cl :.!copycat -n<CR>
map <Leader>g :update<CR>
map <Leader>m :update<CR>:make<CR>
map <Leader>n :cnext<CR>

nnoremap <silent> [b :N<CR>
nnoremap <silent> ]b :n<CR>
nnoremap <silent> [B :first<CR>
nnoremap <silent> ]B :last<CR>

if !exists("autocommands_loaded")
  let autocommands_loaded = 1

  autocmd InsertEnter * echon ''
  autocmd CursorMoved * echon ''

  autocmd VimEnter * call StartupFoo()
  filetype on

  au BufNewFile,BufRead,BufEnter *.[1368] map <LocalLeader>t :update<CR>:!dmanview %<CR><CR>
  au BufNewFile,BufRead,BufEnter *.asd setf lisp
  au BufNewFile,BufRead,BufEnter *.gdb map <LocalLeader>t :update<CR>:!feed % egdb -q<CR><CR>
  au BufNewFile,BufRead,BufEnter *.h setf c
  au BufNewFile,BufRead,BufEnter *.ly setf lilypond
  au BufNewFile,BufRead,BufEnter *.t setlocal makeprg=prove\ --blib\ %:r

  autocmd FileType c setlocal cindent | map <LocalLeader>i :%!clang-format<CR>| iabbrev PUFF fprintf(stderr, "dbg

  autocmd FileType lilypond setlocal shiftwidth=2 | map <LocalLeader>t :w!<CR>

  autocmd FileType lisp setlocal lisp | setlocal shiftwidth=2 | setlocal autoindent | setlocal showmatch | map <LocalLeader>i $?^(<CR>va):!lt<CR> | map <LocalLeader>t :update<CR>:!feed % sbcl --noinform<CR><CR>| iabbrev PUFF format t "~a~%"

  autocmd FileType lojban map <LocalLeader>t vip:!lojify<CR> | setlocal iskeyword+=-,',.

  autocmd FileType make setlocal noexpandtab

  autocmd FileType perl setlocal autoindent | setlocal cinkeys=0{,0},0),0],:,!^F,o,O,e | map <LocalLeader>i :%!perltidy<CR>| iabbrev DIAG diag Dumper | iabbrev DIAC use Data::Dumper::Concise::Aligned; diag DumperA| iabbrev PUDD warn Dumper | iabbrev PUCC use Data::Dumper::Concise::Aligned; warn DumperA

  autocmd FileType tcl setlocal autoindent | map <LocalLeader>t :update<CR>:!feed % tclsh8.6<CR><CR>

  autocmd FileType tex map <LocalLeader>t :!make %:r.pdf;mopen %:r.pdf<CR><CR>
endif

function StartupFoo()
  for f in argv()
    if isdirectory(f)
      echomsg "will not edit directory " . f
      quit
    endif
  endfor
  " work around the 'more files to edit' (E173) bug
  if(argc()>1)
    last
    rewind
  endif
endfunction
