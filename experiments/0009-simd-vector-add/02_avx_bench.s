	.file	"02_avx_bench.cpp"
	.text
	.p2align 4
	.type	_ZSt13__adjust_heapIN9__gnu_cxx17__normal_iteratorIPxSt6vectorIxSaIxEEEElxNS0_5__ops15_Iter_less_iterEEvT_T0_SA_T1_T2_.isra.0, @function
_ZSt13__adjust_heapIN9__gnu_cxx17__normal_iteratorIPxSt6vectorIxSaIxEEEElxNS0_5__ops15_Iter_less_iterEEvT_T0_SA_T1_T2_.isra.0:
.LFB8524:
	.cfi_startproc
	leaq	-1(%rdx), %rax
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rax, %rbp
	movq	%rdx, %r13
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdx, %r12
	shrq	$63, %rbp
	addq	%rax, %rbp
	movq	%rcx, %r9
	andl	$1, %r13d
	sarq	%rbp
	cmpq	%rbp, %rsi
	jge	.L2
	movq	%rsi, %r8
	jmp	.L4
	.p2align 4
	.p2align 3
.L9:
	movq	%rcx, %r8
.L4:
	leaq	1(%r8), %rax
	leaq	(%rax,%rax), %rcx
	salq	$4, %rax
	leaq	-8(%rdi,%rcx,8), %r10
	addq	%rdi, %rax
	leaq	-1(%rcx), %rbx
	movq	(%rax), %rdx
	movq	(%r10), %r11
	cmpq	%rdx, %r11
	cmovg	%r11, %rdx
	cmovg	%rbx, %rcx
	cmovg	%r10, %rax
	movq	%rdx, (%rdi,%r8,8)
	cmpq	%rcx, %rbp
	jg	.L9
	testq	%r13, %r13
	je	.L8
.L5:
	leaq	-1(%rcx), %r8
	movq	%r8, %rdx
	shrq	$63, %rdx
	addq	%r8, %rdx
	sarq	%rdx
	cmpq	%rsi, %rcx
	jg	.L7
	jmp	.L6
	.p2align 4
	.p2align 3
.L17:
	leaq	-1(%rdx), %rcx
	movq	%r8, (%rax)
	movq	%rcx, %rax
	shrq	$63, %rax
	addq	%rcx, %rax
	movq	%rdx, %rcx
	sarq	%rax
	cmpq	%rdx, %rsi
	jge	.L16
	movq	%rax, %rdx
.L7:
	leaq	(%rdi,%rdx,8), %r10
	leaq	(%rdi,%rcx,8), %rax
	movq	(%r10), %r8
	cmpq	%r9, %r8
	jl	.L17
.L6:
	movq	%r9, (%rax)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4
	.p2align 3
.L2:
	.cfi_restore_state
	leaq	(%rdi,%rsi,8), %rax
	testq	%r13, %r13
	jne	.L6
	movq	%rsi, %rcx
	.p2align 4
	.p2align 3
.L8:
	subq	$2, %r12
	movq	%r12, %rdx
	shrq	$63, %rdx
	addq	%r12, %rdx
	sarq	%rdx
	cmpq	%rdx, %rcx
	jne	.L5
	leaq	1(%rcx,%rcx), %rcx
	leaq	(%rdi,%rcx,8), %rdx
	movq	(%rdx), %r8
	movq	%r8, (%rax)
	movq	%rdx, %rax
	jmp	.L5
	.p2align 4
	.p2align 3
.L16:
	movq	%r10, %rax
	movq	%r9, (%rax)
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE8524:
	.size	_ZSt13__adjust_heapIN9__gnu_cxx17__normal_iteratorIPxSt6vectorIxSaIxEEEElxNS0_5__ops15_Iter_less_iterEEvT_T0_SA_T1_T2_.isra.0, .-_ZSt13__adjust_heapIN9__gnu_cxx17__normal_iteratorIPxSt6vectorIxSaIxEEEElxNS0_5__ops15_Iter_less_iterEEvT_T0_SA_T1_T2_.isra.0
	.p2align 4
	.type	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPxSt6vectorIxSaIxEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_.isra.0, @function
_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPxSt6vectorIxSaIxEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_.isra.0:
.LFB8525:
	.cfi_startproc
	movq	%rsi, %rax
	subq	%rdi, %rax
	cmpq	$128, %rax
	jle	.L54
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdi, %r12
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdx, %r13
	movq	%rsi, %r9
	leaq	8(%rdi), %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	testq	%rdx, %rdx
	je	.L55
.L21:
	sarq	$4, %rax
	vmovdqu	(%r12), %xmm0
	leaq	(%r12,%rax,8), %rdi
	movq	-8(%r9), %rdx
	decq	%r13
	movq	(%rdi), %rax
	vmovq	%xmm0, %rcx
	vpalignr	$8, %xmm0, %xmm0, %xmm1
	vpextrq	$1, %xmm0, %rsi
	cmpq	%rsi, %rax
	jle	.L27
	cmpq	%rdx, %rax
	jl	.L33
	cmpq	%rdx, %rsi
	jl	.L53
.L30:
	vmovdqu	%xmm1, (%r12)
	movq	-8(%r9), %rdi
.L29:
	movq	%r9, %rdx
	movq	%rbx, %rax
	cmpq	%rcx, %rsi
	jle	.L43
	.p2align 4
	.p2align 3
.L57:
	addq	$8, %rax
	.p2align 4
	.p2align 3
.L35:
	movq	%rax, %r8
	movq	(%rax), %rcx
	addq	$8, %rax
	cmpq	%rsi, %rcx
	jl	.L35
	movq	%r8, %rbp
.L34:
	subq	$8, %rdx
	cmpq	%rdi, %rsi
	jge	.L36
	.p2align 4
	.p2align 3
.L37:
	movq	-8(%rdx), %rdi
	subq	$8, %rdx
	cmpq	%rsi, %rdi
	jg	.L37
.L36:
	cmpq	%rdx, %rbp
	jnb	.L56
	movq	%rdi, 0(%rbp)
	movq	%rcx, (%rdx)
	movq	(%r12), %rsi
	movq	8(%rbp), %rcx
	movq	-8(%rdx), %rdi
	leaq	8(%rbp), %rax
	cmpq	%rcx, %rsi
	jg	.L57
.L43:
	movq	%rax, %rbp
	jmp	.L34
.L27:
	cmpq	%rdx, %rsi
	jl	.L30
	cmpq	%rdx, %rax
	jge	.L33
.L53:
	movq	%rdx, (%r12)
	movq	%rcx, %rdi
	movq	%rcx, -8(%r9)
	movq	(%r12), %rsi
	movq	8(%r12), %rcx
	jmp	.L29
	.p2align 4
	.p2align 3
.L56:
	movq	%r13, %rdx
	movq	%r9, %rsi
	movq	%rbp, %rdi
	call	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPxSt6vectorIxSaIxEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_.isra.0
	movq	%rbp, %rax
	subq	%r12, %rax
	cmpq	$128, %rax
	jle	.L49
	testq	%r13, %r13
	je	.L40
	movq	%rbp, %r9
	jmp	.L21
.L33:
	movq	%rax, (%r12)
	movq	%rcx, (%rdi)
	movq	8(%r12), %rcx
	movq	(%r12), %rsi
	movq	-8(%r9), %rdi
	jmp	.L29
.L55:
	movq	%rsi, %rbp
.L40:
	sarq	$3, %rax
	leaq	-2(%rax), %rsi
	movq	%rax, %rbx
	sarq	%rsi
	jmp	.L23
.L58:
	decq	%rsi
.L23:
	movq	(%r12,%rsi,8), %rcx
	movq	%rbx, %rdx
	movq	%r12, %rdi
	call	_ZSt13__adjust_heapIN9__gnu_cxx17__normal_iteratorIPxSt6vectorIxSaIxEEEElxNS0_5__ops15_Iter_less_iterEEvT_T0_SA_T1_T2_.isra.0
	testq	%rsi, %rsi
	jne	.L58
	subq	$8, %rbp
	.p2align 4
	.p2align 3
.L24:
	movq	0(%rbp), %rcx
	movq	(%r12), %rax
	movq	%rbp, %rbx
	xorl	%esi, %esi
	subq	%r12, %rbx
	movq	%r12, %rdi
	movq	%rbx, %rdx
	subq	$8, %rbp
	sarq	$3, %rdx
	movq	%rax, 8(%rbp)
	call	_ZSt13__adjust_heapIN9__gnu_cxx17__normal_iteratorIPxSt6vectorIxSaIxEEEElxNS0_5__ops15_Iter_less_iterEEvT_T0_SA_T1_T2_.isra.0
	cmpq	$8, %rbx
	jg	.L24
.L49:
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L54:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	ret
	.cfi_endproc
.LFE8525:
	.size	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPxSt6vectorIxSaIxEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_.isra.0, .-_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPxSt6vectorIxSaIxEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_.isra.0
	.p2align 4
	.globl	_Z10add_scalarPKfS0_Pfi
	.type	_Z10add_scalarPKfS0_Pfi, @function
_Z10add_scalarPKfS0_Pfi:
.LFB8273:
	.cfi_startproc
	endbr64
	testl	%ecx, %ecx
	jle	.L63
	movslq	%ecx, %rcx
	xorl	%eax, %eax
	salq	$2, %rcx
	.p2align 4
	.p2align 3
.L61:
	vmovss	(%rdi,%rax), %xmm0
	vaddss	(%rsi,%rax), %xmm0, %xmm0
	vmovss	%xmm0, (%rdx,%rax)
	addq	$4, %rax
	cmpq	%rax, %rcx
	jne	.L61
.L63:
	ret
	.cfi_endproc
.LFE8273:
	.size	_Z10add_scalarPKfS0_Pfi, .-_Z10add_scalarPKfS0_Pfi
	.p2align 4
	.globl	_Z11add_autovecPKfS0_Pfi
	.type	_Z11add_autovecPKfS0_Pfi, @function
_Z11add_autovecPKfS0_Pfi:
.LFB8274:
	.cfi_startproc
	endbr64
	movslq	%ecx, %rax
	movq	%rsi, %r8
	movq	%rdx, %rsi
	testl	%eax, %eax
	jle	.L94
	leal	-1(%rax), %edx
	movl	%eax, %r9d
	cmpl	$6, %edx
	jbe	.L66
	leaq	4(%rdi), %r10
	movq	%rsi, %rcx
	subq	%r10, %rcx
	cmpq	$56, %rcx
	jbe	.L66
	leaq	4(%r8), %r10
	movq	%rsi, %rcx
	subq	%r10, %rcx
	cmpq	$56, %rcx
	jbe	.L66
	cmpl	$14, %edx
	jbe	.L74
	movl	%eax, %ecx
	xorl	%edx, %edx
	shrl	$4, %ecx
	salq	$6, %rcx
	.p2align 4
	.p2align 3
