PLAT_BASE_DIR = $(TESTS_HOME)/platform
PLAT ?= labcore

PLATS := labcore spike

ifeq ($(findstring $(PLAT), $(PLATS)), "")
$(error Invalid platform, please set correct value such as PLAT=$(PLATS))
endif

# ifeq ($(PLAT), "spike")
# 	CFLAGS += -DPLAT_SPIKE
# endif
PLAT_DIR = $(PLAT_BASE_DIR)/$(PLAT)


PLAT_SRCs = $(shell find -L $(PLAT_DIR)/src -name "*.[cS]")
PLAT_INC = $(PLAT_DIR)/include

LINKER_PATH = $(PLAT_DIR)/linker.ld