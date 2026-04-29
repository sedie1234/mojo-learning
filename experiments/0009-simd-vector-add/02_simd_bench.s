	.att_syntax
	.file	"02_simd_bench.mojo"
	.text
	.p2align	4
	.type	main_closure_0,@function
main_closure_0:
	.cfi_startproc
	xorl	%edi, %edi
	jmp	KGEN_CompilerRT_AsyncRT_CreateRuntime@PLT
.Lfunc_end0:
	.size	main_closure_0, .Lfunc_end0-main_closure_0
	.cfi_endproc

	.p2align	4
	.type	main_closure_1,@function
main_closure_1:
	.cfi_startproc
	jmp	KGEN_CompilerRT_AsyncRT_DestroyRuntime@PLT
.Lfunc_end1:
	.size	main_closure_1, .Lfunc_end1-main_closure_1
	.cfi_endproc

	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0
.LCPI2_0:
	.long	0x3c23d70a
.LCPI2_1:
	.long	0x3f800000
.LCPI2_2:
	.long	0x40000000
	.text
	.globl	main
	.p2align	4
	.type	main,@function
main:
.Lmain$local:
	.type	.Lmain$local,@function
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$280, %rsp
	.cfi_def_cfa_offset 336
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rsi, %rbx
	movl	%edi, %ebp
	callq	KGEN_CompilerRT_AsyncRT_GetCurrentRuntime@PLT
	testq	%rax, %rax
	jne	.LBB2_2
	movq	main_closure_0@GOTPCREL(%rip), %rdx
	movq	main_closure_1@GOTPCREL(%rip), %rcx
	leaq	static_string_a61c3395ab9379d9(%rip), %rdi
	movl	$7, %esi
	callq	KGEN_CompilerRT_GetOrCreateGlobal@PLT
.LBB2_2:
	movabsq	$4611686018427387904, %r14
	movabsq	$2305843009213693952, %r15
	movl	%ebp, %edi
	movq	%rbx, %rsi
	callq	KGEN_CompilerRT_SetArgV@PLT
	callq	KGEN_CompilerRT_PrintStackTraceOnFault@PLT
	leaq	static_string_e01f7c7a8e275f5c(%rip), %rax
	leaq	static_string_bbe01a6a523daf15(%rip), %rsi
	leaq	72(%rsp), %rdi
	movl	$1, %edx
	movl	$1, %r8d
	movq	$55, 80(%rsp)
	xorl	%ecx, %ecx
	movq	%rax, 72(%rsp)
	movq	%r15, 88(%rsp)
	callq	"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>]]"@PLT
	testb	$64, 95(%rsp)
	je	.LBB2_5
	movq	72(%rsp), %rdi
	lock		decq	-8(%rdi)
	jne	.LBB2_5
	addq	$-8, %rdi
	#MEMBARRIER
	callq	KGEN_CompilerRT_AlignedFree@PLT
.LBB2_5:
	leaq	static_string_6bc14c4b48f42840(%rip), %rax
	movabsq	$2305843009213693952, %rdx
	movq	$48, 80(%rsp)
	leaq	static_string_bbe01a6a523daf15(%rip), %rsi
	leaq	72(%rsp), %rdi
	movl	$1, %r8d
	xorl	%ecx, %ecx
	movq	%rax, 72(%rsp)
	movq	%rdx, 88(%rsp)
	movl	$1, %edx
	callq	"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>]]"@PLT
	testq	%r14, 88(%rsp)
	je	.LBB2_8
	movq	72(%rsp), %rdi
	lock		decq	-8(%rdi)
	jne	.LBB2_8
	addq	$-8, %rdi
	#MEMBARRIER
	callq	KGEN_CompilerRT_AlignedFree@PLT
.LBB2_8:
	leaq	static_string_bbe01a6a523daf15(%rip), %rdi
	movl	$1, %esi
	movl	$1, %ecx
	xorl	%edx, %edx
	xorl	%ebx, %ebx
	callq	"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[]"@PLT
	leaq	136(%rsp), %rax
	leaq	160(%rsp), %rdx
	leaq	184(%rsp), %rcx
	leaq	16(%rsp), %r15
	movl	$8, %edi
	movl	$32, %esi
	movq	$1024, 136(%rsp)
	movq	$65536, 160(%rsp)
	movq	$1048576, 184(%rsp)
	movq	$16777216, 16(%rsp)
	movq	%rax, 72(%rsp)
	movq	%rdx, 80(%rsp)
	movq	%rcx, 88(%rsp)
	movq	%r15, 96(%rsp)
	callq	KGEN_CompilerRT_AlignedAlloc@PLT
	movq	%rax, %rdi
	.p2align	4
.LBB2_9:
	movq	72(%rsp,%rbx,8), %rax
	movq	(%rax), %rax
	movq	%rax, (%rdi,%rbx,8)
	incq	%rbx
	cmpq	$4, %rbx
	jne	.LBB2_9
	movl	$1, %eax
	movq	%rdi, %rbp
	movq	%rdi, 208(%rsp)
	jmp	.LBB2_11
	.p2align	4
.LBB2_97:
	movq	224(%rsp), %rcx
	movq	208(%rsp), %rdi
	cmpq	$4, %rcx
	leaq	(%rdi,%rcx,8), %rbp
	movq	%rcx, %rax
	adcq	$0, %rax
	cmpq	$4, %rcx
	jae	.LBB2_98
.LBB2_11:
	movq	(%rbp), %r14
	movq	%rax, 224(%rsp)
	testq	%r14, %r14
	jle	.LBB2_12
	movl	$4, %edi
	xorl	%esi, %esi
	xorl	%edx, %edx
	movq	%r14, %rcx
	callq	"std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f32,size=1\">>, scalar<f32>]"@PLT
	testq	%rcx, %rcx
	movq	%rax, %rbx
	setg	%al
	movq	%rax, 128(%rsp)
	subq	%rdx, %r14
	jle	.LBB2_16
.LBB2_15:
	leaq	(%rbx,%rdx,4), %rdi
	shlq	$2, %r14
	xorl	%esi, %esi
	movq	%r14, %rdx
	callq	memset@PLT
.LBB2_16:
	movq	(%rbp), %r14
	testq	%r14, %r14
	jle	.LBB2_17
	movl	$4, %edi
	xorl	%esi, %esi
	xorl	%edx, %edx
	movq	%r14, %rcx
	callq	"std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f32,size=1\">>, scalar<f32>]"@PLT
	testq	%rcx, %rcx
	movq	%rax, %r12
	setg	%al
	movq	%rax, 120(%rsp)
	subq	%rdx, %r14
	jle	.LBB2_21
.LBB2_20:
	leaq	(%r12,%rdx,4), %rdi
	shlq	$2, %r14
	xorl	%esi, %esi
	movq	%r14, %rdx
	callq	memset@PLT
.LBB2_21:
	movq	(%rbp), %r14
	testq	%r14, %r14
	jle	.LBB2_22
	movl	$4, %edi
	xorl	%esi, %esi
	xorl	%edx, %edx
	movq	%r14, %rcx
	callq	"std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f32,size=1\">>, scalar<f32>]"@PLT
	testq	%rcx, %rcx
	movq	%rax, %r13
	setg	%al
	movq	%rax, 112(%rsp)
	jmp	.LBB2_24
	.p2align	4
.LBB2_12:
	xorl	%edx, %edx
	movl	$4, %ebx
	movq	$0, 128(%rsp)
	subq	%rdx, %r14
	jg	.LBB2_15
	jmp	.LBB2_16
	.p2align	4
.LBB2_17:
	movl	$4, %r12d
	xorl	%edx, %edx
	movq	$0, 120(%rsp)
	subq	%rdx, %r14
	jg	.LBB2_20
	jmp	.LBB2_21
	.p2align	4
.LBB2_22:
	movl	$4, %r13d
	xorl	%edx, %edx
	movq	$0, 112(%rsp)
.LBB2_24:
	vmovss	.LCPI2_0(%rip), %xmm2
	vmovss	.LCPI2_1(%rip), %xmm3
	vmovss	.LCPI2_2(%rip), %xmm4
	subq	%rdx, %r14
	jle	.LBB2_26
	leaq	(%r13,%rdx,4), %rdi
	shlq	$2, %r14
	xorl	%esi, %esi
	movq	%r14, %rdx
	callq	memset@PLT
	vmovss	.LCPI2_2(%rip), %xmm4
	vmovss	.LCPI2_1(%rip), %xmm3
	vmovss	.LCPI2_0(%rip), %xmm2
.LBB2_26:
	movq	(%rbp), %rax
	movabsq	$2361183241434822607, %rsi
	movl	$0, %ecx
	testq	%rax, %rax
	cmovleq	%rcx, %rax
	jle	.LBB2_36
	xorl	%ecx, %ecx
	.p2align	4
.LBB2_28:
	movq	%rcx, %rdx
	shrq	$3, %rdx
	mulxq	%rsi, %rdx, %rdx
	shrq	$4, %rdx
	imulq	$-1000, %rdx, %rdx
	addq	%rcx, %rdx
	vcvtsi2ss	%rdx, %xmm15, %xmm0
	vmulss	%xmm2, %xmm0, %xmm0
	vaddss	%xmm3, %xmm0, %xmm1
	vaddss	%xmm4, %xmm0, %xmm0
	vmovss	%xmm1, (%rbx,%rcx,4)
	vmovss	%xmm0, (%r12,%rcx,4)
	incq	%rcx
	cmpq	%rcx, %rax
	jne	.LBB2_28
	movq	(%rbp), %rcx
	testq	%rcx, %rcx
	jle	.LBB2_36
	movl	$2, %eax
	testq	%rcx, %rcx
	movl	$0, %edx
	cmovleq	%rdx, %rcx
	jle	.LBB2_31
	.p2align	4
.LBB2_34:
	xorl	%edx, %edx
	.p2align	4
.LBB2_35:
	vmovss	(%rbx,%rdx,4), %xmm0
	vaddss	(%r12,%rdx,4), %xmm0, %xmm0
	vmovss	%xmm0, (%r13,%rdx,4)
	incq	%rdx
	cmpq	%rdx, %rcx
	jne	.LBB2_35
.LBB2_31:
	subq	$1, %rax
	jb	.LBB2_36
	movq	(%rbp), %rcx
	testq	%rcx, %rcx
	movl	$0, %edx
	cmovleq	%rdx, %rcx
	jg	.LBB2_34
	jmp	.LBB2_31
	.p2align	4
.LBB2_36:
	movl	$8, %eax
	movl	$9, %edx
	movq	%rbp, 104(%rsp)
	xorl	%ebp, %ebp
	movq	$0, 40(%rsp)
	jmp	.LBB2_37
	.p2align	4
