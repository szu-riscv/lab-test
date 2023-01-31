LIB_DIR ?= $(shell pwd)
INC_DIR += $(LIB_DIR)/include/
DST_DIR ?= $(LIB_DIR)/build/$(PLAT)/
ARCHIVE ?= $(DST_DIR)/$(NAME)-$(PLAT)-$(LIB_MODE)-$(ARCH).a

## Default: Build a linkable archive (.a)
default: $(ARCHIVE)

INC_DIR += $(addsuffix /include/, $(addprefix $(TESTS_HOME)/lib/, $(LIBS)))
CFLAGS  += -fdata-sections -ffunction-sections -fno-builtin

include $(TESTS_HOME)/scripts/riscv64.mk
include $(TESTS_HOME)/scripts/compile.mk

## Compliation rule for objects -> .a (using ar)
$(ARCHIVE): $(OBJs)
	@mkdir -p $(dir $@)
	@echo + AR "->" $(notdir $(ARCHIVE))
	@$(AR) rcs $(ARCHIVE) $(OBJs)

clean: 
	rm -rf $(LIB_DIR)/build/