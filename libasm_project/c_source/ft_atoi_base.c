/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_atoi_base.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: minkyeki <minkyeki@42SEOUL.KR>             +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/02/15 15:28:31 by minkyeki          #+#    #+#             */
/*   Updated: 2023/06/27 15:24:27 by kyeu             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stddef.h>
#include <string.h>
#include <strings.h>

static int	is_valid_1(char *base)
{
	char	*p_base = base;
	char	*compare;

	if (*p_base == '\0') return (0);

	// until null (base char 내부에 공백문자, +, -부호가 없어야 함)
	while (*p_base)
	{
		if (*p_base == '+' || *p_base == '-' \
				|| (*p_base >= 9 && *p_base <= 13) || *p_base == ' ')
			return (0);
		++p_base;
	}

	// base 랑 base 다음꺼를 비교하기 위함.
	// 목적은, 하나라도 중복 문자가 있는지 체크하기 위함.
	// 근데 이따구로 돌 바에 유일성 배열에 삽입하면서 출동나는지 체크하는게 낫지.
	size_t t = strlen(base);
	char lookUp[t];
	bzero(lookUp, t);

	while (*base) {
		char current_char = *base;
		int i = 0;
		int size_of_lookUp = 0;
		// scan lookUp table
		while (i < size_of_lookUp) {
			if (lookUp[i] == current_char) {
				// invalid base
			}
			++i;
		}
		lookUp[i] = current_char; // insert to lookup
		++size_of_lookUp;
		++base;
	}
	// if every char is unique, then OK>
	return (1);



	/**  */
	/** while (*(base + 1)) */
	/** { */
	/**     compare = base + 1; */
	/**     while (*compare) */
	/**     { */
	/**         if (*base == *compare) */
	/**             return (0); */
	/**         ++compare; */
	/**     } */
	/**     ++base; */
	/** } */
	/** return (1); */
}

static int	has_base(char *str, char *base)
{
	while (*base)
	{
		if (*str == *base)
			return (1);
		++base;
	}
	return (0);
}

static int	find_base_index_1(char target, char *base)
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

#include <string.h>

int	ft_atoi_base(char *str, char *base)
{
	/** long long	sign; */
	long long	sum = 0;
	long long	size = strlen(base);
	long long	to_add;

	// (1) check if valid space
	if (size < 2 || !is_valid_1(base))
		return (0);

	skip_white_space(str); // 
	char sign = get_sign_val(str); // +, -가 나오면 부호를 끝까지 가져가기
								   
	while (has_base(str, base))
	{
		to_add = find_base_index_1(*str, base);
		sum = (sum * size) + (long long)to_add;
		++str;
	}
	return ((int)(sum * sign));
}
