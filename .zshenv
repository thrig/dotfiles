# no timezones that wobble, thank you very much
export TZ=UTC

# probably due to vendors whose rsync defaulted to RSH for far too long
export RSYNC_RSH='ssh -ax -o PreferredAuthentications=hostbased,publickey -o Cle
arAllForwardings=yes'

# can cause security warnings, but clever folks go-w those files
umask 002
