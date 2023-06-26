	.text
	.intel_syntax noprefix
	.file	"strcmp_unsigned.c"
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
	mov	qword ptr [rbp - 8], rdi
	mov	qword ptr [rbp - 16], rsi
	mov	rax, qword ptr [rbp - 8]
	mov	qword ptr [rbp - 24], rax
	mov	rax, qword ptr [rbp - 16]
	mov	qword ptr [rbp - 32], rax
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	xor	eax, eax
                                        # kill: def $al killed $al killed $eax
	mov	rcx, qword ptr [rbp - 24]
	movzx	edx, byte ptr [rcx]
	cmp	edx, 0
	mov	byte ptr [rbp - 33], al # 1-byte Spill
	je	.LBB0_4
# %bb.2:                                #   in Loop: Header=BB0_1 Depth=1
	xor	eax, eax
                                        # kill: def $al killed $al killed $eax
	mov	rcx, qword ptr [rbp - 32]
	movzx	edx, byte ptr [rcx]
	cmp	edx, 0
	mov	byte ptr [rbp - 33], al # 1-byte Spill
	je	.LBB0_4
# %bb.3:                                #   in Loop: Header=BB0_1 Depth=1
	mov	rax, qword ptr [rbp - 24]
	movzx	ecx, byte ptr [rax]
	mov	rax, qword ptr [rbp - 32]
	movzx	edx, byte ptr [rax]
	cmp	ecx, edx
	sete	sil
	mov	byte ptr [rbp - 33], sil # 1-byte Spill
.LBB0_4:                                #   in Loop: Header=BB0_1 Depth=1
	mov	al, byte ptr [rbp - 33] # 1-byte Reload
	test	al, 1
	jne	.LBB0_5
	jmp	.LBB0_6
.LBB0_5:                                #   in Loop: Header=BB0_1 Depth=1
	mov	rax, qword ptr [rbp - 24]
	add	rax, 1
	mov	qword ptr [rbp - 24], rax
	mov	rax, qword ptr [rbp - 32]
	add	rax, 1
	mov	qword ptr [rbp - 32], rax
	jmp	.LBB0_1
.LBB0_6:
	mov	rax, qword ptr [rbp - 24]
	movzx	ecx, byte ptr [rax]
	mov	rax, qword ptr [rbp - 32]
	movzx	edx, byte ptr [rax]
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
