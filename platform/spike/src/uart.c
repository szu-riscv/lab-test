#include "htif.h"

void uart_write(char ch) {
  htif_console_putchar(ch);
}