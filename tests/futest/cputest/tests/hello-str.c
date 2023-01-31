#include "common.h"

char buf[128];

int main() {
	sprintf(buf, "%s", "Hello world!\n");
	assert(strcmp(buf, "Hello world!\n") == 0);

	sprintf(buf, "%d + %d = %d\n", 1, 1, 2);
	assert(strcmp(buf, "1 + 1 = 2\n") == 0);

	sprintf(buf, "%d + %d = %d\n", 2, 10, 12);
	assert(strcmp(buf, "2 + 10 = 12\n") == 0);

	return 0;
}
