
; global keyword는 identifer를 linker가 접근 할 수 있게 해줍니다.
global _start

_start:
    mov eax, 60 ; syscall exit
    mov edi, 42 ; exit status
    ; syscall
    int 128
    ; 리눅스 인터럽트 벡터 리스트입니다.
    ; https://www.oreilly.com/library/view/understanding-the-linux/0596005652/ch04s06.html

    ; int 0x80    ; interrupt
    ; exception vector 128(0x80)
    ; is system call handler

; macOs는 global _main이여야 했는데
; 리눅스는 global _start로 해야 함.
; wsl에서 컴파일 하였습니다.
; nasm -f elf64 ex1.s -o ex1.o

; 근데 segfault가 뜹니다...
; 왜인지 찾아보니...

; https://stackoverflow.com/questions/49784186/segmentation-fault-int-80h

;    You can't just add a syscall instruction to the end 
;    and expect that to work. Linux system calls using the 
;    syscall instructions are for amd64 and work differently. 
;    I advise you to stick to a single tutorial and run your code 
;    on actual Linux, not WSL.