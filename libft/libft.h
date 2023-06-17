#ifndef LIBFT_H
# define LIBFT_H

# include <stdlib.h>
# include <stdbool.h>

// Mandatory C functions

size_t ft_strlen(const char* s);

char *strcpy(char *dest, const char *src);

int strcmp(const char *s1, const char *s2);

ssize_t write(int fd, const void *buf, size_t count);

ssize_t read(int fd, void *buf, size_t count);

char *strdup(const char *s);

endif	/* LIBFT_H */
