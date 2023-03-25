EXTRA ?= .
APP_DIR ?= $(shell pwd)
INC_DIR += $(APP_DIR)/include
BUILD_DIR ?= $(APP_DIR)/build
DST_DIR ?= $(APP_DIR)/build/$(EXTRA)/$(PLAT)

include $(TESTS_HOME)/scripts/riscv64.mk
include $(TESTS_HOME)/scripts/platform.mk

LIB_NAME := libc
LIB_MODE ?= m
INC_DIR += $(addsuffix /include/, $(addprefix $(TESTS_HOME)/lib/, $(LIB_NAME)))

LINK_LIBs  = $(sort $(LIB_NAME))

LIBs = $(addsuffix -$(ARCH).a, $(join $(addsuffix /build/$(PLAT)/, \
	$(addprefix $(TESTS_HOME)/lib/, $(LIB_NAME))), \
	$(LIB_NAME)-$(PLAT)-$(LIB_MODE) ))

include $(TESTS_HOME)/scripts/compile.mk

TARGET = $(NAME)-$(PLAT)
TARGET_REF = $(DST_DIR)/$(TARGET)

# ====================

default: build

$(LIB_NAME): %:
	$(MAKE) -C $(TESTS_HOME)/lib/$* LIB_MODE=$(LIB_MODE) ARCH=$(ARCH) archive

$(LIBs): $(LIB_NAME)

$(TARGET_REF).elf: $(OBJs) $(LIBs)
	@echo + LD "->" $(TARGET).elf 
	$(LD) $(LDFLAGS) -o $(TARGET_REF).elf --start-group $(LINKAGE) --end-group

build: $(TARGET_REF).elf
	@$(OBJDUMP) -d $(TARGET_REF).elf > $(TARGET_REF).txt
	@echo + OBJCOPY "->" $(TARGET_REF).bin
	@$(OBJCOPY) -S --set-section-flags .bss=alloc,contents -O binary $(TARGET_REF).elf $(TARGET_REF).bin

clean:
	rm -rf $(APP_DIR)/build/
	$(MAKE) -s -C $(TESTS_HOME)/lib/$* clean

.PHONY: default run build clean