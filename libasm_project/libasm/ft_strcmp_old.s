
; int	ft_strcmp(const char *s1, const char *s2)
; {
;     while (*s1 && *s2 && (*s1 == *s2))
;     {
;         ++s1; ++s2;
;     }
;     return ((int)(*s1 - *s2));
; }

BITS 64

section .text
	global _ft_strcmp

_ft_strcmp:
	; PROLOGUE
	push rbp
	mov rbp, rsp
	sub rsp, 16
	mov qword [rbp - 8], rdi ; char* s1
	mov qword [rbp - 16], rsi ; char* s2

 .PROC_LOOP:
	; check if (*s1 && *s2). Else, return
	xor rax, rax
	xor rcx, rcx
	mov rax, qword [rbp - 8] ; s1_uchar ptr
	mov rcx, qword [rbp - 16] ; s2_uchar ptr
	cmp byte [rax], 0 ; if (*s1 === '/0')
	je _ft_strcmp.PROC_RETURN
	cmp byte [rcx], 0 ; if (*s2 === '/0')
	je _ft_strcmp.PROC_RETURN
	; check if (*s1 == *s2). Else, return
	xor rbx, rbx
	xor rdx, rdx
	mov bl, byte [rax] ; *s1
	mov dl, byte [rcx] ; *s2
	cmp bl, dl ; AND bl, dl --> 0 if 
	jne _ft_strcmp.PROC_RETURN
	; else, increment each, save to stack
	add rax, 1 ; s1++
	mov qword [rbp - 8], rax
	add rcx, 1 ; s2++
	mov qword [rbp - 16], rcx
	jmp _ft_strcmp.PROC_LOOP

 .PROC_RETURN:
	xor rbx, rbx
	xor rdx, rdx
	mov rbx, qword [rbp - 8] ; s1_uchar ptr
	mov rdx, qword [rbp - 16] ; s2_uchar ptr
	xor rax, rax
	xor rcx, rcx
	movsx eax, byte [rbx] ; save signed char (*s1) as int + 남은 공간 초기화 
	movsx ecx, byte [rdx] ; save signed char (*s2) as int + 남은 공간 초기화
	sub eax, ecx ; *s1_ptr - *s2_ptr to eax (4byte)
	; EPILOGUE
	add rsp, 16
	pop rbp
	ret 
