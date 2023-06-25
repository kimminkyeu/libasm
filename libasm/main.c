#include <stddef.h>
#include <stdio.h>
#include <strings.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>


#ifdef __linux__
	#define FT_STRLEN(x)		_ft_strlen(x)
	#define FT_STRCPY(x, y)		_ft_strcpy(x, y)
	#define FT_WRITE(x, y, z)	_ft_write(x, y, z)
	#define FT_READ(x ,y, z)	_ft_read(x, y, z)
	#define FT_STRDUP(x)		_ft_strdup(x)
	extern size_t _ft_strlen(const char* str);
	extern char * _ft_strcpy(char * dst, const char * src);
	extern ssize_t _ft_write(int fd, const void *buf, size_t count);
	extern ssize_t _ft_read(int fd, void *buf, size_t count);
	extern char * _ft_strdup(const char *s);
#elif __APPLE__
	#define FT_STRLEN(x)		ft_strlen(x)
	#define FT_STRCPY(x, y)		ft_strcpy(x, y)
	#define FT_WRITE(x, y, z)	ft_write(x, y, z)
	#define FT_READ(x ,y, z)	ft_read(x, y, z)
	#define FT_STRDUP(x)		ft_strdup(x)
	extern size_t ft_strlen(const char* str);
	extern char * ft_strcpy(char * dst, const char * src);	
	extern ssize_t ft_write(int fd, const void *buf, size_t count);
	extern ssize_t ft_read(int fd, void *buf, size_t count); 
	extern char * ft_strdup(const char *s);
#endif


int main(void) {
	{
		printf("----------------------------\n");
		printf("|  ft_strlen               |\n");
		printf("----------------------------\n");
		const char *str = "Welcome to 42 Assembly language!";
		printf("[ strlen ]     %s : length is %zd\n", str,  strlen(str));
		printf("[ ft_strlen ]  %s : length is %zd\n", str,  FT_STRLEN(str));
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
		FT_STRCPY(dst, str);
		printf("After  : %s\n", dst);
	}
	{
		printf("----------------------------\n");
		printf("|  ft_write - with fd(-1)  |\n");
		printf("----------------------------\n");
		// (1)
		ssize_t ret1 = write(-1, "hello\n", 6);
		fprintf(stderr, "Return value of    write: %zd\n", ret1);
		if (ret1 < 0) perror("Error printed by perror");
		// (2)
		ssize_t ret2 = FT_WRITE(-1, "hello\n", 6);
		fprintf(stderr, "Return value of ft_write: %zd\n", ret2);
		if (ret2 < 0) perror("Error printed by perror");
	}
	{
		printf("----------------------------\n");
		printf("|  ft_write - with fd(1)  |\n");
		printf("----------------------------\n");
		ssize_t ret1 = write(1, "hello\n", 6);
		fprintf(stderr, "Return value of    write: %zd\n", ret1);
		ssize_t ret2 = FT_WRITE(1, "hello\n", 6);
		fprintf(stderr, "Return value of ft_write: %zd\n", ret2);
	}
	{
		char* buff = malloc(1000);
		bzero(buff, 1000);
		printf("----------------------------\n");
		printf("|  ft_read - with fd(2)  |\n");
		printf("----------------------------\n");
		ssize_t ret1 = read(2, buff, 1000);
		fprintf(stderr, "Result of Buff     read: %s\n", buff);
		fprintf(stderr, "Return value of    read: %zd\n", ret1);
		ssize_t ret2 = FT_READ(2, buff, 1000);
		bzero(buff, 1000);
		fprintf(stderr, "Result of Buff  ft_read: %s\n", buff);
		fprintf(stderr, "Return value of ft_read: %zd\n", ret2);
		free(buff);
	}





	return (0);
}
