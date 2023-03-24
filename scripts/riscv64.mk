ISA = riscv

ARCH ?= $(ISA)64
ARCHS = riscv64

ifeq ($(findstring $(ARCH), $(ARCHS)), "")
$(error Invalid ARCH)
endif

CROSS_COMPILE ?= /home/asker/tools/riscv_zfh/bin/riscv64-unknown-elf