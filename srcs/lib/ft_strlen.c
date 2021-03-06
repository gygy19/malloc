/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strlen.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jguyet <jguyet@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2017/02/20 19:00:54 by jguyet            #+#    #+#             */
/*   Updated: 2017/02/20 19:00:55 by jguyet           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#define MALLOC_PROG
#include "mallocstandard.h"

int		ft_strlen(char *str)
{
	int	i;

	i = 0;
	while (str[i])
		i++;
	return (i);
}