.LBB2_42:
	movq	48(%rsp), %rdi
	xorl	%eax, %eax
	testq	%rdx, %rdx
	movq	%rbp, %rsi
	sete	%al
	leaq	(%rax,%rdx,2), %rcx
	callq	"std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index]"@PLT
	movq	%rdx, %rbp
	movq	%rcx, 40(%rsp)
.LBB2_43:
	movq	56(%rsp), %rcx
	subq	64(%rsp), %r14
	movq	8(%rsp), %rdx
	subq	%rcx, %r15
	imulq	$1000000000, %r15, %rcx
	leaq	16(%rsp), %r15
	addq	%rcx, %r14
	movq	%r14, (%rax,%rbp,8)
	incq	%rbp
	subq	$1, %rdx
	jb	.LBB2_44
.LBB2_37:
	movl	$1, %edi
	vxorps	%xmm0, %xmm0, %xmm0
	movq	%r15, %rsi
	movq	%rdx, 8(%rsp)
	movq	%rax, 48(%rsp)
	vmovaps	%xmm0, 16(%rsp)
	callq	clock_gettime@PLT
	movq	16(%rsp), %rax
	movl	$0, %ecx
	movq	%rax, 56(%rsp)
	movq	24(%rsp), %rax
	movq	%rax, 64(%rsp)
	movq	104(%rsp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	cmovleq	%rcx, %rax
	jle	.LBB2_40
	xorl	%ecx, %ecx
	.p2align	4
.LBB2_39:
	vmovss	(%rbx,%rcx,4), %xmm0
	vaddss	(%r12,%rcx,4), %xmm0, %xmm0
	vmovss	%xmm0, (%r13,%rcx,4)
	incq	%rcx
	cmpq	%rcx, %rax
	jne	.LBB2_39
.LBB2_40:
	movl	$1, %edi
	vxorps	%xmm0, %xmm0, %xmm0
	movq	%r15, %rsi
	vmovaps	%xmm0, 16(%rsp)
	callq	clock_gettime@PLT
	movq	16(%rsp), %r15
	movq	24(%rsp), %r14
	movq	40(%rsp), %rdx
	cmpq	%rdx, %rbp
	jge	.LBB2_42
	movq	48(%rsp), %rax
	jmp	.LBB2_43
	.p2align	4
.LBB2_44:
	movq	%rax, %r14
	movq	%rax, %rdi
	movq	%rbp, %rsi
	callq	"std::builtin::sort::_sort[::Copyable,LITMutOrigin,::Origin[::Bool(True), $1],LITOriginSet,def($1|0, $1|0, /) capturing -> ::Bool,::Bool,::Bool](::Span[::Bool(True), $1, $0, $2]),T=[typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index],cmp_fn=\"def[LITOriginSet](::Int, ::Int, /) capturing -> ::Bool|def(::Int, ::Int, /) capturing -> ::Bool|8defd9926c462636[LITOriginSet,def(::Int, ::Int, /) capturing -> ::Bool](::Int,::Int)\"<:(index, index) capturing -> i1 \"std::builtin::sort::sort[LITMutOrigin,::Origin[::Bool(True), $0],::Bool](::Span[::Bool(True), $0, ::Int, $1])__cmp_fn(::Int,::Int)\">,stable=0,do_smallsort=1"@PLT
	movq	40(%r14), %rax
	cmpq	$0, 40(%rsp)
	movq	%rax, 216(%rsp)
	jle	.LBB2_46
	movq	%r14, %rdi
	callq	KGEN_CompilerRT_AlignedFree@PLT
.LBB2_46:
	movq	104(%rsp), %rbp
	movl	$2, %eax
	movq	(%rbp), %rcx
	.p2align	4
.LBB2_47:
	cmpq	$16, %rcx
	jge	.LBB2_53
	xorl	%edx, %edx
	jmp	.LBB2_55
	.p2align	4
.LBB2_53:
	xorl	%esi, %esi
	.p2align	4
.LBB2_54:
	vmovups	(%rbx,%rsi,4), %zmm0
	leaq	16(%rsi), %rdx
	vaddps	(%r12,%rsi,4), %zmm0, %zmm0
	vmovups	%zmm0, (%r13,%rsi,4)
	addq	$32, %rsi
	cmpq	%rcx, %rsi
	movq	%rdx, %rsi
	jle	.LBB2_54
	jmp	.LBB2_55
	.p2align	4
.LBB2_56:
	vmovss	(%rbx,%rdx,4), %xmm0
	vaddss	(%r12,%rdx,4), %xmm0, %xmm0
	vmovss	%xmm0, (%r13,%rdx,4)
	incq	%rdx
	movq	(%rbp), %rcx
.LBB2_55:
	cmpq	%rcx, %rdx
	jl	.LBB2_56
	subq	$1, %rax
	jae	.LBB2_47
	movl	$8, %eax
	movl	$9, %esi
	xorl	%edx, %edx
	xorl	%r14d, %r14d
	jmp	.LBB2_51
	.p2align	4
.LBB2_73:
	movq	8(%rsp), %rdi
	xorl	%eax, %eax
	testq	%rdx, %rdx
	movq	%r14, %rsi
	sete	%al
	leaq	(%rax,%rdx,2), %rcx
	callq	"std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index]"@PLT
	movq	%rdx, %r14
	movq	%rcx, %rdx
.LBB2_74:
	movq	40(%rsp), %rcx
	movq	56(%rsp), %rdi
	movq	64(%rsp), %rsi
	subq	%rcx, %r15
	subq	%rdi, %rbp
	imulq	$1000000000, %r15, %rcx
	leaq	16(%rsp), %r15
	addq	%rcx, %rbp
	movq	%rbp, (%rax,%r14,8)
	movq	104(%rsp), %rbp
	incq	%r14
	subq	$1, %rsi
	jb	.LBB2_57
.LBB2_51:
	movl	$1, %edi
	movq	%rsi, 64(%rsp)
	vxorps	%xmm0, %xmm0, %xmm0
	movq	%r15, %rsi
	movq	%rdx, 48(%rsp)
	movq	%rax, 8(%rsp)
	vmovaps	%xmm0, 16(%rsp)
	vzeroupper
	callq	clock_gettime@PLT
	movq	16(%rsp), %rax
	movq	24(%rsp), %rsi
	movq	(%rbp), %rcx
	movq	%rax, 40(%rsp)
	cmpq	$16, %rcx
	jge	.LBB2_67
	xorl	%eax, %eax
	jmp	.LBB2_69
	.p2align	4
.LBB2_67:
	xorl	%edx, %edx
	.p2align	4
.LBB2_68:
	vmovups	(%rbx,%rdx,4), %zmm0
	leaq	16(%rdx), %rax
	vaddps	(%r12,%rdx,4), %zmm0, %zmm0
	vmovups	%zmm0, (%r13,%rdx,4)
	addq	$32, %rdx
	cmpq	%rcx, %rdx
	movq	%rax, %rdx
	jle	.LBB2_68
.LBB2_69:
	movq	%rsi, 56(%rsp)
	cmpq	%rcx, %rax
	jge	.LBB2_71
	.p2align	4
.LBB2_70:
	vmovss	(%rbx,%rax,4), %xmm0
	vaddss	(%r12,%rax,4), %xmm0, %xmm0
	vmovss	%xmm0, (%r13,%rax,4)
	incq	%rax
	cmpq	(%rbp), %rax
	jl	.LBB2_70
.LBB2_71:
	movl	$1, %edi
	vxorps	%xmm0, %xmm0, %xmm0
	movq	%r15, %rsi
	vmovaps	%xmm0, 16(%rsp)
	vzeroupper
	callq	clock_gettime@PLT
	movq	16(%rsp), %r15
	movq	24(%rsp), %rbp
	movq	48(%rsp), %rdx
	cmpq	%rdx, %r14
	jge	.LBB2_73
	movq	8(%rsp), %rax
	jmp	.LBB2_74
	.p2align	4
.LBB2_57:
	cmpb	$0, 128(%rsp)
	movq	%rdx, 48(%rsp)
	jne	.LBB2_58
	cmpb	$0, 120(%rsp)
	jne	.LBB2_60
.LBB2_61:
	cmpb	$0, 112(%rsp)
	je	.LBB2_63
.LBB2_62:
	movq	%r13, %rdi
	movq	%rax, %rbx
	callq	KGEN_CompilerRT_AlignedFree@PLT
	movq	%rbx, %rax
.LBB2_63:
	movq	%rax, %rbx
	movq	%rax, %rdi
	movq	%r14, %rsi
	callq	"std::builtin::sort::_sort[::Copyable,LITMutOrigin,::Origin[::Bool(True), $1],LITOriginSet,def($1|0, $1|0, /) capturing -> ::Bool,::Bool,::Bool](::Span[::Bool(True), $1, $0, $2]),T=[typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index],cmp_fn=\"def[LITOriginSet](::Int, ::Int, /) capturing -> ::Bool|def(::Int, ::Int, /) capturing -> ::Bool|8defd9926c462636[LITOriginSet,def(::Int, ::Int, /) capturing -> ::Bool](::Int,::Int)\"<:(index, index) capturing -> i1 \"std::builtin::sort::sort[LITMutOrigin,::Origin[::Bool(True), $0],::Bool](::Span[::Bool(True), $0, ::Int, $1])__cmp_fn(::Int,::Int)\">,stable=0,do_smallsort=1"@PLT
	movq	%rbx, %rdi
	movq	40(%rbx), %rbx
	cmpq	$0, 48(%rsp)
	movq	216(%rsp), %r12
	jle	.LBB2_65
	callq	KGEN_CompilerRT_AlignedFree@PLT
.LBB2_65:
	movq	(%rbp), %rsi
	leaq	1(%rbx), %rdi
	movq	%rbx, %r8
	movabsq	$4611686018427387904, %r14
	cmpq	$1, %rdi
	adcq	$1, %r8
	leaq	(,%rsi,4), %rax
	leaq	(%rax,%rax,2), %rcx
	movq	%rcx, %rax
	orq	%r8, %rax
	shrq	$32, %rax
	je	.LBB2_66
	movq	%rcx, %rax
	cqto
	idivq	%r8
	movq	%rax, %r10
	jmp	.LBB2_76
	.p2align	4
.LBB2_58:
	movq	%rbx, %rdi
	movq	%rax, 8(%rsp)
	callq	KGEN_CompilerRT_AlignedFree@PLT
	movq	8(%rsp), %rax
	cmpb	$0, 120(%rsp)
	je	.LBB2_61
.LBB2_60:
	movq	%r12, %rdi
	movq	%rax, %rbx
	callq	KGEN_CompilerRT_AlignedFree@PLT
	movq	%rbx, %rax
	cmpb	$0, 112(%rsp)
	jne	.LBB2_62
	jmp	.LBB2_63
	.p2align	4
.LBB2_66:
	movl	%ecx, %eax
	xorl	%edx, %edx
	divl	%r8d
	movl	%eax, %r10d
.LBB2_76:
	xorq	%rdi, %rcx
	sets	%al
	testq	%rdx, %rdx
	setne	%cl
	andb	%al, %cl
	movzbl	%cl, %eax
	subq	%rax, %r10
	testq	%rdi, %rdi
	movq	%r12, %rax
	cmoveq	%rdi, %r10
	orq	%r8, %rax
	shrq	$32, %rax
	je	.LBB2_77
	movq	%r12, %rax
	cqto
	idivq	%r8
	jmp	.LBB2_79
	.p2align	4
.LBB2_77:
	movl	%r12d, %eax
	xorl	%edx, %edx
	divl	%r8d
.LBB2_79:
	movq	%rdi, %rcx
	xorq	%r12, %rcx
	leaq	static_string_f9e7fe49bfba4b0f(%rip), %rbp
	leaq	static_string_81d1b08491d5bcb4(%rip), %r13
	movq	$8, 264(%rsp)
	movq	$12, 144(%rsp)
	movq	$2, 240(%rsp)
	movq	$11, 168(%rsp)
	movq	$13, 192(%rsp)
	movq	$4, 24(%rsp)
	sets	%cl
	testq	%rdx, %rdx
	movq	%rbp, 256(%rsp)
	movq	%r13, 136(%rsp)
	leaq	static_string_486ee4207f4452dd(%rip), %rbp
	leaq	static_string_2a5587262656d518(%rip), %r13
	setne	%dl
	movq	%rbp, 160(%rsp)
	movq	%r13, 184(%rsp)
	andb	%cl, %dl
	movzbl	%dl, %ecx
	leaq	static_string_9d820e1d0eba9e11(%rip), %rdx
	subq	%rcx, %rax
	leaq	static_string_c6985149de191244(%rip), %rcx
	testq	%rdi, %rdi
	movq	%rdx, 16(%rsp)
	movq	%rcx, 232(%rsp)
	movabsq	$2305843009213693952, %rcx
	cmoveq	%rdi, %rax
	movq	%rcx, 248(%rsp)
	movq	%rcx, 272(%rsp)
	movq	%rcx, 152(%rsp)
	movq	%rcx, 176(%rsp)
	movq	%rcx, 200(%rsp)
	movq	%rcx, 32(%rsp)
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
	leaq	240(%rsp), %rdi
	leaq	264(%rsp), %rdx
	movq	%r12, %rcx
	leaq	144(%rsp), %r8
	movq	%rbx, %r9
	pushq	$1
	.cfi_adjust_cfa_offset 8
	pushq	$0
	.cfi_adjust_cfa_offset 8
	pushq	$1
	.cfi_adjust_cfa_offset 8
	leaq	static_string_bbe01a6a523daf15(%rip), %r11
	pushq	%r11
	.cfi_adjust_cfa_offset 8
	pushq	$1
	.cfi_adjust_cfa_offset 8
	leaq	static_string_a8d4ace0dc8d360e(%rip), %r11
	pushq	%r11
	.cfi_adjust_cfa_offset 8
	pushq	%r15
	.cfi_adjust_cfa_offset 8
	pushq	%r10
	.cfi_adjust_cfa_offset 8
	leaq	256(%rsp), %r10
	pushq	%r10
	.cfi_adjust_cfa_offset 8
	pushq	%rax
	.cfi_adjust_cfa_offset 8
	leaq	248(%rsp), %rax
	pushq	%rax
	.cfi_adjust_cfa_offset 8
	callq	"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>]]"@PLT
	addq	$96, %rsp
	.cfi_adjust_cfa_offset -96
	testq	%r14, 248(%rsp)
	je	.LBB2_82
	movq	232(%rsp), %rdi
	lock		decq	-8(%rdi)
	jne	.LBB2_82
	addq	$-8, %rdi
	#MEMBARRIER
	callq	KGEN_CompilerRT_AlignedFree@PLT
.LBB2_82:
	testq	%r14, 272(%rsp)
	je	.LBB2_85
	movq	256(%rsp), %rdi
	lock		decq	-8(%rdi)
	jne	.LBB2_85
	addq	$-8, %rdi
	#MEMBARRIER
	callq	KGEN_CompilerRT_AlignedFree@PLT
.LBB2_85:
	testq	%r14, 152(%rsp)
	je	.LBB2_88
	movq	136(%rsp), %rdi
	lock		decq	-8(%rdi)
	jne	.LBB2_88
	addq	$-8, %rdi
	#MEMBARRIER
	callq	KGEN_CompilerRT_AlignedFree@PLT
.LBB2_88:
	testq	%r14, 176(%rsp)
	je	.LBB2_91
	movq	160(%rsp), %rdi
	lock		decq	-8(%rdi)
	jne	.LBB2_91
	addq	$-8, %rdi
	#MEMBARRIER
	callq	KGEN_CompilerRT_AlignedFree@PLT
.LBB2_91:
	testq	%r14, 200(%rsp)
	je	.LBB2_94
	movq	184(%rsp), %rdi
	lock		decq	-8(%rdi)
	jne	.LBB2_94
	addq	$-8, %rdi
	#MEMBARRIER
	callq	KGEN_CompilerRT_AlignedFree@PLT
.LBB2_94:
	testq	%r14, 32(%rsp)
	je	.LBB2_97
	movq	16(%rsp), %rdi
	lock		decq	-8(%rdi)
	jne	.LBB2_97
	addq	$-8, %rdi
	#MEMBARRIER
	callq	KGEN_CompilerRT_AlignedFree@PLT
	jmp	.LBB2_97
.LBB2_98:
	callq	KGEN_CompilerRT_AlignedFree@PLT
	callq	KGEN_CompilerRT_DestroyGlobals@PLT
	xorl	%eax, %eax
	addq	$280, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.size	.Lmain$local, .Lfunc_end2-main
	.cfi_endproc

	.p2align	4
	.type	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]",@function
