if [[ $OSTYPE =~ "^darwin" ]]; then
   # eff you Apple Terminal mouse reporting!
   if [[ $TERM_PROGRAM = Apple_Terminal ]]; then
      zmodload zsh/system
      local APPLE_TERMINAL_KLUGE
      # whoops, are multiple terminals opening from a window group or
      # someone spamming new? need to lock...
      zsystem flock -f APPLE_TERMINAL_KLUGE ~/.zlogin
      # aim for less fail if Terminal.app launched at startup as if not
      # in foreground all the rest of this just wastes CPU and time
      osascript -e 'tell application "Terminal" to activate'
      # control sequence to "de-iconify window" which luckily raises it to
      # the foreground
      echo -ne "\e[1t"
      # so that after a delay in event things are slow the horrible mouse
      # reporting thing can be taken out and shot
      osascript -e 'delay 0.5' -e 'tell application "System Events" to keystroke "r" using command down'
      # this of course would be so much easier if Apple deigned to put a
      # checkbox somewhere that would offer the ability to turn off mouse
      # reporting by default, but alas we must make do with buggy systems
      # as best we can.
      zsystem flock -u $APPLE_TERMINAL_KLUGE
   fi
fi
