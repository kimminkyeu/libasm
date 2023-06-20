; *****************************
;      MacOS x64 Intel 
; *****************************

; Parameters to functions are passed in the registers 
; rdi, rsi, rdx, rcx, r8, r9, 
; and further values are passed on the stack in reverse order.

BITS 64

SYS_READ        equ 0x02000003
SYS_WRITE       equ 0x02000004
SYS_EXIT        equ 0x02000001
STDIN           equ 0
STDOUT          equ 1
EXIT_SUCCESS    equ 0
EXIT_FAILURE    equ 1

SECTION .data
	msg1	  db	'enter one digit number', 10, 0
	msg1_len  equ	$ - msg1

section .text
    global _asm_func

_asm_func:
    mov rcx, rdi
    add rcx, rsi
    ;; 아  맞네  순서 대로 밑으로 실행되네 ㅋㅋ 
    ret


;;;;;
; Modern x64 Assembly C calling Convention 
;   https://www.youtube.com/watch?v=kjOcgG0FpNQ