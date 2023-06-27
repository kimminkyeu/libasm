
; char  *ft_strdup(const char *s1)
; {
;     size_t    size;
;     char      *tmp;
;
;     size = ft_strlen(s1);
;     tmp = malloc(sizeof(*tmp) * (size + 1));
;     if (!tmp)
;         return (NULL);
;     while (size > 0)
;     {
;         tmp[size] = s1[size];
;         --size;
;     }
;     tmp[0] = s1[0];
;     return (tmp);
; }


BITS 64 ; for vim syntastic

extern _ft_strlen 
extern _ft_strcpy 

%ifdef __APPLE__
    ; - https://github.com/freebsd/freebsd-src/blob/master/sys/sys/errno.h
	extern _malloc
    %define MALLOC		_malloc
%else
	extern malloc
    %define MALLOC		malloc WRT ..plt 
    ; https://www.nasm.us/xdoc/2.10rc8/html/nasmdoc9.html#section-9.2.5
%endif

; ******************************************************************************************
; 찾은 링크: https://stackoverflow.com/questions/36007975/compile-error-relocation-r-x86-64-pc32-against-undefined-symbol
; call malloc WRT ..plt ; https://www.nasm.us/xdoc/2.10rc8/html/nasmdoc9.html#section-9.2.5
; 이 부분이 매우 중요함.
; 이 부분이 -no-pie 옵션을 쓰지 말라는 부분과 관련 있음!
; library를 생성할 때, 라이브러리 외부에 있는 함수를 호출 할 경우
; ******************************************************************************************

section .text
	global _ft_strdup

_ft_strdup:
	endbr64
	; PROLOGUE
	push rbp
	mov rbp, rsp
	sub rsp, 24
	mov qword [rbp - 8], rdi ; const char* s1
	; STRLEN
	call _ft_strlen ; rdi is already set to s1.
	mov qword [rbp - 16], rax ; save ft_strlen result
	; MALLOC
	add rax, 1 ; size + 1
	mov rdi, rax
	call MALLOC; https://www.nasm.us/xdoc/2.10rc8/html/nasmdoc9.html#section-9.2.5
	mov qword [rbp - 24], rax ; save malloc result (char* tmp)
	; CHECK IF TMP IS NULL
	cmp rax, 0 ; if not 0, copy string
	jne .PROC_COPY_STRING 
	mov rax, 0 ; if 0, return NULL
	jmp .PROC_RETURN 

 .PROC_COPY_STRING:
	mov rdi, qword [rbp - 24] ; param A : char* dst
	mov rsi, qword [rbp - 8] ; param B : char* src
	call _ft_strcpy ; rax is now addr of dst string
	; SET NULL AT THE END
	mov rcx, qword [rbp - 16] ; length of src string
	mov byte [rax + rcx], 0 ; set null

 .PROC_RETURN:
	; EPILOGUE
	add rsp, 24
	pop rbp
	ret

	
