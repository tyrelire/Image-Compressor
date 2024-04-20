##
## EPITECH PROJECT, 2024
## Makefile
## File description:
## Wolfram
##

NAME        = imageCompressor

all :
	stack build
	cp $(shell stack path --local-install-root)/bin/$(NAME)-exe ./$(NAME)

clean :
	stack clean

fclean: clean
	rm -rf $(NAME)

re: fclean all