"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]":
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r13
	.cfi_def_cfa_offset 32
	pushq	%r12
	.cfi_def_cfa_offset 40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	subq	$80, %rsp
	.cfi_def_cfa_offset 128
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rsi, %rbx
	movq	%rdi, %r15
	testq	%rdi, %rdi
	js	.LBB3_1
	movq	4096(%rbx), %r14
	cmpq	$4096, %r14
	jle	.LBB3_8
	movq	4104(%rbx), %rax
	movq	%rbx, %rsi
	movq	%r14, %rdx
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%r14d, %r14d
	movq	$0, 4096(%rbx)
	testq	%r15, %r15
	jne	.LBB3_13
	jmp	.LBB3_11
.LBB3_1:
	movq	4096(%rbx), %rdx
	leaq	1(%rdx), %rax
	cmpq	$4097, %rax
	jl	.LBB3_3
	movq	4104(%rbx), %rax
	movq	%rbx, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%rbx)
.LBB3_3:
	movb	$45, (%rbx,%rdx)
	movq	4096(%rbx), %r14
	incq	%r14
	movq	%r14, 4096(%rbx)
	cmpq	$4097, %r14
	jl	.LBB3_5
	movq	4104(%rbx), %rax
	movq	%rbx, %rsi
	movq	%r14, %rdx
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%r14d, %r14d
	movq	$0, 4096(%rbx)
.LBB3_5:
	movl	$63, %ecx
	movabsq	$7378697629483820647, %rsi
	leaq	static_string_978d8d34847e5196(%rip), %rdi
	movabsq	$-7378697629483820647, %r8
	movb	$0, 79(%rsp)
	.p2align	4
.LBB3_6:
	movq	%r15, %rax
	imulq	%rsi
	movq	%r15, %r10
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$2, %rdx
	addq	%rax, %rdx
	addq	%rdx, %rdx
	leaq	(%rdx,%rdx,4), %rax
	movq	%r15, %rdx
	subq	%rax, %rdx
	testq	%r15, %r15
	movq	$-10, %rax
	setns	%r9b
	testq	%rdx, %rdx
	cmoveq	%rdx, %rax
	sarq	$63, %r10
	andnq	%rax, %r10, %rax
	addq	%rdx, %rax
	movq	%rax, %rdx
	negq	%rdx
	cmovsq	%rax, %rdx
	movzbl	(%rdx,%rdi), %eax
	movb	%al, 15(%rsp,%rcx)
	movq	%r15, %rax
	imulq	%r8
	decq	%rcx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$2, %rdx
	addq	%rax, %rdx
	leaq	(%rdx,%rdx), %rax
	leaq	(%rax,%rax,4), %rax
	addq	%r15, %rax
	setne	%al
	andb	%r9b, %al
	movzbl	%al, %r15d
	subq	%rdx, %r15
	jne	.LBB3_6
	jmp	.LBB3_15
.LBB3_8:
	testq	%r15, %r15
	je	.LBB3_9
.LBB3_13:
	movl	$63, %ecx
	leaq	static_string_978d8d34847e5196(%rip), %rax
	movabsq	$-3689348814741910323, %rsi
	movb	$0, 79(%rsp)
	.p2align	4
.LBB3_14:
	movq	%r15, %rdx
	mulxq	%rsi, %rdx, %rdx
	movq	%r15, %r8
	shrq	$3, %rdx
	leaq	(%rdx,%rdx), %rdi
	leaq	(%rdi,%rdi,4), %rdi
	subq	%rdi, %r8
	movzbl	(%rax,%r8), %edi
	movb	%dil, 15(%rsp,%rcx)
	decq	%rcx
	cmpq	$10, %r15
	movq	%rdx, %r15
	jae	.LBB3_14
.LBB3_15:
	leaq	1(%rcx), %rax
	addq	$66, %rcx
	movl	$65, %r13d
	movl	$64, %r15d
	movq	%rcx, %rdx
	sarq	$63, %rdx
	andnq	%rcx, %rdx, %rcx
	cmpq	$65, %rax
	cmovlq	%rax, %r13
	testq	%rax, %rax
	cmovsq	%rcx, %r13
	leaq	15(%rsp,%r13), %r12
	subq	%r13, %r15
	cmpq	$4097, %r15
	jl	.LBB3_17
	movq	4104(%rbx), %rax
	movq	%rbx, %rsi
	movq	%r14, %rdx
	movq	(%rax), %rdi
	callq	write@PLT
	movq	$0, 4096(%rbx)
	movq	%r12, %rsi
	movq	%r15, %rdx
	movq	4104(%rbx), %rax
	movq	(%rax), %rdi
	callq	write@PLT
	jmp	.LBB3_32
