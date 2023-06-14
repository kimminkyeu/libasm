
section .data
BYTE_TABLE  db 'a', 'b', 'c'

section .text
    global _main

_main:
    xor rbx, rbx
    mov bl, byte [BYTE_TABLE]
