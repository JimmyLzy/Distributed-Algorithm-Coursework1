
# distributed algorithms, n.dulay, 4 jan 17
# simple build and run makefile, v1

# Ziyang Liu(zl4214) and Hong Lu(hyl14)

.SUFFIXES: .erl .beam

MODULES  = system2 process2 app pl system22
HOSTS    = 3
HOSTSm1  = 2

# BUILD =======================================================

ERLC	= erlc -o ebin

ebin/%.beam: %.erl
	$(ERLC) $<

all:	ebin ${MODULES:%=ebin/%.beam} 

ebin:	
	mkdir ebin

debug:
	erl -s crashdump_viewer start 

.PHONY: clean
clean:
	rm -f ebin/* erl_crash.dump

# LOCAL RUN ===================================================

SYSTEM    = system2
L_SYSTEM  = system22

L_HOST    = localhost.localdomain
L_ERL     = erl -noshell -pa ebin -setcookie pass
L_ERLNODE = node

run1:	all
	$(L_ERL) -s $(SYSTEM) start

# to run manually, run make node1 and make node2 in separate windows
# then make man2, remove manually
node1:	all
	$(L_ERL) -name $(L_ERLNODE)1@$(L_HOST)

node2:	all
	$(L_ERL) -name $(L_ERLNODE)2@$(L_HOST)
	
man2:	all
	$(L_ERL) -name $(L_ERLNODE)3@$(L_HOST) -s $(L_SYSTEM) start 

# to run and clean up automatically
run2:	all
	$(L_ERL) -s $(L_SYSTEM) start






















