# RHEL sets colours by default, ugh! Turn off if stuck on bash-only host so
# can read things.
unalias ll 2>/dev/null
unalias l. 2>/dev/null
unalias ls 2>/dev/null
# die colors, die!
unset LS_COLORS
# no really.
unalias grep 2>/dev/null

# KLUGE eliminate super annoying "alternate screen" that blanks out
# the contents of the man page you were just reading when you exit
# from the pager. Also, reduce chances of color spam.
TERM=vt220

# avoid linux "helper" scripts
# http://seclists.org/fulldisclosure/2014/Nov/74
unset LESSOPEN LESSCLOSE
# various other handy things
export LESS="-iegX-j5"
export LESSHISTFILE=/dev/null
export LESSSECURE=1

alias firefox='firefox -no-remote'
