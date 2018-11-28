: expt
dup 0> if dup 1 = if drop
else over swap 2 ?do over
* loop * then else dup 0= if
( they're coming to take me away )
  2drop 1 else
  abort then then
;
3 0 expt .s cr drop
3 1 expt .s cr drop
3 2 expt .s cr drop
3 3 expt .s cr drop
3 4 expt .s cr drop
3 5 expt .s cr drop
