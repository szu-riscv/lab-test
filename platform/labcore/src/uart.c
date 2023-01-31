#include <platform.h>

#define UARTLITE_MMIO 0x40600000

void _exit(int code) {
  __asm__ volatile("mv a0, %0; .word 0x0005006b" : :"r"(code));
  while(1);
}


void console_putchar(char c) {
  uart_write(c);
}

void uart_write(char ch) {
  outb(UARTLITE_MMIO, ch);
}

void uart_read(char ch) {

}