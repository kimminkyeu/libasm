
NAME = tester
CC = cc
CFLAGS = -g

all: $(NAME)

$(NAME):
	make -C libasm
	mv libasm/libasm.a ./
	$(CC) $(CFLAGS) main.c libasm.a -o $@

clean:
	rm -rf libasm.a
	make fclean -C libasm

fclean:		clean
	rm -rf $(NAME)

re:			fclean all

.PHONY:		all clean fclean re
