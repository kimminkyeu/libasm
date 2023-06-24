
; size_t ft_strlen(const char* str) {
;	size_t cnt = 0;
; 	while (*(str++)) cnt++;
;	return cnt;
; }

BITS 64 ; for vim syntastic

section .text
	global _ft_strlen
_ft_strlen:
	push rbp ; save parent's first stack frame address
	mov rbp, rsp ; set self's first stack frame
	sub rsp, 24 ; decrement stack ptr by 16 byte
	mov qword [rbp - 8], rdi ; char* str_ptr = str
	mov qword [rbp - 16], 0 ; size_t cnt = 0
 .PROC_CHECK_NULL:
	mov rax, qword [rbp - 8] ; str_ptr
	mov rcx, qword [rbp - 16] ; cnt
	cmp byte [rax + rcx], 0	 ; if (*(str_ptr + cnt) === '/0')
	je  _ft_strlen.PROC_RETURN_LEN ; jump to .PROC_RETURN_LEN
 .PROC_INCREMENT_COUNT:  
	mov rax, qword [rbp - 16] ; rax = cnt
	add rax, 1 ; rax++
	mov qword [rbp - 16], rax ; cnt = rax
	jmp _ft_strlen.PROC_CHECK_NULL
 .PROC_RETURN_LEN:
	mov rax, qword [rbp - 16] ; return value
	add rsp, 24 ; increment stack ptr by 16 byte ( = pop )
	pop rbp ; clear stack
	ret 

