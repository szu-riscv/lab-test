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

include $(TESTS_HOME)/scripts/compile.mk

TARGET = $(NAME)-$(PLAT)
TARGET_REF = $(DST_DIR)/$(TARGET)

clean:
	rm -rf $(APP_DIR)/build/

.PHONY: default run build clean