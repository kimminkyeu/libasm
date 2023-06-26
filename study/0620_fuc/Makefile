
# nasm -f macho64 asm_func.s
# cc -c main.c -o main.o
# cc main.o asm_func.o -o your_program.out
# 만약 직접 링킹한다면 ?

NAME            = libasm.a
NASM			= nasm -f macho64
INCLUDE         = include
RM              = rm -f
AR              = ar rcs

SRC        		= asm_func.s \

OBJ 			= $(SRC:s=o)


# Colors
DEF_COLOR       = \033[0;39m
GRAY            = \033[0;90m
RED             = \033[0;91m
GREEN           = \033[0;92m
YELLOW          = \033[0;93m
BLUE            = \033[0;94m
MAGENTA         = \033[0;95m
CYAN            = \033[0;96m
WHITE           = \033[0;97m


# Rules 
all: $(NAME)

$(NAME): $(OBJ)
	$(AR) $(NAME) $^
	@echo "$(GREEN)----------------------------$(DEF_COLOR)"
	@echo "$(GREEN)|                          |$(DEF_COLOR)"
	@echo "$(GREEN)| LibAsm compile finished. |$(DEF_COLOR)"
	@echo "$(GREEN)|                          |$(DEF_COLOR)"
	@echo "$(GREEN)----------------------------$(DEF_COLOR)"

%.o: %.s
	$(NASM) $< -o $@
	@echo "$(GREEN)Compiling with NASM ... \t$< $(DEF_COLOR)"

clean:
	@rm -rf $(OBJ)
	@echo "$(CYAN)Libasm obj files has been deleted.$(DEF_COLOR)"

fclean: clean
	@${RM} ${NAME}
	@echo "$(CYAN)Libasm archive files has been deleted.$(DEF_COLOR)"

re: fclean all
	@echo "$(BLUE)Cleaned and rebuilt everything.$(DEF_COLOR)"

.PHONY: all clean fclean re bonus