; size_t ft_strlen(const char* str) {
;	size_t cnt = 0;
; 	while (*(str++)) cnt++;
;	return cnt;
; }

BITS 64 ; for vim syntastic

section .text
	global _ft_strlen

_ft_strlen:
	; PROLOGUE
	push rbp ; save parent's first stack frame address
	mov rbp, rsp ; set self's first stack frame
	sub rsp, 16 ; decrement stack ptr by 16 byte
	; LOCAL VAR
	mov qword [rbp - 8], rdi ; char* str_ptr = str
	mov qword [rbp - 16], 0 ; size_t cnt = 0

 .PROC_CHECK_NULL:
	mov rax, qword [rbp - 8] ; str_ptr
	mov rcx, qword [rbp - 16] ; cnt
	cmp byte [rax + rcx], 0	 ; if (*(str_ptr + cnt) === '/0')
	je  _ft_strlen.PROC_RETURN_LEN ; jump to .PROC_RETURN_LEN

 .PROC_INCREMENT_COUNT:  
	mov rax, qword [rbp - 16] ; rax = cnt
	add rax, 1 ; rax++
	mov qword [rbp - 16], rax ; cnt = rax
	jmp _ft_strlen.PROC_CHECK_NULL

 .PROC_RETURN_LEN:
	; RETURN VAL
	mov rax, qword [rbp - 16] ; return value
	; EPILOGUE
	add rsp, 16 ; increment stack ptr by 16 byte (= mov rsp, rbp)
	pop rbp ; clear stack
	ret 

; (1) Stack을 사용하는 것은 register를 사용하는 것보다 x10 느림.
; (2) 최적화 옵션 (cc -o{0~3}) 중 0옵션 (미최적화) 는 모든 것을 stack으로 씀.
; (3) 최적화를 키면, 이 stack 사용을 register 사용으로 줄여준다.


; ***********************************
; |    Stack Frame (x64) example    |
; ***********************************
;
;                 HIGHER ADDRESS
; ------------------------------
; |  ...                       | +32
; ------------------------------
; |  ...                       | +24
; ------------------------------
; |  arg of caller             | +16
; ------------------------------
; |  return address            | +8  (rip's next target when callee returns)
; ------------------------------
; |  caller's rbp (old rbp)    | <-- rbp
; ------------------------------
; |  callee's local variable A | -8
; ------------------------------
; |  callee's local variable B | -16
; ------------------------------
; |  ...                       | -24
; ------------------------------
; |  ...                       | -32
; ------------------------------
;                  LOWER ADDRESS

; 1. call intruction pushes next rip value on top of the stack.
;    (call 다음에 실행할 주소)
; 2. 함수 진입 순간, rsp는 return address를 가리키고 있음.
; 3. 함수 반환 순간, rsp는 반드시 return address를 가리켜야 함.
; 4. ret instruction은 pop한 value(rsp가 가리키는)를 rip에 load함.






