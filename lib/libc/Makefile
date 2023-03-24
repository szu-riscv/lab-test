NAME = $(notdir $(realpath .))
include $(TESTS_HOME)/scripts/platform.mk
SRCs = $(shell find -L ./src/ -name "*.c") $(PLAT_SRCs)
INC_DIR += $(PLAT_INC)
include ../../scripts/lib.mk