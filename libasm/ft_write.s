
; ***************************************************************
;                         [rdi]          [rsi]           [rdx]
; extern ssize_t ft_write(int fd, const void *buf, size_t count);
; ***************************************************************


; Using "call ___error" allows to 
; return a int* that point on the variable Errno. 
; So the solution is to modify the byte pointed by Rax
; after use of call ___error.
extern  ___error
; - https://stackoverflow.com/questions/15304829/how-to-return-errno-in-assembly
; - https://github.com/freebsd/freebsd-src/blob/master/sys/sys/errno.h

%define EFAULT 14

section .data
    ; 이 부분이 section .data 하위 라벨로 넣어야 하는건지...?
    ; 왜냐면 이렇게 안해도 됬었거든.

    ; [ MacOS Syscall Table ]
    ; https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master
    SYS_READ        equ 0x02000003
    SYS_WRITE       equ 0x02000004
    SYS_EXIT        equ 0x02000001
    STDIN           equ 0
    STDOUT          equ 1
    EXIT_SUCCESS    equ 0
    EXIT_FAILURE    equ 1

section .text
    global _ft_write

_ft_write:
    push    rbp
    mov     rbp, rsp

    ; (1) set arguments to stack
    ; 아 이거는 x64 레지스터 바이트 패팅을 8byte로 맞췄네!!!
    ; mov dword [rbp - 4], rdi ; 4byte

    mov dword [rbp - 4], edi ; 4byte
    ; mov qword [rbp - 12], rsi ; 8byte
    mov qword [rbp - 16], rsi ; 8byte
    ; mov qword [rbp - 20], rdx ; 8byte
    mov qword [rbp - 24], rdx ; 8byte

    ; *****************************************
    ; 아니 근데... 보니까 그냥 syscall 바로 해도 되네 ...
    ; 어차피 edi rsi rdx는 새팅이 되어 있으니 rax만 세팅하면 끝나네?
    ; *****************************************

    ; (3) Execute syscall (write)
    mov rax, SYS_WRITE  ; for write syscall
    ; mov rdi, [rbp - 4]  ; fd
    mov edi, dword [rbp - 4]  ; fd
    ; mov rsi, [rbp - 12] ; string address
    mov rsi, qword [rbp - 16] ; string address
    ; mov rdx, [rbp - 20] ; number of bytes
    mov rdx, qword [rbp - 24] ; number of bytes
    syscall

    jnc _ft_write.PROC_END ; if CF not set, then jump to end

 .PROC_SET_ERRNO:
    mov qword [rbp - 32], rax ; syscall returns errno int value?
    ; mov r15, rax
    call ___error ; after calling ___error, rax is set to int*
    ; mov [rax], r15
    mov rcx, qword [rbp - 32]
    mov qword [rax], rcx
    mov rax, -1 ; return은 -1을 하긴 해야 함.

 .PROC_END:
     ; (4) Clean-up stack frame
    pop     rbp
    ret

; FreeBSD Errno Setting 방법 (아래 링크 참조.)
; https://github.com/cacharle/libasm_test/issues/2
; 근데 이게 맞아...?