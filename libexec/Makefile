all: votcana

votcana: votcana.m4 ../m4/cf.m4
	m4 votcana.m4 > votcana
	chmod +x votcana

clean:
	-rm votcana

# m4 only tested with OpenBSD flavor of m4
depend:
	echo 'm4_m4exit(0)' | m4 -P

.PHONY: clean depend
