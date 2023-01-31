#include "assert.h"

extern void _exit(int code);
__attribute__((noinline)) void assert(int cond) {
  if (!cond) _exit(1);
}