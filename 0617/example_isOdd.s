
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
	; 하고 싶은 것. -> 위 문자열의 N을 다른 문자로 대체하고 싶음.
	msg2_len  equ	$ - msg2
	msg_odd	 db 'number is odd'
	msg_odd_len equ $ - msg_odd
	msg_even db 'number is even'
	msg_even_len equ $ - msg_even

SECTION .bss
	buffer_byte resb 1

; https://www.nasm.us/xdoc/2.11.02/html/nasmdoc6.html
; exporting Symbols to other modules

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
	mov rsi, buffer_byte	  ; store data to cl
	mov rdx, 1		  ; read 1 byte
	syscall

	; check if buffer_byte is odd
	xor rax, rax
	mov rax, [buffer_byte]

	; test는 rax에 결과를 저장하지 않고, flag만 세팅함.
	test rax, 1		; if 1, then flag zero sets to false
	; if odd (test result is 1)
	jnz	_start.handleOdd
	; else (test result is 0)
	jmp _start.handleEven

; global Label.
..@exit_program:
	mov rax, SYS_EXIT
	mov rdi, EXIT_SUCCESS
	syscall

; Local Label assosiated to _start label
.handleOdd:
	mov rax, SYS_WRITE ; print message
	mov rdi, STDOUT
	mov rsi, msg_odd
	mov rdx, msg_odd_len
	syscall
	jmp ..@exit_program

; Local Label assosiated to _start label
.handleEven:
	mov rax, SYS_WRITE ; print message
	mov rdi, STDOUT
	mov rsi, msg_even
	mov rdx, msg_even_len
	syscall
	jmp ..@exit_program


; function exit