.LBB3_17:
	leaq	(%r14,%r15), %rax
	cmpq	$4097, %rax
	jl	.LBB3_19
	movq	4104(%rbx), %rax
	movq	%rbx, %rsi
	movq	%r14, %rdx
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%r14d, %r14d
	movq	$0, 4096(%rbx)
.LBB3_19:
	addq	%rbx, %r14
	cmpq	$4, %r15
	jg	.LBB3_23
	cmpq	$64, %r13
	je	.LBB3_31
	movzbl	(%r12), %ecx
	movzbl	78(%rsp), %edx
	movl	$63, %eax
	subq	%r13, %rax
	movb	%cl, (%r14)
	movb	%dl, (%r14,%rax)
	cmpq	$3, %r15
	jl	.LBB3_31
	movzbl	1(%r12), %ecx
	movzbl	77(%rsp), %edx
	movl	$62, %eax
	subq	%r13, %rax
	movb	%cl, 1(%r14)
	movb	%dl, (%r14,%rax)
	jmp	.LBB3_31
.LBB3_23:
	cmpq	$16, %r15
	jg	.LBB3_27
	cmpq	$8, %r15
	jl	.LBB3_26
	movq	(%r12), %rax
	movq	71(%rsp), %rcx
	movq	%rax, (%r14)
	movq	%rcx, -8(%r14,%r15)
	jmp	.LBB3_31
.LBB3_9:
	cmpq	$4096, %r14
	jne	.LBB3_11
	movq	4104(%rbx), %rax
	movq	%rbx, %rsi
	movq	%r14, %rdx
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%r14d, %r14d
	movq	$0, 4096(%rbx)
.LBB3_11:
	movb	$48, (%rbx,%r14)
	incq	4096(%rbx)
	jmp	.LBB3_32
.LBB3_27:
	movabsq	$9223372036854775776, %r13
	andq	%r15, %r13
	je	.LBB3_29
	movq	%r14, %rdi
	movq	%r12, %rsi
	movq	%r13, %rdx
	callq	memcpy@PLT
.LBB3_29:
	cmpq	%r15, %r13
	je	.LBB3_31
	movl	%r15d, %edx
	addq	%r13, %r14
	addq	%r13, %r12
	andl	$31, %edx
	movq	%r14, %rdi
	movq	%r12, %rsi
	callq	memcpy@PLT
	jmp	.LBB3_31
.LBB3_26:
	movl	(%r12), %eax
	movl	75(%rsp), %ecx
	movl	%eax, (%r14)
	movl	%ecx, -4(%r14,%r15)
.LBB3_31:
	addq	%r15, 4096(%rbx)
.LBB3_32:
	addq	$80, %rsp
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end3:
	.size	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]", .Lfunc_end3-"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"
	.cfi_endproc

	.p2align	4
	.type	"std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index]",@function
"std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index]":
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	pushq	%rax
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rsi, %r14
	leaq	(,%rcx,8), %rsi
	movq	%rdi, %r15
	movl	$8, %edi
	movq	%rcx, %rbx
	movq	%rdx, (%rsp)
	callq	KGEN_CompilerRT_AlignedAlloc@PLT
	leaq	(,%r14,8), %rbp
	movq	%rax, %r13
	cmpq	$4, %rbp
	jg	.LBB4_4
	testq	%rbp, %rbp
	je	.LBB4_12
	movzbl	(%r15), %eax
	movb	%al, (%r13)
	movzbl	-1(%r15,%rbp), %eax
	movb	%al, -1(%r13,%rbp)
	cmpq	$3, %rbp
	jl	.LBB4_12
	movzbl	1(%r15), %eax
	movb	%al, 1(%r13)
	movzbl	-2(%r15,%rbp), %eax
	movb	%al, -2(%r13,%rbp)
	cmpq	$0, (%rsp)
	jg	.LBB4_13
	jmp	.LBB4_14
.LBB4_4:
	cmpq	$16, %rbp
	ja	.LBB4_8
	cmpq	$8, %rbp
	jl	.LBB4_7
	movq	(%r15), %rax
	movq	%rax, (%r13)
	movq	-8(%r15,%rbp), %rax
	movq	%rax, -8(%r13,%rbp)
	cmpq	$0, (%rsp)
	jg	.LBB4_13
	jmp	.LBB4_14
.LBB4_8:
	movabsq	$9223372036854775776, %r12
	andq	%rbp, %r12
	je	.LBB4_10
	movq	%r13, %rdi
	movq	%r15, %rsi
	movq	%r12, %rdx
	callq	memcpy@PLT
.LBB4_10:
	cmpq	%rbp, %r12
	je	.LBB4_12
	movq	%r13, %rdi
	movq	%r15, %rsi
	andl	$24, %ebp
	addq	%r12, %rdi
	addq	%r12, %rsi
	movq	%rbp, %rdx
	callq	memcpy@PLT
.LBB4_12:
	cmpq	$0, (%rsp)
	jle	.LBB4_14
.LBB4_13:
	movq	%r15, %rdi
	callq	KGEN_CompilerRT_AlignedFree@PLT
.LBB4_14:
	movq	%r13, %rax
	movq	%r14, %rdx
	movq	%rbx, %rcx
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.LBB4_7:
	.cfi_def_cfa_offset 64
	movl	(%r15), %eax
	movl	%eax, (%r13)
	movl	-4(%r15,%rbp), %eax
	movl	%eax, -4(%r13,%rbp)
	cmpq	$0, (%rsp)
	jg	.LBB4_13
	jmp	.LBB4_14
.Lfunc_end4:
	.size	"std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index]", .Lfunc_end4-"std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index]"
	.cfi_endproc

	.p2align	4
	.type	"std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f32,size=1\">>, scalar<f32>]",@function
"std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f32,size=1\">>, scalar<f32>]":
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	pushq	%rax
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rsi, %r14
	leaq	(,%rcx,4), %rsi
	movq	%rdi, %r15
	movl	$4, %edi
	movq	%rcx, %rbx
	movq	%rdx, (%rsp)
	callq	KGEN_CompilerRT_AlignedAlloc@PLT
	leaq	(,%r14,4), %rbp
	movq	%rax, %r13
	cmpq	$4, %rbp
	jg	.LBB5_4
	testq	%rbp, %rbp
	je	.LBB5_12
	movzbl	(%r15), %eax
	movb	%al, (%r13)
	movzbl	-1(%r15,%rbp), %eax
	movb	%al, -1(%r13,%rbp)
	cmpq	$3, %rbp
	jl	.LBB5_12
	movzbl	1(%r15), %eax
	movb	%al, 1(%r13)
	movzbl	-2(%r15,%rbp), %eax
	movb	%al, -2(%r13,%rbp)
	cmpq	$0, (%rsp)
	jg	.LBB5_13
	jmp	.LBB5_14
.LBB5_4:
	cmpq	$16, %rbp
	ja	.LBB5_8
	cmpq	$8, %rbp
	jl	.LBB5_7
	movq	(%r15), %rax
	movq	%rax, (%r13)
	movq	-8(%r15,%rbp), %rax
	movq	%rax, -8(%r13,%rbp)
	cmpq	$0, (%rsp)
	jg	.LBB5_13
	jmp	.LBB5_14
.LBB5_8:
	movabsq	$9223372036854775776, %r12
	andq	%rbp, %r12
	je	.LBB5_10
	movq	%r13, %rdi
	movq	%r15, %rsi
	movq	%r12, %rdx
	callq	memcpy@PLT
.LBB5_10:
	cmpq	%rbp, %r12
	je	.LBB5_12
	movq	%r13, %rdi
	movq	%r15, %rsi
	andl	$28, %ebp
	addq	%r12, %rdi
	addq	%r12, %rsi
	movq	%rbp, %rdx
	callq	memcpy@PLT
.LBB5_12:
	cmpq	$0, (%rsp)
	jle	.LBB5_14
.LBB5_13:
	movq	%r15, %rdi
	callq	KGEN_CompilerRT_AlignedFree@PLT
.LBB5_14:
	movq	%r13, %rax
	movq	%r14, %rdx
	movq	%rbx, %rcx
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.LBB5_7:
	.cfi_def_cfa_offset 64
	movl	(%r15), %eax
	movl	%eax, (%r13)
	movl	-4(%r15,%rbp), %eax
	movl	%eax, -4(%r13,%rbp)
	cmpq	$0, (%rsp)
	jg	.LBB5_13
	jmp	.LBB5_14
.Lfunc_end5:
	.size	"std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f32,size=1\">>, scalar<f32>]", .Lfunc_end5-"std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f32,size=1\">>, scalar<f32>]"
	.cfi_endproc

	.p2align	4
	.type	"std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::memory::span::Span,mut=1,origin._mlir_origin`={  },T=[typevalue<#kgen.instref<\\1B\\22std::builtin::int::Int\\22>>, index],origin={  }\">>, struct<(pointer<none>, index)>]",@function
"std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::memory::span::Span,mut=1,origin._mlir_origin`={  },T=[typevalue<#kgen.instref<\\1B\\22std::builtin::int::Int\\22>>, index],origin={  }\">>, struct<(pointer<none>, index)>]":
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	pushq	%rax
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rsi, %r14
	movq	%rcx, %rsi
	movq	%rdi, %r15
	shlq	$4, %rsi
	movl	$8, %edi
	movq	%rcx, %rbx
	movq	%rdx, (%rsp)
	callq	KGEN_CompilerRT_AlignedAlloc@PLT
	movq	%r14, %rbp
	shlq	$4, %rbp
	movq	%rax, %r13
	cmpq	$4, %rbp
	jg	.LBB6_4
	testq	%rbp, %rbp
	je	.LBB6_12
	movzbl	(%r15), %eax
	movb	%al, (%r13)
	movzbl	-1(%r15,%rbp), %eax
	movb	%al, -1(%r13,%rbp)
	cmpq	$3, %rbp
	jl	.LBB6_12
	movzbl	1(%r15), %eax
	movb	%al, 1(%r13)
	movzbl	-2(%r15,%rbp), %eax
	movb	%al, -2(%r13,%rbp)
	cmpq	$0, (%rsp)
	jg	.LBB6_13
	jmp	.LBB6_14
.LBB6_4:
	cmpq	$16, %rbp
	ja	.LBB6_8
	cmpq	$8, %rbp
	jl	.LBB6_7
	movq	(%r15), %rax
	movq	%rax, (%r13)
	movq	-8(%r15,%rbp), %rax
	movq	%rax, -8(%r13,%rbp)
	cmpq	$0, (%rsp)
	jg	.LBB6_13
	jmp	.LBB6_14
.LBB6_8:
	movabsq	$9223372036854775776, %r12
	andq	%rbp, %r12
	je	.LBB6_10
	movq	%r13, %rdi
	movq	%r15, %rsi
	movq	%r12, %rdx
	callq	memcpy@PLT
