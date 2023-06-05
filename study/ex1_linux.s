
; *****************************************
; *                                       *
; *       x86 CPU Assembly + Linux        *
; *                                       *
; *****************************************

; https://www.youtube.com/watch?v=wLXIWKUWpSs&list=PLmxT2pVYo5LB5EzTPZGfFN0c2GDiSXgQe

global _start       ; Global Keyword: define entry point

_start:

;   mov eax, 1   ; copy 1 to eax (32)
    mov rax, 1   ; copy 1 to rax (64)

;   mov ebx, 42  ; copy 42 to ebx (32)
    mov rbx, 42  ; copy 42 to rbx (64)

    int 0x80     ; Interrupt handler for Syscall. [0x80] is 128 indecimal. [ INT X ] --> X는 0-255 사이. 
                 ; [ Interrupt descriptor table + Interrupt vector table ]
                 ; (1) https://ko.wikipedia.org/wiki/INT_(x86_%EB%AA%85%EB%A0%B9%EC%96%B4)
                 ; (2) https://stackoverflow.com/questions/1817577/what-does-int-0x80-mean-in-assembly-code

; -------------------------------------------------------------------
;       (1) Compile with:        nasm -f elf32 ex1.s -o ex1.o
;           -f : 출력파일형식 설정
;                                       elf stands for Executable and Linkable Format
;
;           - Nasm manual      : https://linux.die.net/man/1/nasm
;           - Nasm file format : https://www.nasm.us/xdoc/2.09.10/html/nasmdoc7.html
;
;
;       (2) Link Object files:   ld -m elf_i386 ex1.o -o ex1 
;
; -------------------------------------------------------------------
; What is nasm ?
;   nasm stands for Netwide Assembler.
;   넷와이드 어셈블러(Netwide Assembler, NASM)은 인텔 x86 아키텍처용 어셈블러이자 역어셈블러이다. 
;   16비트, 32비트(IA-32), 64비트(x86-64) 프로그램 작성에 사용할 수 있다. 
;   NASM은 가장 대중적인 리눅스용 어셈블러들 가운데 하나로 인식된다.

