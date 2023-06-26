
; *********************
; *   LINUX VERSION   *
; *********************

; NASM Assembler Directive
; ---------------------------------------
; https://www.nasm.us/xdoc/2.13.03/html/nasmdoc6.html
BITS 64 ; for vim syntastic. no need otherwise
; [%define] = https://www.tortall.net/projects/yasm/manual/html/nasm-preprocessor.html
%define a(x) (x+2)
%assign BUFF_SIZE   4 ; %define/%assing macro in NASM
; ---------------------------------------

; Below Examples are source from...
; https://www.tutorialspoint.com/assembly_programming/assembly_arithmetic_instructions.htm
SYS_READ        equ 0
SYS_WRITE       equ 1
SYS_EXIT        equ 60
STDIN           equ 0
STDOUT          equ 1
EXIT_SUCCESS    equ 0
EXIT_FAILURE    equ 1

section .data
    msg1        db "Enter a digit", 10, 0 ; = "Enter a digit\n\0"
    msg1_len    equ $ - msg1 ; $ is current address.
    msg2        db "Please Enter a second digit", 10, 0
    msg2_len    equ $ - msg2
    msg3        db "The Sum is: "
    msg3_len    equ $ - msg3


; https://www.csie.ntu.edu.tw/~comp03/nasm/nasmdoc3.html
section .bss
    input_num1    resb BUFF_SIZE ; reserved bytes = 4
    input_num2    resb BUFF_SIZE ; reserved bytes = 4
    result        resb BUFF_SIZE ; reserved bytes = 4


section .text
    global _start

_start:
    ; Linux_System_Call_Table_for_x86_64
    ; https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/

    ;write
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, msg1
    mov rdx, msg1_len
    syscall

    ;read
    mov rax, SYS_READ
    mov rdi, STDIN
    mov rsi, input_num1
    mov rdx, BUFF_SIZE
    syscall

    ;write
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, msg2
    mov rdx, msg2_len
    syscall

    ;read
    mov rax, SYS_READ
    mov rdi, STDIN
    mov rsi, input_num2
    mov rdx, BUFF_SIZE
    syscall

    ;write
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, msg3
    mov rdx, msg3_len
    syscall

    ; --------------------------------

    mov rax, [input_num1]
    sub rax, '0'

    mov rbx, [input_num2]
    sub rbx, '0'

    add rax, rbx
    add rax, '0'

    mov [result], rax
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, result
    mov rdx, 1
    syscall

    ; --------------------------------

    ;exit
    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall


