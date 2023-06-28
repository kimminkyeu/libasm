/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_atoi_base.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: minkyeki <minkyeki@42SEOUL.KR>             +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/02/15 15:28:31 by minkyeki          #+#    #+#             */
/*   Updated: 2023/06/28 01:41:09 by kyeu             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stddef.h>
#include <string.h>
#include <strings.h>

void _skip_white_space(char* p_base)
{
	while (*p_base)
	{
		if (*p_base == '+' || *p_base == '-' \
				|| (*p_base >= 9 && *p_base <= 13) || *p_base == ' ')
			return;
		++p_base;
	}
}

static int	check_if_string_matches_base(char *str, char *base)
{
	while (*base)
	{
		if (*str == *base)
			return (1);
		++base;
	}
	return (0);
}


static size_t	is_valid_base(char* str, char* base)
{
	char	*p_base = base;

	_skip_white_space(p_base);
	size_t t = strlen(base);

	char lookUp[t + 1]; // 마지막 null화
	bzero(lookUp, t + 1);

	size_t  size_of_lookUp = 0;

	while (*base) {
		char current_char = *base;
		size_t i = 0;
		// scan lookUp table
		while (i < size_of_lookUp) 
		{
			if (lookUp[i] == current_char) return (0);
			++i;
		}
		lookUp[i] = current_char; // insert to lookup
		++size_of_lookUp;
		++base;
	}

	// 마지막으로 str 문자열의 내용이 모두 lookUp에 존재하는지 체크
	check_if_string_matches_base(str, lookUp);
	// if every char is unique, then OK>
	return (size_of_lookUp);
}


static int	find_base_index(char target, char *base)
{
	int	index;

	index = 0;
	while (*base)
	{
		if (*base == target)
			return (index);
		++base;
		++index;
	}
	return (0);
}

void skip_white_space(char *str)
{
	while (*str && ((*str == ' ') || (*str >= 9 && *str <= 13)))
		++str;
}

char get_sign_val(char *str)
{
	char sign = 1;
	while (*str && (*str == '+' || *str == '-'))
	{
		if (*str == '-')
			sign *= -1;
		++str;
	}	
	return sign;
}

// 아 이건 해독함수지;;
int	ft_atoi_base(char *str, char *base)
{
	/** long long	sign; */
	long long	sum = 0;
	long long	to_add;

	// (1) check if valid space
	size_t	size = is_valid_base(str, base); // returns 0 if invalid. else, returns true size of base (공백문자 제거)
	if (size == 0) return (0);

	skip_white_space(str); // 
	char sign = get_sign_val(str); // +, -가 나오면 부호를 끝까지 가져가기
								   
	while (*str)
	{
		to_add = find_base_index(*str, base);
		sum = (sum * size) + (long long)to_add;
		++str;
	}
	return ((int)(sum * sign));
}
