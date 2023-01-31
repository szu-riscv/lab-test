#ifndef _LIBC_RISCV_H_
#define _LIBC_RISCV_H_

#include <encoding.h>

#define CSR_STR(s) #s

#define csr_read(csr) \
	({ \
		uint64_t temp; \
		__asm__ __volatile__("csrr %0, " CSR_STR(csr) "\n\r" \
				     : "=r"(temp) :: "memory"); \
		temp; \
	})

#define csr_write(csr, val) \
	  asm __volatile__("csrw " CSR_STR(csr) ", %0\n\r" :: "rK"(val) : "memory");

#define csr_set(csr, val) \
	  asm __volatile__("csrs " CSR_STR(csr) ", %0\n\r" :: "rK"(val) : "memory");
 
#define csr_clear(csr, val) \
	  asm __volatile__("csrc " CSR_STR(csr) ", %0\n\r" :: "rK"(val) : "memory");

#endif