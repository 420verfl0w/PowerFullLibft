# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: stales <stales@42.fr>                      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/03/29 18:23:35 by stales            #+#    #+#              #
#    Updated: 2022/04/05 20:56:40 by stales           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#  Bash Color

green			:= \033[38;5;82m
blue			:= \033[38;5;75m
red				:= \033[38;5;196m
yellow			:= \033[38;5;226m

blinking		:= \033[5m
reset			:= \033[0m

font_color		:= $(blue)
bold			:= $(red)

define print_ascii
	@printf "$(red)"
	@printf "██▓     ██▓ ▄▄▄▄     █████▒▄▄▄█████▓\n"
	@printf "▓██▒    ▓██▒▓█████▄ ▓██   ▒ ▓  ██▒ ▓▒\n"
	@printf "▒██░    ▒██▒▒██▒ ▄██▒████ ░ ▒ ▓██░ ▒░\n"
	@printf "▒██░    ░██░▒██░█▀  ░▓█▒  ░ ░ ▓██▓ ░\n"
	@printf "░██████▒░██░░▓█  ▀█▓░▒█░      ▒██▒ ░\n"
	@printf "░ ▒░▓  ░░▓  ░▒▓███▀▒ ▒ ░      ▒ ░░\n"
	@printf "░ ░ ▒  ░ ▒ ░▒░▒   ░  ░          ░\n"
	@printf "  ░ ░    ▒ ░ ░    ░  ░ ░      ░\n"
	@printf "    ░  ░ ░   ░\n"
	@printf "                  ░\n"
	@printf "$(reset)"
endef

# **************************************************************************** #

# **************************************************************************** #
# config

BASE_SRC		:= ft_atoi.c
ASM_SRC			:= ft_memset.s
OBJ				:= $(BASE_SRC:.c=.o)
ASM_OBJ			:= $(ASM_SRC:.s=.o)
CFLAGS			:= -Wall -Wextra -Werror -I.
NAME			:= libft.a
LIBSHARE		:= libft.so
NASM			:= nasm

# **************************************************************************** #

# **************************************************************************** #
# Building rules

all:			$(NAME)

%.o: %.s
	@tabs 18
	@printf "$(font_color)[$(green)+$(font_color)] Creation of the object $(bold)$< $(blinking)$(font_color)\t-> $(reset)$(bold) $@ $(reset)\n"
	@$(NASM) -f elf64 -o $@ $<

%.o: %.c
	@tabs 18
	@printf "$(font_color)[$(green)+$(font_color)] Creation of the object $(bold)$< $(blinking)$(font_color)\t-> $(reset)$(bold) $@ $(reset)\n"
	@$(CC) $(CFLAGS) -o $@ -c $<

$(NAME):		$(OBJ)
	@printf "$(font_color)[$(green)+$(font_color)] Creation of $(bold)libft.a$(reset)\n"
	@ar rcs $(NAME) $(OBJ)
	$(print_ascii)

so:
	$(CC) -c -fPIC $(CFLAGS) $(BASE_SRC)
	gcc -nostartfiles -shared -o $(LIBSHARE) $(OBJ)

clean:
	@printf "$(font_color)[$(red)-$(font_color)] Deleting object files$(reset)\n"
	@$(RM) $(OBJ)
	@$(RM) $(BONUS_OBJ)
	@$(RM) $(LIBSHARE)

fclean:			clean
	@printf "$(font_color)[$(red)-$(font_color)] Deleting $(bold)$(NAME)$(reset)\n"
	@$(RM) $(NAME) $(LIBSHARE)

re:				fclean $(NAME)

bonus:			$(BONUS_OBJ)
	@printf "$(font_color)[$(green)+$(font_color)] Creation of $(bold)libft.a$(font_color) with bonus $(reset)\n"
	@ar rcs $(NAME) $(BONUS_OBJ)
	$(print_ascii)

.PHONY:			all clean fclean re

# **************************************************************************** #