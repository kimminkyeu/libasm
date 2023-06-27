
NAME = tester
CC = cc
CFLAGS = -g

all: $(NAME)

$(NAME):
	make -C libasm
	mv libasm/libasm.a ./
	$(CC) $(CFLAGS) mandatory_tester.c libasm.a -o $@

bonus:
	make bonus -C libasm
	mv libasm/libasm.a ./
	$(CC) $(CFLAGS) bonus_tester.c libasm.a -o $@

clean:
	rm -rf libasm.a
	make fclean -C libasm

fclean:		clean
	rm -rf $(NAME)

re:			fclean all

.PHONY:		all clean fclean re
