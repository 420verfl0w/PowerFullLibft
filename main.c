#include "lib/libft.h"
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
	char buf[0x100];

	ft_memset(buf, 'a', sizeof(buf));

	printf("%s\n", buf);

	return (0);
}
