" for vi(1) a.k.a. nex/nvi of OpenBSD
set autoindent
set autowrite
set ignorecase
set noedcompatible
set nomesg
set noruler
set noshowmode
set noverbose
set shiftwidth=4
set tabstop=8
set verbose
set wrapscan
set writeany

ab hbp #!/usr/bin/env perluse strict;use warnings;
ab PUDD use Data::Dumper; warn Dumper
ab PUCC use Data::Dumper::Concise::Aligned; warn DumperA
ab DIAG use Data::Dumper; diag Dumper
ab DIAC use Data::Dumper::Concise::Aligned; diag DumperA

" easy saves, habit from growing up with load shedding
map g :w!

map v :w!:next
map V :w!:prev

map T !Gautoformat 
map t :%!perltidy

" too close to esc, I'll find the help when I need it
map <f1> <nop>

" bad habits, nix these
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
