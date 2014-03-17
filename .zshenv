# No timezones that wobble, thank you very much. I have been paged too
# many times due to things breaking at oh-whoops-there-was-no-02:00 to
# tolerate timezones that break things twice per year.
export TZ=UTC

# probably due to vendors whose rsync defaulted to RSH for far too long
export RSYNC_RSH='ssh -ax -o PreferredAuthentications=hostbased,publickey -o Cle
arAllForwardings=yes'

# can cause security warnings, but clever folks go-rwx those files
umask 002

# PATH setup for ZSH: arrays > annoying ${PATH:+$PATH:}$foo or, worse,
# forking out to awk(1) for each and every path element. If concerned
# about building PATH for each new shell, setup a Makefile or something
# that generates a static bit of text for ZSH to read.
#
# NOTE be sure to disable "path helper" in /etc/zshenv on Mac OS X (and
# to include any of the paths in finds in your setup, if and only if
# necessary). Also beware being too loose with globs, as things like 
# /usr/X11/bin and /usr/X11R6/bin often point to the same place, and 
# `typeset -U` may not exclude that same directory, depending on how
# things are symlinked. (Or one might glob some network file share,
# which would doubtless be as reliable and speedy as network file shares
# are wont to be.)

typeset -U path

# Wipe out everything and start from scratch. Opinions vary on whether
# or not this is a good idea, especially in .zshenv, which in most cases
# might get by just fine with the inherited PATH, depending on what you
# expect to run via SSH or otherwise non-interactive interfaces. For
# example, a laptop you never SSH to might set PATH elsewhere, while a
# system you SSH to run commands on may need the directories those
# commands reside in added to PATH via .zshenv or other means.
#
# Need to set something here, as otherwise get a ":..." prefix which
# acts the same as "." in the PATH, which I in no way ever want in
# the PATH.
PATH=$HOME/bin

while read dirspec; do
  dirspec=$dirspec'(N/)'   # NOMATCH and only directories
  path+=( ${~dirspec} )
done << EOPATH
~/usr/$OSTYPE-$MACHTYPE/bin
~/*/bin
/usr/local/(s|)bin
/opt/local/(s|)bin
/usr/X11R6/bin
/usr/(s|)bin
/(s|)bin
EOPATH

# MANPATH and suchlike can also be setup in this fashion, but should not
# be done here, but instead only in .zshrc (unless you have a command
# run via SSH that needs MANPATH setup that early...)
export PATH
