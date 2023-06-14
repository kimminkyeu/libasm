
// Calculator Program

SYS_EXIT    equ 1
SYS_WRITE   equ 4
STDIN       equ 0
STDOUT      equ 1

; > 초기화된 데이터가 저장되는 데이터 세그먼트다.
section .data
    msg1        db "Enter a digit", 10, 0 ; = "Enter a digit\n\0"
    msg1_len    equ $ - msg1 ; $ is current address.
    msg2        db "Please Enter a second digit", 10, 0
    msg2_len    equ $ - msg2
    msg3        db "The Sum is: "
    msg3_len    equ $ - msg3

; https://www.csie.ntu.edu.tw/~comp03/nasm/nasmdoc3.html
; NASM에서 지원하는 데이터 지시어에 대해 알아보자. NASM에서는 메모리 공간을 정의하는 방법이 2가지 있다. 
; 하나는 메모리 공간만을 정의하는 resx 계열 지시어고, 다른 하나는 메모리 공간과 초기 값을 지정하는 dx 계열 지시어다

; > 초기화되지 않은 데이터가 저장되는 데이터 세그먼트다.
section .bss ; Uninitialized data section
    num1    resb 4 ; reserved bytes = 4
    num2    resb 4 ; reserved bytes = 4
    res     resb 4 ; reserved bytes = 4


section .text
    global _main

_main:


