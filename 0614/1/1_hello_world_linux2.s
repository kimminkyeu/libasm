
BITS 64    ; not needed, but it's for vim-syntastic plugin.

; CONSTANT

; VARIABLE
section .data
    STDIN equ 0
    STDOUT equ 1
    NEWLINE equ 10
    NULL equ 0
    EXIT_SUCCESS equ 0
    EXIT_FAILURE equ 1
    SYS_EXIT equ 1
    SYS_WRITE equ 4
    var5 db 'hello, world'
    var5_len dq 12
    ; var5_len equ $ - var5

section .text
    global _start

_start:
    ; linux는 _main이 아니라 _start로 시작.
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, var5
    mov rdx, var5_len       ; write size
    syscall

    ; mov [var5], dword 'Nuha' ; dword = 4byte, 4글자. ; qword = 8btye
    ; 근데 웃긴게, syscall 을 한 후에 mov를 해서 단어를 바꿧는데.. 
    ; 왜 Nuhao, world가 출력되지?
    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall






