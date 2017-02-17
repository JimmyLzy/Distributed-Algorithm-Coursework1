
# distributed algorithms, n.dulay, 4 jan 17
# simple build and run makefile, v1

# Ziyang Liu(zl4214) and Hong Lu(hyl14)

.SUFFIXES: .erl .beam

MODULES  = system3 process3 app3 pl3 beb system32 system33 system34 system35 system36 process350 process30 process32
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

SYSTEM    = system3
L_SYSTEM  = system32
LL_SYSTEM = system33
LLL_SYSTEM  = system34
LLLL_SYSTEM = system35
LLLLL_SYSTEM  = system36

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

run3:	all
	$(L_ERL) -s $(LL_SYSTEM) start

run4:	all
	$(L_ERL) -s $(LLL_SYSTEM) start

run5:	all
	$(L_ERL) -s $(LLLL_SYSTEM) start

run6:	all
	$(L_ERL) -s $(LLLLL_SYSTEM) start


