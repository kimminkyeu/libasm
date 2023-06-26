
; ***************************************************************
;                         [rdi]          [rsi]           [rdx]
; extern ssize_t ft_write(int fd, const void *buf, size_t count);
; ***************************************************************

%ifdef __APPLE__
    ; - https://github.com/freebsd/freebsd-src/blob/master/sys/sys/errno.h
    extern  ___error ; defined in freeBSD errno.h header
    %define GET_ERRNO_PTR_TO_RAX ___error
    SYS_READ        equ 0x02000003
    SYS_WRITE       equ 0x02000004
%else
    extern  __errno_location ; defined in linux errno.h header
    %define GET_ERRNO_PTR_TO_RAX __errno_location
    SYS_READ        equ 0
    SYS_WRITE       equ 1
    ; ... 
%endif

BITS 64
    ; [ MacOS Syscall Table ]
    ; https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master
   
section .text
    global _ft_write
_ft_write:
    ; PROLOGUE
    push rbp
    mov rbp, rsp
    sub rsp, 24
    ; LOCAL VAR (아래 파라미터 복사 과정은 생략 가능함)
    mov dword [rbp - 4], edi ; 4byte ; rbp-8에 저장해도 상관 없음.
    mov qword [rbp - 16], rsi ; 8byte
    mov qword [rbp - 24], rdx ; 8byte
    ; SYSCALL
    mov rax, SYS_WRITE  ; for write syscall
    mov edi, dword [rbp - 4] ; fd ; rbp-8에 저장해도 상관 없음.
    mov rsi, qword [rbp - 16] ; string address
    mov rdx, qword [rbp - 24] ; number of bytes
    syscall
    ; CHECK RESULT 
    cmp rax, 0 ; 0보다 작을 경우 넘어가도록 임시 수정.
    jl _ft_write.PROC_SET_ERRNO
    ; jc _ft_write.PROC_SET_ERRNO ; if CF not set, then jump to end

 .PROC_END: ; (4) Clean-up stack frame
    add rsp, 24
    pop rbp
    ret

 .PROC_SET_ERRNO:
    neg rax ; -N : N (2's compliment)
    mov rcx, rax ; save syscall return value to rcx (returns errno if failed)
    call GET_ERRNO_PTR_TO_RAX WRT ..plt ; https://www.nasm.us/xdoc/2.10rc8/html/nasmdoc9.html#section-9.2.5
    mov [rax], rcx ; save syscall result to rcx
    mov rax, -1 ; on error, return -1
    jmp _ft_write.PROC_END


;                   HIGH ADDRESS        **(포인터도 ++로 연산해서 다음 칸으로 이동하듯)
;                                         (Start 주소에서 +방향으로 데이터가 쌓임.)
; ------------------------------ +16
; |                            | 
; -   return address           -
; |                            | 
; ------------------------------ +8
; |                            | 
; -   caller's rbp (old)       -
; |                            | 
; ------------------------------ +0  <-- rbp (8byte)
; |    int fd (4btye)          | 
; -   -   -   -   -   -   -    - -4
; |    여기다 해도 됨(rbp-8)   | 
; ------------------------------ -8
; |                            | 
; -    void* buff              -
; |                            | 
; ------------------------------ -16
; |                            | 
; -    size_t count            -
; |                            | 
; ------------------------------ -24
; |                            | 
; -                            -
; |                            | 
; ------------------------------ -32
;                  LOWER ADDRESS

