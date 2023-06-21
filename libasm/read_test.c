#include <unistd.h>

ssize_t ft_read(int fd, void *buf, size_t count)
{
    return read(fd, buf, count);
}