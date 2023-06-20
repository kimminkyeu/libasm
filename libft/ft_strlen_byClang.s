
; ********************************
; #include <stddef.h>
; size_t	ft_strlen(const char *str)
; {
; 	size_t	size = 0;

; 	while (str[size])
; 		size++;
; 	return (size);
; }
; ********************************


	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 15	sdk_version 10, 15, 6
	.intel_syntax noprefix
	.globl	_ft_strlen              ## -- Begin function ft_strlen
	.p2align	4, 0x90
_ft_strlen:                             ## @ft_strlen
	.cfi_startproc
## %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	mov	qword ptr [rbp - 8], rdi
	mov	qword ptr [rbp - 16], 0
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	mov	rax, qword ptr [rbp - 8]
	mov	rcx, qword ptr [rbp - 16]
	cmp	byte ptr [rax + rcx], 0
	je	LBB0_3
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
	mov	rax, qword ptr [rbp - 16]
	add	rax, 1
	mov	qword ptr [rbp - 16], rax
	jmp	LBB0_1
LBB0_3:
	mov	rax, qword ptr [rbp - 16]
	pop	rbp
	ret
	.cfi_endproc
                                        ## -- End function
.subsections_via_symbols
