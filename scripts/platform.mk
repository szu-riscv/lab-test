PLAT_BASE_DIR = $(TESTS_HOME)/platform
PLAT ?= labcore
PLAT_DIR = $(PLAT_BASE_DIR)/$(PLAT)

PLAT_SRCs = $(shell find -L $(PLAT_DIR)/src -name "*.[cS]")
PLAT_INC = $(PLAT_DIR)/include

LINKER_PATH = $(PLAT_DIR)/linker.ld