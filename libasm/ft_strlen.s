
BITS 64 ; for vim syntastic
; Parameters to functions are passed in the registers
; rdi, rsi, rdx, rcx, r8, r9, and further values are passed on the stack in reverse order.
; https://www.youtube.com/watch?v=kjOcgG0FpNQ

section .text
	global ft_strlen ;; if MacOS, needs underbar _ft_strlen.

; [ How to use stack in asm ]
; https://www.youtube.com/watch?v=vcfQVwtoyHY
; https://www.youtube.com/watch?v=5eWiz3soaEM

ft_strlen:
	push rbp
	mov rbp, rsp
	mov qword [rbp - 8], rdi
	mov qword [rbp - 16], 0
 .PROC_CHECK_NULL:
	mov rax, qword [rbp - 8]
	mov rcx, qword [rbp - 16]
	cmp byte [rax + rcx], 0
	je  ft_strlen.PROC_RETURN_LEN
 .PROC_INCREMENT_COUNT:  
	mov rax, qword [rbp - 16]
	add rax, 1
	mov qword [rbp - 16], rax
	jmp ft_strlen.PROC_CHECK_NULL
 .PROC_RETURN_LEN:
	mov rax, qword [rbp - 16]
	pop rbp
	ret
