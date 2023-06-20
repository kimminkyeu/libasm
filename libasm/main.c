#include <stddef.h>
#include <stdio.h>

extern size_t ft_strlen(const char* str);

int main(void) {
	const char* str = "hello, world!";
	size_t len = ft_strlen(str);
	printf("[%s] len: %zd\n", str, len);
	return (0);
}
