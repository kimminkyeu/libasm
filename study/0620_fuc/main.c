
#include <stdio.h>

extern unsigned int asm_func(unsigned int lhs, unsigned int rhs);

int main(void) {
    unsigned int x = 4;
    unsigned int y = 10;
    unsigned int ret = asm_func(x, y);
    printf("asm_func()'s result: %d\n", ret);
    return (0);
}