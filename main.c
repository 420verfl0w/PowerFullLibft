#include "lib/libft.h"
#include <stdio.h>

int main(void)
{
	char buf[0x100];

	//        rdi   rsi  rdx
	ft_memset(buf, 'a', sizeof(buf));

	printf("%s\n", buf);

	return (0);
}
