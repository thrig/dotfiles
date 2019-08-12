include(`m4/cf.m4')dnl
divert(-1)
asociar(`CUR_HOME', `printf "$HOME"')
divert(0)dnl
export PATH HOME TERM
export ENV=CUR_HOME/.kshrc
