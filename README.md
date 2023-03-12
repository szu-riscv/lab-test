# Lab Test
Lab Test Project用于生成测试示例，以作为实验所设计的RISC-V核的测试激励。

# Submodule

## riscv-tests

riscv-tests是针对于RISC-V处理器设计的单元测试库。

使用下列命令下载父模块和子模块
```
git clone --recursive https://github.com/szu-riscv/lab-test.git
cd lab-test
```

或者

```
git clone https://github.com/szu-riscv/lab-test.git
cd lab-test
git submodule update --init --recursive
```

### 编译riscv-tests
```
cd riscv-tests/isa
make lab dir=rv64ui
```
变量dir默认为rv64ui，因此编译rv64ui下的源码可以直接执行`make lab`，dir可选择的值为`rv32mi  rv32si  rv32ua  rv32uc  rv32ud  rv32uf  rv32ui  rv32um  rv32uzfh  rv64mi  rv64mzicbo  rv64si  rv64ssvnapot  rv64ua  rv64uc  rv64ud  rv64uf  rv64ui  rv64um  rv64uzfh`。

编译完成后输出文件在`riscv-test/isa/build`下，`p`表示裸机物理地址测试，`v`表示在虚拟内存上测试（默认Sv39地址转换和保护方案）。在`p`或`v`路径下对应平台名的目录下有输出的二进制文件`*.bin`、可执行文件`*.elf`和反汇编文件`*.txt`（例如`lab-test/riscv-tests/isa/build/v/labcore/rv64ui-add-v-labcore.bin`）。


