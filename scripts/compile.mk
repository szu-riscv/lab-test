# Cross Compilers
AS      = $(CROSS_COMPILE)-gcc
CC      = $(CROSS_COMPILE)-gcc
CXX     = $(CROSS_COMPILE)-g++
LD      = $(CROSS_COMPILE)-ld
OBJDUMP = $(CROSS_COMPILE)-objdump
OBJCOPY = $(CROSS_COMPILE)-objcopy

INC_FLAGS += $(addprefix -I, $(INC_DIR))

OBJs = $(addprefix $(DST_DIR)/, $(addsuffix .o, $(basename $(SRCs))))

LINKAGE = $(OBJs) $(LIBs)

# -Wall 输出较多的警告讯息，以便找出程式的错误
# -ffreestanding : 允许重新定义标准库里已经有的函数
# -g : debug info
# -I : 
# -mcmodel : TODO: 
# -march 
COMMON_FLAGS += -march=rv64g
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

