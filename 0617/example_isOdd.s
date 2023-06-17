
; *********************
; *   LINUX VERSION   *
; *********************

; ---------------------------------------
BITS 64
%define BUFF_SIZE   4

; ---------------------------------------
SYS_READ        equ 0
SYS_WRITE       equ 1
SYS_EXIT        equ 60
STDIN           equ 0
STDOUT          equ 1
EXIT_SUCCESS    equ 0
EXIT_FAILURE    equ 1

; ---------------------------------------
; get if number is odd
; https://www.tutorialspoint.com/assembly_programming/assembly_logical_instructions.htm
SECTION .data
	msg1	  db	'enter one digit number', 10, 0
	msg1_len  equ	$ - msg1
	msg2	  db	'your input is: N'
	msg2_len  equ	$ - msg2

SECTION .bss
	buffer resb 1

SECTION .text
	global _start

_start:
	mov rax, SYS_WRITE ; print message
	mov rdi, STDOUT
	mov rsi, msg1
	mov rdx, msg1_len
	syscall

	mov rax, SYS_READ ; get input
	mov rdi, STDIN
	mov rsi, buffer	  ; store data to cl
	mov rdx, 1		  ; read 1 byte
	syscall

	; sub rcx, '0'	; change ascii to decimal
	; dump_mem	0, buffer, 1

	; add concatenate input character(=:buffer) to msg2 string table
	; mov [msg2 + 2], [buffer]

	; mov rax, SYS_WRITE ; print your input
	; mov rdi, STDOUT
	; mov rsi, msg2
	; mov rdx, msg2_len
	; syscall

	; mov rax, SYS_WRITE ; print your input
	; mov rdi, STDOUT
	; mov rsi, buffer
	; mov rdx, 8
	; syscall

	jmp exit
	

; function exit
exit:
	mov rax, SYS_EXIT
	mov rdi, EXIT_SUCCESS
	syscall

; 왜 sys_read를 rcx에 직접 넣으면 작동이 안되는가?
; 그 이류를 막 찾던 도중 괜찮은 학습자료를 또 찾음.

; https://courses.ics.hawaii.edu/ReviewICS312/morea/FirstProgram/ics312_nasm_first_program.pdf