.LBB6_10:
	cmpq	%rbp, %r12
	je	.LBB6_12
	movq	%r13, %rdi
	movq	%r15, %rsi
	andl	$16, %ebp
	addq	%r12, %rdi
	addq	%r12, %rsi
	movq	%rbp, %rdx
	callq	memcpy@PLT
.LBB6_12:
	cmpq	$0, (%rsp)
	jle	.LBB6_14
.LBB6_13:
	movq	%r15, %rdi
	callq	KGEN_CompilerRT_AlignedFree@PLT
.LBB6_14:
	movq	%r13, %rax
	movq	%r14, %rdx
	movq	%rbx, %rcx
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.LBB6_7:
	.cfi_def_cfa_offset 64
	movl	(%r15), %eax
	movl	%eax, (%r13)
	movl	-4(%r15,%rbp), %eax
	movl	%eax, -4(%r13,%rbp)
	cmpq	$0, (%rsp)
	jg	.LBB6_13
	jmp	.LBB6_14
.Lfunc_end6:
	.size	"std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::memory::span::Span,mut=1,origin._mlir_origin`={  },T=[typevalue<#kgen.instref<\\1B\\22std::builtin::int::Int\\22>>, index],origin={  }\">>, struct<(pointer<none>, index)>]", .Lfunc_end6-"std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::memory::span::Span,mut=1,origin._mlir_origin`={  },T=[typevalue<#kgen.instref<\\1B\\22std::builtin::int::Int\\22>>, index],origin={  }\">>, struct<(pointer<none>, index)>]"
	.cfi_endproc

	.p2align	4
	.type	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0",@function
"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0":
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r13
	.cfi_def_cfa_offset 32
	pushq	%r12
	.cfi_def_cfa_offset 40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdx, %rbx
	movq	%rsi, %r15
	movq	%rdi, %r14
	cmpq	$4097, %rdx
	jl	.LBB7_1
	movq	4104(%r14), %rax
	movq	4096(%r14), %rdx
	movq	%r14, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	movq	$0, 4096(%r14)
	movq	%r15, %rsi
	movq	%rbx, %rdx
	movq	4104(%r14), %rax
	movq	(%rax), %rdi
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	write@PLT
.LBB7_1:
	.cfi_def_cfa_offset 48
	movq	4096(%r14), %rdx
	leaq	(%rdx,%rbx), %rax
	cmpq	$4097, %rax
	jl	.LBB7_3
	movq	4104(%r14), %rax
	movq	%r14, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%r14)
.LBB7_3:
	addq	%r14, %rdx
	cmpq	$4, %rbx
	jg	.LBB7_7
	testq	%rbx, %rbx
	je	.LBB7_15
	movzbl	(%r15), %eax
	movb	%al, (%rdx)
	movzbl	-1(%r15,%rbx), %eax
	movb	%al, -1(%rdx,%rbx)
	cmpq	$3, %rbx
	jl	.LBB7_15
	movzbl	1(%r15), %eax
	movb	%al, 1(%rdx)
	movzbl	-2(%r15,%rbx), %eax
	movb	%al, -2(%rdx,%rbx)
	jmp	.LBB7_15
.LBB7_7:
	cmpq	$16, %rbx
	jg	.LBB7_11
	cmpq	$8, %rbx
	jl	.LBB7_10
	movq	(%r15), %rax
	movq	%rax, (%rdx)
	movq	-8(%r15,%rbx), %rax
	movq	%rax, -8(%rdx,%rbx)
	jmp	.LBB7_15
.LBB7_11:
	movabsq	$9223372036854775776, %r12
	andq	%rbx, %r12
	je	.LBB7_13
	movq	%rdx, %rdi
	movq	%rdx, %r13
	movq	%r15, %rsi
	movq	%r12, %rdx
	callq	memcpy@PLT
	movq	%r13, %rdx
.LBB7_13:
	cmpq	%rbx, %r12
	je	.LBB7_15
	movl	%ebx, %eax
	addq	%r12, %rdx
	addq	%r12, %r15
	andl	$31, %eax
	movq	%rdx, %rdi
	movq	%r15, %rsi
	movq	%rax, %rdx
	callq	memcpy@PLT
	jmp	.LBB7_15
.LBB7_10:
	movl	(%r15), %eax
	movl	%eax, (%rdx)
	movl	-4(%r15,%rbx), %eax
	movl	%eax, -4(%rdx,%rbx)
.LBB7_15:
	addq	%rbx, 4096(%r14)
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end7:
	.size	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0", .Lfunc_end7-"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.LCPI8_0:
	.quad	0x3ff4cccccccccccd
	.text
	.p2align	4
	.type	"std::builtin::sort::_sort[::Copyable,LITMutOrigin,::Origin[::Bool(True), $1],LITOriginSet,def($1|0, $1|0, /) capturing -> ::Bool,::Bool,::Bool](::Span[::Bool(True), $1, $0, $2]),T=[typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index],cmp_fn=\"def[LITOriginSet](::Int, ::Int, /) capturing -> ::Bool|def(::Int, ::Int, /) capturing -> ::Bool|8defd9926c462636[LITOriginSet,def(::Int, ::Int, /) capturing -> ::Bool](::Int,::Int)\"<:(index, index) capturing -> i1 \"std::builtin::sort::sort[LITMutOrigin,::Origin[::Bool(True), $0],::Bool](::Span[::Bool(True), $0, ::Int, $1])__cmp_fn(::Int,::Int)\">,stable=0,do_smallsort=1",@function
"std::builtin::sort::_sort[::Copyable,LITMutOrigin,::Origin[::Bool(True), $1],LITOriginSet,def($1|0, $1|0, /) capturing -> ::Bool,::Bool,::Bool](::Span[::Bool(True), $1, $0, $2]),T=[typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index],cmp_fn=\"def[LITOriginSet](::Int, ::Int, /) capturing -> ::Bool|def(::Int, ::Int, /) capturing -> ::Bool|8defd9926c462636[LITOriginSet,def(::Int, ::Int, /) capturing -> ::Bool](::Int,::Int)\"<:(index, index) capturing -> i1 \"std::builtin::sort::sort[LITMutOrigin,::Origin[::Bool(True), $0],::Bool](::Span[::Bool(True), $0, ::Int, $1])__cmp_fn(::Int,::Int)\">,stable=0,do_smallsort=1":
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	pushq	%rax
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rsi, %rax
	orq	$1, %rax
	movl	$2, %ebx
	lzcntq	%rax, %rax
	xorq	$63, %rax
	vcvtsi2sd	%rax, %xmm15, %xmm0
	vmulsd	.LCPI8_0(%rip), %xmm0, %xmm0
	vroundsd	$10, %xmm0, %xmm0, %xmm0
	vcvttsd2si	%xmm0, %rax
	cmpq	$3, %rax
	cmovgeq	%rax, %rbx
	cmpq	$2, %rsi
	movl	$1, %eax
	cmovgeq	%rsi, %rax
	cmpq	$5, %rsi
	jg	.LBB8_47
	addq	$-2, %rsi
	cmpq	$3, %rsi
	ja	.LBB8_55
	leaq	.LJTI8_1(%rip), %rax
	movslq	(%rax,%rsi,4), %rcx
	addq	%rax, %rcx
	jmpq	*%rcx
.LBB8_3:
	movq	(%rdi), %rax
	movq	8(%rdi), %rcx
	cmpq	%rcx, %rax
	jl	.LBB8_55
	movq	%rcx, (%rdi)
	movq	%rax, 8(%rdi)
	jmp	.LBB8_55
.LBB8_47:
	cmpq	$31, %rsi
	ja	.LBB8_58
	cmpq	$1, %rax
	je	.LBB8_55
	movl	$1, %ecx
	movl	$2, %r8d
	jmp	.LBB8_50
	.p2align	4
.LBB8_53:
	xorl	%esi, %esi
.LBB8_54:
	xorl	%r8d, %r8d
	cmpq	%rax, %rcx
	movq	%rdx, (%rdi,%rsi,8)
	setne	%r8b
	addq	%rcx, %r8
	cmpq	%rax, %rcx
	je	.LBB8_55
.LBB8_50:
	movq	%rcx, %rsi
	movq	(%rdi,%rsi,8), %rdx
	movq	%r8, %rcx
	testq	%rsi, %rsi
	je	.LBB8_53
	.p2align	4
.LBB8_51:
	movq	-8(%rdi,%rsi,8), %r8
	cmpq	%r8, %rdx
	jge	.LBB8_54
	movq	%r8, (%rdi,%rsi,8)
	decq	%rsi
	leaq	1(%rsi), %r8
	cmpq	$1, %r8
	jg	.LBB8_51
	jmp	.LBB8_53
.LBB8_58:
	movq	%rbx, %rax
	movq	%rdi, (%rsp)
	shlq	$4, %rax
	movl	$8, %edi
	movq	%rsi, %r14
	movq	%rax, %rsi
	callq	KGEN_CompilerRT_AlignedAlloc@PLT
	movq	(%rsp), %rsi
	movl	$1, %edx
	leaq	.LJTI8_0(%rip), %r15
	movq	%rsi, (%rax)
	movq	%r14, 8(%rax)
	jmp	.LBB8_59
	.p2align	4
.LBB8_106:
	cmpq	$1, %rcx
	jle	.LBB8_56
.LBB8_59:
	movq	%rdx, %rcx
	shlq	$4, %rdx
	movl	$1, %edi
	movq	-8(%rax,%rdx), %r13
	movq	-16(%rax,%rdx), %r12
	leaq	-1(%rcx), %rdx
	cmpq	$2, %r13
	cmovgeq	%r13, %rdi
	cmpq	$5, %r13
	jg	.LBB8_107
	addq	$-2, %r13
	cmpq	$3, %r13
	ja	.LBB8_106
	movslq	(%r15,%r13,4), %rdi
	addq	%r15, %rdi
	jmpq	*%rdi
.LBB8_62:
	movq	(%r12), %rdi
	movq	8(%r12), %r8
	cmpq	%r8, %rdi
	jl	.LBB8_106
	movq	%r8, (%r12)
	movq	%rdi, 8(%r12)
	jmp	.LBB8_106
	.p2align	4
.LBB8_107:
	cmpq	$31, %r13
	ja	.LBB8_115
	cmpq	$1, %rdi
	je	.LBB8_106
	movl	$1, %r8d
	movl	$2, %r11d
	jmp	.LBB8_110
	.p2align	4
.LBB8_113:
	xorl	%r10d, %r10d
.LBB8_114:
	xorl	%r11d, %r11d
	cmpq	%rdi, %r8
	movq	%r9, (%r12,%r10,8)
	setne	%r11b
	addq	%r8, %r11
	cmpq	%rdi, %r8
	je	.LBB8_106
