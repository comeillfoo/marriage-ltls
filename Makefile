SPIN=spin
CC=gcc
LD=gcc

all: help

help:
	@echo 'Verification targets:'
	@echo
	@echo '. verify-NEVER: "Я никогда не выйду замуж"'
	@echo '. verify-EXACTLY_ONCE: "Я выйду замуж точно один раз"'
	@echo '. verify-NO_MORE_THAN_ONCE: "Я выйду замуж не более одного раза"'
	@echo '. verify-AT_LEAST_ONCE: "Я выйду замуж не менее одного раза"'
	@echo '. verify-EXACTLY_TWICE: "Я выйду замуж точно два раза"'
	@echo '. verify-NO_MORE_THAN_TWICE: "Я выйду замуж не более двух раз"'
	@echo '. verify-AT_LEAST_TWICE: "Я выйду замуж не менее двух раз"'
	@echo



verify-%: marriage.pml
	$(SPIN) -D$(subst verify-,,$@) -a $<
	$(LD) -DNXT -o pan pan.c
	./pan -a

clean:
	rm -f ./pan*
	rm -f _spin*
	rm -f ._n_i_p_s_
	rm -f *.trail

.PHONY: clean
