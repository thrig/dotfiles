# RHEL sets colours by default, ugh! Turn off if stuck on bash-only host so
# can read things.
unalias ll 2>/dev/null
unalias l. 2>/dev/null
unalias ls 2>/dev/null
# die colors, die!
unset LS_COLORS
# whatevs
TERM=vt220
