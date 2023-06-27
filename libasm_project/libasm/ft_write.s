
; ***************************************************************
;                         [rdi]          [rsi]           [rdx]
; extern ssize_t ft_write(int fd, const void *buf, size_t count);
; ***************************************************************

%ifdef __APPLE__
    ; - https://github.com/freebsd/freebsd-src/blob/master/sys/sys/errno.h
    extern  ___error ; defined in freeBSD errno.h header
    %define GET_ERRNO_PTR_TO_RAX    ___error
    SYS_READ        equ 0x02000003
    SYS_WRITE       equ 0x02000004
    %define __CHECK_ERROR          .PROC_CHECK_ERROR___FREEBSD
%else
    extern  __errno_location ; defined in linux errno.h header
    %define GET_ERRNO_PTR_TO_RAX    __errno_location WRT ..plt
    ; https://www.nasm.us/xdoc/2.10rc8/html/nasmdoc9.html#section-9.2.5
    SYS_READ        equ 0
    SYS_WRITE       equ 1
    %define __CHECK_ERROR          .PROC_CHECK_ERROR___LINUX
%endif

BITS 64
    ; [ MacOS Syscall Table ]
    ; https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master

; **********************************************************
; 주의! MacOS는 Stack을 16byte alignment로 잡기 때문에, 
; 각 함수의 stack frame은 16의 배수로 끝나야 한다.  (마지막 stack을 32로 잡은 이유)
; **********************************************************
   
section .text
    global _ft_write
_ft_write:
    ; PROLOGUE
    push rbp
    mov rbp, rsp
    sub rsp, 32 ; for MacOS 16byte alignment, always keep %rsp to [16 * N]
    ; LOCAL VAR (아래 파라미터 복사 과정은 생략 가능함)
    mov dword [rbp - 4], edi ; 4byte ; rbp-8에 저장해도 상관 없음.
    mov qword [rbp - 16], rsi ; 8byte
    mov qword [rbp - 24], rdx ; 8byte
    ; SYSCALL
    mov rax, SYS_WRITE  ; for write syscall
    mov edi, dword [rbp - 4] ; fd ; rbp-8에 저장해도 상관 없음.
    mov rsi, qword [rbp - 16] ; string address
    mov rdx, qword [rbp - 24] ; number of bytes
    syscall ; 미리 rsp를 16의 배수로 뺐기 때문에, MacOS에서 syscall이 안전하게 동작한다.
    jmp __CHECK_ERROR

 .PROC_CHECK_ERROR___FREEBSD:
    jc _ft_write.PROC_SET_ERRNO ; if CF not set, then jump to end
    jmp _ft_write.PROC_END

 .PROC_CHECK_ERROR___LINUX:
    cmp rax, 0 ;
    jl _ft_write.PROC_NEGATE_RAX___LINUX
    jmp _ft_write.PROC_END

 .PROC_NEGATE_RAX___LINUX:
    neg rax ; -N : N (2's compliment)
    jmp _ft_write.PROC_SET_ERRNO

 .PROC_SET_ERRNO:
    ; FreeBSD의 __error 함수는 rcx, rax를 모두 쓰기 떄문에, call 이전에 미리 변수들을 stack에 저장해줘야 함.
    mov qword [rbp - 32], rax ; save errno value to stack (returns errno if failed)
    call GET_ERRNO_PTR_TO_RAX
    mov rcx, qword [rbp - 32] ; move errno from stack to rcx
    mov [rax], rcx ; save syscall result to rcx
    mov rax, -1 ; on error, return -1
    jmp _ft_write.PROC_END

 .PROC_END: ; (4) Clean-up stack frame
    add rsp, 32
    pop rbp
    ret

; ----------------------------------------------------------------------------
;                   HIGH ADDRESS        **(포인터도 ++로 연산해서 다음 칸으로 이동하듯)
;                                         (Start 주소에서 +방향으로 데이터가 쌓임.)
;
;
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
; -    errno value             -
; |                            | 
; ------------------------------ -32 <-- rsp
;                  LOWER ADDRESS
;
;
;
