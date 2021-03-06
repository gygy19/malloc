# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jguyet <jguyet@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2016/03/25 15:18:38 by jguyet            #+#    #+#              #
#    Updated: 2016/07/12 19:17:15 by jguyet           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ifeq ($(HOSTTYPE),)
	HOSTTYPE := $(shell uname -m)_$(shell uname -s)
endif

EXTENSION	=	.so

SPACE		=	_

NAMESTD		=	libft_malloc

NAME		=	$(addprefix $(addprefix $(addprefix $(NAMESTD), $(SPACE)), $(HOSTTYPE)), $(EXTENSION))

NAMELINK	=	$(addprefix $(NAMESTD), $(EXTENSION))

NAMEBASE    =   $(shell basename $(NAME))

LENGTHNAME	=	`printf "%s" $(NAMEBASE) | wc -c`

MAX_COLS	=	$$(echo "$$(tput cols)-20-$(LENGTHNAME)"|bc)

CC			=	gcc

FLAGS		=	-fPIC -W -Wall -Wextra -Werror -g3

SRCDIR		=	srcs/

OBJDIR		=	.objs/

INCDIR		=	includes/

SRCBASE		=	\
				main.c												\
				ft_mmap.c											\
				memory_finder.c										\
				maps.c												\
				free.c												\
				shield.c											\
				utils.c												\
				realloc.c											\
				search.c											\
				utils_two.c											\
				print.c												\
				print_zone.c										\
				lib/ft_itoabase.c									\
				lib/ft_putchar.c									\
				lib/ft_putnbr.c										\
				lib/ft_strlen.c										\
				lib/ft_putstr.c										\
				print_hexa_memory.c									\
				print_hexa_memory_suite.c

SRCS		=	$(addprefix $(SRCDIR), $(SRCBASE))

OBJS		=	$(addprefix $(OBJDIR), $(SRCBASE:.c=.o))

.SILENT:

all:
	if test -f $(NAME) ; then												\
		echo "make: Nothing to be done for \`all\`.";						\
	else																	\
		$(MAKE) -j $(NAME);													\
	fi
$(NAME):	$(OBJDIR) $(OBJS)
	$(CC) $(FLAGS) -shared -o $(NAME) $(OBJS) -I $(INCDIR)
	ln -sf $(NAME) $(NAMELINK)
	echo "MAKE   [$(NAMEBASE)]"

$(OBJDIR):
	mkdir -p $(OBJDIR)
	mkdir -p $(dir $(OBJS))

$(OBJDIR)%.o : $(SRCDIR)%.c | $(OBJDIR)
	$(CC) $(FLAGS) -MMD -c $< -o $@											\
		-I $(INCDIR)
	printf "\r\033[38;5;117m%s%*.*s\033[0m\033[K"							\
	"MAKE   "$(NAMEBASE)" plz wait ..."										\
		$(MAX_COLS) $(MAX_COLS) "($(@)))"

clean:
	if [[ `rm -R $(OBJDIR) &> /dev/null 2>&1; echo $$?` == "0" ]]; then		\
		echo -en "\r\033[38;5;101mCLEAN  "									\
		"[\033[0m$(NAMEBASE)\033[38;5;101m]\033[K";							\
	else																	\
		printf "\r";														\
	fi

fclean:		clean
	if [[ `rm $(NAME) &> /dev/null 2>&1; echo $$?` == "0" ]]; then			\
		echo -en "\r\033[38;5;124mFCLEAN "									\
		"[\033[0m$(NAMEBASE)\033[38;5;124m]\033[K";							\
	else																	\
		printf "\r";														\
	fi
	rm -rf $(NAMELINK)
	rm -rf test

test:
	cp $(NAME) libftmalloc.a
	gcc -o test0 tests/test0.c -I includes/ -L . -lft_malloc
	gcc -o test1 tests/test1.c -I includes/ -L . -lft_malloc
	gcc -o test2 tests/test2.c -I includes/ -L . -lft_malloc
	gcc -o test3 tests/test3.c -I includes/ -L . -lft_malloc
	gcc -o test3bis tests/test3bis.c -I includes/ -L . -lft_malloc
	gcc -o test4 tests/test4.c -I includes/ -L . -lft_malloc
	gcc -o test5 tests/test5.c -I includes/ -L . -lft_malloc
	echo "Test generated\n"

re:			fclean all

.PHONY:		fclean clean re

-include $(OBJS:.o=.d)

.PHONY: all clean fclean re