.L68:
	vmovups	(%rdi,%rdx), %zmm1
	vaddps	(%r8,%rdx), %zmm1, %zmm0
	vmovups	%zmm0, (%rsi,%rdx)
	addq	$64, %rdx
	cmpq	%rdx, %rcx
	jne	.L68
	movl	%eax, %ecx
	andl	$-16, %ecx
	movl	%ecx, %edx
	cmpl	%ecx, %eax
	je	.L93
	movl	%eax, %r9d
	subl	%ecx, %r9d
	leal	-1(%r9), %r10d
	cmpl	$6, %r10d
	jbe	.L70
.L67:
	salq	$2, %rdx
	vmovups	(%rdi,%rdx), %ymm2
	vaddps	(%r8,%rdx), %ymm2, %ymm0
	vmovups	%ymm0, (%rsi,%rdx)
	movl	%r9d, %edx
	andl	$-8, %edx
	addl	%edx, %ecx
	andl	$7, %r9d
	je	.L93
.L70:
	movslq	%ecx, %rdx
	leal	1(%rcx), %r9d
	salq	$2, %rdx
	vmovss	(%rdi,%rdx), %xmm0
	vaddss	(%r8,%rdx), %xmm0, %xmm0
	vmovss	%xmm0, (%rsi,%rdx)
	cmpl	%r9d, %eax
	jle	.L93
	vmovss	4(%rdi,%rdx), %xmm0
	vaddss	4(%r8,%rdx), %xmm0, %xmm0
	leal	2(%rcx), %r9d
	vmovss	%xmm0, 4(%rsi,%rdx)
	cmpl	%r9d, %eax
	jle	.L93
	vmovss	8(%rdi,%rdx), %xmm0
	vaddss	8(%r8,%rdx), %xmm0, %xmm0
	leal	3(%rcx), %r9d
	vmovss	%xmm0, 8(%rsi,%rdx)
	cmpl	%r9d, %eax
	jle	.L93
	vmovss	12(%rdi,%rdx), %xmm0
	vaddss	12(%r8,%rdx), %xmm0, %xmm0
	leal	4(%rcx), %r9d
	vmovss	%xmm0, 12(%rsi,%rdx)
	cmpl	%r9d, %eax
	jle	.L93
	vmovss	16(%rdi,%rdx), %xmm0
	vaddss	16(%r8,%rdx), %xmm0, %xmm0
	leal	5(%rcx), %r9d
	vmovss	%xmm0, 16(%rsi,%rdx)
	cmpl	%r9d, %eax
	jle	.L93
	vmovss	20(%rdi,%rdx), %xmm0
	vaddss	20(%r8,%rdx), %xmm0, %xmm0
	addl	$6, %ecx
	vmovss	%xmm0, 20(%rsi,%rdx)
	cmpl	%ecx, %eax
	jle	.L93
	vmovss	24(%rdi,%rdx), %xmm0
	vaddss	24(%r8,%rdx), %xmm0, %xmm0
	vmovss	%xmm0, 24(%rsi,%rdx)
	vzeroupper
	ret
	.p2align 4
	.p2align 3
.L93:
	vzeroupper
.L94:
	ret
	.p2align 4
	.p2align 3
.L66:
	leaq	0(,%rax,4), %rdx
	xorl	%eax, %eax
	.p2align 4
	.p2align 3
.L72:
	vmovss	(%rdi,%rax), %xmm0
	vaddss	(%r8,%rax), %xmm0, %xmm0
	vmovss	%xmm0, (%rsi,%rax)
	addq	$4, %rax
	cmpq	%rax, %rdx
	jne	.L72
	ret
.L74:
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	jmp	.L67
	.cfi_endproc
.LFE8274:
	.size	_Z11add_autovecPKfS0_Pfi, .-_Z11add_autovecPKfS0_Pfi
	.p2align 4
	.globl	_Z10add_avx512PKfS0_Pfi
	.type	_Z10add_avx512PKfS0_Pfi, @function
_Z10add_avx512PKfS0_Pfi:
.LFB8275:
	.cfi_startproc
	endbr64
	movq	%rdx, %r8
	movl	%ecx, %r9d
	cmpl	$15, %ecx
	jle	.L105
	leal	-16(%rcx), %eax
	shrl	$4, %eax
	leal	1(%rax), %edx
	xorl	%eax, %eax
	movq	%rdx, %rcx
	salq	$6, %rdx
	.p2align 4
	.p2align 3
.L97:
	vmovups	(%rdi,%rax), %zmm1
	vaddps	(%rsi,%rax), %zmm1, %zmm0
	vmovups	%zmm0, (%r8,%rax)
	addq	$64, %rax
	cmpq	%rax, %rdx
	jne	.L97
	movl	%ecx, %eax
	sall	$4, %eax
	cmpl	%eax, %r9d
	jle	.L124
.L127:
	movl	%r9d, %r10d
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movslq	%eax, %rcx
	subl	%eax, %r10d
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r14
	pushq	%r13
	pushq	%r12
	.cfi_offset 14, -24
	.cfi_offset 13, -32
	.cfi_offset 12, -40
	leal	-1(%r10), %r12d
	pushq	%rbx
	.cfi_offset 3, -48
	cmpl	$6, %r12d
	jbe	.L99
	leaq	0(,%rcx,4), %rdx
	leaq	(%r8,%rdx), %rbx
	leaq	4(%rdi,%rdx), %r14
	leaq	4(%rdx), %r11
	movq	%rbx, %r13
	subq	%r14, %r13
	cmpq	$56, %r13
	jbe	.L99
	addq	%rsi, %r11
	movq	%rbx, %r13
	subq	%r11, %r13
	cmpq	$56, %r13
	jbe	.L99
	cmpl	$14, %r12d
	jbe	.L106
	vmovups	(%rdi,%rdx), %zmm3
	vaddps	(%rsi,%rdx), %zmm3, %zmm0
	movl	%r10d, %edx
	andl	$-16, %edx
	addl	%edx, %eax
	vmovups	%zmm0, (%rbx)
	testb	$15, %r10b
	je	.L122
	subl	%edx, %r10d
	leal	-1(%r10), %r11d
	cmpl	$6, %r11d
	jbe	.L102
.L100:
	addq	%rcx, %rdx
	salq	$2, %rdx
	vmovups	(%rdi,%rdx), %ymm2
	vaddps	(%rsi,%rdx), %ymm2, %ymm0
	vmovups	%ymm0, (%r8,%rdx)
	movl	%r10d, %edx
	andl	$-8, %edx
	addl	%edx, %eax
	andl	$7, %r10d
	je	.L122
.L102:
	movslq	%eax, %rdx
	leal	1(%rax), %ecx
	salq	$2, %rdx
	vmovss	(%rdi,%rdx), %xmm0
	vaddss	(%rsi,%rdx), %xmm0, %xmm0
	vmovss	%xmm0, (%r8,%rdx)
	cmpl	%ecx, %r9d
	jle	.L122
	vmovss	4(%rdi,%rdx), %xmm0
	vaddss	4(%rsi,%rdx), %xmm0, %xmm0
	leal	2(%rax), %ecx
	vmovss	%xmm0, 4(%r8,%rdx)
	cmpl	%ecx, %r9d
	jle	.L122
	vmovss	8(%rdi,%rdx), %xmm0
	vaddss	8(%rsi,%rdx), %xmm0, %xmm0
	leal	3(%rax), %ecx
	vmovss	%xmm0, 8(%r8,%rdx)
	cmpl	%ecx, %r9d
	jle	.L122
	vmovss	12(%rdi,%rdx), %xmm0
	vaddss	12(%rsi,%rdx), %xmm0, %xmm0
	leal	4(%rax), %ecx
	vmovss	%xmm0, 12(%r8,%rdx)
	cmpl	%ecx, %r9d
	jle	.L122
	vmovss	16(%rdi,%rdx), %xmm0
	vaddss	16(%rsi,%rdx), %xmm0, %xmm0
	leal	5(%rax), %ecx
	vmovss	%xmm0, 16(%r8,%rdx)
	cmpl	%ecx, %r9d
	jle	.L122
	vmovss	20(%rdi,%rdx), %xmm0
	vaddss	20(%rsi,%rdx), %xmm0, %xmm0
	addl	$6, %eax
	vmovss	%xmm0, 20(%r8,%rdx)
	cmpl	%eax, %r9d
	jle	.L122
	vmovss	24(%rdi,%rdx), %xmm0
	vaddss	24(%rsi,%rdx), %xmm0, %xmm0
	vmovss	%xmm0, 24(%r8,%rdx)
.L122:
	vzeroupper
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
	.p2align 4
	.p2align 3