.LBB8_110:
	movq	%r8, %r10
	movq	(%r12,%r10,8), %r9
	movq	%r11, %r8
	testq	%r10, %r10
	je	.LBB8_113
	.p2align	4
.LBB8_111:
	movq	-8(%r12,%r10,8), %r11
	cmpq	%r11, %r9
	jge	.LBB8_114
	movq	%r11, (%r12,%r10,8)
	decq	%r10
	leaq	1(%r10), %r11
	cmpq	$1, %r11
	jg	.LBB8_111
	jmp	.LBB8_113
.LBB8_70:
	movq	(%r12), %r9
	movq	16(%r12), %rdi
	cmpq	%rdi, %r9
	jge	.LBB8_72
	movq	%rdi, %r8
	movq	%r9, %rdi
	movq	8(%r12), %r11
	movq	24(%r12), %r10
	cmpq	%r10, %r11
	jl	.LBB8_74
.LBB8_75:
	movq	%r10, 8(%r12)
	movq	%r11, %r9
	movq	%r11, 24(%r12)
	cmpq	%r10, %rdi
	jl	.LBB8_77
.LBB8_78:
	movq	%r10, (%r12)
	movq	%rdi, 8(%r12)
	cmpq	%r9, %r8
	jl	.LBB8_80
.LBB8_81:
	movq	%r9, 16(%r12)
	movq	%r8, 24(%r12)
	cmpq	%r9, %rdi
	jl	.LBB8_106
	jmp	.LBB8_83
.LBB8_84:
	movq	(%r12), %r9
	movq	8(%r12), %r8
	cmpq	%r8, %r9
	jge	.LBB8_86
	movq	%r9, %rdi
	movq	%r8, %r9
	movq	24(%r12), %r8
	movq	32(%r12), %r10
	cmpq	%r10, %r8
	jl	.LBB8_88
.LBB8_89:
	movq	%r10, 24(%r12)
	movq	%r8, %r14
	movq	%r8, 32(%r12)
	movq	16(%r12), %r8
	cmpq	%r10, %r8
	jl	.LBB8_91
.LBB8_92:
	movq	%r10, 16(%r12)
	movq	%r8, 24(%r12)
	cmpq	%r14, %r8
	jge	.LBB8_94
	movq	%r8, %r11
	movq	%r14, %r8
	cmpq	%r8, %r9
	jl	.LBB8_96
	jmp	.LBB8_97
.LBB8_64:
	movq	8(%r12), %r9
	movq	16(%r12), %rdi
	cmpq	%rdi, %r9
	jge	.LBB8_66
	movq	%rdi, %r8
	movq	%r9, %rdi
	movq	(%r12), %r9
	cmpq	%rdi, %r9
	jl	.LBB8_106
	jmp	.LBB8_68
.LBB8_72:
	movq	%rdi, (%r12)
	movq	%r9, %r8
	movq	%r9, 16(%r12)
	movq	8(%r12), %r11
	movq	24(%r12), %r10
	cmpq	%r10, %r11
	jge	.LBB8_75
.LBB8_74:
	movq	%r10, %r9
	movq	%r11, %r10
	cmpq	%r10, %rdi
	jge	.LBB8_78
.LBB8_77:
	movq	%r10, %rdi
	cmpq	%r9, %r8
	jge	.LBB8_81
.LBB8_80:
	movq	%r8, %r9
	cmpq	%r9, %rdi
	jl	.LBB8_106
.LBB8_83:
	movq	%r9, 8(%r12)
	movq	%rdi, 16(%r12)
	jmp	.LBB8_106
.LBB8_86:
	movq	%r8, (%r12)
	movq	%r8, %rdi
	movq	%r9, 8(%r12)
	movq	24(%r12), %r8
	movq	32(%r12), %r10
	cmpq	%r10, %r8
	jge	.LBB8_89
.LBB8_88:
	movq	%r10, %r14
	movq	%r8, %r10
	movq	16(%r12), %r8
	cmpq	%r10, %r8
	jge	.LBB8_92
.LBB8_91:
	movq	%r10, %r11
	movq	%r8, %r10
	movq	%r14, %r8
	cmpq	%r8, %r9
	jge	.LBB8_97
.LBB8_96:
	movq	%r9, %r8
	cmpq	%r10, %rdi
	jl	.LBB8_99
.LBB8_100:
	movq	%r10, (%r12)
	movq	%rdi, 16(%r12)
	cmpq	%r11, %rdi
	jge	.LBB8_102
	movq	%r11, %r9
	movq	%rdi, %r11
	cmpq	%r11, %r8
	jl	.LBB8_106
	jmp	.LBB8_104
.LBB8_66:
	movq	%rdi, 8(%r12)
	movq	%r9, %r8
	movq	%r9, 16(%r12)
	movq	(%r12), %r9
	cmpq	%rdi, %r9
	jl	.LBB8_106
.LBB8_68:
	movq	%rdi, (%r12)
	movq	%r9, 8(%r12)
	cmpq	%r8, %r9
	jl	.LBB8_106
	movq	%r8, 8(%r12)
	movq	%r9, 16(%r12)
	jmp	.LBB8_106
.LBB8_94:
	movq	%r14, 24(%r12)
	movq	%r14, %r11
	movq	%r8, 32(%r12)
	cmpq	%r8, %r9
	jl	.LBB8_96
.LBB8_97:
	movq	%r8, 8(%r12)
	movq	%r9, 32(%r12)
	cmpq	%r10, %rdi
	jge	.LBB8_100
.LBB8_99:
	movq	%r11, %r9
	movq	%r10, %r11
	cmpq	%r11, %r8
	jl	.LBB8_106
	jmp	.LBB8_104
.LBB8_102:
	movq	%r11, 16(%r12)
	movq	%rdi, %r9
	movq	%rdi, 24(%r12)
	cmpq	%r11, %r8
	jl	.LBB8_106
.LBB8_104:
	movq	%r11, 8(%r12)
	movq	%r8, 16(%r12)
	cmpq	%r9, %r8
	jl	.LBB8_106
	movq	%r9, 16(%r12)
	movq	%r8, 24(%r12)
	jmp	.LBB8_106
.LBB8_115:
	movq	%r13, %r8
	shrq	%r8
	movq	(%r12), %rdi
	movq	(%r12,%r8,8), %r9
	cmpq	%rdi, %r9
	jge	.LBB8_117
	movq	%rdi, %r9
	movq	-8(%r12,%r13,8), %rdi
	cmpq	%rdi, %r9
	jge	.LBB8_119
	jmp	.LBB8_120
.LBB8_117:
	movq	%rdi, (%r12,%r8,8)
	movq	%r9, (%r12)
	movq	-8(%r12,%r13,8), %rdi
	cmpq	%rdi, %r9
	jl	.LBB8_120
.LBB8_119:
	movq	%rdi, (%r12)
	movq	%r9, -8(%r12,%r13,8)
	movq	(%r12), %r9
.LBB8_120:
	movq	(%r12,%r8,8), %rdi
	cmpq	%r9, %rdi
	jge	.LBB8_122
	movq	%r9, %rdi
	leaq	-1(%r13), %r8
	cmpq	%rsi, %r12
	jg	.LBB8_124
	jmp	.LBB8_140
.LBB8_122:
	movq	%r9, (%r12,%r8,8)
	movq	%rdi, (%r12)
	leaq	-1(%r13), %r8
	cmpq	%rsi, %r12
	jle	.LBB8_140
.LBB8_124:
	cmpq	%rdi, -8(%r12)
	jge	.LBB8_125
.LBB8_140:
	movl	$1, %r9d
.LBB8_141:
	leaq	-1(%r9), %rbp
	shlq	$3, %r9
	movl	$8, %r14d
	subq	%r9, %r14
	.p2align	4
.LBB8_142:
	movq	8(%r12,%rbp,8), %r10
	incq	%rbp
	addq	$-8, %r14
	cmpq	%rdi, %r10
	jl	.LBB8_142
	cmpq	%r8, %rbp
	jge	.LBB8_147
	leaq	1(%rbp), %r9
	.p2align	4
.LBB8_145:
	movq	(%r12,%r8,8), %r11
	cmpq	%rdi, %r11
	jl	.LBB8_156
	decq	%r8
	cmpq	%r8, %rbp
	jl	.LBB8_145
	jmp	.LBB8_147
.LBB8_156:
	movq	%r11, (%r12,%rbp,8)
	movq	%r10, (%r12,%r8,8)
	decq	%r8
	movq	(%r12), %rdi
	jmp	.LBB8_141
.LBB8_147:
	movq	-8(%r12,%rbp,8), %r8
	movq	%rdi, -8(%r12,%rbp,8)
	leaq	1(%rbp), %rdi
	movq	%r8, (%r12)
	cmpq	%rdi, %r13
	jle	.LBB8_151
	cmpq	%rbx, %rcx
	jle	.LBB8_150
	xorl	%ecx, %ecx
	testq	%rbx, %rbx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movq	%rbx, %rdx
	sete	%cl
	leaq	(%rcx,%rbx,2), %rcx
	callq	"std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::memory::span::Span,mut=1,origin._mlir_origin`={  },T=[typevalue<#kgen.instref<\\1B\\22std::builtin::int::Int\\22>>, index],origin={  }\">>, struct<(pointer<none>, index)>]"@PLT
	movq	(%rsp), %rsi
	movq	%rcx, %rbx
.LBB8_150:
	movq	%rdx, %rdi
	movq	%r12, %rcx
	incq	%rdx
	subq	%rbp, %r13
	subq	%r14, %rcx
	shlq	$4, %rdi
	movq	%rcx, (%rax,%rdi)
	movq	%r13, 8(%rax,%rdi)
.LBB8_151:
	decq	%rbp
	cmpq	$2, %rbp
	jl	.LBB8_139
	cmpq	%rbx, %rdx
	jl	.LBB8_154
	xorl	%ecx, %ecx
	testq	%rbx, %rbx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movq	%rbx, %rdx
	sete	%cl
	leaq	(%rcx,%rbx,2), %rcx
	callq	"std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::memory::span::Span,mut=1,origin._mlir_origin`={  },T=[typevalue<#kgen.instref<\\1B\\22std::builtin::int::Int\\22>>, index],origin={  }\">>, struct<(pointer<none>, index)>]"@PLT
	movq	(%rsp), %rsi
	movq	%rcx, %rbx
.LBB8_154:
	movq	%rdx, %rdi
	shlq	$4, %rdi
	movq	%rbp, %r13
	leaq	(%rax,%rdi), %rcx
	movq	%r12, (%rax,%rdi)
	jmp	.LBB8_138
.LBB8_125:
	movl	$1, %ebp
	leaq	(%r12,%rbp,8), %r14
	cmpq	%r8, %rbp
	jge	.LBB8_131
	.p2align	4
