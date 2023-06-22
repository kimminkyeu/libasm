; ***********************************************
;                     [rdi]          [rsi]
; char * strcpy(char * dst, const char * src)
; {
;     char * dst_start = dst;
;     while (*(src))
;         *(dst++) = *(src++);
;     return dst_start;
; }
; ***********************************************

BITS 64

section .text
    global _ft_strcpy

_ft_strcpy:
    push rbp
    mov rbp, rsp
    mov qword [rbp - 8], rdi ; first argument
    mov qword [rbp - 16], rsi ; second argument
    mov rax, qword [rbp - 8] ; char * src
    mov qword [rbp - 24], rax ; copy local variable (tmp)

 .PROC_CHECK_NULL:
    mov rax, qword [rbp - 16]; ; char * src
    cmp byte [rax], 0 ; check if (*src) is 0
    je _ft_strcpy.PROC_RETURN_ADDR 

 .PROC_COPY_CHAR:
    ; (1) get src ptr
    mov rax, qword [rbp - 16] ; char * src
    mov rcx, rax ; char * src
    add rcx, 1 ; char * src++ (increament pointer)
    mov qword [rbp - 16], rcx ; src = src + 1

    ; (2) save character pointed by src ptr
    mov dl, byte [rax] ; mov to dl, byte one character pointed by rax (*src++)

    ; (3) get dst ptr
    mov rax, qword [rbp - 8] ; char * dst
    mov rcx, rax ; char * dst
    add rcx, 1 ; rcx = dst* + 1
    mov qword [rbp - 8], rcx ; dst = dst + 1

    ; (4) copy saved character [from (2)] to *dst
    mov byte [rax], dl ; *dst = char from *src
    jmp _ft_strcpy.PROC_CHECK_NULL

 .PROC_RETURN_ADDR:
    mov rax, qword [rbp - 24] ; return tmp (dst*'s original value)
    pop rbp ; clear current frame
    ret ; return rax value
