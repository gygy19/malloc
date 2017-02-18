/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jguyet <jguyet@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2016/08/20 17:07:37 by jguyet            #+#    #+#             */
/*   Updated: 2017/02/15 19:41:55 by jguyet           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#define MALLOC_PROG
#include "mallocstandard.h"

/*
** <b>void			free(void *ptr)</b><br>
** Supprime la zone allouer *ptr.
*/
void	free(void *ptr)
{
	t_shield *s;

	if (ptr == NULL)
		return ;
	//printf("FREE\n");
	//printf("s->ptr = %p, potential->ptr = %p\n", ptr, ptr - sizeof(struct s_shield));
	s = (t_shield*)((char*)ptr - sizeof(struct s_shield));
	if (s == NULL)
	{
		//printf("FREE ->s == NULL\n");
		return ;
	}
	//printf("FREE s->size : %zu, addr : %p\n", s->size, s->ptr);
	s->free = TRUE;
	find_and_free_map();
}

/*
** <b>void			*malloc(size_t size)</b><br>
** Alloue une zone memoire de la taille size et
** retourne le pointer de debut.
*/
void	*malloc(size_t size)
{
	if (size < 1)
		return (NULL);
	t_shield	*result;

	if (!(result = get_shield(size)))
		return (NULL);
	result->free = FALSE;
	return (result->ptr);
}

/*
** <b>void			*realloc(void *ptr, size_t size)</b><br>
** Allonge la taille d'une zone et renvoi le nouveau
** pointer de debut.
*/
void	*realloc(void *ptr, size_t size)
{
	(void)ptr;
	(void)size;
	return (NULL);
}

void	print_zone(char *zone, t_map *map)
{
	t_shield *s;

	s = map->data;
	printf("%s : %p\n", zone, map);
	while (s)
	{
		if (s->free == FALSE)
			printf("[V] %p - %p : %zu octets\n", s->ptr, s->ptr + s->size, s->size);
		else
			printf("[X] %p - %p : %zu octets\n", s->ptr, s->ptr + s->size, s->size);
		s = s->next;
	}
}
/*
** <b>void			show_alloc_mem(void)</b><br>
** Affiche les zones disponibles TINY, SMALL, LARGE
*/
void	show_alloc_mem(void)
{
	t_map	*map;
	t_map	*next;

	map = getallmaps();
	next = map;
	while (next)
	{
		if (next->first == FALSE && next->zone == ZONE_TINY)
			print_zone("TINY", next);
		next = next->next;
	}
	next = map;
	while (next)
	{
		if (next->first == FALSE && next->zone == ZONE_SMALL)
			print_zone("SMALL", next);
		next = next->next;
	}
	next = map;
	while (next)
	{
		if (next->first == FALSE && next->zone == ZONE_LARGE)
			print_zone("LARGE", next);
		next = next->next;
	}
}

void	*test_malloc(size_t size)
{
	return (malloc(size));
}