.L99:
	.cfi_restore_state
	leaq	0(,%rcx,4), %rdx
	leal	1(%rax), %ecx
	vmovss	(%rdi,%rdx), %xmm0
	vaddss	(%rsi,%rdx), %xmm0, %xmm0
	vmovss	%xmm0, (%r8,%rdx)
	cmpl	%ecx, %r9d
	jle	.L122
	vmovss	4(%rdi,%rdx), %xmm0
	vaddss	4(%rsi,%rdx), %xmm0, %xmm0
	leal	2(%rax), %ecx
	vmovss	%xmm0, 4(%r8,%rdx)
	cmpl	%ecx, %r9d
	jle	.L122
	vmovss	8(%rsi,%rdx), %xmm0
	vaddss	8(%rdi,%rdx), %xmm0, %xmm0
	leal	3(%rax), %ecx
	vmovss	%xmm0, 8(%r8,%rdx)
	cmpl	%ecx, %r9d
	jle	.L122
	vmovss	12(%rdi,%rdx), %xmm0
	vaddss	12(%rsi,%rdx), %xmm0, %xmm0
	leal	4(%rax), %ecx
	vmovss	%xmm0, 12(%r8,%rdx)
	cmpl	%ecx, %r9d
	jle	.L122
	vmovss	16(%rdi,%rdx), %xmm0
	vaddss	16(%rsi,%rdx), %xmm0, %xmm0
	leal	5(%rax), %ecx
	vmovss	%xmm0, 16(%r8,%rdx)
	cmpl	%ecx, %r9d
	jle	.L122
	vmovss	20(%rdi,%rdx), %xmm0
	vaddss	20(%rsi,%rdx), %xmm0, %xmm0
	leal	6(%rax), %ecx
	vmovss	%xmm0, 20(%r8,%rdx)
	cmpl	%ecx, %r9d
	jle	.L122
	vmovss	24(%rdi,%rdx), %xmm0
	vaddss	24(%rsi,%rdx), %xmm0, %xmm0
	leal	7(%rax), %ecx
	vmovss	%xmm0, 24(%r8,%rdx)
	cmpl	%ecx, %r9d
	jle	.L122
	vmovss	28(%rdi,%rdx), %xmm0
	vaddss	28(%rsi,%rdx), %xmm0, %xmm0
	leal	8(%rax), %ecx
	vmovss	%xmm0, 28(%r8,%rdx)
	cmpl	%ecx, %r9d
	jle	.L122
	vmovss	32(%rdi,%rdx), %xmm0
	vaddss	32(%rsi,%rdx), %xmm0, %xmm0
	leal	9(%rax), %ecx
	vmovss	%xmm0, 32(%r8,%rdx)
	cmpl	%ecx, %r9d
	jle	.L122
	vmovss	36(%rdi,%rdx), %xmm0
	vaddss	36(%rsi,%rdx), %xmm0, %xmm0
	leal	10(%rax), %ecx
	vmovss	%xmm0, 36(%r8,%rdx)
	cmpl	%ecx, %r9d
	jle	.L122
	vmovss	40(%rdi,%rdx), %xmm0
	vaddss	40(%rsi,%rdx), %xmm0, %xmm0
	leal	11(%rax), %ecx
	vmovss	%xmm0, 40(%r8,%rdx)
	cmpl	%ecx, %r9d
	jle	.L122
	vmovss	44(%rdi,%rdx), %xmm0
	vaddss	44(%rsi,%rdx), %xmm0, %xmm0
	leal	12(%rax), %ecx
	vmovss	%xmm0, 44(%r8,%rdx)
	cmpl	%ecx, %r9d
	jle	.L122
	vmovss	48(%rdi,%rdx), %xmm0
	vaddss	48(%rsi,%rdx), %xmm0, %xmm0
	leal	13(%rax), %ecx
	vmovss	%xmm0, 48(%r8,%rdx)
	cmpl	%ecx, %r9d
	jle	.L122
	vmovss	52(%rdi,%rdx), %xmm0
	vaddss	52(%rsi,%rdx), %xmm0, %xmm0
	leal	14(%rax), %ecx
	vmovss	%xmm0, 52(%r8,%rdx)
	cmpl	%ecx, %r9d
	jle	.L122
	vmovss	56(%rdi,%rdx), %xmm0
	vaddss	56(%rsi,%rdx), %xmm0, %xmm0
	addl	$15, %eax
	vmovss	%xmm0, 56(%r8,%rdx)
	cmpl	%eax, %r9d
	jle	.L122
	vmovss	60(%rdi,%rdx), %xmm0
	vaddss	60(%rsi,%rdx), %xmm0, %xmm0
	vmovss	%xmm0, 60(%r8,%rdx)
	jmp	.L122
	.p2align 4
	.p2align 3
.L105:
	.cfi_def_cfa 7, 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	xorl	%eax, %eax
	cmpl	%eax, %r9d
	jg	.L127
.L124:
	vzeroupper
	ret
.L106:
	.cfi_def_cfa 6, 16
	.cfi_offset 3, -48
	.cfi_offset 6, -16
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	xorl	%edx, %edx
	jmp	.L100
	.cfi_endproc
.LFE8275:
	.size	_Z10add_avx512PKfS0_Pfi, .-_Z10add_avx512PKfS0_Pfi
	.section	.text._ZNSt6vectorIfSaIfEED2Ev,"axG",@progbits,_ZNSt6vectorIfSaIfEED5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIfSaIfEED2Ev
	.type	_ZNSt6vectorIfSaIfEED2Ev, @function
_ZNSt6vectorIfSaIfEED2Ev:
.LFB8318:
	.cfi_startproc
	endbr64
	movq	(%rdi), %rax
	testq	%rax, %rax
	je	.L130
	movq	16(%rdi), %rsi
	movq	%rax, %rdi
	subq	%rax, %rsi
	jmp	_ZdlPvm@PLT
	.p2align 4
	.p2align 3
.L130:
	ret
	.cfi_endproc
.LFE8318:
	.size	_ZNSt6vectorIfSaIfEED2Ev, .-_ZNSt6vectorIfSaIfEED2Ev
	.weak	_ZNSt6vectorIfSaIfEED1Ev
	.set	_ZNSt6vectorIfSaIfEED1Ev,_ZNSt6vectorIfSaIfEED2Ev
	.section	.text._ZNSt6vectorIxSaIxEED2Ev,"axG",@progbits,_ZNSt6vectorIxSaIxEED5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIxSaIxEED2Ev
	.type	_ZNSt6vectorIxSaIxEED2Ev, @function
_ZNSt6vectorIxSaIxEED2Ev:
.LFB8376:
	.cfi_startproc
	endbr64
	movq	(%rdi), %rax
	testq	%rax, %rax
	je	.L133
	movq	16(%rdi), %rsi
	movq	%rax, %rdi
	subq	%rax, %rsi
	jmp	_ZdlPvm@PLT
	.p2align 4
	.p2align 3
.L133:
	ret
	.cfi_endproc
.LFE8376:
	.size	_ZNSt6vectorIxSaIxEED2Ev, .-_ZNSt6vectorIxSaIxEED2Ev
	.weak	_ZNSt6vectorIxSaIxEED1Ev
	.set	_ZNSt6vectorIxSaIxEED1Ev,_ZNSt6vectorIxSaIxEED2Ev
	.section	.rodata._ZNSt6vectorIxSaIxEE17_M_realloc_insertIJxEEEvN9__gnu_cxx17__normal_iteratorIPxS1_EEDpOT_.str1.1,"aMS",@progbits,1
.LC0:
	.string	"vector::_M_realloc_insert"
	.section	.text._ZNSt6vectorIxSaIxEE17_M_realloc_insertIJxEEEvN9__gnu_cxx17__normal_iteratorIPxS1_EEDpOT_,"axG",@progbits,_ZNSt6vectorIxSaIxEE17_M_realloc_insertIJxEEEvN9__gnu_cxx17__normal_iteratorIPxS1_EEDpOT_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIxSaIxEE17_M_realloc_insertIJxEEEvN9__gnu_cxx17__normal_iteratorIPxS1_EEDpOT_
	.type	_ZNSt6vectorIxSaIxEE17_M_realloc_insertIJxEEEvN9__gnu_cxx17__normal_iteratorIPxS1_EEDpOT_, @function
_ZNSt6vectorIxSaIxEE17_M_realloc_insertIJxEEEvN9__gnu_cxx17__normal_iteratorIPxS1_EEDpOT_:
.LFB8441:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movabsq	$1152921504606846975, %rcx
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movq	8(%rdi), %r12
	movq	(%rdi), %r13
	movq	%r12, %rax
	subq	%r13, %rax
	sarq	$3, %rax
	cmpq	%rcx, %rax
	je	.L157
	movq	%rsi, %r15
	movq	%rdi, %rbp
	movq	%rsi, %r14
	subq	%r13, %r15
	cmpq	%r12, %r13
	je	.L158
	leaq	(%rax,%rax), %rcx
	cmpq	%rax, %rcx
	jb	.L149
	testq	%rcx, %rcx
	jne	.L159
	xorl	%ebx, %ebx
	xorl	%edi, %edi
.L140:
	movq	(%rdx), %rdx
	leaq	8(%rdi,%r15), %rcx
	subq	%r14, %r12
	vmovq	%rdi, %xmm1
	movq	%rdx, (%rdi,%r15)
	leaq	(%rcx,%r12), %rdx
	vpinsrq	$1, %rdx, %xmm1, %xmm0
	vmovdqa	%xmm0, (%rsp)
	testq	%r15, %r15
	jg	.L160
	testq	%r12, %r12
	jle	.L144
	movq	%r12, %rdx
	movq	%r14, %rsi
	movq	%rcx, %rdi
	call	memcpy@PLT
.L144:
	testq	%r13, %r13
	jne	.L143
.L146:
	vmovdqa	(%rsp), %xmm2
	movq	%rbx, 16(%rbp)
	vmovdqu	%xmm2, 0(%rbp)
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4
	.p2align 3
.L149:
	.cfi_restore_state
	movabsq	$9223372036854775800, %rbx
.L139:
	movq	%rbx, %rdi
	movq	%rdx, (%rsp)
	call	_Znwm@PLT
	movq	(%rsp), %rdx
	movq	%rax, %rdi
	addq	%rax, %rbx
	jmp	.L140
	.p2align 4
	.p2align 3
.L160:
	movq	%r15, %rdx
	movq	%r13, %rsi
	movq	%rcx, 24(%rsp)
	call	memmove@PLT
	testq	%r12, %r12
	jg	.L161
.L143:
	movq	16(%rbp), %rsi
	movq	%r13, %rdi
	subq	%r13, %rsi
	call	_ZdlPvm@PLT
	jmp	.L146
	.p2align 4
	.p2align 3
.L158:
	addq	$1, %rax
	jc	.L149
	movabsq	$1152921504606846975, %rcx
	cmpq	%rcx, %rax
	movq	%rcx, %rbx
	cmovbe	%rax, %rbx
	salq	$3, %rbx
	jmp	.L139
	.p2align 4
	.p2align 3
.L161:
	movq	24(%rsp), %rdi
	movq	%r14, %rsi
	movq	%r12, %rdx
	call	memcpy@PLT
	movq	16(%rbp), %rsi
	movq	%r13, %rdi
	subq	%r13, %rsi
	call	_ZdlPvm@PLT
	jmp	.L146
.L159:
	movabsq	$1152921504606846975, %rax
	cmpq	%rax, %rcx
	cmova	%rax, %rcx
	leaq	0(,%rcx,8), %rbx
	jmp	.L139
.L157:
	leaq	.LC0(%rip), %rdi
	call	_ZSt20__throw_length_errorPKc@PLT
	.cfi_endproc
.LFE8441:
	.size	_ZNSt6vectorIxSaIxEE17_M_realloc_insertIJxEEEvN9__gnu_cxx17__normal_iteratorIPxS1_EEDpOT_, .-_ZNSt6vectorIxSaIxEE17_M_realloc_insertIJxEEEvN9__gnu_cxx17__normal_iteratorIPxS1_EEDpOT_
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC3:
	.string	"=== MOJO-11 \353\271\204\352\265\220: C++ vector add ==="
	.align 8
.LC4:
	.string	"N              scalar(no-vec)  scalar(O3)      AVX-512         scalar/avx  auto/avx"
	.align 8
.LC5:
	.string	"cannot create std::vector larger than max_size()"
	.align 8
.LC24:
	.string	"%-14d %-15lld %-15lld %-15lld %-12lld %-8lld\n"
	.align 8
.LC25:
	.string	"    [avx512 bandwidth] %lld GB/s (effective)\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB26:
	.section	.text.startup,"ax",@progbits
