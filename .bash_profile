# RHEL sets colours by default, ugh! Turn off if stuck on bash-only host so
# can read things. (otherwise, I use ZSH on my primary systems)
unalias ll 2>/dev/null
unalias l. 2>/dev/null
unalias ls 2>/dev/null
# die colors, die!
unset LS_COLORS
# whatevs
TERM=vt220

# avoid linux "helper" scripts
# http://seclists.org/fulldisclosure/2014/Nov/74
unset LESSOPEN LESSCLOSE

alias firefox='firefox -no-remote'
