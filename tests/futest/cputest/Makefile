
ALL = $(basename $(notdir $(shell find tests/. -name "*.c")))

all: $(addprefix Makefile., $(ALL))
	@echo "" $(ALL)

$(ALL): %: Makefile.%

Makefile.%: tests/%.c latest
	@/bin/echo -e "NAME = $*\nSRCs = $<\ninclude $${TESTS_HOME}/scripts/app.mk" > $@
	-@make  -f $@ $(MAKECMDGOALS)
	-@rm -f Makefile.$*

image: ;
default $(MAKECMDGOALS): all ;

clean:
	rm -rf Makefile.* build/

latest:

.PHONY: all run clean latest $(ALL)