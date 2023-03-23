#include "htif.h"


void _exit(int code) {
  htif_poweroff();
  while(1);
}

void console_putchar(char c) {
  uart_write(c);
}

void uart_write(char ch) {
  htif_console_putchar(ch);
}