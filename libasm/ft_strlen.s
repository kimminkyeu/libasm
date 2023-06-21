BITS 64 ; for vim syntastic

section .text
	global _ft_strlen
_ft_strlen:
	push rbp
	mov qword [rbp - 8], rdi
	mov qword [rbp - 16], 0
 .PROC_CHECK_NULL:
	mov rax, qword [rbp - 8]
	mov rcx, qword [rbp - 16]
	cmp byte [rax + rcx], 0
	je  _ft_strlen.PROC_RETURN_LEN
 .PROC_INCREMENT_COUNT:  
	mov rax, qword [rbp - 16]
	add rax, 1
	mov qword [rbp - 16], rax
	jmp _ft_strlen.PROC_CHECK_NULL
 .PROC_RETURN_LEN:
	mov rax, qword [rbp - 16]
	pop rbp 
	ret
