; int   ft_strcmp(const char *s1, const char *s2)
; {
;     while (*s1 && *s2 && (*s1 == *s2))
;     {
;         ++s1; ++s2;
;     }
;     return ((int)(*s1 - *s2));
; }

BITS 64 ; for vim syntastic

section .text
	global _ft_strcmp

_ft_strcmp:
	push rbp
	mov rbp, rsp
	call _inner_ft_strcmp ; 내부 함수 호출.
	mov rsp, rbp
	pop rbp
	ret

_inner_ft_strcmp:
	; PROLOGUE
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov qword [rbp - 8], rdi ; char* s1
	mov qword [rbp - 16], rsi ; char* s2
	jmp .PROC_CHECK_S1_NULL

 .PROC_CHECK_S1_NULL:
	mov rax, qword [rbp - 8] ; char* s1
	movzx eax, byte [rax] ; edx = *s1
	test al, al ; same as "cmp edx, 0"
	jz .PROC_RETURN ; same as je

 .PROC_CHECK_S2_NULL:
	mov rax, qword [rbp - 16] ; char* s2
	movzx eax, byte [rax] ; edx = *s2
	test al, al ; same as "cmp edx, 0"
	jz .PROC_RETURN ; same as je

 .PROC_CHECK_S1_S2_EQUAL:
	mov rax, qword [rbp - 8] ; char* s1
	movzx ecx, byte [rax] ; edx = 0 && ecx = *s1
	mov rax, qword [rbp - 16] ; char* s2
	movzx edx, byte [rax] ; edx = 0 && edx = *s2
	cmp cl, dl ; same as "cmp ecx, edx"
	jne .PROC_RETURN

 .PROC_ADVANCE_EACH_PTR:
	add qword [rbp - 8], 1 ; s1++
	add qword [rbp - 16], 1 ; s2++
	jmp .PROC_CHECK_S1_NULL

 .PROC_RETURN:
	mov rax, qword [rbp - 8] ; char* s1
	movzx ebx, byte [rax] ; ebx = 0 && eax = *s1
	mov rax, qword [rbp - 16] ; char* s2
	movzx ecx, byte [rax] ; ecx = 0 && eax = *s2
	mov eax, ebx ; use eax to set return value
	sub eax, ecx ; *s1 - *s2 (4byte)
	; EPILOGUE
	add rsp, 16
	pop rbp
	ret

