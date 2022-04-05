#include <stdio.h>
#include <string.h>
#include <stdint.h>

int main(void)
{
	char buf[0x8];
	memset(buf, 'a', sizeof(buf));
	return (0);
}