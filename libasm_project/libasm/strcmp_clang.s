	.text
	.intel_syntax noprefix
	.file	"strcmp.c"
	.globl	ft_strcmp               # -- Begin function ft_strcmp
	.p2align	4, 0x90
	.type	ft_strcmp,@function
ft_strcmp:                              # @ft_strcmp
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	mov	qword ptr [rbp - 8], rdi ; NOTE: VAR 1 LOAD
	mov	qword ptr [rbp - 16], rsi ; NOTE: VAR 2 LOAD

.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	; NOTE: *s1가 null인지 체크
	xor	eax, eax 
                                        # kill: def $al killed $al killed $eax
	mov	rcx, qword ptr [rbp - 8]
	movsx	edx, byte ptr [rcx]
	cmp	edx, 0
	mov	byte ptr [rbp - 17], al # 1-byte Spill ; WARN: 아니 이건 뭐지??
	je	.LBB0_4

# %bb.2:                                #   in Loop: Header=BB0_1 Depth=1
	; NOTE: *s2가 null인지 체크
	xor	eax, eax                                         # kill: def $al killed $al killed $eax
	mov	rcx, qword ptr [rbp - 16]
	movsx	edx, byte ptr [rcx]
	cmp	edx, 0
	mov	byte ptr [rbp - 17], al # 1-byte Spill ; WARN: 아니 이건 뭐지??
	je	.LBB0_4


# %bb.3:                                #   in Loop: Header=BB0_1 Depth=1
	; NOTE: *s1 == *s2 인지 체크
	mov	rax, qword ptr [rbp - 8]
	movsx	ecx, byte ptr [rax] ;NOTE: movsx는 signed 버전의 movzx
	mov	rax, qword ptr [rbp - 16]
	movsx	edx, byte ptr [rax]
	cmp	ecx, edx
	sete	sil ; WARN: 아니 이건 뭐지??
	mov	byte ptr [rbp - 17], sil # 1-byte Spill  ; NOTE: sil is 8bit of rsi

.LBB0_4:                                #   in Loop: Header=BB0_1 Depth=1
	mov	al, byte ptr [rbp - 17] # 1-byte Reload
	test	al, 1
	jne	.LBB0_5
	jmp	.LBB0_6

.LBB0_5:                                #   in Loop: Header=BB0_1 Depth=1
	; NOTE: s1++, s2++
	mov	rax, qword ptr [rbp - 8]
	add	rax, 1
	mov	qword ptr [rbp - 8], rax
	mov	rax, qword ptr [rbp - 16]
	add	rax, 1
	mov	qword ptr [rbp - 16], rax
	jmp	.LBB0_1
.LBB0_6:
	; NOTE: save return value to eax 
	mov	rax, qword ptr [rbp - 8]
	movsx	ecx, byte ptr [rax]
	mov	rax, qword ptr [rbp - 16]
	movsx	edx, byte ptr [rax]
	sub	ecx, edx
	mov	eax, ecx
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.Lfunc_end0:
	.size	ft_strcmp, .Lfunc_end0-ft_strcmp
	.cfi_endproc
                                        # -- End function
	.ident	"clang version 10.0.0-4ubuntu1 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
