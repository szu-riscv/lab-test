#include "common.h"

volatile int A[10];
volatile int b;
volatile signed char C[10];
int main() {
	A[0] = 0;
	A[1] = 1;
	A[2] = 2;
	A[3] = 3;
	A[4] = 4;

	b = A[3];
	A[5] = b;
	C[0] = 'a';
	assert(C[0] == 'a');
	C[1] = C[0];
	assert(C[1] == 'a');
	A[0] = (int)C[0];
	assert(A[0] == 'a');
	C[1] = 0x80;
	A[0] = (int)C[1];
	assert(A[1] == 1);
	assert(A[2] == 2);
	assert(A[3] == 3);
	assert(A[4] == 4);
	assert(b == 3);
	assert(A[5] == 3);
	assert(C[1] == 0xffffff80);
	assert(A[0] == 0xffffff80);

	return 0;
}
