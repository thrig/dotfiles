\ XTerm Control Sequences - http://invisible-island.net/
\ so can bump the "ok" messages off to the right margin of the terminal
\ where they less clutter up the results
\   (only so doesn't work in PFE)
: cursorcol  ( colnum -- )  27 emit ." [" . ." G" ;
: clok       ( -- )         78 cursorcol ;