.LHOTB26:
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB8277:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA8277
	endbr64
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-64, %rsp
	leaq	.LC3(%rip), %rdi
	pushq	-8(%r10)
	pushq	%rbp
	movq	%rsp, %rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	pushq	%rbx
	subq	$384, %rsp
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	vmovdqa	.LC2(%rip), %xmm0
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	vmovdqa	%xmm0, -80(%rbp)
.LEHB0:
	call	puts@PLT
	leaq	.LC4(%rip), %rdi
	call	puts@PLT
	leaq	-80(%rbp), %rax
	movq	%rax, -392(%rbp)
	leaq	-64(%rbp), %rax
	movq	%rax, -416(%rbp)
.L300:
	movq	-392(%rbp), %rax
	movslq	(%rax), %rax
	movq	%rax, %r14
	movq	%rax, -384(%rbp)
	shrq	$61, %rax
	jne	.L414
	cmpq	$0, -384(%rbp)
	movq	$0, -200(%rbp)
	movq	$0, -192(%rbp)
	je	.L415
	movq	-384(%rbp), %r15
	leaq	0(,%r15,4), %rbx
	movq	%rbx, %rdi
	movq	%rbx, -376(%rbp)
	call	_Znwm@PLT
.LEHE0:
	addq	%rax, %rbx
	movq	%rax, %r12
	leaq	4(%rax), %rdi
	movq	%rax, -208(%rbp)
	movq	%rbx, -192(%rbp)
	movl	$0x00000000, (%rax)
	cmpq	$1, %r15
	je	.L167
	cmpq	%rdi, %rbx
	je	.L169
	movq	-376(%rbp), %rax
	xorl	%esi, %esi
	leaq	-4(%rax), %rdx
	call	memset@PLT
.L169:
	movq	%rbx, -200(%rbp)
	movq	$0, -168(%rbp)
	movq	$0, -160(%rbp)
.L170:
	movq	-376(%rbp), %r15
	movq	%r15, %rdi
.LEHB1:
	call	_Znwm@PLT
.LEHE1:
	leaq	(%rax,%r15), %r13
	movq	%rax, %rbx
	leaq	4(%rax), %rdi
	movq	%rax, -176(%rbp)
	movl	$0x00000000, (%rax)
	movq	-384(%rbp), %rax
	movq	%r13, -160(%rbp)
	decq	%rax
	movq	%rax, -232(%rbp)
	je	.L171
	cmpq	%rdi, %r13
	je	.L174
	movq	-376(%rbp), %rax
	xorl	%esi, %esi
	leaq	-4(%rax), %rdx
	call	memset@PLT
.L174:
	movq	%r13, -168(%rbp)
	movq	$0, -136(%rbp)
	movq	$0, -128(%rbp)
.L173:
	movq	-376(%rbp), %r13
	movq	%r13, %rdi
.LEHB2:
	call	_Znwm@PLT
.LEHE2:
	addq	%rax, %r13
	cmpq	$0, -232(%rbp)
	movq	%rax, %r15
	leaq	4(%rax), %rdi
	movq	%rax, -144(%rbp)
	movq	%r13, -128(%rbp)
	movl	$0x00000000, (%rax)
	je	.L175
	cmpq	%r13, %rdi
	je	.L177
	movq	-376(%rbp), %rax
	xorl	%esi, %esi
	leaq	-4(%rax), %rdx
	call	memset@PLT
.L177:
	movq	%r13, %rdi
.L175:
	leal	-1(%r14), %eax
	movq	%rdi, -136(%rbp)
	cmpl	$14, %eax
	jbe	.L305
	vmovdqa32	.LC1(%rip), %zmm3
	movl	$16, %edx
	vbroadcastss	.LC12(%rip), %zmm5
	vbroadcastss	.LC14(%rip), %zmm9
	vbroadcastss	.LC16(%rip), %zmm8
	movl	%r14d, %ecx
	xorl	%eax, %eax
	vpbroadcastd	%edx, %zmm7
	movl	$274877907, %edx
	vpbroadcastd	%edx, %zmm4
	movl	$1000, %edx
	shrl	$4, %ecx
	vpbroadcastd	%edx, %zmm6
	salq	$6, %rcx
	.p2align 4
	.p2align 3
.L179:
	vmovdqa32	%zmm3, %zmm0
	vpaddd	%zmm7, %zmm3, %zmm3
	vmovdqa32	.LC9(%rip), %zmm10
	vpmuldq	%zmm4, %zmm0, %zmm1
	vpsrlq	$32, %zmm0, %zmm2
	vpmuldq	%zmm4, %zmm2, %zmm2
	vpermt2d	%zmm2, %zmm10, %zmm1
	vpsrad	$6, %zmm1, %zmm1
	vpmulld	%zmm6, %zmm1, %zmm1
	vpsubd	%zmm1, %zmm0, %zmm0
	vcvtdq2ps	%zmm0, %zmm0
	vmovaps	%zmm0, %zmm1
	vfmadd132ps	%zmm5, %zmm8, %zmm0
	vfmadd132ps	%zmm5, %zmm9, %zmm1
	vmovups	%zmm0, (%rbx,%rax)
	vmovups	%zmm1, (%r12,%rax)
	addq	$64, %rax
	cmpq	%rax, %rcx
	jne	.L179
	movl	%r14d, %eax
	andl	$-16, %eax
	movl	%eax, %edx
	cmpl	%eax, %r14d
	je	.L404
.L178:
	movl	%r14d, %esi
	subl	%edx, %esi
	leal	-1(%rsi), %ecx
	cmpl	$6, %ecx
	jbe	.L181
	vpbroadcastd	%eax, %ymm0
	vpaddd	.LC17(%rip), %ymm0, %ymm0
	movl	$274877907, %ecx
	vpbroadcastd	%ecx, %ymm2
	movl	$1000, %ecx
	salq	$2, %rdx
	vpmuldq	%ymm2, %ymm0, %ymm1
	vpsrlq	$32, %ymm0, %ymm3
	vpmuldq	%ymm2, %ymm3, %ymm2
	vmovdqa	.LC19(%rip), %ymm3
	vpermt2d	%ymm2, %ymm3, %ymm1
	vpbroadcastd	%ecx, %ymm2
	vpsrad	$6, %ymm1, %ymm1
	vpmulld	%ymm2, %ymm1, %ymm1
	vpsubd	%ymm1, %ymm0, %ymm0
	vbroadcastss	.LC12(%rip), %ymm1
	vcvtdq2ps	%ymm0, %ymm0
	vmovaps	%ymm0, %ymm2
	vfmadd213ps	.LC14(%rip){1to8}, %ymm1, %ymm2
	vfmadd213ps	.LC16(%rip){1to8}, %ymm1, %ymm0
	vmovups	%ymm2, (%r12,%rdx)
	vmovups	%ymm0, (%rbx,%rdx)
	movl	%esi, %edx
	andl	$-8, %edx
	addl	%edx, %eax
	andl	$7, %esi
	je	.L404
.L181:
	movslq	%eax, %rdx
	movl	%eax, %esi
	vmovss	.LC14(%rip), %xmm1
	vmovss	.LC12(%rip), %xmm2
	imulq	$274877907, %rdx, %rcx
	vxorps	%xmm5, %xmm5, %xmm5
	sarl	$31, %esi
	sarq	$38, %rcx
	subl	%esi, %ecx
	movl	%eax, %esi
	imull	$1000, %ecx, %ecx
	salq	$2, %rdx
	subl	%ecx, %esi
	vcvtsi2ssl	%esi, %xmm5, %xmm0
	vfmadd132ss	%xmm0, %xmm1, %xmm2
	leal	1(%rax), %esi
	vmovss	%xmm2, (%r12,%rdx)
	vmovss	.LC16(%rip), %xmm2
	vfmadd132ss	.LC12(%rip), %xmm2, %xmm0
	vmovss	%xmm0, (%rbx,%rdx)
	cmpl	%esi, %r14d
	jle	.L404
	movl	%esi, %ecx
	vmovss	.LC12(%rip), %xmm3
	imulq	$274877907, %rcx, %rcx
	shrq	$38, %rcx
	imull	$1000, %ecx, %ecx
	subl	%ecx, %esi
	vcvtsi2ssl	%esi, %xmm5, %xmm0
	vfmadd132ss	%xmm0, %xmm1, %xmm3
	leal	2(%rax), %esi
	vfmadd132ss	.LC12(%rip), %xmm2, %xmm0
	vmovss	%xmm0, 4(%rbx,%rdx)
	vmovss	%xmm3, 4(%r12,%rdx)
	cmpl	%esi, %r14d
	jle	.L404
	movl	%esi, %ecx
	vmovss	.LC12(%rip), %xmm3
	imulq	$274877907, %rcx, %rcx
	shrq	$38, %rcx
	imull	$1000, %ecx, %ecx
	subl	%ecx, %esi
	vcvtsi2ssl	%esi, %xmm5, %xmm0
	vfmadd132ss	%xmm0, %xmm1, %xmm3
	leal	3(%rax), %esi
	vfmadd132ss	.LC12(%rip), %xmm2, %xmm0
	vmovss	%xmm0, 8(%rbx,%rdx)
	vmovss	%xmm3, 8(%r12,%rdx)
	cmpl	%esi, %r14d
	jle	.L404
	movl	%esi, %ecx
	vmovss	.LC12(%rip), %xmm3
	imulq	$274877907, %rcx, %rcx
	shrq	$38, %rcx
	imull	$1000, %ecx, %ecx
	subl	%ecx, %esi
	vcvtsi2ssl	%esi, %xmm5, %xmm0
	vfmadd132ss	%xmm0, %xmm1, %xmm3
	leal	4(%rax), %esi
	vfmadd132ss	.LC12(%rip), %xmm2, %xmm0
	vmovss	%xmm0, 12(%rbx,%rdx)
	vmovss	%xmm3, 12(%r12,%rdx)
	cmpl	%esi, %r14d
	jle	.L404
	movl	%esi, %ecx
	vmovss	.LC12(%rip), %xmm3
	imulq	$274877907, %rcx, %rcx
	shrq	$38, %rcx
	imull	$1000, %ecx, %ecx
	subl	%ecx, %esi
	vcvtsi2ssl	%esi, %xmm5, %xmm0
	vfmadd132ss	%xmm0, %xmm1, %xmm3
	leal	5(%rax), %esi
	vfmadd132ss	.LC12(%rip), %xmm2, %xmm0
	vmovss	%xmm0, 16(%rbx,%rdx)
	vmovss	%xmm3, 16(%r12,%rdx)
	cmpl	%esi, %r14d
	jle	.L404
	movl	%esi, %ecx
	vmovss	.LC12(%rip), %xmm3
	addl	$6, %eax
	imulq	$274877907, %rcx, %rcx
	shrq	$38, %rcx
	imull	$1000, %ecx, %ecx
	subl	%ecx, %esi
	vcvtsi2ssl	%esi, %xmm5, %xmm0
	vfmadd132ss	%xmm0, %xmm1, %xmm3
	vfmadd132ss	.LC12(%rip), %xmm2, %xmm0
	vmovss	%xmm0, 20(%rbx,%rdx)
	vmovss	%xmm3, 20(%r12,%rdx)
	cmpl	%eax, %r14d
	jle	.L404
	movl	%eax, %ecx
	imulq	$274877907, %rcx, %rcx
	shrq	$38, %rcx
	imull	$1000, %ecx, %ecx
	subl	%ecx, %eax
	vcvtsi2ssl	%eax, %xmm5, %xmm0
	vfmadd231ss	.LC12(%rip), %xmm0, %xmm1
	vfmadd132ss	.LC12(%rip), %xmm2, %xmm0
	vmovss	%xmm1, 24(%r12,%rdx)
	vmovss	%xmm0, 24(%rbx,%rdx)
	vzeroupper
