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

; (1) 왜 const unsigned char* 기준으로 하지 않았는지 설명할 것.
; (2) int 반환할 때와 size_t 반환할 때 차이를 어떻게 asm에서 두지?
; (3) 왜 clang은 byte spill 을 하고, gcc는 하지 않는거임.?

; 이건 공부용. call stack이 어떻게 정리되는지 설명하기 위함.
; 직접 그리면서 stack이 어떻게 변화하는지 설명할 것! 
; gdb(or lldb) 도 함께 보기.

_ft_strcmp:
	endbr64
	push rbp
	mov rbp, rsp
	call _inner_ft_strcmp ; 내부 함수 호출.
	mov rsp, rbp
	pop rbp
	ret

_inner_ft_strcmp:
	; endbr64는 메모리 보호 기법으로 사용된다. (디버깅하다 발견)
	endbr64 ; https://core-research-team.github.io/2020-05-01/memory
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
	je .PROC_RETURN

 .PROC_CHECK_S2_NULL:
	mov rax, qword [rbp - 16] ; char* s2
	movzx eax, byte [rax] ; edx = *s2
	test al, al ; same as "cmp edx, 0"
	je .PROC_RETURN

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
	movzx eax, byte [rax] ; eax = 0 && eax = *s1
	movsx edx, al ; edx = 0 && edx = al
	mov rax, qword [rbp - 16] ; char* s2
	movzx eax, byte [rax] ; eax = 0 && eax = *s2
	movsx ecx, al ; ecx = 0 && ecx = al
	mov eax, edx ; 
	sub eax, ecx ; *s1 - *s2 (4byte)
	; EPILOGUE
	add rsp, 16
	pop rbp
	ret

