#include "common.h"

volatile int A[10];
volatile int b;

int main() {
	A[0] = 0;
	A[1] = 1;
	A[2] = 2;
	A[3] = 3;
	A[4] = 4;

	b = A[3];
	A[5] = b;

	assert(A[0] == 0);
	assert(A[1] == 1);
	assert(A[2] == 2);
	assert(A[3] == 3);
	assert(A[4] == 4);
	assert(b == 3);
	assert(A[5] == 3);

	return 0;
}
