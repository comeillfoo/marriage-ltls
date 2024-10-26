SPIN=spin
CC=gcc
LD=gcc
MAKE?=make

MODELS=model_1_1 model_1_2 model_1_3 model_1_4 model_1_5 model_1_6 model_1_7

_space=$(noop) $(noop)
_comma=$(noop),$(noop)

all: help

help:
	@echo 'Targets:'
	@echo '. test-all: tests all models ($(subst $(_space),$(_comma)$(_space),$(MODELS)))'
	@echo
	@echo 'Test single specific model:'
	@for model in $(MODELS); do echo ". test-single-$${model} - tests $${model} both on allowed and forbidden cases"; done
	@echo
	@echo 'Test single model on allowed cases:'
	@for model in $(MODELS); do echo ". test-allowed-$${model} - tests $${model} but only for allowed cases"; done
	@echo
	@echo 'Test single model on forbidden cases:'
	@for model in $(MODELS); do echo ". test-forbidden-$${model} - tests $${model} but only for forbidden cases"; done


test-all: $(addprefix test-single-,$(MODELS))
	@echo 'All tests passed.'


build-allowed-%: %.pml
	@$(SPIN) -DENABLE_ALLOWED_CASES -a $< >/dev/null
	@$(LD) -DNXT -o pan pan.c

build-forbidden-%: %.pml
	@$(SPIN) -a $< >/dev/null
	@$(LD) -DNXT -o pan pan.c


test-allowed-%: %.pml clean
	@$(MAKE) --no-print-directory build-allowed-$(basename $<) 2>/dev/null
	@echo "TEST:$(basename $<):allowed"
	@./test.sh p1  0 'works on allowed cases'
	@./test.sh np1 1 'negation fails on allowed cases'

test-forbidden-%: %.pml clean
	@$(MAKE) --no-print-directory build-forbidden-$(basename $<) 2>/dev/null
	@echo "TEST:$(basename $<):forbidden"
	@./test.sh p1  1 'fails on forbidden cases'
	@./test.sh np1 0 'negation works on forbidden cases'

test-single-%: %.pml
	@echo "TEST:$(basename $<)"
	@$(MAKE) --no-print-directory test-allowed-$(basename $<) 2>/dev/null
	@$(MAKE) --no-print-directory test-forbidden-$(basename $<) 2>/dev/null


clean:
	@rm -f ./pan* _spin* ._n_i_p_s_ *.trail

.PHONY: clean
