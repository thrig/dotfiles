# RHEL sets colours by default, ugh! Turn off if stuck on bash-only host so
# can read things.
unalias ll
unalias l.
unalias ls
# die colors, die!
unset LS_COLORS
# whatevs
TERM=vt220
