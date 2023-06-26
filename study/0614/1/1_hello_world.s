BITS 64    ; not needed, but it's for vim-syntastic plugin.
section .data

; How to write constants
constant_var equ 50 ; constant value
STDIN equ 0
STDOUT equ 1
SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4

; How to write variable
var1 db 'a', 10, 0 ; 10 is '\n', 0 is null
var2 dw 12345
var3 dw -12345
var4 times 9 db '*' ; *********
; var5 db 'hello, world', 10, 0 ; this is actually [ TABLE OF BYTES ]
var5 db 'hello, world'
; for Example...
;   string  db 'Assembly', 0, 1, 2, 3
;   will be compiled to:
;   string:  41h, 73h, 73h, 65h, 6Dh, 62h, 6Ch, 79h, 00h, 01h, 02h, 03h

; equ is constant directive. [equl]
var5_len equ $ - var5   ; length of var5 string



; code starts here
section .text
    global _main

_main:
    mov rax, 0x02000004     ; write syscall
    mov rdi, 1              ; fd 1
    mov rsi, var1
    mov rdx, 3              ; write size
    syscall
    ; prints 'y'

    mov rax, 0x02000004     ; write syscall
    mov rdi, 1              ; fd 1
    mov rsi, var4
    mov rdx, 9              ; write size
    syscall
    ; prints '*********'

    mov rax, 0x02000004     ; write syscall
    mov rdi, 1              ; fd 1
    mov rsi, var5
    mov rdx, var5_len             ; write size
    syscall
    ; prints 'hello, world'

    ; now, var5 contains the address of string 'hello world'.
    ; https://www.tutorialspoint.com/assembly_programming/assembly_addressing_modes.htm
    ; mov qword var5, qword 'bibye' ; change 'hello' to 'bibye'

    mov rax, 0x02000004     ; write syscall
    mov rdi, 1              ; fd 1
    mov rsi, var5
    mov rdx, var5_len       ; write size
    syscall
    ; prints 'hello, world'

    mov rax, 0x02000001     ; exit syscall
    mov rdi, 1              ; exit code 0
    syscall
    ; exit 0
; 1. How to Print Integer in decimal?
; https://stackoverflow.com/questions/13166064/how-do-i-print-an-integer-in-assembly-level-programming-without-printf-from-the
