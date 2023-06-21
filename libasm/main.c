#include <stddef.h>
#include <stdio.h>
#include <string.h>

extern size_t ft_strlen(const char* str);
extern char * ft_strcpy(char * dst, const char * src);

int main(void) {
	{
		printf("----------------------------\n");
		printf("|  ft_strlen               |\n");
		printf("----------------------------\n");
		const char *str = "Welcome to 42 Assembly language!";
		printf("[ strlen ]     %s : length is %zd\n", str,  strlen(str));
		printf("[ ft_strlen ]  %s : length is %zd\n", str,  ft_strlen(str));
	}

	{
		printf("----------------------------\n");
		printf("|  ft_strcpy               |\n");
		printf("----------------------------\n");
		const char *str = "HELLOWORLD";
		char dst[11];
		for (int i = 0; i < 10; i++)
			dst[i] = i + '0';
		dst[10] = '\0';
		printf("Before : %s\n", str);
		ft_strcpy(dst, str);
		printf("After  : %s\n", dst);
	}

	{

	}

	return (0);
}
