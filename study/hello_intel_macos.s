section .data
message: db "Hello, World!", 0Ah, 00h
; 0A는 16진수 ascii로 LF, 줄바꿈이고 00은 NUL 이다.

global _main
section .text

;  word  2byte
; dword  4byte 
; qword  8byte

; 주의! Linux Syscall Table과 MacOS Syscall Table은 다르다.
; 또 64bit와 32bit 또한 다르다.
; 64-bit is a bit cleaner, but completely different: OS X (and GNU/Linux and everyone except Windows) on 64 architectures adopt the System V AMD64 ABI reference. 
; Jump to section A.2.1 for the syscall calling convention.

; 참조 Hello World 
; (1) https://filippo.io/making-system-calls-from-assembly-in-mac-os-x/
; (2) https://rderik.com/blog/let-s-write-some-assembly-code-in-macos-for-intel-x86-64/

; MacOS과 Linux간의 Syscall number가 다른 이유
; (1) https://stackoverflow.com/questions/65528933/why-do-macos-use-absolute-memory-locations-for-system-calls
; (2) 정확한 목적과 코드, 이유
;     - http://dustin.schultz.io/mac-os-x-64-bit-assembly-system-calls.html
; 결론부터 말하면, 0x02000000 + Unix Syscall 번호 = MacOS Syscall 번호이다.
; 2가 세팅된 이유는, x86 x64간의 시스템 콜을 구분하는 목적인 것 같다. (위 링크 참조)
; 그냥 생각해봐. 0x0000^0000에서 x64는 모두 읽고, x86은 잘려서 뒤 4개만 읽는다.

; [아래 링크를 보면 모든 정답이 나와 있다!!! 0xFF << SYSCALL_CLASS_SHIFT(24)]를 하는 거다.
; - https://opensource.apple.com/source/xnu/xnu-792.13.8/osfmk/mach/i386/syscall_sw.h
; - All the syscalls are listed in /usr/include/asm/unistd.h, together with their numbers 
; - (the value to put in EAX before you call int 80h).

; ***********************
; !!! 리눅스랑 번호가 다름 !!!
; ***********************

_main:
    mov     rax, 0x02000004     ; for write syscall
    mov     rdi, 1              ; write to fd 1
    mov     rsi, qword message  ; get string address (64bit addr)
    mov     rdx, 13             ; number of bytes
    syscall                     ; execute syscall (write)

    mov     rax, 0x02000001     ; for exit syscall
    mov     rdi, 0              ; exit code 0
    syscall                     ; execute syscall (exit)


; ---------------------------------------------------
; [ How to generate object file + executable ]
;   nasm -f macho64 hello_intel.s
;   ld -lSystem -o hello_intel hello_intel.o
;
;        * 여기서 -l System은 System's dylibs를 링크하는 것을 의미한다.
;        * 시스템콜을 링킹 해줘야 하기 때문이다.
; ---------------------------------------------------