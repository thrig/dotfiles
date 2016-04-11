if [[ $OSTYPE =~ "^darwin" ]]; then
  # eff you Apple Terminal mouse reporting!
  if [[ $TERM_PROGRAM = Apple_Terminal ]]; then
    osascript -e 'tell application "System Events" to keystroke "r" using command down'
    # KLUGE osascript does not block, so pad to block shell hopefully
    # until after the script completes. Why Apple can't provide a
    # checkbox somewhere to always disable mouse reporting, well...
    sleep 1
  fi
fi