.LBB8_127:
	leaq	(%r12,%r8,8), %r9
	.p2align	4
.LBB8_128:
	cmpq	(%r14), %rdi
	jl	.LBB8_131
	incq	%rbp
	addq	$8, %r14
	cmpq	%rbp, %r8
	jne	.LBB8_128
	movq	%r8, %rbp
	movq	%r9, %r14
.LBB8_131:
	incq	%r8
	.p2align	4
.LBB8_132:
	movq	-8(%r12,%r8,8), %r9
	decq	%r8
	cmpq	%r9, %rdi
	jl	.LBB8_132
	cmpq	%r8, %rbp
	jge	.LBB8_134
	movq	(%r14), %rdi
	movq	%r9, (%r14)
	incq	%rbp
	movq	%rdi, (%r12,%r8,8)
	decq	%r8
	movq	(%r12), %rdi
	leaq	(%r12,%rbp,8), %r14
	cmpq	%r8, %rbp
	jl	.LBB8_127
	jmp	.LBB8_131
.LBB8_134:
	movq	-8(%r14), %r8
	movq	%rdi, -8(%r14)
	leaq	1(%rbp), %rdi
	movq	%r8, (%r12)
	cmpq	%rdi, %r13
	jle	.LBB8_139
	cmpq	%rbx, %rcx
	jle	.LBB8_137
	xorl	%ecx, %ecx
	testq	%rbx, %rbx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movq	%rbx, %rdx
	sete	%cl
	leaq	(%rcx,%rbx,2), %rcx
	callq	"std::collections::list::List::_realloc(::List[$0]&,::Int),T=[typevalue<#kgen.instref<\"std::memory::span::Span,mut=1,origin._mlir_origin`={  },T=[typevalue<#kgen.instref<\\1B\\22std::builtin::int::Int\\22>>, index],origin={  }\">>, struct<(pointer<none>, index)>]"@PLT
	movq	(%rsp), %rsi
	movq	%rcx, %rbx
.LBB8_137:
	movq	%rdx, %rdi
	shlq	$4, %rdi
	subq	%rbp, %r13
	leaq	(%rax,%rdi), %rcx
	movq	%r14, (%rax,%rdi)
.LBB8_138:
	incq	%rdx
	movq	%r13, 8(%rcx)
.LBB8_139:
	testq	%rdx, %rdx
	jg	.LBB8_59
.LBB8_56:
	testq	%rbx, %rbx
	jle	.LBB8_55
	movq	%rax, %rdi
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	KGEN_CompilerRT_AlignedFree@PLT
.LBB8_11:
	.cfi_def_cfa_offset 64
	movq	(%rdi), %rdx
	movq	16(%rdi), %rax
	cmpq	%rax, %rdx
	jge	.LBB8_13
	movq	%rax, %rcx
	movq	%rdx, %rax
	movq	8(%rdi), %r8
	movq	24(%rdi), %rsi
	cmpq	%rsi, %r8
	jl	.LBB8_15
.LBB8_16:
	movq	%rsi, 8(%rdi)
	movq	%r8, %rdx
	movq	%r8, 24(%rdi)
	cmpq	%rsi, %rax
	jl	.LBB8_18
.LBB8_19:
	movq	%rsi, (%rdi)
	movq	%rax, 8(%rdi)
	cmpq	%rdx, %rcx
	jl	.LBB8_21
.LBB8_22:
	movq	%rdx, 16(%rdi)
	movq	%rcx, 24(%rdi)
	cmpq	%rdx, %rax
	jge	.LBB8_24
	jmp	.LBB8_55
.LBB8_25:
	movq	(%rdi), %rdx
	movq	8(%rdi), %rcx
	cmpq	%rcx, %rdx
	jge	.LBB8_27
	movq	%rdx, %rax
	movq	%rcx, %rdx
	movq	24(%rdi), %rcx
	movq	32(%rdi), %rsi
	cmpq	%rsi, %rcx
	jl	.LBB8_29
.LBB8_30:
	movq	%rsi, 24(%rdi)
	movq	%rcx, %r9
	movq	%rcx, 32(%rdi)
	movq	16(%rdi), %rcx
	cmpq	%rsi, %rcx
	jl	.LBB8_32
.LBB8_33:
	movq	%rsi, 16(%rdi)
	movq	%rcx, 24(%rdi)
	cmpq	%r9, %rcx
	jge	.LBB8_35
	movq	%rcx, %r8
	movq	%r9, %rcx
	cmpq	%rcx, %rdx
	jl	.LBB8_37
	jmp	.LBB8_38
.LBB8_5:
	movq	8(%rdi), %rdx
	movq	16(%rdi), %rax
	cmpq	%rax, %rdx
	jge	.LBB8_7
	movq	%rax, %rcx
	movq	%rdx, %rax
	movq	(%rdi), %rdx
	cmpq	%rax, %rdx
	jge	.LBB8_9
	jmp	.LBB8_55
.LBB8_13:
	movq	%rax, (%rdi)
	movq	%rdx, %rcx
	movq	%rdx, 16(%rdi)
	movq	8(%rdi), %r8
	movq	24(%rdi), %rsi
	cmpq	%rsi, %r8
	jge	.LBB8_16
.LBB8_15:
	movq	%rsi, %rdx
	movq	%r8, %rsi
	cmpq	%rsi, %rax
	jge	.LBB8_19
.LBB8_18:
	movq	%rsi, %rax
	cmpq	%rdx, %rcx
	jge	.LBB8_22
.LBB8_21:
	movq	%rcx, %rdx
	cmpq	%rdx, %rax
	jl	.LBB8_55
.LBB8_24:
	movq	%rdx, 8(%rdi)
	movq	%rax, 16(%rdi)
	jmp	.LBB8_55
.LBB8_27:
	movq	%rcx, (%rdi)
	movq	%rcx, %rax
	movq	%rdx, 8(%rdi)
	movq	24(%rdi), %rcx
	movq	32(%rdi), %rsi
	cmpq	%rsi, %rcx
	jge	.LBB8_30
.LBB8_29:
	movq	%rsi, %r9
	movq	%rcx, %rsi
	movq	16(%rdi), %rcx
	cmpq	%rsi, %rcx
	jge	.LBB8_33
.LBB8_32:
	movq	%rsi, %r8
	movq	%rcx, %rsi
	movq	%r9, %rcx
	cmpq	%rcx, %rdx
	jge	.LBB8_38
.LBB8_37:
	movq	%rdx, %rcx
	cmpq	%rsi, %rax
	jl	.LBB8_40
.LBB8_41:
	movq	%rsi, (%rdi)
	movq	%rax, 16(%rdi)
	cmpq	%r8, %rax
	jge	.LBB8_43
	movq	%r8, %rdx
	movq	%rax, %r8
	cmpq	%r8, %rcx
	jge	.LBB8_45
	jmp	.LBB8_55
.LBB8_7:
	movq	%rax, 8(%rdi)
	movq	%rdx, %rcx
	movq	%rdx, 16(%rdi)
	movq	(%rdi), %rdx
	cmpq	%rax, %rdx
	jl	.LBB8_55
.LBB8_9:
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	cmpq	%rcx, %rdx
	jl	.LBB8_55
	movq	%rcx, 8(%rdi)
	movq	%rdx, 16(%rdi)
	jmp	.LBB8_55
.LBB8_35:
	movq	%r9, 24(%rdi)
	movq	%r9, %r8
	movq	%rcx, 32(%rdi)
	cmpq	%rcx, %rdx
	jl	.LBB8_37
.LBB8_38:
	movq	%rcx, 8(%rdi)
	movq	%rdx, 32(%rdi)
	cmpq	%rsi, %rax
	jge	.LBB8_41
.LBB8_40:
	movq	%r8, %rdx
	movq	%rsi, %r8
	cmpq	%r8, %rcx
	jge	.LBB8_45
	jmp	.LBB8_55
.LBB8_43:
	movq	%r8, 16(%rdi)
	movq	%rax, %rdx
	movq	%rax, 24(%rdi)
	cmpq	%r8, %rcx
	jl	.LBB8_55
.LBB8_45:
	movq	%r8, 8(%rdi)
	movq	%rcx, 16(%rdi)
	cmpq	%rdx, %rcx
	jl	.LBB8_55
	movq	%rdx, 16(%rdi)
	movq	%rcx, 24(%rdi)
.LBB8_55:
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end8:
	.size	"std::builtin::sort::_sort[::Copyable,LITMutOrigin,::Origin[::Bool(True), $1],LITOriginSet,def($1|0, $1|0, /) capturing -> ::Bool,::Bool,::Bool](::Span[::Bool(True), $1, $0, $2]),T=[typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index],cmp_fn=\"def[LITOriginSet](::Int, ::Int, /) capturing -> ::Bool|def(::Int, ::Int, /) capturing -> ::Bool|8defd9926c462636[LITOriginSet,def(::Int, ::Int, /) capturing -> ::Bool](::Int,::Int)\"<:(index, index) capturing -> i1 \"std::builtin::sort::sort[LITMutOrigin,::Origin[::Bool(True), $0],::Bool](::Span[::Bool(True), $0, ::Int, $1])__cmp_fn(::Int,::Int)\">,stable=0,do_smallsort=1", .Lfunc_end8-"std::builtin::sort::_sort[::Copyable,LITMutOrigin,::Origin[::Bool(True), $1],LITOriginSet,def($1|0, $1|0, /) capturing -> ::Bool,::Bool,::Bool](::Span[::Bool(True), $1, $0, $2]),T=[typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index],cmp_fn=\"def[LITOriginSet](::Int, ::Int, /) capturing -> ::Bool|def(::Int, ::Int, /) capturing -> ::Bool|8defd9926c462636[LITOriginSet,def(::Int, ::Int, /) capturing -> ::Bool](::Int,::Int)\"<:(index, index) capturing -> i1 \"std::builtin::sort::sort[LITMutOrigin,::Origin[::Bool(True), $0],::Bool](::Span[::Bool(True), $0, ::Int, $1])__cmp_fn(::Int,::Int)\">,stable=0,do_smallsort=1"
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
.LJTI8_0:
	.long	.LBB8_62-.LJTI8_0
	.long	.LBB8_64-.LJTI8_0
	.long	.LBB8_70-.LJTI8_0
	.long	.LBB8_84-.LJTI8_0
.LJTI8_1:
	.long	.LBB8_3-.LJTI8_1
	.long	.LBB8_5-.LJTI8_1
	.long	.LBB8_11-.LJTI8_1
	.long	.LBB8_25-.LJTI8_1

	.text
	.p2align	4
	.type	"std::io::io::_flush(::FileDescriptor)",@function
