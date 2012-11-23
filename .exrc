set autowrite
"set noshowcmd
set ruler
set ic
set shiftwidth=2
set tabstop=8
set autoindent
set noedcompatible
set wrapscan
set showmode

map T !Gautoformat 
map t :%!perltidy

map v :w!:n
map V :w!:N
" need diff key, make M's control chars
"map V :w^M:!ispell -x %^M:e!^M^M

ab hbp #!/usr/bin/env perluse strict;use warnings;
ab PUDD use Data::Dumper; warn Dumper
map g :w!

map <f1> <nop>
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
