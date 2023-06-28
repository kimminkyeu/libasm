#include <stdio.h>

extern int ft_atoi_base(char *str, char *base);

int main(void) 
{
	char* original_string = "FF";
	char* base_hex = "0123456789ABCDEF";
	int decimal = ft_atoi_base(original_string, base_hex);
	printf("origin: %s, decimal: %d", original_string, decimal);
	return (0);
}
