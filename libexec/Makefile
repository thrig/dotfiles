all: cdda votcana xnest xomb

cdda: cdda.m4 ../m4/cf.m4
	m4 cdda.m4 > cdda
	chmod +x cdda

votcana: votcana.m4 ../m4/cf.m4
	m4 votcana.m4 > votcana
	chmod +x votcana

xnest: xnest.m4 ../m4/cf.m4
	m4 xnest.m4 > xnest
	chmod +x xnest

xomb: xomb.m4 ../m4/cf.m4
	m4 xomb.m4 > xomb
	chmod +x xomb

clean:
	-rm cdda votcana xnest xomb

# m4 only tested with OpenBSD flavor of m4
depend:
	echo 'm4_m4exit(0)' | m4 -P

.PHONY: clean depend
