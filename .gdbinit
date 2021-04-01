#set startup-with-shell off
set style enabled off
set confirm off
define hexdump
  if $argc == 1
    dump binary memory xxxxx $arg0 $arg0+256
  end
  if $argc == 2
    dump binary memory xxxxx $arg0 $arg0+$arg1
  end
  shell hexdump -C xxxxx
end