.L166:
	movl	$3, %r8d
.L183:
	movl	%r14d, %ecx
	movq	%r15, %rdx
	movq	%rbx, %rsi
	movq	%r12, %rdi
	call	_Z10add_scalarPKfS0_Pfi
	decl	%r8d
	jne	.L183
	leaq	-216(%rbp), %rax
	xorl	%r8d, %r8d
	movq	$0, -112(%rbp)
	movq	$0, -104(%rbp)
	movq	$0, -96(%rbp)
	movl	$10, -240(%rbp)
	movq	$0, -304(%rbp)
	movq	%rax, -312(%rbp)
	jmp	.L186
	.p2align 4
	.p2align 3
.L417:
	movq	%rax, (%r8)
	addq	$8, %r8
	decl	-240(%rbp)
	movq	%r8, -104(%rbp)
	je	.L416
.L186:
	movq	%r8, -232(%rbp)
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	movq	%r12, %rdi
	movl	%r14d, %ecx
	movq	%r15, %rdx
	movq	%rbx, %rsi
	movq	%rax, %r13
	call	_Z10add_scalarPKfS0_Pfi
	vzeroupper
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	movq	-304(%rbp), %rdi
	movq	-232(%rbp), %r8
	subq	%r13, %rax
	movq	%rax, -216(%rbp)
	cmpq	%rdi, %r8
	jne	.L417
	movq	-312(%rbp), %rdx
	leaq	-112(%rbp), %rax
	movq	%r8, %rsi
	movq	%rax, %rdi
	movq	%rax, -232(%rbp)
.LEHB3:
	call	_ZNSt6vectorIxSaIxEE17_M_realloc_insertIJxEEEvN9__gnu_cxx17__normal_iteratorIPxS1_EEDpOT_
.LEHE3:
	movq	-96(%rbp), %rax
	movq	-104(%rbp), %r8
	decl	-240(%rbp)
	movq	%rax, -304(%rbp)
	jne	.L186
.L416:
	movq	-112(%rbp), %r13
	movq	-304(%rbp), %rax
	subq	%r13, %rax
	movq	%rax, -232(%rbp)
	cmpq	%r8, %r13
	je	.L187
	movq	%r8, %rcx
	movl	$63, %edx
	movq	%r8, %rsi
	movq	%r13, %rdi
	subq	%r13, %rcx
	movq	%r8, -304(%rbp)
	movq	%rcx, %rax
	movq	%rcx, -240(%rbp)
	sarq	$3, %rax
	lzcntq	%rax, %rax
	subl	%eax, %edx
	movslq	%edx, %rdx
	addq	%rdx, %rdx
	call	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPxSt6vectorIxSaIxEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_.isra.0
	movq	-240(%rbp), %rcx
	movq	-304(%rbp), %r8
	leaq	8(%r13), %rax
	cmpq	$128, %rcx
	jle	.L188
	leaq	128(%r13), %rsi
	movq	%r12, -240(%rbp)
	movq	%rbx, -312(%rbp)
	movq	%r13, %r12
	movq	%rsi, %rbx
	movq	%rax, %r13
	movl	%r14d, -304(%rbp)
	movq	%r8, -320(%rbp)
	jmp	.L195
	.p2align 4
	.p2align 3
.L419:
	movq	%r13, %rdx
	subq	%r12, %rdx
	cmpq	$8, %rdx
	jle	.L190
	movl	$8, %edi
	movq	%r12, %rsi
	subq	%rdx, %rdi
	addq	%r13, %rdi
	call	memmove@PLT
.L191:
	addq	$8, %r13
	movq	%r14, (%r12)
	cmpq	%r13, %rbx
	je	.L418
.L195:
	movq	0(%r13), %r14
	movq	(%r12), %rax
	movq	%r13, %rsi
	cmpq	%rax, %r14
	jl	.L419
	movq	-8(%r13), %rdx
	leaq	-8(%r13), %rax
	cmpq	%rdx, %r14
	jge	.L193
	.p2align 4
	.p2align 3
.L194:
	movq	%rax, %rsi
	movq	%rdx, 8(%rax)
	movq	-8(%rax), %rdx
	subq	$8, %rax
	cmpq	%rdx, %r14
	jl	.L194
.L193:
	addq	$8, %r13
	movq	%r14, (%rsi)
	cmpq	%r13, %rbx
	jne	.L195
.L418:
	movq	-320(%rbp), %r8
	movq	%rbx, %rsi
	movq	%r12, %r13
	movl	-304(%rbp), %r14d
	movq	-240(%rbp), %r12
	movq	-312(%rbp), %rbx
	cmpq	%r8, %rsi
	je	.L200
	.p2align 4
	.p2align 3
.L196:
	movq	(%rsi), %rcx
	movq	-8(%rsi), %rdx
	leaq	-8(%rsi), %rax
	cmpq	%rdx, %rcx
	jge	.L306
	.p2align 4
	.p2align 3
.L199:
	movq	%rax, %rdi
	movq	%rdx, 8(%rax)
	movq	-8(%rax), %rdx
	subq	$8, %rax
	cmpq	%rdx, %rcx
	jl	.L199
.L198:
	addq	$8, %rsi
	movq	%rcx, (%rdi)
	cmpq	%r8, %rsi
	jne	.L196
.L200:
	movq	40(%r13), %rax
	movq	%rax, -408(%rbp)
.L197:
	movq	-232(%rbp), %rsi
	movq	%r13, %rdi
	call	_ZdlPvm@PLT
	testl	%r14d, %r14d
	je	.L208
	vmovss	(%r12), %xmm0
	vaddss	(%rbx), %xmm0, %xmm0
	vmovss	%xmm0, (%r15)
	cmpl	$1, %r14d
	je	.L208
	vmovss	4(%r12), %xmm0
	vaddss	4(%rbx), %xmm0, %xmm0
	vmovss	%xmm0, 4(%r15)
	cmpl	$2, %r14d
	je	.L208
	vmovss	8(%r12), %xmm0
	vaddss	8(%rbx), %xmm0, %xmm0
	movl	$3, %eax
	vmovss	%xmm0, 8(%r15)
	cmpl	$3, %r14d
	je	.L208
.L210:
	vmovss	(%r12,%rax,4), %xmm0
	vaddss	(%rbx,%rax,4), %xmm0, %xmm0
	vmovss	%xmm0, (%r15,%rax,4)
	incq	%rax
	cmpl	%eax, %r14d
	jne	.L210
.L208:
	movl	%r14d, %r13d
	leal	-1(%r14), %eax
	xorl	%esi, %esi
	movq	$0, -112(%rbp)
	shrl	$4, %r13d
	movl	%eax, -320(%rbp)
	movq	$0, -104(%rbp)
	movq	$0, -96(%rbp)
	movl	$10, -312(%rbp)
	movq	$0, -240(%rbp)
	movl	%r14d, %eax
	salq	$6, %r13
	andl	$-16, %eax
	movl	%eax, -324(%rbp)
	.p2align 4
	.p2align 3
.L224:
	movq	%rsi, -304(%rbp)
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	testl	%r14d, %r14d
	movq	-304(%rbp), %rsi
	movq	%rax, -232(%rbp)
	je	.L219
	xorl	%eax, %eax
	cmpl	$14, -320(%rbp)
	jbe	.L308
	.p2align 4
	.p2align 3
.L217:
	vmovups	(%r12,%rax), %zmm7
	vaddps	(%rbx,%rax), %zmm7, %zmm0
	vmovups	%zmm0, (%r15,%rax)
	addq	$64, %rax
	cmpq	%rax, %r13
	jne	.L217
	movl	-324(%rbp), %edx
	movl	%edx, %eax
	cmpl	%eax, %r14d
	je	.L412
.L216:
	movl	%r14d, %ecx
	subl	%eax, %ecx
	leal	-1(%rcx), %edi
	cmpl	$6, %edi
	jbe	.L221
	salq	$2, %rax
	vmovups	(%r12,%rax), %ymm5
	vaddps	(%rbx,%rax), %ymm5, %ymm0
	vmovups	%ymm0, (%r15,%rax)
	movl	%ecx, %eax
	andl	$-8, %eax
	addl	%eax, %edx
	andl	$7, %ecx
	je	.L412
.L221:
	movslq	%edx, %rax
	leal	1(%rdx), %ecx
	salq	$2, %rax
	vmovss	(%r12,%rax), %xmm0
	vaddss	(%rbx,%rax), %xmm0, %xmm0
	vmovss	%xmm0, (%r15,%rax)
	cmpl	%ecx, %r14d
	jle	.L412
	vmovss	4(%r12,%rax), %xmm0
	vaddss	4(%rbx,%rax), %xmm0, %xmm0
	leal	2(%rdx), %ecx
	vmovss	%xmm0, 4(%r15,%rax)
	cmpl	%ecx, %r14d
	jle	.L412
	vmovss	8(%rbx,%rax), %xmm0
	vaddss	8(%r12,%rax), %xmm0, %xmm0
	leal	3(%rdx), %ecx
	vmovss	%xmm0, 8(%r15,%rax)
	cmpl	%ecx, %r14d
	jle	.L412
	vmovss	12(%r12,%rax), %xmm0
	vaddss	12(%rbx,%rax), %xmm0, %xmm0
	leal	4(%rdx), %ecx
	vmovss	%xmm0, 12(%r15,%rax)
	cmpl	%ecx, %r14d
	jle	.L412
	vmovss	16(%r12,%rax), %xmm0
	vaddss	16(%rbx,%rax), %xmm0, %xmm0
	leal	5(%rdx), %ecx
	vmovss	%xmm0, 16(%r15,%rax)
	cmpl	%ecx, %r14d
	jle	.L412
	vmovss	20(%r12,%rax), %xmm0
	vaddss	20(%rbx,%rax), %xmm0, %xmm0
	addl	$6, %edx
	vmovss	%xmm0, 20(%r15,%rax)
	cmpl	%edx, %r14d
	jle	.L412
	vmovss	24(%r12,%rax), %xmm0
	vaddss	24(%rbx,%rax), %xmm0, %xmm0
	vmovss	%xmm0, 24(%r15,%rax)
	vzeroupper
