#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(void)
{
	char buf[0x100];
	memset(buf, 'a', sizeof(buf));
	return (0);
}