"std::io::io::_flush(::FileDescriptor)":
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	callq	dup@PLT
	leaq	static_string_0d78baac08237ddb(%rip), %rsi
	movl	%eax, %edi
	callq	fdopen@PLT
	movq	%rax, %rdi
	movq	%rax, %rbx
	callq	fflush@PLT
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	fclose@PLT
.Lfunc_end9:
	.size	"std::io::io::_flush(::FileDescriptor)", .Lfunc_end9-"std::io::io::_flush(::FileDescriptor)"
	.cfi_endproc

	.p2align	4
	.type	"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[]",@function
"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[]":
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$4120, %rsp
	.cfi_def_cfa_offset 4144
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	leaq	8(%rsp), %r14
	movl	%edx, %ebx
	movq	%rsi, %rdx
	movq	%rdi, %rsi
	movq	%rcx, (%rsp)
	movq	$0, 4104(%rsp)
	movq	%rsp, %rax
	movq	%rax, 4112(%rsp)
	movq	%r14, %rdi
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	4112(%rsp), %rax
	movq	4104(%rsp), %rdx
	movq	%r14, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	testb	$1, %bl
	je	.LBB10_1
	movq	(%rsp), %rdi
	addq	$4120, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	"std::io::io::_flush(::FileDescriptor)"@PLT
.LBB10_1:
	.cfi_def_cfa_offset 4144
	addq	$4120, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end10:
	.size	"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[]", .Lfunc_end10-"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[]"
	.cfi_endproc

	.p2align	4
	.type	"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>]]",@function
"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>]]":
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$4200, %rsp
	.cfi_def_cfa_offset 4256
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%r9, 32(%rsp)
	movq	%rcx, 24(%rsp)
	movq	%rsi, 16(%rsp)
	leaq	8(%rsp), %rcx
	movq	%r8, %r14
	movq	%rdx, %r15
	movq	%rdi, %rsi
	movq	4320(%rsp), %rax
	movq	%rax, 80(%rsp)
	movq	4312(%rsp), %rax
	movq	%rax, 72(%rsp)
	movzbl	4328(%rsp), %eax
	movq	4304(%rsp), %r12
	movq	4296(%rsp), %r13
	movb	%al, 7(%rsp)
	movq	4288(%rsp), %rax
	movq	%rax, 64(%rsp)
	movq	4280(%rsp), %rax
	movq	%rax, 56(%rsp)
	movq	4272(%rsp), %rax
	movq	%rax, 48(%rsp)
	movq	4264(%rsp), %rax
	movq	%rax, 40(%rsp)
	movq	4336(%rsp), %rax
	movq	4256(%rsp), %rbp
	movq	$0, 4184(%rsp)
	movq	%rcx, 4192(%rsp)
	movq	%rax, 8(%rsp)
	movq	16(%rdi), %rax
	testq	%rax, %rax
	js	.LBB11_1
	movq	8(%rsi), %rdx
	movq	(%rsi), %rsi
	jmp	.LBB11_3
.LBB11_1:
	movl	$1336, %ecx
	bextrq	%rcx, %rax, %rdx
.LBB11_3:
	leaq	88(%rsp), %rbx
	movq	%rbx, %rdi
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	%rbx, %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	16(%rsp), %rdi
	movq	%rbx, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"@PLT
	movq	%rbx, %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	16(%r15), %rax
	testq	%rax, %rax
	js	.LBB11_4
	movq	8(%r15), %rdx
	movq	(%r15), %r15
	jmp	.LBB11_6
.LBB11_4:
	movl	$1336, %ecx
	bextrq	%rcx, %rax, %rdx
.LBB11_6:
	leaq	88(%rsp), %rbx
	movq	%r15, %rsi
	movq	%rbx, %rdi
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	%rbx, %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	24(%rsp), %rdi
	movq	%rbx, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"@PLT
	movq	%rbx, %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	16(%r14), %rax
	testq	%rax, %rax
	js	.LBB11_7
	movq	8(%r14), %rdx
	movq	(%r14), %r14
	jmp	.LBB11_9
.LBB11_7:
	movl	$1336, %ecx
	bextrq	%rcx, %rax, %rdx
.LBB11_9:
	leaq	88(%rsp), %rbx
	movq	%r14, %rsi
	movq	%rbx, %rdi
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	%rbx, %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	32(%rsp), %rdi
	movq	%rbx, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"@PLT
	movq	%rbx, %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	16(%rbp), %rax
	testq	%rax, %rax
	js	.LBB11_10
	movq	8(%rbp), %rdx
	movq	(%rbp), %rbp
	jmp	.LBB11_12
.LBB11_10:
	movl	$1336, %ecx
	bextrq	%rcx, %rax, %rdx
.LBB11_12:
	leaq	88(%rsp), %rbx
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	%rbx, %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	40(%rsp), %rdi
	movq	%rbx, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"@PLT
	movq	%rbx, %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	48(%rsp), %rsi
	movq	16(%rsi), %rax
	testq	%rax, %rax
	js	.LBB11_13
	movq	8(%rsi), %rdx
	movq	(%rsi), %rsi
	jmp	.LBB11_15
.LBB11_13:
	movl	$1336, %ecx
	bextrq	%rcx, %rax, %rdx
.LBB11_15:
	leaq	88(%rsp), %rbx
	movq	%rbx, %rdi
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	%rbx, %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	56(%rsp), %rdi
	movq	%rbx, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"@PLT
	movq	%rbx, %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	64(%rsp), %rsi
	movq	16(%rsi), %rax
	testq	%rax, %rax
	js	.LBB11_16
	movq	8(%rsi), %rdx
	movq	(%rsi), %rsi
	jmp	.LBB11_18
.LBB11_16:
	movl	$1336, %ecx
	bextrq	%rcx, %rax, %rdx
.LBB11_18:
	leaq	88(%rsp), %rbx
	movq	%rbx, %rdi
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	72(%rsp), %rsi
	movq	80(%rsp), %rdx
	movq	%rbx, %rdi
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	4192(%rsp), %rax
	movq	4184(%rsp), %rdx
	movq	%rbx, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	testb	$1, 7(%rsp)
	je	.LBB11_19
	movq	8(%rsp), %rdi
	addq	$4200, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	"std::io::io::_flush(::FileDescriptor)"@PLT
.LBB11_19:
	.cfi_def_cfa_offset 4256
	addq	$4200, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end11:
	.size	"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>]]", .Lfunc_end11-"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>]]"
	.cfi_endproc

	.p2align	4
	.type	"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>]]",@function
"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>]]":
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r12
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	subq	$4120, %rsp
	.cfi_def_cfa_offset 4160
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%r8, (%rsp)
	movq	$0, 4104(%rsp)
	movq	%rsp, %rax
	movq	%rax, 4112(%rsp)
	movq	%rsi, %r15
	movl	%ecx, %ebx
	movq	%rdx, %r14
	movq	%rdi, %rsi
	movq	16(%rdi), %rax
	testq	%rax, %rax
	js	.LBB12_1
	movq	8(%rsi), %rdx
	movq	(%rsi), %rsi
	jmp	.LBB12_3
.LBB12_1:
	movl	$1336, %ecx
	bextrq	%rcx, %rax, %rdx
.LBB12_3:
	leaq	8(%rsp), %r12
	movq	%r12, %rdi
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	%r12, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	4112(%rsp), %rax
	movq	4104(%rsp), %rdx
	movq	%r12, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	testb	$1, %bl
	je	.LBB12_4
	movq	(%rsp), %rdi
	addq	$4120, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	"std::io::io::_flush(::FileDescriptor)"@PLT
.LBB12_4:
	.cfi_def_cfa_offset 4160
	addq	$4120, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end12:
	.size	"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>]]", .Lfunc_end12-"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>]]"
	.cfi_endproc

	.type	static_string_9d820e1d0eba9e11,@object
	.section	.rodata,"a",@progbits
	.p2align	4, 0x0
static_string_9d820e1d0eba9e11:
	.asciz	"GB/s"
	.size	static_string_9d820e1d0eba9e11, 5

	.type	static_string_2a5587262656d518,@object
	.p2align	4, 0x0
static_string_2a5587262656d518:
	.asciz	"  bw(simd16):"
	.size	static_string_2a5587262656d518, 14

	.type	static_string_486ee4207f4452dd,@object
	.p2align	4, 0x0
static_string_486ee4207f4452dd:
	.asciz	"ns   ratio:"
	.size	static_string_486ee4207f4452dd, 12

	.type	static_string_81d1b08491d5bcb4,@object
	.p2align	4, 0x0
static_string_81d1b08491d5bcb4:
	.asciz	"ns   simd16:"
	.size	static_string_81d1b08491d5bcb4, 13

	.type	static_string_f9e7fe49bfba4b0f,@object
	.p2align	4, 0x0
static_string_f9e7fe49bfba4b0f:
	.asciz	" scalar:"
	.size	static_string_f9e7fe49bfba4b0f, 9

	.type	static_string_c6985149de191244,@object
	.p2align	4, 0x0
static_string_c6985149de191244:
	.asciz	"N="
	.size	static_string_c6985149de191244, 3

	.type	static_string_6bc14c4b48f42840,@object
	.p2align	4, 0x0
static_string_6bc14c4b48f42840:
	.asciz	"alias W = 16 (AVX-512 native float32 lane count)"
	.size	static_string_6bc14c4b48f42840, 49

	.type	static_string_e01f7c7a8e275f5c,@object
	.p2align	4, 0x0
static_string_e01f7c7a8e275f5c:
	.asciz	"=== MOJO-11: vector add (scalar vs explicit SIMD16) ==="
	.size	static_string_e01f7c7a8e275f5c, 56

	.type	static_string_a8d4ace0dc8d360e,@object
	.p2align	4, 0x0
static_string_a8d4ace0dc8d360e:
	.asciz	" "
	.size	static_string_a8d4ace0dc8d360e, 2

	.type	static_string_bbe01a6a523daf15,@object
	.p2align	4, 0x0
static_string_bbe01a6a523daf15:
	.asciz	"\n"
	.size	static_string_bbe01a6a523daf15, 2

	.type	static_string_a61c3395ab9379d9,@object
	.p2align	4, 0x0
static_string_a61c3395ab9379d9:
	.asciz	"Runtime"
	.size	static_string_a61c3395ab9379d9, 8

	.type	static_string_978d8d34847e5196,@object
	.p2align	4, 0x0
static_string_978d8d34847e5196:
	.asciz	"0123456789abcdefghijklmnopqrstuvwxyz"
	.size	static_string_978d8d34847e5196, 37

	.type	static_string_0d78baac08237ddb,@object
	.p2align	4, 0x0
static_string_0d78baac08237ddb:
	.asciz	"a"
	.size	static_string_0d78baac08237ddb, 2

	.section	".note.GNU-stack","",@progbits