.L219:
	movq	%rsi, -304(%rbp)
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	movq	-232(%rbp), %rdi
	movq	-304(%rbp), %rsi
	subq	%rdi, %rax
	movq	-240(%rbp), %rdi
	movq	%rax, -216(%rbp)
	cmpq	%rdi, %rsi
	je	.L420
	movq	%rax, (%rsi)
	addq	$8, %rsi
	movq	%rsi, -104(%rbp)
.L223:
	decl	-312(%rbp)
	jne	.L224
	movq	-112(%rbp), %r13
	movq	-240(%rbp), %rax
	subq	%r13, %rax
	movq	%rax, -232(%rbp)
	cmpq	%rsi, %r13
	je	.L225
	movq	%rsi, %rcx
	movl	$63, %edx
	movq	%r13, %rdi
	movq	%rsi, -304(%rbp)
	subq	%r13, %rcx
	movq	%rcx, %rax
	movq	%rcx, -240(%rbp)
	sarq	$3, %rax
	lzcntq	%rax, %rax
	subl	%eax, %edx
	movslq	%edx, %rdx
	addq	%rdx, %rdx
	call	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPxSt6vectorIxSaIxEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_.isra.0
	movq	-240(%rbp), %rcx
	movq	-304(%rbp), %rsi
	leaq	8(%r13), %rax
	cmpq	$128, %rcx
	jle	.L226
	leaq	128(%r13), %r8
	movl	%r14d, -304(%rbp)
	movq	%r12, -240(%rbp)
	movq	%rbx, -312(%rbp)
	movq	%r8, %r14
	movq	%r13, %rbx
	movq	%rax, %r12
	movq	%rsi, -320(%rbp)
	jmp	.L233
	.p2align 4
	.p2align 3
.L422:
	movq	%r12, %rdx
	subq	%rbx, %rdx
	cmpq	$8, %rdx
	jle	.L228
	movl	$8, %edi
	movq	%rbx, %rsi
	subq	%rdx, %rdi
	addq	%r12, %rdi
	call	memmove@PLT
.L229:
	addq	$8, %r12
	movq	%r13, (%rbx)
	cmpq	%r12, %r14
	je	.L421
.L233:
	movq	(%r12), %r13
	movq	(%rbx), %rax
	movq	%r12, %rsi
	cmpq	%rax, %r13
	jl	.L422
	movq	-8(%r12), %rdx
	leaq	-8(%r12), %rax
	cmpq	%rdx, %r13
	jge	.L231
	.p2align 4
	.p2align 3
.L232:
	movq	%rax, %rsi
	movq	%rdx, 8(%rax)
	movq	-8(%rax), %rdx
	subq	$8, %rax
	cmpq	%rdx, %r13
	jl	.L232
.L231:
	addq	$8, %r12
	movq	%r13, (%rsi)
	cmpq	%r12, %r14
	jne	.L233
.L421:
	movq	-320(%rbp), %rsi
	movq	%r14, %r8
	movq	%rbx, %r13
	movq	-240(%rbp), %r12
	movq	-312(%rbp), %rbx
	movl	-304(%rbp), %r14d
	cmpq	%rsi, %r8
	je	.L239
	.p2align 4
	.p2align 3
.L238:
	movq	(%r8), %rcx
	movq	-8(%r8), %rdx
	movq	%r8, %rdi
	leaq	-8(%r8), %rax
	cmpq	%rdx, %rcx
	jge	.L236
	.p2align 4
	.p2align 3
.L237:
	movq	%rax, %rdi
	movq	%rdx, 8(%rax)
	movq	-8(%rax), %rdx
	subq	$8, %rax
	cmpq	%rdx, %rcx
	jl	.L237
.L236:
	addq	$8, %r8
	movq	%rcx, (%rdi)
	cmpq	%r8, %rsi
	jne	.L238
.L239:
	movq	40(%r13), %rax
	movq	%rax, -400(%rbp)
.L235:
	movq	-232(%rbp), %rsi
	movq	%r13, %rdi
	call	_ZdlPvm@PLT
	leal	-16(%r14), %eax
	movl	%r14d, %edi
	movl	$3, %ecx
	shrl	$4, %eax
	leal	1(%rax), %r13d
	xorl	%eax, %eax
	movl	%r13d, %edx
	sall	$4, %edx
	salq	$6, %r13
	cmpl	$15, %r14d
	cmovg	%edx, %eax
	movslq	%eax, %r9
	subl	%r9d, %edi
	movq	%r9, %r10
	movl	%r9d, -328(%rbp)
	movq	%r9, -240(%rbp)
	leal	-1(%rdi), %eax
	movl	%edi, -320(%rbp)
	movl	%eax, -324(%rbp)
	leaq	0(,%r9,4), %rax
	leaq	(%rbx,%rax), %rsi
	leaq	(%r12,%rax), %r11
	addq	%r15, %rax
	movq	%rax, -344(%rbp)
	movl	%edi, %eax
	andl	$15, %edi
	movq	%rsi, -336(%rbp)
	andl	$-16, %eax
	movl	%edi, %esi
	movq	%r11, -368(%rbp)
	movl	%eax, -356(%rbp)
	addl	%r9d, %eax
	movl	%eax, -352(%rbp)
.L247:
	cmpl	$15, %r14d
	jle	.L423
.L251:
	xorl	%eax, %eax
	.p2align 4
	.p2align 3
.L249:
	vmovups	(%r12,%rax), %zmm4
	vaddps	(%rbx,%rax), %zmm4, %zmm0
	vmovups	%zmm0, (%r15,%rax)
	addq	$64, %rax
	cmpq	%rax, %r13
	jne	.L249
	cmpl	%r10d, %r14d
	jle	.L424
.L250:
	cmpl	$14, -324(%rbp)
	jbe	.L309
	movq	-336(%rbp), %rax
	vmovups	(%rax), %zmm2
	vaddps	(%r11), %zmm2, %zmm0
	movq	-344(%rbp), %rax
	vmovups	%zmm0, (%rax)
	testl	%esi, %esi
	je	.L255
	movl	-356(%rbp), %eax
	movl	-352(%rbp), %edx
.L253:
	movl	-320(%rbp), %edi
	subl	%eax, %edi
	leal	-1(%rdi), %r8d
	cmpl	$6, %r8d
	jbe	.L256
	addq	%r9, %rax
	salq	$2, %rax
	vmovups	(%r12,%rax), %ymm3
	vaddps	(%rbx,%rax), %ymm3, %ymm0
	vmovups	%ymm0, (%r15,%rax)
	movl	%edi, %eax
	andl	$-8, %eax
	addl	%eax, %edx
	andl	$7, %edi
	je	.L255
.L256:
	movslq	%edx, %rax
	leal	1(%rdx), %edi
	salq	$2, %rax
	vmovss	(%r12,%rax), %xmm0
	vaddss	(%rbx,%rax), %xmm0, %xmm0
	vmovss	%xmm0, (%r15,%rax)
	cmpl	%edi, %r14d
	jle	.L255
	vmovss	4(%r12,%rax), %xmm0
	vaddss	4(%rbx,%rax), %xmm0, %xmm0
	leal	2(%rdx), %edi
	vmovss	%xmm0, 4(%r15,%rax)
	cmpl	%edi, %r14d
	jle	.L255
	vmovss	8(%r12,%rax), %xmm0
	vaddss	8(%rbx,%rax), %xmm0, %xmm0
	leal	3(%rdx), %edi
	vmovss	%xmm0, 8(%r15,%rax)
	cmpl	%edi, %r14d
	jle	.L255
	vmovss	12(%rbx,%rax), %xmm0
	vaddss	12(%r12,%rax), %xmm0, %xmm0
	leal	4(%rdx), %edi
	vmovss	%xmm0, 12(%r15,%rax)
	cmpl	%edi, %r14d
	jle	.L255
	vmovss	16(%r12,%rax), %xmm0
	vaddss	16(%rbx,%rax), %xmm0, %xmm0
	leal	5(%rdx), %edi
	vmovss	%xmm0, 16(%r15,%rax)
	cmpl	%edi, %r14d
	jle	.L255
	vmovss	20(%rbx,%rax), %xmm0
	vaddss	20(%r12,%rax), %xmm0, %xmm0
	addl	$6, %edx
	vmovss	%xmm0, 20(%r15,%rax)
	cmpl	%edx, %r14d
	jle	.L255
	vmovss	24(%r12,%rax), %xmm0
	vaddss	24(%rbx,%rax), %xmm0, %xmm0
	vmovss	%xmm0, 24(%r15,%rax)
.L255:
	decl	%ecx
	jne	.L247
.L252:
	movl	-320(%rbp), %eax
	xorl	%esi, %esi
	movq	$0, -112(%rbp)
	movq	$0, -104(%rbp)
	movq	$0, -96(%rbp)
	movl	$10, -348(%rbp)
	movq	$0, -312(%rbp)
	andl	$15, %eax
	movl	%eax, -360(%rbp)
	vzeroupper
	.p2align 4
	.p2align 3
.L270:
	movq	%rsi, -304(%rbp)
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	cmpl	$15, %r14d
	movq	-304(%rbp), %rsi
	movq	%rax, -232(%rbp)
	jle	.L259
	xorl	%eax, %eax
	.p2align 4
	.p2align 3
.L260:
	vmovups	(%r12,%rax), %zmm6
	vaddps	(%rbx,%rax), %zmm6, %zmm0
	vmovups	%zmm0, (%r15,%rax)
	addq	$64, %rax
	cmpq	%rax, %r13
	jne	.L260
.L259:
	movl	-328(%rbp), %eax
	cmpl	%eax, %r14d
	jle	.L266
	cmpl	$14, -324(%rbp)
	jbe	.L310
	movq	-368(%rbp), %rax
	movl	-360(%rbp), %ecx
	vmovups	(%rax), %zmm2
	movq	-336(%rbp), %rax
	vaddps	(%rax), %zmm2, %zmm0
	movq	-344(%rbp), %rax
	vmovaps	%zmm2, -304(%rbp)
	vmovups	%zmm0, (%rax)
	testl	%ecx, %ecx
	je	.L266
	movl	-356(%rbp), %eax
	movl	-352(%rbp), %edx
.L264:
	movl	-320(%rbp), %ecx
	subl	%eax, %ecx
	leal	-1(%rcx), %edi
	cmpl	$6, %edi
	jbe	.L267
	movq	-240(%rbp), %rdi
	addq	%rdi, %rax
	salq	$2, %rax
	vmovups	(%rbx,%rax), %ymm3
	vaddps	(%r12,%rax), %ymm3, %ymm0
	vmovups	%ymm0, (%r15,%rax)
	movl	%ecx, %eax
	andl	$-8, %eax
	addl	%eax, %edx
	andl	$7, %ecx
	je	.L266
