#include <stddef.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>

extern size_t ft_strlen(const char* str);
extern char * ft_strcpy(char * dst, const char * src);
extern ssize_t ft_write(int fd, const void *buf, size_t count);
extern ssize_t ft_read(int fd, void *buf, size_t count); 
extern char * strdup(const char *s);

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
		printf("----------------------------\n");
		printf("|  ft_write                |\n");
		printf("----------------------------\n");
		ssize_t ret1 = write(-1, "hello\n", 6);
		perror("write");
		fprintf(stderr, "Return value of    write: %zd\n", ret1);
		ssize_t ret2 = ft_write(-1, "hello\n", 6);
		fprintf(stderr, "Return value of ft_write: %zd\n", ret2);
		perror("ft_write");
	}

	return (0);
}
