BITS 64 ; for vim syntastic

section .text
	global _ft_strlen
_ft_strlen:
	push rbp
	mov qword [rbp - 8], rdi
	; ** 내가 체크해야 할 가설: 위 연산을 하면 rsp가 바뀌는지 반드시 체크...
	; 왜냐면, 이 행위가 stack에 ft_strlen의 local variable frame을
	; 넣는 행위잖아.... 그런데... 이 행위가 rsp를 바꾸지 않으면... 잘못된거 아냐?
	; rsp는 항상 stack의 끝을 가리켜야 하니까...
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