.L267:
	movslq	%edx, %rax
	leal	1(%rdx), %ecx
	salq	$2, %rax
	vmovss	(%r12,%rax), %xmm0
	vaddss	(%rbx,%rax), %xmm0, %xmm0
	vmovss	%xmm0, (%r15,%rax)
	cmpl	%ecx, %r14d
	jle	.L266
	vmovss	4(%r12,%rax), %xmm0
	vaddss	4(%rbx,%rax), %xmm0, %xmm0
	leal	2(%rdx), %ecx
	vmovss	%xmm0, 4(%r15,%rax)
	cmpl	%ecx, %r14d
	jle	.L266
	vmovss	8(%r12,%rax), %xmm0
	vaddss	8(%rbx,%rax), %xmm0, %xmm0
	leal	3(%rdx), %ecx
	vmovss	%xmm0, 8(%r15,%rax)
	cmpl	%ecx, %r14d
	jle	.L266
	vmovss	12(%r12,%rax), %xmm0
	vaddss	12(%rbx,%rax), %xmm0, %xmm0
	leal	4(%rdx), %ecx
	vmovss	%xmm0, 12(%r15,%rax)
	cmpl	%ecx, %r14d
	jle	.L266
	vmovss	16(%rbx,%rax), %xmm0
	vaddss	16(%r12,%rax), %xmm0, %xmm0
	leal	5(%rdx), %ecx
	vmovss	%xmm0, 16(%r15,%rax)
	cmpl	%ecx, %r14d
	jle	.L266
	vmovss	20(%rbx,%rax), %xmm0
	vaddss	20(%r12,%rax), %xmm0, %xmm0
	addl	$6, %edx
	vmovss	%xmm0, 20(%r15,%rax)
	cmpl	%edx, %r14d
	jle	.L266
	vmovss	24(%rbx,%rax), %xmm0
	vaddss	24(%r12,%rax), %xmm0, %xmm0
	vmovss	%xmm0, 24(%r15,%rax)
.L266:
	movq	%rsi, -304(%rbp)
	vzeroupper
	call	_ZNSt6chrono3_V212system_clock3nowEv@PLT
	movq	-232(%rbp), %rdi
	movq	-304(%rbp), %rsi
	subq	%rdi, %rax
	movq	-312(%rbp), %rdi
	movq	%rax, -216(%rbp)
	cmpq	%rdi, %rsi
	je	.L425
	movq	%rax, (%rsi)
	addq	$8, %rsi
	movq	%rsi, -104(%rbp)
.L269:
	decl	-348(%rbp)
	jne	.L270
	movq	-112(%rbp), %r13
	movq	-312(%rbp), %rax
	subq	%r13, %rax
	movq	%rax, -232(%rbp)
	cmpq	%rsi, %r13
	je	.L271
	movq	%rsi, %rcx
	movl	$63, %edx
	movq	%r13, %rdi
	movq	%rsi, -304(%rbp)
	subq	%r13, %rcx
	movq	%rcx, %rax
	movq	%rcx, -240(%rbp)
	sarq	$3, %rax
	lzcntq	%rax, %rax
	subl	%eax, %edx
	movslq	%edx, %rdx
	addq	%rdx, %rdx
	call	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPxSt6vectorIxSaIxEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_.isra.0
	movq	-240(%rbp), %rcx
	movq	-304(%rbp), %rsi
	leaq	8(%r13), %rax
	cmpq	$128, %rcx
	jle	.L272
	leaq	128(%r13), %r8
	movl	%r14d, -304(%rbp)
	movq	%r12, -240(%rbp)
	movq	%rbx, -312(%rbp)
	movq	%r8, %r14
	movq	%r13, %rbx
	movq	%rax, %r12
	movq	%rsi, -320(%rbp)
	jmp	.L279
	.p2align 4
	.p2align 3
.L427:
	movq	%r12, %rdx
	subq	%rbx, %rdx
	cmpq	$8, %rdx
	jle	.L274
	movl	$8, %edi
	movq	%rbx, %rsi
	subq	%rdx, %rdi
	addq	%r12, %rdi
	call	memmove@PLT
.L275:
	addq	$8, %r12
	movq	%r13, (%rbx)
	cmpq	%r12, %r14
	je	.L426
.L279:
	movq	(%r12), %r13
	movq	(%rbx), %rax
	movq	%r12, %rsi
	cmpq	%rax, %r13
	jl	.L427
	movq	-8(%r12), %rdx
	leaq	-8(%r12), %rax
	cmpq	%rdx, %r13
	jge	.L277
	.p2align 4
	.p2align 3
.L278:
	movq	%rax, %rsi
	movq	%rdx, 8(%rax)
	movq	-8(%rax), %rdx
	subq	$8, %rax
	cmpq	%rdx, %r13
	jl	.L278
.L277:
	addq	$8, %r12
	movq	%r13, (%rsi)
	cmpq	%r12, %r14
	jne	.L279
.L426:
	movq	-320(%rbp), %rsi
	movq	%r14, %r8
	movq	%rbx, %r13
	movq	-240(%rbp), %r12
	movq	-312(%rbp), %rbx
	movl	-304(%rbp), %r14d
	cmpq	%rsi, %r8
	je	.L285
	.p2align 4
	.p2align 3
.L284:
	movq	(%r8), %rcx
	movq	-8(%r8), %rdx
	movq	%r8, %rdi
	leaq	-8(%r8), %rax
	cmpq	%rcx, %rdx
	jle	.L282
	.p2align 4
	.p2align 3
.L283:
	movq	%rax, %rdi
	movq	%rdx, 8(%rax)
	movq	-8(%rax), %rdx
	subq	$8, %rax
	cmpq	%rdx, %rcx
	jl	.L283
.L282:
	addq	$8, %r8
	movq	%rcx, (%rdi)
	cmpq	%r8, %rsi
	jne	.L284
.L285:
	movq	40(%r13), %r9
.L281:
	movq	-232(%rbp), %rsi
	movq	%r13, %rdi
	movq	%r9, -304(%rbp)
	call	_ZdlPvm@PLT
	movq	-400(%rbp), %rax
	movq	-304(%rbp), %r9
	movq	-400(%rbp), %r8
	movq	-408(%rbp), %rcx
	leaq	.LC24(%rip), %rsi
	movl	$2, %edi
	leaq	1(%r9), %r13
	cqto
	idivq	%r13
	pushq	%rax
	movq	-408(%rbp), %rax
	cqto
	idivq	%r13
	movl	%r14d, %edx
	pushq	%rax
	xorl	%eax, %eax
.LEHB4:
	.cfi_escape 0x2e,0x10
	call	__printf_chk@PLT
	popq	%rax
	movq	-384(%rbp), %rax
	leaq	.LC25(%rip), %rsi
	movl	$2, %edi
	popq	%rdx
	leaq	(%rax,%rax,2), %rax
	salq	$2, %rax
	cqto
	idivq	%r13
	movq	%rax, %rdx
	xorl	%eax, %eax
	.cfi_escape 0x2e,0
	call	__printf_chk@PLT
.LEHE4:
	testq	%r15, %r15
	je	.L295
	movq	-376(%rbp), %rsi
	movq	%r15, %rdi
	call	_ZdlPvm@PLT
.L295:
	testq	%rbx, %rbx
	je	.L296
	movq	-376(%rbp), %rsi
	movq	%rbx, %rdi
	call	_ZdlPvm@PLT
.L296:
	testq	%r12, %r12
	je	.L297
	movq	-376(%rbp), %rsi
	movq	%r12, %rdi
	call	_ZdlPvm@PLT
	addq	$4, -392(%rbp)
	movq	-416(%rbp), %rdi
	movq	-392(%rbp), %rax
	cmpq	%rdi, %rax
	jne	.L300
.L299:
	movq	-56(%rbp), %rax
	subq	%fs:40, %rax
	jne	.L391
	leaq	-48(%rbp), %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
.L404:
	.cfi_restore_state
	vzeroupper
	jmp	.L166
.L415:
	xorl	%ebx, %ebx
	xorl	%r12d, %r12d
	xorl	%r15d, %r15d
	movq	$0, -208(%rbp)
	movq	$0, -192(%rbp)
	movq	$0, -200(%rbp)
	movq	$0, -176(%rbp)
	movq	$0, -160(%rbp)
	movq	$0, -168(%rbp)
	movq	$0, -144(%rbp)
	movq	$0, -128(%rbp)
	movq	$0, -136(%rbp)
	movq	$0, -376(%rbp)
	jmp	.L166
.L188:
	cmpq	%rax, %r8
	je	.L200
	movq	%r12, -240(%rbp)
	movq	%rbx, -312(%rbp)
	movq	%r13, %r12
	movq	%r8, %rbx
	movq	%rax, %r13
	movl	%r14d, -304(%rbp)
	jmp	.L207
	.p2align 4
	.p2align 3
.L429:
	movq	%r13, %rdx
	subq	%r12, %rdx
	cmpq	$8, %rdx
	jle	.L202
	movl	$8, %edi
	movq	%r12, %rsi
	subq	%rdx, %rdi
	addq	%r13, %rdi
	call	memmove@PLT
.L203:
	addq	$8, %r13
	movq	%r14, (%r12)
	cmpq	%r13, %rbx
	je	.L428
.L207:
	movq	0(%r13), %r14
	movq	(%r12), %rax
	movq	%r13, %rsi
	cmpq	%rax, %r14
	jl	.L429
	movq	-8(%r13), %rdx
	leaq	-8(%r13), %rax
	cmpq	%r14, %rdx
	jle	.L205
	.p2align 4
	.p2align 3
.L206:
	movq	%rax, %rsi
	movq	%rdx, 8(%rax)
	movq	-8(%rax), %rdx
	subq	$8, %rax
	cmpq	%rdx, %r14
	jl	.L206
.L205:
	addq	$8, %r13
	movq	%r14, (%rsi)
	cmpq	%r13, %rbx
	jne	.L207
.L428:
	movq	%r12, %r13
	movl	-304(%rbp), %r14d
	movq	-312(%rbp), %rbx
	movq	-240(%rbp), %r12
	jmp	.L200
	.p2align 4
	.p2align 3
.L412:
	vzeroupper
	jmp	.L219
	.p2align 4
	.p2align 3
.L420:
	leaq	-112(%rbp), %rax
	leaq	-216(%rbp), %rdx
	movq	%rax, %rdi
	movq	%rax, -232(%rbp)
