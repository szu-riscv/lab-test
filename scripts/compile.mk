# Cross Compilers
AS      = $(CROSS_COMPILE)-gcc
CC      = $(CROSS_COMPILE)-gcc
CXX     = $(CROSS_COMPILE)-g++
LD      = $(CROSS_COMPILE)-ld
OBJDUMP = $(CROSS_COMPILE)-objdump
OBJCOPY = $(CROSS_COMPILE)-objcopy

INC_FLAGS += $(addprefix -I, $(INC_DIR))

OBJs = $(addprefix $(DST_DIR)/, $(addsuffix .o, $(basename $(SRCs))))

LIBs = $(addsuffix -$(ARCH).a, $(join $(addsuffix /build/labcore/, \
	$(addprefix $(TESTS_HOME)/lib/, $(LIB_NAME))), \
	$(LIB_NAME)-$(PLAT)-$(LIB_MODE) ))

LINKAGE = $(OBJs) $(LIBs)

# -Wall 输出较多的警告讯息，以便找出程式的错误
# -ffreestanding : 允许重新定义标准库里已经有的函数
# -g : debug info
# -I : 
# -mcmodel : TODO: 
# -march 
COMMON_FLAGS += -march=rv64g_zfh
CFLAGS += -ffreestanding -g -Wall $(INC_FLAGS) -mcmodel=medany $(COMMON_FLAGS)
CXXFLAGS +=  $(CFLAGS) -fno-rtti -fno-exceptions $(COMMON_FLAGS)
ASFLAGS  += -MMD $(INC_FLAGS) $(COMMON_FLAGS)

# -T FILE, --script FILE      Read linker script
# -melf64lriscv : TODO:
LDFLAGS += -T $(LINKER_PATH) -melf64lriscv

# ====================
# compile rule
# ====================
$(DST_DIR)/%.o: %.c
	@mkdir -p $(dir $@) 
	@echo + GCC $<
	@$(CC) -std=gnu11 $(CFLAGS) -c -o $@ $(realpath $<)

### Rule (compile): a single `.cpp` -> `.o` (g++)
$(DST_DIR)/%.o: %.cpp
	@mkdir -p $(dir $@) && echo + CXX $<
	@$(CXX) -std=c++17 $(CXXFLAGS) -c -o $@ $(realpath $<)

$(DST_DIR)/%.o: %.S
	@mkdir -p $(dir $@) && echo + AS $<
	@echo $(notdir $(OBJs))
	@$(AS) $(ASFLAGS) -c -o $@ $(realpath $<)

# ====================

default: build

archive: $(ARCHIVE)

$(LIB_NAME): %:
	@$(MAKE) -s -C $(TESTS_HOME)/lib/$* LIB_MODE=$(LIB_MODE) archive

$(LIBs): $(LIB_NAME)

$(TARGET_REF).elf: $(OBJs) $(LIBs)
	@echo + LD "->" $(TARGET).elf 
	$(LD) $(LDFLAGS) -o $(TARGET_REF).elf --start-group $(LINKAGE) --end-group

build: $(TARGET_REF).elf
	@$(OBJDUMP) -d $(TARGET_REF).elf > $(TARGET_REF).txt
	@echo + OBJCOPY "->" $(TARGET_REF).bin
	@$(OBJCOPY) -S --set-section-flags .bss=alloc,contents -O binary $(TARGET_REF).elf $(TARGET_REF).bin