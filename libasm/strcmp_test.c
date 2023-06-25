#include <stddef.h>

int	ft_strcmp(const char *s1, const char *s2)
{
	const unsigned char	*s1_uchar;
	const unsigned char	*s2_uchar;

	s1_uchar = (const unsigned char *)s1;
	s2_uchar = (const unsigned char *)s2;

	while (*s1_uchar && *s2_uchar && (*s1_uchar == *s2_uchar))
	{
		s1_uchar++;
		s2_uchar++;
	}
	return ((int)(*s1_uchar - *s2_uchar));
}