.LEHB5:
	call	_ZNSt6vectorIxSaIxEE17_M_realloc_insertIJxEEEvN9__gnu_cxx17__normal_iteratorIPxS1_EEDpOT_
.LEHE5:
	movq	-96(%rbp), %rax
	movq	-104(%rbp), %rsi
	movq	%rax, -240(%rbp)
	jmp	.L223
.L308:
	xorl	%edx, %edx
	jmp	.L216
.L226:
	cmpq	%rax, %rsi
	je	.L239
	movq	%r12, -240(%rbp)
	movq	%rbx, -312(%rbp)
	movq	%r13, %r12
	movq	%rsi, %rbx
	movq	%rax, %r13
	movl	%r14d, -304(%rbp)
	jmp	.L246
	.p2align 4
	.p2align 3
.L431:
	movq	%r13, %rdx
	subq	%r12, %rdx
	cmpq	$8, %rdx
	jle	.L241
	movl	$8, %edi
	movq	%r12, %rsi
	subq	%rdx, %rdi
	addq	%r13, %rdi
	call	memmove@PLT
.L242:
	addq	$8, %r13
	movq	%r14, (%r12)
	cmpq	%r13, %rbx
	je	.L430
.L246:
	movq	0(%r13), %r14
	movq	(%r12), %rax
	movq	%r13, %rsi
	cmpq	%rax, %r14
	jl	.L431
	movq	-8(%r13), %rdx
	leaq	-8(%r13), %rax
	cmpq	%rdx, %r14
	jge	.L244
	.p2align 4
	.p2align 3
.L245:
	movq	%rax, %rsi
	movq	%rdx, 8(%rax)
	movq	-8(%rax), %rdx
	subq	$8, %rax
	cmpq	%rdx, %r14
	jl	.L245
.L244:
	addq	$8, %r13
	movq	%r14, (%rsi)
	cmpq	%r13, %rbx
	jne	.L246
.L430:
	movq	%r12, %r13
	movl	-304(%rbp), %r14d
	movq	-312(%rbp), %rbx
	movq	-240(%rbp), %r12
	jmp	.L239
.L423:
	testl	%r14d, %r14d
	jne	.L250
	jmp	.L255
	.p2align 4
	.p2align 3
.L425:
	leaq	-112(%rbp), %rax
	leaq	-216(%rbp), %rdx
	movq	%rax, %rdi
	movq	%rax, -232(%rbp)
.LEHB6:
	call	_ZNSt6vectorIxSaIxEE17_M_realloc_insertIJxEEEvN9__gnu_cxx17__normal_iteratorIPxS1_EEDpOT_
.LEHE6:
	movq	-96(%rbp), %rax
	movq	-104(%rbp), %rsi
	movq	%rax, -312(%rbp)
	jmp	.L269
.L310:
	movl	%eax, %edx
	xorl	%eax, %eax
	jmp	.L264
.L272:
	cmpq	%rax, %rsi
	je	.L285
	movq	%r12, -240(%rbp)
	movq	%rbx, -312(%rbp)
	movq	%r13, %r12
	movq	%rsi, %rbx
	movq	%rax, %r13
	movl	%r14d, -304(%rbp)
	jmp	.L292
	.p2align 4
	.p2align 3
.L433:
	movq	%r13, %rdx
	subq	%r12, %rdx
	cmpq	$8, %rdx
	jle	.L287
	movl	$8, %edi
	movq	%r12, %rsi
	subq	%rdx, %rdi
	addq	%r13, %rdi
	call	memmove@PLT
.L288:
	addq	$8, %r13
	movq	%r14, (%r12)
	cmpq	%r13, %rbx
	je	.L432
.L292:
	movq	0(%r13), %r14
	movq	(%r12), %rax
	movq	%r13, %rsi
	cmpq	%rax, %r14
	jl	.L433
	movq	-8(%r13), %rdx
	leaq	-8(%r13), %rax
	cmpq	%rdx, %r14
	jge	.L290
	.p2align 4
	.p2align 3
.L291:
	movq	%rax, %rsi
	movq	%rdx, 8(%rax)
	movq	-8(%rax), %rdx
	subq	$8, %rax
	cmpq	%rdx, %r14
	jl	.L291
.L290:
	addq	$8, %r13
	movq	%r14, (%rsi)
	cmpq	%r13, %rbx
	jne	.L292
.L432:
	movq	%r12, %r13
	movl	-304(%rbp), %r14d
	movq	-312(%rbp), %rbx
	movq	-240(%rbp), %r12
	jmp	.L285
.L297:
	addq	$4, -392(%rbp)
	movq	-392(%rbp), %rax
	cmpq	%rax, -416(%rbp)
	jne	.L300
	jmp	.L299
.L271:
	movq	40(%rsi), %r9
	jmp	.L281
.L225:
	movq	40(%rsi), %rax
	movq	%rax, -400(%rbp)
	jmp	.L235
.L187:
	movq	40(%r8), %rax
	movq	%rax, -408(%rbp)
	jmp	.L197
.L306:
	movq	%rsi, %rdi
	jmp	.L198
.L424:
	decl	%ecx
	jne	.L251
	jmp	.L252
.L309:
	xorl	%eax, %eax
	movl	%r10d, %edx
	jmp	.L253
.L167:
	movq	%rdi, -200(%rbp)
	xorl	%edi, %edi
	movq	$4, -376(%rbp)
	movq	%rdi, -168(%rbp)
	movq	%rdi, -160(%rbp)
	jmp	.L170
.L171:
	xorl	%esi, %esi
	movq	%rdi, -168(%rbp)
	movq	%rsi, -136(%rbp)
	movq	%rsi, -128(%rbp)
	jmp	.L173
.L287:
	jne	.L288
	movq	%rax, 0(%r13)
	jmp	.L288
.L274:
	jne	.L275
	movq	%rax, (%r12)
	jmp	.L275
.L241:
	jne	.L242
	movq	%rax, 0(%r13)
	jmp	.L242
.L228:
	jne	.L229
	movq	%rax, (%r12)
	jmp	.L229
.L202:
	jne	.L203
	movq	%rax, 0(%r13)
	jmp	.L203
.L190:
	jne	.L191
	movq	%rax, 0(%r13)
	jmp	.L191
.L305:
	xorl	%edx, %edx
	xorl	%eax, %eax
	jmp	.L178
.L414:
	movq	-56(%rbp), %rax
	subq	%fs:40, %rax
	jne	.L391
	leaq	.LC5(%rip), %rdi
.LEHB7:
	call	_ZSt20__throw_length_errorPKc@PLT
.LEHE7:
.L391:
	call	__stack_chk_fail@PLT
.L312:
	endbr64
	movq	%rax, %rbx
	vzeroupper
	jmp	.L301
.L313:
	endbr64
	movq	%rax, %rbx
	vzeroupper
	jmp	.L212
.L314:
	endbr64
	movq	%rax, %rbx
	jmp	.L294
.L316:
	endbr64
	movq	%rax, %rbx
	jmp	.L294
.L311:
	endbr64
	movq	%rax, %rbx
	vzeroupper
	jmp	.L302
.L315:
	endbr64
	movq	%rax, %rbx
	jmp	.L294
	.globl	__gxx_personality_v0
	.section	.gcc_except_table,"a",@progbits
.LLSDA8277:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE8277-.LLSDACSB8277
.LLSDACSB8277:
	.uleb128 .LEHB0-.LFB8277
	.uleb128 .LEHE0-.LEHB0
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB1-.LFB8277
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L311-.LFB8277
	.uleb128 0
	.uleb128 .LEHB2-.LFB8277
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L312-.LFB8277
	.uleb128 0
	.uleb128 .LEHB3-.LFB8277
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L314-.LFB8277
	.uleb128 0
	.uleb128 .LEHB4-.LFB8277
	.uleb128 .LEHE4-.LEHB4
	.uleb128 .L313-.LFB8277
	.uleb128 0
	.uleb128 .LEHB5-.LFB8277
	.uleb128 .LEHE5-.LEHB5
	.uleb128 .L315-.LFB8277
	.uleb128 0
	.uleb128 .LEHB6-.LFB8277
	.uleb128 .LEHE6-.LEHB6
	.uleb128 .L316-.LFB8277
	.uleb128 0
	.uleb128 .LEHB7-.LFB8277
	.uleb128 .LEHE7-.LEHB7
	.uleb128 0
	.uleb128 0
.LLSDACSE8277:
	.section	.text.startup
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC8277
	.type	main.cold, @function
main.cold:
.LFSB8277:
.L294:
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	.cfi_escape 0x10,0x6,0x2,0x76,0
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	movq	-232(%rbp), %rdi
	vzeroupper
	call	_ZNSt6vectorIxSaIxEED1Ev
.L212:
	leaq	-144(%rbp), %rdi
	call	_ZNSt6vectorIfSaIfEED1Ev
.L301:
	leaq	-176(%rbp), %rdi
	call	_ZNSt6vectorIfSaIfEED1Ev
.L302:
	leaq	-208(%rbp), %rdi
	call	_ZNSt6vectorIfSaIfEED1Ev
	movq	-56(%rbp), %rax
	subq	%fs:40, %rax
	jne	.L434
	movq	%rbx, %rdi
.LEHB8:
	call	_Unwind_Resume@PLT
.LEHE8:
.L434:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE8277:
	.section	.gcc_except_table
.LLSDAC8277:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC8277-.LLSDACSBC8277
.LLSDACSBC8277:
	.uleb128 .LEHB8-.LCOLDB26
	.uleb128 .LEHE8-.LEHB8
	.uleb128 0
	.uleb128 0
.LLSDACSEC8277:
	.section	.text.unlikely
	.section	.text.startup
	.size	main, .-main
	.section	.text.unlikely
	.size	main.cold, .-main.cold
.LCOLDE26:
	.section	.text.startup
.LHOTE26:
	.section	.rodata
	.align 64
.LC1:
	.long	0
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6
	.long	7
	.long	8
	.long	9
	.long	10
	.long	11
	.long	12
	.long	13
	.long	14
	.long	15
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC2:
	.long	1024
	.long	65536
	.long	1048576
	.long	16777216
	.section	.rodata
	.align 64
.LC9:
	.long	1
	.long	17
	.long	3
	.long	19
	.long	5
	.long	21
	.long	7
	.long	23
	.long	9
	.long	25
	.long	11
	.long	27
	.long	13
	.long	29
	.long	15
	.long	31
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC12:
	.long	1008981770
	.align 4
.LC14:
	.long	1065353216
	.align 4
.LC16:
	.long	1073741824
	.set	.LC17,.LC1
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC19:
	.long	1
	.long	9
	.long	3
	.long	11
	.long	5
	.long	13
	.long	7
	.long	15
	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.rel.local.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.align 8
	.type	DW.ref.__gxx_personality_v0, @object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.quad	__gxx_personality_v0
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
