	.file	"01_avx_kernel.cpp"
	.text
	.p2align 4
	.globl	_Z4add8Dv8_fS_
	.type	_Z4add8Dv8_fS_, @function
_Z4add8Dv8_fS_:
.LFB6444:
	.cfi_startproc
	endbr64
	vaddps	%ymm1, %ymm0, %ymm0
	ret
	.cfi_endproc
.LFE6444:
	.size	_Z4add8Dv8_fS_, .-_Z4add8Dv8_fS_
	.p2align 4
	.globl	_Z5add16Dv16_fS_
	.type	_Z5add16Dv16_fS_, @function
_Z5add16Dv16_fS_:
.LFB6445:
	.cfi_startproc
	endbr64
	vaddps	%zmm1, %zmm0, %zmm0
	ret
	.cfi_endproc
.LFE6445:
	.size	_Z5add16Dv16_fS_, .-_Z5add16Dv16_fS_
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"add8: "
.LC2:
	.string	"%g "
.LC4:
	.string	"add16: "
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB6476:
	.cfi_startproc
	endbr64
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-64, %rsp
	leaq	.LC1(%rip), %rsi
	movl	$2, %edi
	pushq	-8(%r10)
	pushq	%rbp
	movq	%rsp, %rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r13
	pushq	%r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x68,0x6
	.cfi_escape 0x10,0xd,0x2,0x76,0x78
	.cfi_escape 0x10,0xc,0x2,0x76,0x70
	pushq	%rbx
	leaq	-176(%rbp), %r13
	.cfi_escape 0x10,0x3,0x2,0x76,0x60
	leaq	-208(%rbp), %rbx
	leaq	.LC2(%rip), %r12
	subq	$208, %rsp
	vmovaps	.LC0(%rip), %ymm0
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	vmovaps	%ymm0, -208(%rbp)
	vzeroupper
	call	__printf_chk@PLT
	.p2align 4
	.p2align 3
.L5:
	vxorpd	%xmm2, %xmm2, %xmm2
	movq	%r12, %rsi
	vcvtss2sd	(%rbx), %xmm2, %xmm0
	movl	$2, %edi
	movl	$1, %eax
	addq	$4, %rbx
	call	__printf_chk@PLT
	cmpq	%r13, %rbx
	jne	.L5
	movl	$10, %edi
	leaq	-112(%rbp), %r13
	call	putchar@PLT
	vmovaps	.LC3(%rip), %zmm0
	xorl	%eax, %eax
	leaq	.LC4(%rip), %rsi
	movl	$2, %edi
	vmovaps	%zmm0, -176(%rbp)
	vzeroupper
	call	__printf_chk@PLT
	.p2align 4
	.p2align 3
.L6:
	vxorpd	%xmm1, %xmm1, %xmm1
	movq	%r12, %rsi
	vcvtss2sd	(%rbx), %xmm1, %xmm0
	movl	$2, %edi
	movl	$1, %eax
	addq	$4, %rbx
	call	__printf_chk@PLT
	cmpq	%r13, %rbx
	jne	.L6
	movl	$10, %edi
	call	putchar@PLT
	movq	-56(%rbp), %rax
	subq	%fs:40, %rax
	jne	.L11
	addq	$208, %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
.L11:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE6476:
	.size	main, .-main
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC0:
	.long	1093664768
	.long	1094713344
	.long	1095761920
	.long	1096810496
	.long	1097859072
	.long	1098907648
	.long	1099431936
	.long	1099956224
	.section	.rodata
	.align 64
.LC3:
	.long	1120534528
	.long	1120665600
	.long	1120796672
	.long	1120927744
	.long	1121058816
	.long	1121189888
	.long	1121320960
	.long	1121452032
	.long	1121583104
	.long	1121714176
	.long	1121845248
	.long	1121976320
	.long	1122107392
	.long	1122238464
	.long	1122369536
	.long	1122500608
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
