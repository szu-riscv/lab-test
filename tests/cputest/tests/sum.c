#include "common.h"

int main() {
	int i = 1;
	volatile int sum = 0;
	while(i <= 100) {
		sum += i;
		i ++;
	}

	assert(sum == 5050);

	return 0;
}
