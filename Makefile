all: .cwmrc .kshrc .muttrc .profile .tmux.conf .xsession .zshrc

.cwmrc: cwmrc.m4 m4/cf.m4
	m4 cwmrc.m4 > .cwmrc

.kshrc: kshrc.m4 m4/cf.m4
	m4 kshrc.m4 > .kshrc

.muttrc: muttrc.m4 m4/cf.m4
	m4 muttrc.m4 > .muttrc

.profile: profile.m4 m4/cf.m4
	m4 profile.m4 > .profile

.tmux.conf: tmux.m4 m4/cf.m4
	m4 tmux.m4 > .tmux.conf

.xsession: xsession.m4 m4/cf.m4
	m4 xsession.m4 > .xsession

.zshrc: zshrc.m4 m4/cf.m4
	m4 zshrc.m4 > .zshrc

clean:
	-rm .cwmrc .kshrc .muttrc .profile .tmux.conf .xsession .zshrc

# m4 only tested with OpenBSD flavor of m4
depend:
	expect -c 'package require Tcl 8.5'
	echo 'm4_m4exit(0)' | m4 -P
	perl -e 'use 5.24.0'

.PHONY: clean depend
