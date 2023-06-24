
; ***************************************************************
;                         [rdi]          [rsi]           [rdx]
; extern ssize_t ft_write(int fd, const void *buf, size_t count);
; ***************************************************************

%ifdef __linux__
    extern  __errno_location ; defined in linux errno.h header
    %define GET_ERRNO_PTR __errno_location
    SYS_READ        equ 0
    SYS_WRITE       equ 1
%elif __APPLE__
    ; - https://github.com/freebsd/freebsd-src/blob/master/sys/sys/errno.h
    extern  ___error ; defined in freeBSD errno.h header
    %define GET_ERRNO_PTR ___error
    SYS_READ        equ 0x02000003
    SYS_WRITE       equ 0x02000004
%else 
    ; ... 
%endif

BITS 64
    ; [ MacOS Syscall Table ]
    ; https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master
section .data
   
section .text
    global _ft_write
_ft_write:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov dword [rbp - 4], edi ; 4byte
    mov qword [rbp - 16], rsi ; 8byte
    mov qword [rbp - 24], rdx ; 8byte
    mov rax, SYS_WRITE  ; for write syscall
    mov edi, dword [rbp - 4] ; fd
    mov rsi, qword [rbp - 16] ; string address
    mov rdx, qword [rbp - 24] ; number of bytes
    syscall
    jnc _ft_write.PROC_END ; if CF not set, then jump to end
 .PROC_SET_ERRNO:
    sub rsp, 8
    mov qword [rbp - 32], rax ; save syscall result
    call GET_ERRNO_PTR ; after calling ___error, rax is set to int*
    ; 어떤 errno를 세팅하지?
    mov rax, qword [rbp - 32] ; save syscall result to rcx
    add rsp, 8
    ; mov rax, -1 ; set return value
 .PROC_END: ; (4) Clean-up stack frame
    add rsp, 32
    pop rbp
    ret
