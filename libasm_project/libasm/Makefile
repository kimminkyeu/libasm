


# NOTE: OS 판단 후 컴파일
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux) # LINUX
	NASM_FILE_FORMAT = elf64
	OS_TYPE = __linux__ # nasm에서 system macro 정의가 안되있기 때문.
endif
ifeq ($(UNAME_S),Darwin) # MACOS
	NASM_FILE_FORMAT = macho64
	OS_TYPE = __APPLE__ # nasm에서 system macro 정의가 안되있기 때문.
endif

NAME            = libasm.a
NASM			= nasm -f $(NASM_FILE_FORMAT) -d ${OS_TYPE}
INCLUDE         = include
RM              = rm -f
AR              = ar rcs 

# mandatory
SRC_MANDATORY   = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s
OBJ_MANDATORY   = $(SRC_MANDATORY:s=o)

# bonus
SRC_BONUS       = ft_atoi_base.s ft_list_push_front.s ft_list_size.s ft_list_sort.s ft_list_remove_if.s
OBJ_BONUS       = $(SRC_BONUS:s=o)

# Keep makefile from relink
ifdef WITH_BONUS
     OBJ_RESULT = $(OBJ_MANDATORY) $(OBJ_BONUS)
else
     OBJ_RESULT = $(OBJ_MANDATORY)
endif


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

$(NAME): $(OBJ_RESULT)
	$(AR) $(NAME) $^
	@echo "$(GREEN)----------------------------$(DEF_COLOR)"
	@echo "$(GREEN)|                          |$(DEF_COLOR)"
	@echo "$(GREEN)| LibAsm compile finished. |$(DEF_COLOR)"
	@echo "$(GREEN)|                          |$(DEF_COLOR)"
	@echo "$(GREEN)----------------------------$(DEF_COLOR)"

%.o: %.s
	$(NASM) $< -o $@
	@echo "$(GREEN)Compiling with NASM ... \t$< $(DEF_COLOR)"

bonus:
	make WITH_BONUS=1

clean:
	rm -rf $(OBJ_RESULT)
	@echo "$(CYAN)Libasm obj files has been deleted.$(DEF_COLOR)"

fclean: clean
	${RM} ${NAME}
	@echo "$(CYAN)Libasm archive files has been deleted.$(DEF_COLOR)"

re: fclean all
	@echo "$(BLUE)Cleaned and rebuilt everything.$(DEF_COLOR)"

.PHONY: all clean fclean re bonus
