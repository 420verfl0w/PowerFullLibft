# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: brda-sil <brda-sil@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/03/29 18:23:35 by stales            #+#    #+#              #
#    Updated: 2022/04/06 15:02:36 by brda-sil         ###   ########.fr        #
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
CFLAGS			:= -Wall -Wextra -Werror
NAME			:= libft.a
LIBSHARE		:= libft.so
RM				:= rm -rf
NASM			:= nasm
CC				:= gcc

# SRC
SRC_DIR			:= src
SRC_BASE		:= ft_atoi.c
SRC_ASM			:= ft_memset.s

SRC_BASE		:= $(patsubst %,$(SRC_DIR)/%,$(SRC_BASE))
SRC_ASM			:= $(patsubst %,$(SRC_DIR)/%,$(SRC_ASM))

# OBJ
OBJ_DIR			:= obj

OBJ_BASE		:= $(patsubst $(SRC_DIR)/%,$(OBJ_DIR)/%,$(SRC_BASE:%.c=%.o))
OBJ_ASM			:= $(patsubst $(SRC_DIR)/%,$(OBJ_DIR)/%,$(SRC_ASM:%.s=%.o))

# LIB DIR
LIB_DIR			:= lib
CFLAGS			+= -I$(LIB_DIR)

# **************************************************************************** #

# **************************************************************************** #
# Building rules

all:			create_dir $(NAME)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	@tabs 18
	@printf "$(font_color)[$(green)+$(font_color)] Creation of $(bold)$< $(blinking)$(font_color)\t-> $(reset)$(bold) $@ $(reset)\n"
	@$(NASM) -f elf64 -o $@ $<

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@tabs 18
	@printf "$(font_color)[$(green)+$(font_color)] Creation of $(bold)$< $(blinking)$(font_color)\t-> $(reset)$(bold) $@ $(reset)\n"
	@$(CC) $(CFLAGS) -o $@ -c $<

$(NAME):		$(OBJ_BASE) $(OBJ_ASM)
	@printf "$(font_color)[$(green)+$(font_color)] Creation of $(bold)libft.a$(reset)\n"
	@ar rcs $(NAME) $(OBJ_BASE) $(OBJ_ASM)
	$(print_ascii)

so: $(OBJ_ASM)
	$(CC) -c -fPIC $(CFLAGS) $(SRC_BASE)
	gcc -nostartfiles -shared -o $(LIBSHARE) $(OBJ_BASE) $(OBJ_ASM)

clean:
	@printf "$(font_color)[$(red)-$(font_color)] Deleting $(bold)object folder$(reset)\n"
	@$(RM) $(OBJ_DIR)
	@$(RM) $(LIBSHARE)

fclean:			clean
	@printf "$(font_color)[$(red)-$(font_color)] Deleting $(bold)$(NAME)$(reset)\n"
	@$(RM) $(NAME) $(LIBSHARE)

re:				fclean create_dir $(NAME)

# create OBJDIR, "-p" mean no error if already here
create_dir:
	@printf "$(font_color)[$(green)+$(font_color)] Creation of $(bold)obj dir$(reset)\n"
	@mkdir -p $(OBJ_DIR)
	@printf "$(reset)"

.PHONY:			all clean fclean re

# **************************************************************************** #
