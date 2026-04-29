	.att_syntax
	.file	"01_simd_kernel.mojo"
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

	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5, 0x0
.LCPI2_0:
	.long	0x41300000
	.long	0x41400000
	.long	0x41500000
	.long	0x41600000
	.long	0x41700000
	.long	0x41800000
	.long	0x41880000
	.long	0x41900000
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
.LCPI2_1:
	.long	0x42ca0000
	.long	0x42cc0000
	.long	0x42ce0000
	.long	0x42d00000
	.long	0x42d20000
	.long	0x42d40000
	.long	0x42d60000
	.long	0x42d80000
	.long	0x42da0000
	.long	0x42dc0000
	.long	0x42de0000
	.long	0x42e00000
	.long	0x42e20000
	.long	0x42e40000
	.long	0x42e60000
	.long	0x42e80000
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
	pushq	%rbx
	.cfi_def_cfa_offset 40
	subq	$56, %rsp
	.cfi_def_cfa_offset 96
	.cfi_offset %rbx, -40
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
	vmovaps	.LCPI2_0(%rip), %ymm0
	leaq	static_string_43b6feca8a7883bf(%rip), %rax
	leaq	static_string_a8d4ace0dc8d360e(%rip), %rsi
	leaq	static_string_bbe01a6a523daf15(%rip), %rcx
	leaq	8(%rsp), %rdi
	movl	$1, %edx
	movl	$1, %r8d
	movq	$15, 16(%rsp)
	xorl	%r9d, %r9d
	movq	$1, (%rsp)
	movq	%rax, 8(%rsp)
	movq	%r15, 24(%rsp)
	callq	"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f32,size=8\">>, simd<8, f32>]]"@PLT
	testb	$64, 31(%rsp)
	je	.LBB2_5
	movq	8(%rsp), %rdi
	lock		decq	-8(%rdi)
	jne	.LBB2_5
	addq	$-8, %rdi
	#MEMBARRIER
	vzeroupper
	callq	KGEN_CompilerRT_AlignedFree@PLT
.LBB2_5:
	vmovaps	.LCPI2_1(%rip), %zmm0
	leaq	static_string_2fba8616703f45c4(%rip), %rax
	leaq	static_string_a8d4ace0dc8d360e(%rip), %rsi
	leaq	static_string_bbe01a6a523daf15(%rip), %rcx
	leaq	32(%rsp), %rdi
	movl	$1, %edx
	movl	$1, %r8d
	movq	$18, 40(%rsp)
	xorl	%r9d, %r9d
	movq	$1, (%rsp)
	movq	%rax, 32(%rsp)
	movq	%r15, 48(%rsp)
	callq	"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f32,size=16\">>, simd<16, f32>]]"@PLT
	testq	%r14, 48(%rsp)
	je	.LBB2_8
	movq	32(%rsp), %rdi
	lock		decq	-8(%rdi)
	jne	.LBB2_8
	addq	$-8, %rdi
	#MEMBARRIER
	vzeroupper
	callq	KGEN_CompilerRT_AlignedFree@PLT
.LBB2_8:
	vzeroupper
	callq	KGEN_CompilerRT_DestroyGlobals@PLT
	xorl	%eax, %eax
	addq	$56, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
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
	.type	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=f32,size=16,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]",@function
"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=f32,size=16,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]":
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	andq	$-64, %rsp
	subq	$256, %rsp
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	movq	4096(%rdi), %rdx
	movq	%rdi, %rbx
	vmovaps	%zmm0, 64(%rsp)
	leaq	1(%rdx), %rax
	cmpq	$4097, %rax
	jl	.LBB3_2
	movq	4104(%rbx), %rax
	movq	%rbx, %rsi
	movq	(%rax), %rdi
	vzeroupper
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%rbx)
.LBB3_2:
	movb	$91, (%rbx,%rdx)
	incq	4096(%rbx)
	xorl	%r14d, %r14d
	jmp	.LBB3_3
	.p2align	4
.LBB3_6:
	movw	$8236, (%rbx,%rdx)
	addq	$2, 4096(%rbx)
.LBB3_7:
	movq	%rbx, %rdi
	vzeroupper
	callq	"std::builtin::_format_float::_write_float[::Writer,::DType]($0&,::SIMD[$1, ::Int(1)]){#pop.cast_to_builtin<#pop.simd_xor<#pop.simd_cmp<eq, #pop.simd_and<#pop.cast_from_builtin<#pop.dtype_to_ui8<#lit.struct.extract<:!lit.struct<_std::_builtin::_dtype::_DType> *(0,1), \"_mlir_value\">> : ui8> : !pop.scalar<ui8>, #pop<simd 64> : !pop.scalar<ui8>> : !pop.scalar<ui8>, #pop<simd 0> : !pop.scalar<ui8>> : !pop.scalar<bool>, #pop<simd true> : !pop.scalar<bool>> : !pop.scalar<bool>>},W=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>],dtype=f32"@PLT
	incq	%r14
	cmpq	$16, %r14
	je	.LBB3_8
.LBB3_3:
	vmovaps	64(%rsp), %zmm0
	movl	%r14d, %eax
	andl	$15, %eax
	vmovaps	%zmm0, 128(%rsp)
	vmovss	128(%rsp,%rax,4), %xmm0
	testq	%r14, %r14
	je	.LBB3_7
	movq	4096(%rbx), %rdx
	leaq	2(%rdx), %rax
	cmpq	$4097, %rax
	jl	.LBB3_6
	movq	4104(%rbx), %rax
	movq	%rbx, %rsi
	vmovss	%xmm0, 60(%rsp)
	movq	(%rax), %rdi
	vzeroupper
	callq	write@PLT
	vmovss	60(%rsp), %xmm0
	xorl	%edx, %edx
	movq	$0, 4096(%rbx)
	jmp	.LBB3_6
.LBB3_8:
	movq	4096(%rbx), %rdx
	leaq	1(%rdx), %rax
	cmpq	$4097, %rax
	jl	.LBB3_10
	movq	4104(%rbx), %rax
	movq	%rbx, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%rbx)
.LBB3_10:
	movb	$93, (%rbx,%rdx)
	incq	4096(%rbx)
	leaq	-16(%rbp), %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end3:
	.size	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=f32,size=16,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]", .Lfunc_end3-"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=f32,size=16,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"
	.cfi_endproc

	.p2align	4
	.type	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=f32,size=8,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]",@function
"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=f32,size=8,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]":
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	andq	$-32, %rsp
	subq	$96, %rsp
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	movq	4096(%rdi), %rdx
	movq	%rdi, %rbx
	vmovaps	%ymm0, 32(%rsp)
	leaq	1(%rdx), %rax
	cmpq	$4097, %rax
	jl	.LBB4_2
	movq	4104(%rbx), %rax
	movq	%rbx, %rsi
	movq	(%rax), %rdi
	vzeroupper
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%rbx)
.LBB4_2:
	movb	$91, (%rbx,%rdx)
	incq	4096(%rbx)
	xorl	%r14d, %r14d
	jmp	.LBB4_3
	.p2align	4
.LBB4_6:
	movw	$8236, (%rbx,%rdx)
	addq	$2, 4096(%rbx)
.LBB4_7:
	movq	%rbx, %rdi
	vzeroupper
	callq	"std::builtin::_format_float::_write_float[::Writer,::DType]($0&,::SIMD[$1, ::Int(1)]){#pop.cast_to_builtin<#pop.simd_xor<#pop.simd_cmp<eq, #pop.simd_and<#pop.cast_from_builtin<#pop.dtype_to_ui8<#lit.struct.extract<:!lit.struct<_std::_builtin::_dtype::_DType> *(0,1), \"_mlir_value\">> : ui8> : !pop.scalar<ui8>, #pop<simd 64> : !pop.scalar<ui8>> : !pop.scalar<ui8>, #pop<simd 0> : !pop.scalar<ui8>> : !pop.scalar<bool>, #pop<simd true> : !pop.scalar<bool>> : !pop.scalar<bool>>},W=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>],dtype=f32"@PLT
	incq	%r14
	cmpq	$8, %r14
	je	.LBB4_8
.LBB4_3:
	vmovaps	32(%rsp), %ymm0
	movl	%r14d, %eax
	andl	$7, %eax
	vmovaps	%ymm0, 64(%rsp)
	vmovss	64(%rsp,%rax,4), %xmm0
	testq	%r14, %r14
	je	.LBB4_7
	movq	4096(%rbx), %rdx
	leaq	2(%rdx), %rax
	cmpq	$4097, %rax
	jl	.LBB4_6
	movq	4104(%rbx), %rax
	movq	%rbx, %rsi
	vmovss	%xmm0, 28(%rsp)
	movq	(%rax), %rdi
	vzeroupper
	callq	write@PLT
	vmovss	28(%rsp), %xmm0
	xorl	%edx, %edx
	movq	$0, 4096(%rbx)
	jmp	.LBB4_6
.LBB4_8:
	movq	4096(%rbx), %rdx
	leaq	1(%rdx), %rax
	cmpq	$4097, %rax
	jl	.LBB4_10
	movq	4104(%rbx), %rax
	movq	%rbx, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%rbx)
.LBB4_10:
	movb	$93, (%rbx,%rdx)
	incq	4096(%rbx)
	leaq	-16(%rbp), %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end4:
	.size	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=f32,size=8,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]", .Lfunc_end4-"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=f32,size=8,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"
	.cfi_endproc

	.p2align	4
	.type	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]",@function
"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]":
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
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rdx, %rbx
	testq	%rdi, %rdi
	je	.LBB5_1
	movq	%rdi, %r14
	jns	.LBB5_6
	leaq	static_string_a8e3dd8c929b6eb8(%rip), %rax
	movabsq	$2305843009213693952, %rcx
	movq	$1, 8(%rsp)
	movq	%rsp, %rdi
	movq	%rbx, %rdx
	movq	%rax, (%rsp)
	movq	%rcx, 16(%rsp)
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movq	%rax, %rsi
	movq	%rdx, %rbx
.LBB5_6:
	cmpq	$2049, %rbx
	jge	.LBB5_26
	movl	$63, %ecx
	movb	$0, 64(%rsp)
	testq	%r14, %r14
	js	.LBB5_8
	leaq	static_string_978d8d34847e5196(%rip), %rax
	movabsq	$-3689348814741910323, %rdi
	.p2align	4
.LBB5_11:
	movq	%r14, %rdx
	mulxq	%rdi, %rdx, %rdx
	movq	%r14, %r9
	shrq	$3, %rdx
	leaq	(%rdx,%rdx), %r8
	leaq	(%r8,%r8,4), %r8
	subq	%r8, %r9
	movzbl	(%rax,%r9), %r8d
	movb	%r8b, (%rsp,%rcx)
	decq	%rcx
	cmpq	$10, %r14
	movq	%rdx, %r14
	jae	.LBB5_11
	jmp	.LBB5_12
.LBB5_1:
	cmpq	$2048, %rbx
	jg	.LBB5_26
	cmpq	$2048, %rbx
	je	.LBB5_26
	movb	$48, (%rsi,%rbx)
	leaq	1(%rbx), %rdx
	jmp	.LBB5_25
.LBB5_8:
	movabsq	$7378697629483820647, %rdi
	leaq	static_string_978d8d34847e5196(%rip), %r8
	movabsq	$-7378697629483820647, %r9
	.p2align	4
.LBB5_9:
	movq	%r14, %rax
	imulq	%rdi
	movq	%r14, %r11
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$2, %rdx
	addq	%rax, %rdx
	addq	%rdx, %rdx
	leaq	(%rdx,%rdx,4), %rax
	movq	%r14, %rdx
	subq	%rax, %rdx
	testq	%r14, %r14
	movq	$-10, %rax
	setns	%r10b
	testq	%rdx, %rdx
	cmoveq	%rdx, %rax
	sarq	$63, %r11
	andnq	%rax, %r11, %rax
	addq	%rdx, %rax
	movq	%rax, %rdx
	negq	%rdx
	cmovsq	%rax, %rdx
	movzbl	(%rdx,%r8), %eax
	movb	%al, (%rsp,%rcx)
	movq	%r14, %rax
	imulq	%r9
	decq	%rcx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$2, %rdx
	addq	%rax, %rdx
	leaq	(%rdx,%rdx), %rax
	leaq	(%rax,%rax,4), %rax
	addq	%r14, %rax
	setne	%al
	andb	%r10b, %al
	movzbl	%al, %r14d
	subq	%rdx, %r14
	jne	.LBB5_9
.LBB5_12:
	leaq	1(%rcx), %rax
	addq	$66, %rcx
	movl	$64, %r14d
	movq	%rcx, %rdx
	sarq	$63, %rdx
	andnq	%rcx, %rdx, %rdx
	cmpq	$65, %rax
	movl	$65, %ecx
	cmovlq	%rax, %rcx
	testq	%rax, %rax
	cmovsq	%rdx, %rcx
	subq	%rcx, %r14
	leaq	(%r14,%rbx), %rdx
	cmpq	$2049, %rdx
	jge	.LBB5_26
	addq	%rsi, %rbx
	leaq	(%rsp,%rcx), %r15
	cmpq	$4, %r14
	jg	.LBB5_17
	cmpq	$64, %rcx
	je	.LBB5_25
	movzbl	(%r15), %edi
	movl	$63, %eax
	subq	%rcx, %rax
	movb	%dil, (%rbx)
	movzbl	63(%rsp), %edi
	movb	%dil, (%rbx,%rax)
	cmpq	$3, %r14
	jl	.LBB5_25
	movl	$62, %eax
	subq	%rcx, %rax
	movzbl	1(%r15), %ecx
	movb	%cl, 1(%rbx)
	movzbl	62(%rsp), %ecx
	movb	%cl, (%rbx,%rax)
	jmp	.LBB5_25
.LBB5_17:
	cmpq	$16, %r14
	ja	.LBB5_21
	cmpq	$8, %r14
	jl	.LBB5_20
	movq	(%r15), %rax
	movq	%rax, (%rbx)
	movq	56(%rsp), %rax
	movq	%rax, -8(%rbx,%r14)
	jmp	.LBB5_25
.LBB5_21:
	movabsq	$9223372036854775776, %r12
	andq	%r14, %r12
	je	.LBB5_23
	movl	$32, %eax
	movq	%rsi, %r13
	movq	%rbx, %rdi
	movq	%r15, %rsi
	movq	%rdx, %rbp
	subq	%rcx, %rax
	andq	$-32, %rax
	addq	$32, %rax
	movq	%rax, %rdx
	callq	memcpy@PLT
	movq	%rbp, %rdx
	movq	%r13, %rsi
.LBB5_23:
	cmpq	%r14, %r12
	je	.LBB5_25
	addq	%r12, %rbx
	addq	%r12, %r15
	andl	$31, %r14d
	movq	%rbx, %rdi
	movq	%rsi, %rbx
	movq	%r15, %rsi
	movq	%rdx, %r15
	movq	%r14, %rdx
	callq	memcpy@PLT
	movq	%r15, %rdx
	movq	%rbx, %rsi
	jmp	.LBB5_25
.LBB5_20:
	movl	(%r15), %eax
	movl	%eax, (%rbx)
	movl	60(%rsp), %eax
	movl	%eax, -4(%rbx,%r14)
.LBB5_25:
	movq	%rsi, %rax
	addq	$72, %rsp
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
.LBB5_26:
	.cfi_def_cfa_offset 128
	movl	$1, %edi
	callq	"std::io::io::_printf[::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType](*$1,file:::FileDescriptor),fmt={ #interp.memref<{[(#interp.memory_handle<16, \"HEAP_BUFFER_BYTES exceeded, increase with: `mojo -D HEAP_BUFFER_BYTES=4096`\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 76 },types=[]"@PLT
	ud2
.Lfunc_end5:
	.size	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]", .Lfunc_end5-"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	.cfi_endproc

	.p2align	4
	.type	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui32,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]",@function
"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui32,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]":
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$72, %rsp
	.cfi_def_cfa_offset 96
	.cfi_offset %rbx, -24
	.cfi_offset %rbp, -16
	movq	4096(%rsi), %rdx
	movq	%rsi, %rbx
	testl	%edi, %edi
	je	.LBB6_1
	cmpq	$4097, %rdx
	jl	.LBB6_6
	movq	4104(%rbx), %rax
	movl	%edi, %ebp
	movq	%rbx, %rsi
	movq	(%rax), %rax
	movq	%rax, %rdi
	callq	write@PLT
	movl	%ebp, %edi
	movq	$0, 4096(%rbx)
.LBB6_6:
	movl	$64, %eax
	movl	$3435973837, %ecx
	leaq	static_string_978d8d34847e5196(%rip), %rdx
	movb	$0, 71(%rsp)
	.p2align	4
.LBB6_7:
	movl	%edi, %esi
	imulq	%rcx, %rsi
	movl	%edi, %r9d
	shrq	$35, %rsi
	leal	(%rsi,%rsi), %r8d
	leal	(%r8,%r8,4), %r8d
	subl	%r8d, %r9d
	movzbl	(%r9,%rdx), %r8d
	movb	%r8b, 6(%rsp,%rax)
	decq	%rax
	cmpl	$9, %edi
	movl	%esi, %edi
	ja	.LBB6_7
	leaq	65(%rax), %rcx
	movl	$65, %edi
	movq	%rcx, %rdx
	sarq	$63, %rdx
	andnq	%rcx, %rdx, %rcx
	cmpq	$65, %rax
	movl	$64, %edx
	cmovlq	%rax, %rdi
	testq	%rax, %rax
	cmovsq	%rcx, %rdi
	leaq	7(%rsp,%rdi), %rsi
	subq	%rdi, %rdx
	movq	%rbx, %rdi
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=1"@PLT
	addq	$72, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.LBB6_1:
	.cfi_def_cfa_offset 96
	cmpq	$4097, %rdx
	setl	%al
	cmpq	$4096, %rdx
	setne	%cl
	testb	%cl, %al
	jne	.LBB6_3
	movq	4104(%rbx), %rax
	movq	%rbx, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%rbx)
.LBB6_3:
	movb	$48, (%rbx,%rdx)
	incq	4096(%rbx)
	addq	$72, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end6:
	.size	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui32,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]", .Lfunc_end6-"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui32,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"
	.cfi_endproc

	.p2align	4
	.type	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui8,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]",@function
"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui8,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]":
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$72, %rsp
	.cfi_def_cfa_offset 96
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	4096(%rsi), %rdx
	movq	%rsi, %rbx
	testb	%dil, %dil
	je	.LBB7_1
	cmpq	$4097, %rdx
	jl	.LBB7_6
	movq	4104(%rbx), %rax
	movq	%rdi, %r14
	movq	%rbx, %rsi
	movq	(%rax), %rax
	movq	%rax, %rdi
	callq	write@PLT
	movq	%r14, %rdi
	movq	$0, 4096(%rbx)
.LBB7_6:
	movl	$64, %eax
	leaq	static_string_978d8d34847e5196(%rip), %rcx
	movb	$0, 71(%rsp)
	.p2align	4
.LBB7_7:
	movzbl	%dil, %edx
	imull	$205, %edx, %edi
	movl	%edx, %r8d
	shrl	$11, %edi
	leal	(%rdi,%rdi), %esi
	leal	(%rsi,%rsi,4), %esi
	subb	%sil, %r8b
	movzbl	%r8b, %esi
	movzbl	(%rsi,%rcx), %esi
	movb	%sil, 6(%rsp,%rax)
	decq	%rax
	cmpb	$9, %dl
	ja	.LBB7_7
	leaq	65(%rax), %rcx
	movl	$65, %edi
	movq	%rcx, %rdx
	sarq	$63, %rdx
	andnq	%rcx, %rdx, %rcx
	cmpq	$65, %rax
	movl	$64, %edx
	cmovlq	%rax, %rdi
	testq	%rax, %rax
	cmovsq	%rcx, %rdi
	leaq	7(%rsp,%rdi), %rsi
	subq	%rdi, %rdx
	movq	%rbx, %rdi
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=1"@PLT
	addq	$72, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.LBB7_1:
	.cfi_def_cfa_offset 96
	cmpq	$4097, %rdx
	setl	%al
	cmpq	$4096, %rdx
	setne	%cl
	testb	%cl, %al
	jne	.LBB7_3
	movq	4104(%rbx), %rax
	movq	%rbx, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%rbx)
.LBB7_3:
	movb	$48, (%rbx,%rdx)
	incq	4096(%rbx)
	addq	$72, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end7:
	.size	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui8,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]", .Lfunc_end7-"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui8,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"
	.cfi_endproc

	.p2align	4
	.type	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=uindex,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]",@function
"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=uindex,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]":
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
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rdx, %rcx
	movq	%rsi, %rax
	testq	%rdi, %rdi
	je	.LBB8_1
	cmpq	$2049, %rcx
	jge	.LBB8_21
	movq	%rdi, %rdx
	movl	$64, %r8d
	leaq	static_string_978d8d34847e5196(%rip), %rdi
	movabsq	$-3689348814741910323, %r9
	movb	$0, 71(%rsp)
	.p2align	4
.LBB8_6:
	mulxq	%r9, %r10, %r10
	movq	%rdx, %rbx
	shrq	$3, %r10
	leaq	(%r10,%r10), %r11
	leaq	(%r11,%r11,4), %r11
	subq	%r11, %rbx
	movzbl	(%rdi,%rbx), %r11d
	movb	%r11b, 6(%rsp,%r8)
	decq	%r8
	cmpq	$9, %rdx
	movq	%r10, %rdx
	ja	.LBB8_6
	leaq	65(%r8), %rdx
	movl	$64, %ebx
	movq	%rdx, %rdi
	sarq	$63, %rdi
	andnq	%rdx, %rdi, %rdx
	cmpq	$65, %r8
	movl	$65, %edi
	cmovlq	%r8, %rdi
	testq	%r8, %r8
	cmovsq	%rdx, %rdi
	subq	%rdi, %rbx
	leaq	(%rbx,%rcx), %rdx
	cmpq	$2049, %rdx
	jge	.LBB8_21
	leaq	7(%rsp,%rdi), %r14
	addq	%rcx, %rsi
	cmpq	$4, %rbx
	jg	.LBB8_12
	cmpq	$64, %rdi
	je	.LBB8_20
	movzbl	(%r14), %r8d
	movl	$63, %ecx
	subq	%rdi, %rcx
	movb	%r8b, (%rsi)
	movzbl	70(%rsp), %r8d
	movb	%r8b, (%rsi,%rcx)
	cmpq	$3, %rbx
	jl	.LBB8_20
	movl	$62, %ecx
	subq	%rdi, %rcx
	movzbl	1(%r14), %edi
	movb	%dil, 1(%rsi)
	movzbl	69(%rsp), %edi
	movb	%dil, (%rsi,%rcx)
	jmp	.LBB8_20
.LBB8_1:
	cmpq	$2048, %rcx
	jg	.LBB8_21
	je	.LBB8_21
	movb	$48, (%rax,%rcx)
	incq	%rcx
	movq	%rcx, %rdx
.LBB8_20:
	addq	$72, %rsp
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
.LBB8_12:
	.cfi_def_cfa_offset 128
	cmpq	$16, %rbx
	ja	.LBB8_16
	cmpq	$8, %rbx
	jl	.LBB8_15
	movq	(%r14), %rcx
	movq	%rcx, (%rsi)
	movq	63(%rsp), %rcx
	movq	%rcx, -8(%rsi,%rbx)
	jmp	.LBB8_20
.LBB8_16:
	movabsq	$9223372036854775776, %r15
	andq	%rbx, %r15
	je	.LBB8_18
	movl	$32, %ecx
	movq	%rsi, %r12
	movq	%rdx, %r13
	movq	%rax, %rbp
	subq	%rdi, %rcx
	movq	%rsi, %rdi
	movq	%r14, %rsi
	andq	$-32, %rcx
	addq	$32, %rcx
	movq	%rcx, %rdx
	callq	memcpy@PLT
	movq	%r13, %rdx
	movq	%r12, %rsi
	movq	%rbp, %rax
.LBB8_18:
	cmpq	%rbx, %r15
	je	.LBB8_20
	addq	%r15, %rsi
	addq	%r15, %r14
	andl	$31, %ebx
	movq	%rsi, %rdi
	movq	%r14, %rsi
	movq	%rdx, %r14
	movq	%rbx, %rdx
	movq	%rax, %rbx
	callq	memcpy@PLT
	movq	%r14, %rdx
	movq	%rbx, %rax
	jmp	.LBB8_20
.LBB8_15:
	movl	(%r14), %ecx
	movl	%ecx, (%rsi)
	movl	67(%rsp), %ecx
	movl	%ecx, -4(%rsi,%rbx)
	jmp	.LBB8_20
.LBB8_21:
	movl	$1, %edi
	callq	"std::io::io::_printf[::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType](*$1,file:::FileDescriptor),fmt={ #interp.memref<{[(#interp.memory_handle<16, \"HEAP_BUFFER_BYTES exceeded, increase with: `mojo -D HEAP_BUFFER_BYTES=4096`\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 76 },types=[]"@PLT
	ud2
.Lfunc_end8:
	.size	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=uindex,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]", .Lfunc_end8-"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=uindex,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
	.cfi_endproc

	.p2align	4
	.type	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]",@function
"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]":
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	16(%rdi), %rax
	testq	%rax, %rax
	js	.LBB9_1
	movq	8(%rdi), %rax
	movq	(%rdi), %rdi
	leaq	(%rax,%rdx), %rcx
	cmpq	$2049, %rcx
	jge	.LBB9_18
.LBB9_4:
	addq	%rsi, %rdx
	cmpq	$4, %rax
	jg	.LBB9_8
	testq	%rax, %rax
	je	.LBB9_17
	movzbl	(%rdi), %r8d
	movb	%r8b, (%rdx)
	movzbl	-1(%rdi,%rax), %r8d
	movb	%r8b, -1(%rdx,%rax)
	cmpq	$3, %rax
	jl	.LBB9_17
	movzbl	1(%rdi), %r8d
	movb	%r8b, 1(%rdx)
	movzbl	-2(%rdi,%rax), %edi
	movb	%dil, -2(%rdx,%rax)
.LBB9_17:
	movq	%rsi, %rax
	movq	%rcx, %rdx
	popq	%rcx
	.cfi_def_cfa_offset 8
	vzeroupper
	retq
.LBB9_8:
	.cfi_def_cfa_offset 16
	cmpq	$16, %rax
	ja	.LBB9_12
	cmpq	$8, %rax
	jl	.LBB9_11
	movq	(%rdi), %r8
	movq	%r8, (%rdx)
	movq	-8(%rdi,%rax), %rdi
	movq	%rdi, -8(%rdx,%rax)
	movq	%rsi, %rax
	movq	%rcx, %rdx
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.LBB9_1:
	.cfi_def_cfa_offset 16
	movl	$1336, %ecx
	bextrq	%rcx, %rax, %rax
	leaq	(%rax,%rdx), %rcx
	cmpq	$2049, %rcx
	jl	.LBB9_4
.LBB9_18:
	movl	$1, %edi
	callq	"std::io::io::_printf[::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType](*$1,file:::FileDescriptor),fmt={ #interp.memref<{[(#interp.memory_handle<16, \"HEAP_BUFFER_BYTES exceeded, increase with: `mojo -D HEAP_BUFFER_BYTES=4096`\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 76 },types=[]"@PLT
	ud2
.LBB9_12:
	movabsq	$9223372036854775776, %r8
	andq	%rax, %r8
	je	.LBB9_15
	xorl	%r9d, %r9d
	.p2align	4
.LBB9_14:
	vmovups	(%rdi,%r9), %ymm0
	vmovups	%ymm0, (%rdx,%r9)
	addq	$32, %r9
	cmpq	%r8, %r9
	jb	.LBB9_14
.LBB9_15:
	cmpq	%rax, %r8
	je	.LBB9_17
	.p2align	4
.LBB9_16:
	movzbl	(%rdi,%r8), %r9d
	movb	%r9b, (%rdx,%r8)
	incq	%r8
	cmpq	%r8, %rax
	jne	.LBB9_16
	jmp	.LBB9_17
.LBB9_11:
	movl	(%rdi), %r8d
	movl	%r8d, (%rdx)
	movl	-4(%rdi,%rax), %edi
	movl	%edi, -4(%rdx,%rax)
	movq	%rsi, %rax
	movq	%rcx, %rdx
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end9:
	.size	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]", .Lfunc_end9-"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"
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
	jl	.LBB10_1
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
.LBB10_1:
	.cfi_def_cfa_offset 48
	movq	4096(%r14), %rdx
	leaq	(%rdx,%rbx), %rax
	cmpq	$4097, %rax
	jl	.LBB10_3
	movq	4104(%r14), %rax
	movq	%r14, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%r14)
.LBB10_3:
	addq	%r14, %rdx
	cmpq	$4, %rbx
	jg	.LBB10_7
	testq	%rbx, %rbx
	je	.LBB10_15
	movzbl	(%r15), %eax
	movb	%al, (%rdx)
	movzbl	-1(%r15,%rbx), %eax
	movb	%al, -1(%rdx,%rbx)
	cmpq	$3, %rbx
	jl	.LBB10_15
	movzbl	1(%r15), %eax
	movb	%al, 1(%rdx)
	movzbl	-2(%r15,%rbx), %eax
	movb	%al, -2(%rdx,%rbx)
	jmp	.LBB10_15
.LBB10_7:
	cmpq	$16, %rbx
	jg	.LBB10_11
	cmpq	$8, %rbx
	jl	.LBB10_10
	movq	(%r15), %rax
	movq	%rax, (%rdx)
	movq	-8(%r15,%rbx), %rax
	movq	%rax, -8(%rdx,%rbx)
	jmp	.LBB10_15
.LBB10_11:
	movabsq	$9223372036854775776, %r12
	andq	%rbx, %r12
	je	.LBB10_13
	movq	%rdx, %rdi
	movq	%rdx, %r13
	movq	%r15, %rsi
	movq	%r12, %rdx
	callq	memcpy@PLT
	movq	%r13, %rdx
.LBB10_13:
	cmpq	%rbx, %r12
	je	.LBB10_15
	movl	%ebx, %eax
	addq	%r12, %rdx
	addq	%r12, %r15
	andl	$31, %eax
	movq	%rdx, %rdi
	movq	%r15, %rsi
	movq	%rax, %rdx
	callq	memcpy@PLT
	jmp	.LBB10_15
.LBB10_10:
	movl	(%r15), %eax
	movl	%eax, (%rdx)
	movl	-4(%r15,%rbx), %eax
	movl	%eax, -4(%rdx,%rbx)
.LBB10_15:
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
.Lfunc_end10:
	.size	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0", .Lfunc_end10-"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"
	.cfi_endproc

	.p2align	4
	.type	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=1",@function
"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=1":
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
	jl	.LBB11_1
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
.LBB11_1:
	.cfi_def_cfa_offset 48
	movq	4096(%r14), %rdx
	leaq	(%rdx,%rbx), %rax
	cmpq	$4097, %rax
	jl	.LBB11_3
	movq	4104(%r14), %rax
	movq	%r14, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%r14)
.LBB11_3:
	addq	%r14, %rdx
	cmpq	$4, %rbx
	jg	.LBB11_7
	testq	%rbx, %rbx
	je	.LBB11_15
	movzbl	(%r15), %eax
	movb	%al, (%rdx)
	movzbl	-1(%r15,%rbx), %eax
	movb	%al, -1(%rdx,%rbx)
	cmpq	$3, %rbx
	jl	.LBB11_15
	movzbl	1(%r15), %eax
	movb	%al, 1(%rdx)
	movzbl	-2(%r15,%rbx), %eax
	movb	%al, -2(%rdx,%rbx)
	jmp	.LBB11_15
.LBB11_7:
	cmpq	$16, %rbx
	jg	.LBB11_11
	cmpq	$8, %rbx
	jl	.LBB11_10
	movq	(%r15), %rax
	movq	%rax, (%rdx)
	movq	-8(%r15,%rbx), %rax
	movq	%rax, -8(%rdx,%rbx)
	jmp	.LBB11_15
.LBB11_11:
	movabsq	$9223372036854775776, %r12
	andq	%rbx, %r12
	je	.LBB11_13
	movq	%rdx, %rdi
	movq	%rdx, %r13
	movq	%r15, %rsi
	movq	%r12, %rdx
	callq	memcpy@PLT
	movq	%r13, %rdx
.LBB11_13:
	cmpq	%rbx, %r12
	je	.LBB11_15
	movl	%ebx, %eax
	addq	%r12, %rdx
	addq	%r12, %r15
	andl	$31, %eax
	movq	%rdx, %rdi
	movq	%r15, %rsi
	movq	%rax, %rdx
	callq	memcpy@PLT
	jmp	.LBB11_15
.LBB11_10:
	movl	(%r15), %eax
	movl	%eax, (%rdx)
	movl	-4(%r15,%rbx), %eax
	movl	%eax, -4(%rdx,%rbx)
.LBB11_15:
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
.Lfunc_end11:
	.size	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=1", .Lfunc_end11-"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=1"
	.cfi_endproc

	.p2align	4
	.type	"std::builtin::_format_float::_write_float[::Writer,::DType]($0&,::SIMD[$1, ::Int(1)]){#pop.cast_to_builtin<#pop.simd_xor<#pop.simd_cmp<eq, #pop.simd_and<#pop.cast_from_builtin<#pop.dtype_to_ui8<#lit.struct.extract<:!lit.struct<_std::_builtin::_dtype::_DType> *(0,1), \"_mlir_value\">> : ui8> : !pop.scalar<ui8>, #pop<simd 64> : !pop.scalar<ui8>> : !pop.scalar<ui8>, #pop<simd 0> : !pop.scalar<ui8>> : !pop.scalar<bool>, #pop<simd true> : !pop.scalar<bool>> : !pop.scalar<bool>>},W=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>],dtype=f32",@function
"std::builtin::_format_float::_write_float[::Writer,::DType]($0&,::SIMD[$1, ::Int(1)]){#pop.cast_to_builtin<#pop.simd_xor<#pop.simd_cmp<eq, #pop.simd_and<#pop.cast_from_builtin<#pop.dtype_to_ui8<#lit.struct.extract<:!lit.struct<_std::_builtin::_dtype::_DType> *(0,1), \"_mlir_value\">> : ui8> : !pop.scalar<ui8>, #pop<simd 64> : !pop.scalar<ui8>> : !pop.scalar<ui8>, #pop<simd 0> : !pop.scalar<ui8>> : !pop.scalar<bool>, #pop<simd true> : !pop.scalar<bool>> : !pop.scalar<bool>>},W=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>],dtype=f32":
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
	subq	$2472, %rsp
	.cfi_def_cfa_offset 2528
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	vmovd	%xmm0, %eax
	movq	%rdi, %r13
	movl	%eax, %ecx
	andl	$2147483647, %ecx
	cmpl	$2139095040, %ecx
	jne	.LBB12_8
	testl	%eax, %eax
	js	.LBB12_2
	movq	4096(%r13), %rdx
	leaq	3(%rdx), %rax
	cmpq	$4097, %rax
	jl	.LBB12_7
	movq	4104(%r13), %rax
	movq	%r13, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%r13)
.LBB12_7:
	movw	$28265, (%r13,%rdx)
	movb	$102, 2(%r13,%rdx)
	addq	$3, 4096(%r13)
	jmp	.LBB12_108
.LBB12_8:
	vucomiss	%xmm0, %xmm0
	jp	.LBB12_109
	movl	$2071, %ecx
	movl	%eax, %r14d
	andl	$8388607, %r14d
	bextrl	%ecx, %eax, %ebx
	testl	%eax, %eax
	js	.LBB12_10
	movl	%ebx, %eax
	orl	%r14d, %eax
	je	.LBB12_14
.LBB12_17:
	testl	%r14d, %r14d
	movabsq	$2305843009213693952, %rsi
	movq	%r13, (%rsp)
	setne	%al
	testq	%rbx, %rbx
	sete	%cl
	orb	%al, %cl
	je	.LBB12_18
	leaq	-150(%rbx), %rcx
	testq	%rbx, %rbx
	movq	$-149, %rax
	leal	16777216(%r14,%r14), %r9d
	leal	(%r14,%r14), %edx
	movl	$32, %r15d
	movq	$29, 360(%rsp)
	movq	$16, 384(%rsp)
	movq	$12, 408(%rsp)
	cmovneq	%rcx, %rax
	leaq	static_string_acd13d9261b6d2db(%rip), %rcx
	cmovel	%edx, %r9d
	imulq	$315653, %rax, %r14
	movq	%rcx, 352(%rsp)
	leaq	static_string_9e82ac40fb677304(%rip), %rcx
	movq	%rsi, 368(%rsp)
	movq	%rcx, 376(%rsp)
	leaq	static_string_220f5f6631208dbe(%rip), %rcx
	movq	%rsi, 392(%rsp)
	movq	%rcx, 400(%rsp)
	movq	%rsi, 416(%rsp)
	sarq	$20, %r14
	subq	%r14, %r15
	cmpq	$78, %r15
	jae	.LBB12_22
	imulq	$-1741647, %r14, %rbp
	leaq	global_constant(%rip), %rcx
	movl	%r9d, %edx
	orl	$1, %edx
	movl	%r9d, %edi
	decl	%edi
	leaq	1(%r14), %r8
	addq	$1741647, %rbp
	sarq	$19, %rbp
	addq	%rax, %rbp
	movq	(%rcx,%r15,8), %rax
	movl	%ebp, %ecx
	notb	%cl
	shrxq	%rcx, %rax, %rbx
	shlxl	%ebp, %edx, %ecx
	movl	%eax, %edx
	shrq	$32, %rax
	imulq	%rcx, %rdx
	imulq	%rcx, %rax
	shrq	$32, %rdx
	addq	%rax, %rdx
	shrq	$32, %rdx
	imulq	$1374389535, %rdx, %r12
	shrq	$37, %r12
	imull	$-100, %r12d, %r13d
	addl	%edx, %r13d
	cmpl	%ebx, %r13d
	jae	.LBB12_27
	imull	$184254097, %r12d, %eax
	xorl	%ecx, %ecx
	shrdl	$4, %r12d, %eax
	cmpl	$429497, %eax
	cmovael	%r12d, %eax
	setb	%cl
	xorl	%esi, %esi
	imull	$42949673, %eax, %edx
	shrdl	$2, %eax, %edx
	cmpl	$42949673, %edx
	cmovael	%eax, %edx
	setb	%sil
	imull	$1288490189, %edx, %r12d
	addl	%esi, %esi
	leal	(%rsi,%rcx,4), %r14d
	shrdl	$1, %edx, %r12d
	cmpl	$429496730, %r12d
	cmovael	%edx, %r12d
	adcq	%r8, %r14
	jmp	.LBB12_32
.LBB12_2:
	movq	4096(%r13), %rdx
	leaq	4(%rdx), %rax
	cmpq	$4097, %rax
	jl	.LBB12_4
	movq	4104(%r13), %rax
	movq	%r13, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%r13)
.LBB12_4:
	movl	$1718511917, (%r13,%rdx)
	addq	$4, 4096(%r13)
	jmp	.LBB12_108
.LBB12_10:
	movq	4096(%r13), %rdx
	leaq	1(%rdx), %rax
	cmpq	$4097, %rax
	jl	.LBB12_12
	movq	4104(%r13), %rax
	movq	%r13, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%r13)
.LBB12_12:
	movb	$45, (%r13,%rdx)
	incq	4096(%r13)
	movl	%ebx, %eax
	orl	%r14d, %eax
	jne	.LBB12_17
.LBB12_14:
	movq	4096(%r13), %rdx
	leaq	3(%rdx), %rax
	cmpq	$4097, %rax
	jl	.LBB12_16
	movq	4104(%r13), %rax
	movq	%r13, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%r13)
.LBB12_16:
	movw	$11824, (%r13,%rdx)
	movb	$48, 2(%r13,%rdx)
	addq	$3, 4096(%r13)
	jmp	.LBB12_108
.LBB12_18:
	imulq	$631305, %rbx, %r14
	movl	$31, %r15d
	movl	$1, %edx
	addq	$-94957413, %r14
	sarq	$21, %r14
	imulq	$-1741647, %r14, %rax
	subq	%r14, %r15
	movq	%r15, %rdi
	sarq	$19, %rax
	leaq	-150(%rax,%rbx), %r12
	movq	%r12, %rsi
	callq	"std::builtin::_format_float::_compute_endpoint[::DType,::Int,::Int,::Int](::Int,::Int,::Bool),CarrierDType=ui32,sig_bits=23,total_bits=32,cache_bits=64"@PLT
	movl	%eax, %ebp
	movq	%r15, %rdi
	movq	%r12, %rsi
	xorl	%edx, %edx
	callq	"std::builtin::_format_float::_compute_endpoint[::DType,::Int,::Int,::Int](::Int,::Int,::Bool),CarrierDType=ui32,sig_bits=23,total_bits=32,cache_bits=64"@PLT
	addl	$-154, %ebx
	movl	%eax, %eax
	cmpl	$-2, %ebx
	adcl	$0, %ebp
	imulq	$429496730, %rax, %rax
	shrq	$32, %rax
	leal	(%rax,%rax), %ecx
	leal	(%rcx,%rcx,4), %ecx
	cmpl	%ebp, %ecx
	jae	.LBB12_19
	movb	$39, %cl
	leaq	global_constant(%rip), %rax
	subb	%r12b, %cl
	shrxq	%rcx, (%rax,%r15,8), %r12
	incl	%r12d
	shrl	%r12d
	cmpl	%ebp, %r12d
	adcl	$0, %r12d
	jmp	.LBB12_33
.LBB12_19:
	imull	$184254097, %eax, %ecx
	incq	%r14
	xorl	%edx, %edx
	shrdl	$4, %eax, %ecx
	cmpl	$429497, %ecx
	cmovael	%eax, %ecx
	setb	%dl
	xorl	%esi, %esi
	imull	$42949673, %ecx, %eax
	shrdl	$2, %ecx, %eax
	cmpl	$42949673, %eax
	cmovael	%ecx, %eax
	setb	%sil
	imull	$1288490189, %eax, %r12d
	addl	%esi, %esi
	leal	(%rsi,%rdx,4), %ecx
	shrdl	$1, %eax, %r12d
	cmpl	$429496730, %r12d
	cmovael	%eax, %r12d
	adcq	%rcx, %r14
	jmp	.LBB12_33
.LBB12_27:
	jne	.LBB12_30
	movq	%r15, %rsi
	movq	%rbp, %rdx
	movq	%r9, 8(%rsp)
	callq	"std::builtin::_format_float::_compute_mul_parity[::DType](::SIMD[$0, ::Int(1)],::Int,::Int),CarrierDType=ui64"@PLT
	movq	8(%rsp), %r9
	leaq	1(%r14), %rdi
	orb	%al, %dl
	testb	$1, %dl
	je	.LBB12_30
	imull	$184254097, %r12d, %eax
	xorl	%ecx, %ecx
	shrdl	$4, %r12d, %eax
	cmpl	$429497, %eax
	cmovael	%r12d, %eax
	setb	%cl
	xorl	%esi, %esi
	imull	$42949673, %eax, %edx
	shrdl	$2, %eax, %edx
	cmpl	$42949673, %edx
	cmovael	%eax, %edx
	setb	%sil
	imull	$1288490189, %edx, %r12d
	addl	%esi, %esi
	leal	(%rsi,%rcx,4), %r14d
	shrdl	$1, %edx, %r12d
	cmpl	$429496730, %r12d
	cmovael	%edx, %r12d
	adcq	%rdi, %r14
	jmp	.LBB12_32
.LBB12_30:
	shrl	%ebx
	leal	(%r12,%r12,4), %eax
	subl	%ebx, %r13d
	imull	$6554, %r13d, %ecx
	addl	$32770, %ecx
	movzwl	%cx, %edx
	shrl	$16, %ecx
	leal	(%rcx,%rax,2), %r12d
	cmpl	$6553, %edx
	ja	.LBB12_32
	movq	%r9, %rdi
	movq	%r15, %rsi
	movq	%rbp, %rdx
	callq	"std::builtin::_format_float::_compute_mul_parity[::DType](::SIMD[$0, ::Int(1)],::Int,::Int),CarrierDType=ui64"@PLT
	xorb	%r13b, %al
	movzbl	%al, %eax
	andl	$1, %eax
	subl	%eax, %r12d
.LBB12_32:
	movq	(%rsp), %r13
.LBB12_33:
	movq	%r14, %rax
	negq	%rax
	cmovsq	%r14, %rax
	xorl	%ebp, %ebp
	testl	%r12d, %r12d
	je	.LBB12_40
	leaq	static_string_acd13d9261b6d2db(%rip), %rcx
	leaq	static_string_9e82ac40fb677304(%rip), %rdx
	leaq	static_string_220f5f6631208dbe(%rip), %rsi
	movl	$3435973837, %edi
	movl	%r12d, %r8d
	.p2align	4
.LBB12_35:
	movabsq	$2305843009213693952, %r9
	movq	$29, 168(%rsp)
	movq	%rcx, 160(%rsp)
	movq	$16, 192(%rsp)
	movq	%rdx, 184(%rsp)
	movq	$12, 216(%rsp)
	movq	%rsi, 208(%rsp)
	movq	%r9, 176(%rsp)
	movq	%r9, 200(%rsp)
	movq	%r9, 224(%rsp)
	cmpq	$21, %rbp
	je	.LBB12_36
	movl	%r8d, %r9d
	imulq	%rdi, %r9
	movl	%r8d, %r11d
	shrq	$35, %r9
	leal	(%r9,%r9), %r10d
	leal	(%r10,%r10,4), %r10d
	subl	%r10d, %r11d
	movb	%r11b, 104(%rsp,%rbp)
	incq	%rbp
	cmpl	$10, %r8d
	sbbq	$-1, %r14
	cmpl	$9, %r8d
	movl	%r9d, %r8d
	ja	.LBB12_35
.LBB12_40:
	leaq	-1(%rbp), %rbx
	leaq	20(%rbp), %rcx
	testq	%rbp, %rbp
	movq	%rax, %rsi
	cmovgq	%rbx, %rcx
	subq	%rbp, %rsi
	testq	%r14, %r14
	sets	%dl
	cmpq	$4, %rsi
	movq	%rsi, 24(%rsp)
	setge	%sil
	cmpq	$15, %r14
	jg	.LBB12_42
	andb	%sil, %dl
	jne	.LBB12_42
	testq	%r14, %r14
	sets	%cl
	cmpq	%rbp, %rax
	setg	%al
	testb	%al, %cl
	je	.LBB12_72
	movq	4096(%r13), %rdx
	movq	24(%rsp), %r14
	movq	%rbx, 16(%rsp)
	leaq	2(%rdx), %rax
	cmpq	$4097, %rax
	jl	.LBB12_76
	movq	4104(%r13), %rax
	movq	%r13, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%r13)
.LBB12_76:
	movw	$11824, (%r13,%rdx)
	movq	4096(%r13), %rdx
	addq	$2, %rdx
	movq	%rdx, 4096(%r13)
	testq	%r14, %r14
	jle	.LBB12_81
	movq	%r14, %rax
	sarq	$63, %rax
	andnq	%r14, %rax, %rbx
	cmpq	$1, %rbx
	adcq	$-1, %rbx
	incq	%rbx
	jmp	.LBB12_78
	.p2align	4
.LBB12_80:
	movb	$48, (%r13,%rdx)
	movq	4096(%r13), %rdx
	incq	%rdx
	decq	%rbx
	movq	%rdx, 4096(%r13)
	je	.LBB12_81
.LBB12_78:
	leaq	1(%rdx), %rax
	cmpq	$4097, %rax
	jl	.LBB12_80
	movq	4104(%r13), %rax
	movq	%r13, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%r13)
	jmp	.LBB12_80
.LBB12_42:
	cmpl	$9, %r12d
	ja	.LBB12_44
	movl	%r12d, %edi
	movq	%r13, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui32,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"@PLT
	movabsq	$2305843009213693952, %rbp
	testq	%rbx, %rbx
	jg	.LBB12_50
	jmp	.LBB12_52
.LBB12_44:
	leaq	static_string_acd13d9261b6d2db(%rip), %rax
	movabsq	$2305843009213693952, %rbp
	leaq	static_string_9e82ac40fb677304(%rip), %rsi
	leaq	static_string_220f5f6631208dbe(%rip), %rdx
	movq	$29, 240(%rsp)
	movq	$16, 264(%rsp)
	movq	$12, 288(%rsp)
	movq	%rax, 232(%rsp)
	movq	%rsi, 256(%rsp)
	movq	%rdx, 280(%rsp)
	movq	%rbp, 248(%rsp)
	movq	%rbp, 272(%rsp)
	movq	%rbp, 296(%rsp)
	cmpq	$21, %rcx
	jae	.LBB12_45
	movzbl	104(%rsp,%rcx), %edi
	movq	%r13, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui8,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"@PLT
	movq	4096(%r13), %rdx
	leaq	1(%rdx), %rax
	cmpq	$4097, %rax
	jl	.LBB12_48
	movq	4104(%r13), %rax
	movq	%r13, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%r13)
.LBB12_48:
	movb	$46, (%r13,%rdx)
	incq	4096(%r13)
	testq	%rbx, %rbx
	jle	.LBB12_52
.LBB12_50:
	movq	%rbx, %rax
	sarq	$63, %rax
	andnq	%rbx, %rax, %rbx
	.p2align	4
.LBB12_51:
	movzbl	103(%rsp,%rbx), %edi
	movq	%r13, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui8,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"@PLT
	decq	%rbx
	jne	.LBB12_51
.LBB12_52:
	testq	%r14, %r14
	js	.LBB12_53
	movq	4096(%r13), %rdx
	leaq	2(%rdx), %rax
	cmpq	$4097, %rax
	jl	.LBB12_61
	movq	4104(%r13), %rax
	movq	%r13, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%r13)
.LBB12_61:
	movw	$11109, (%r13,%rdx)
	addq	$2, 4096(%r13)
	jmp	.LBB12_62
.LBB12_72:
	movq	%r14, %rax
	notq	%rax
	movq	%rax, 8(%rsp)
	movq	24(%rsp), %r12
	testq	%rbp, %rbp
	jle	.LBB12_73
	leaq	104(%rsp,%rbx), %rcx
	movq	%rbp, %rax
	negq	%rax
	xorl	%r13d, %r13d
	xorl	%r15d, %r15d
	movq	%rax, 136(%rsp)
	movq	%rbx, 16(%rsp)
	movq	%rcx, 128(%rsp)
	.p2align	4
.LBB12_87:
	testq	%r12, %r12
	setle	%al
	cmpq	%r13, 8(%rsp)
	sete	%bl
	andb	%al, %bl
	cmpb	$1, %bl
	jne	.LBB12_97
	movq	(%rsp), %rax
	movq	4096(%rax), %rdx
	testq	%r13, %r13
	je	.LBB12_89
	leaq	1(%rdx), %rax
	cmpq	$4097, %rax
	jl	.LBB12_94
.LBB12_95:
	movq	(%rsp), %r12
	movq	4104(%r12), %rax
	movq	%r12, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%r12)
	jmp	.LBB12_96
.LBB12_89:
	leaq	1(%rdx), %rax
	cmpq	$4097, %rax
	jl	.LBB12_90
	movq	(%rsp), %r12
	movq	4104(%r12), %rax
	movq	%r12, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%r12)
	jmp	.LBB12_92
.LBB12_90:
	movq	(%rsp), %r12
.LBB12_92:
	movb	$48, (%r12,%rdx)
	movq	4096(%r12), %rdx
	incq	%rdx
	movq	%rdx, 4096(%r12)
	leaq	1(%rdx), %rax
	cmpq	$4097, %rax
	jge	.LBB12_95
.LBB12_94:
	movq	(%rsp), %r12
.LBB12_96:
	movb	$46, (%r12,%rdx)
	incq	4096(%r12)
	movq	24(%rsp), %r12
.LBB12_97:
	leaq	static_string_9e82ac40fb677304(%rip), %rcx
	movq	$16, 64(%rsp)
	leaq	static_string_acd13d9261b6d2db(%rip), %rax
	movabsq	$2305843009213693952, %rdx
	movq	$29, 40(%rsp)
	movq	$12, 88(%rsp)
	movq	%rcx, 56(%rsp)
	leaq	static_string_220f5f6631208dbe(%rip), %rcx
	movq	%rax, 32(%rsp)
	movq	%rdx, 48(%rsp)
	movq	%rdx, 72(%rsp)
	movq	%rcx, 80(%rsp)
	movq	%rdx, 96(%rsp)
	cmpq	$22, %rbp
	jae	.LBB12_84
	movq	128(%rsp), %rax
	movq	(%rsp), %rsi
	orb	%bl, %r15b
	movzbl	(%rax,%r13), %edi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui8,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"@PLT
	decq	%r13
	cmpq	%r13, 136(%rsp)
	jne	.LBB12_87
	jmp	.LBB12_99
.LBB12_81:
	testq	%rbp, %rbp
	jle	.LBB12_108
	leaq	static_string_acd13d9261b6d2db(%rip), %rbx
	leaq	static_string_9e82ac40fb677304(%rip), %r14
	leaq	static_string_220f5f6631208dbe(%rip), %r15
	movq	%rbp, %r12
	.p2align	4
.LBB12_83:
	movabsq	$2305843009213693952, %rax
	movq	$29, 40(%rsp)
	movq	%rbx, 32(%rsp)
	movq	$16, 64(%rsp)
	movq	%r14, 56(%rsp)
	movq	$12, 88(%rsp)
	movq	%r15, 80(%rsp)
	movq	%rax, 48(%rsp)
	movq	%rax, 72(%rsp)
	movq	%rax, 96(%rsp)
	cmpq	$22, %rbp
	jae	.LBB12_84
	movzbl	103(%rsp,%r12), %edi
	movq	%r13, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui8,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"@PLT
	decq	%r12
	jne	.LBB12_83
	jmp	.LBB12_108
.LBB12_53:
	movq	4096(%r13), %rdx
	leaq	2(%rdx), %rax
	cmpq	$4097, %rax
	jl	.LBB12_55
	movq	4104(%r13), %rax
	movq	%r13, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%r13)
.LBB12_55:
	movw	$11621, (%r13,%rdx)
	negq	%r14
	movq	4096(%r13), %rax
	leaq	2(%rax), %rdx
	movq	%rdx, 4096(%r13)
	cmpq	$9, %r14
	jg	.LBB12_62
	addq	$3, %rax
	cmpq	$4097, %rax
	jl	.LBB12_58
	movq	4104(%r13), %rax
	movq	%r13, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%r13)
.LBB12_58:
	movb	$48, (%r13,%rdx)
	incq	4096(%r13)
	testq	%r14, %r14
	jle	.LBB12_108
.LBB12_62:
	movq	$-1, %rbx
	leaq	static_string_acd13d9261b6d2db(%rip), %r15
	leaq	static_string_9e82ac40fb677304(%rip), %r12
	leaq	static_string_220f5f6631208dbe(%rip), %r13
	movabsq	$-3689348814741910323, %rax
	.p2align	4
.LBB12_63:
	movq	$29, 312(%rsp)
	movq	%r15, 304(%rsp)
	movq	$16, 336(%rsp)
	movq	%r12, 328(%rsp)
	movq	$12, 112(%rsp)
	movq	%r13, 104(%rsp)
	movq	%rbp, 320(%rsp)
	movq	%rbp, 344(%rsp)
	movq	%rbp, 120(%rsp)
	cmpq	$9, %rbx
	je	.LBB12_64
	movq	%r14, %rdx
	mulxq	%rax, %rcx, %rcx
	movl	%r14d, %esi
	shrq	$3, %rcx
	leal	(%rcx,%rcx), %edx
	leal	(%rdx,%rdx,4), %edx
	subl	%edx, %esi
	movb	%sil, 151(%rsp,%rbx)
	incq	%rbx
	cmpq	$9, %r14
	movq	%rcx, %r14
	ja	.LBB12_63
	movq	%rbx, %r14
	.p2align	4
.LBB12_68:
	movq	$29, 40(%rsp)
	movq	%r15, 32(%rsp)
	movq	$16, 64(%rsp)
	movq	%r12, 56(%rsp)
	movq	$12, 88(%rsp)
	movq	%r13, 80(%rsp)
	movq	%rbp, 48(%rsp)
	movq	%rbp, 72(%rsp)
	movq	%rbp, 96(%rsp)
	cmpq	$10, %rbx
	jae	.LBB12_69
	movzbl	150(%rsp,%r14), %edi
	movq	(%rsp), %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=ui8,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"@PLT
	addq	$-1, %r14
	jb	.LBB12_68
	jmp	.LBB12_108
.LBB12_73:
	xorl	%r15d, %r15d
.LBB12_99:
	subq	%rbp, %r14
	movabsq	$9223372036854775806, %rax
	movq	(%rsp), %rbx
	cmpq	%rax, %r14
	movq	8(%rsp), %r14
	jbe	.LBB12_100
.LBB12_104:
	testb	$1, %r15b
	jne	.LBB12_108
	movq	4096(%rbx), %rdx
	leaq	2(%rdx), %rax
	cmpq	$4097, %rax
	jl	.LBB12_107
	movq	4104(%rbx), %rax
	movq	%rbx, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%rbx)
.LBB12_107:
	movw	$12334, (%rbx,%rdx)
	addq	$2, 4096(%rbx)
.LBB12_108:
	addq	$2472, %rsp
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
.LBB12_100:
	.cfi_def_cfa_offset 2528
	movq	4096(%rbx), %rdx
	addq	%rbp, %r14
	jmp	.LBB12_101
	.p2align	4
.LBB12_103:
	movb	$48, (%rbx,%rdx)
	movq	4096(%rbx), %rdx
	incq	%rdx
	incq	%r14
	movq	%rdx, 4096(%rbx)
	je	.LBB12_104
.LBB12_101:
	leaq	1(%rdx), %rax
	cmpq	$4097, %rax
	jl	.LBB12_103
	movq	4104(%rbx), %rax
	movq	%rbx, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	xorl	%edx, %edx
	movq	$0, 4096(%rbx)
	jmp	.LBB12_103
.LBB12_36:
	movabsq	$8232973118699499081, %rax
	movabsq	$8746397786379218537, %rcx
	leaq	160(%rsp), %rdi
	leaq	424(%rsp), %rsi
	movl	$11, %edx
	movq	%rax, 424(%rsp)
	movq	%rcx, 427(%rsp)
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movl	$21, %edi
	movq	%rax, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	leaq	184(%rsp), %rdi
	movq	%rax, %rsi
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movl	$21, %edi
	movq	%rax, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=uindex,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	leaq	208(%rsp), %rdi
	jmp	.LBB12_37
.LBB12_64:
	movabsq	$8232973118699499081, %rax
	movabsq	$8746397786379218537, %rcx
	leaq	304(%rsp), %rdi
	leaq	424(%rsp), %rsi
	movl	$11, %edx
	movq	%rax, 424(%rsp)
	movq	%rcx, 427(%rsp)
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movl	$10, %edi
	movq	%rax, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	leaq	328(%rsp), %rdi
	movq	%rax, %rsi
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movl	$10, %edi
	movq	%rax, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=uindex,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	leaq	104(%rsp), %rdi
	jmp	.LBB12_65
.LBB12_69:
	movabsq	$8232973118699499081, %rax
	movabsq	$8746397786379218537, %rcx
	leaq	32(%rsp), %rdi
	leaq	424(%rsp), %rsi
	movl	$11, %edx
	movq	%rax, 424(%rsp)
	movq	%rcx, 427(%rsp)
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movq	%r14, %rdi
	movq	%rax, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	leaq	56(%rsp), %rdi
	movq	%rax, %rsi
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movl	$10, %edi
	movq	%rax, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=uindex,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	leaq	80(%rsp), %rdi
.LBB12_65:
	movq	%rax, %rsi
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movl	$10, %edi
	jmp	.LBB12_23
.LBB12_84:
	movabsq	$8232973118699499081, %rax
	movabsq	$8746397786379218537, %rcx
	leaq	32(%rsp), %rdi
	leaq	424(%rsp), %rsi
	movl	$11, %edx
	movq	%rax, 424(%rsp)
	movq	%rcx, 427(%rsp)
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movq	16(%rsp), %rdi
	movq	%rax, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	leaq	56(%rsp), %rdi
	movq	%rax, %rsi
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movl	$21, %edi
	movq	%rax, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=uindex,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	leaq	80(%rsp), %rdi
.LBB12_37:
	movq	%rax, %rsi
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movl	$21, %edi
.LBB12_23:
	movq	%rax, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=uindex,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	leaq	1(%rdx), %rcx
	cmpq	$2049, %rcx
	jl	.LBB12_24
	movl	$1, %edi
	callq	"std::io::io::_printf[::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType](*$1,file:::FileDescriptor),fmt={ #interp.memref<{[(#interp.memory_handle<16, \"HEAP_BUFFER_BYTES exceeded, increase with: `mojo -D HEAP_BUFFER_BYTES=4096`\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 76 },types=[]"@PLT
	ud2
.LBB12_24:
	movb	$0, (%rax,%rdx)
	leaq	static_string_96e550f66d8e6995(%rip), %rcx
	movl	$83, %esi
	movl	$61, %edx
	movl	$65, %r8d
	movq	%rax, %rdi
	callq	"std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)"@PLT
.LBB12_109:
	leaq	static_string_e5411518d45eb182(%rip), %rsi
	movl	$3, %edx
	movq	%r13, %rdi
	addq	$2472, %rsp
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
	jmp	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
.LBB12_22:
	.cfi_def_cfa_offset 2528
	movabsq	$8232973118699499081, %rax
	movabsq	$8746397786379218537, %rcx
	leaq	352(%rsp), %rdi
	leaq	424(%rsp), %rsi
	movl	$11, %edx
	movq	%rax, 424(%rsp)
	movq	%rcx, 427(%rsp)
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movl	$78, %edi
	movq	%rax, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	leaq	376(%rsp), %rdi
	movq	%rax, %rsi
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movl	$78, %edi
	movq	%rax, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=uindex,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	leaq	400(%rsp), %rdi
	movq	%rax, %rsi
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movl	$78, %edi
	jmp	.LBB12_23
.LBB12_45:
	movabsq	$8232973118699499081, %rax
	movabsq	$8746397786379218537, %rcx
	leaq	232(%rsp), %rdi
	leaq	424(%rsp), %rsi
	movl	$11, %edx
	movq	%rax, 424(%rsp)
	movq	%rcx, 427(%rsp)
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movq	%rbx, %rdi
	movq	%rax, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	leaq	256(%rsp), %rdi
	movq	%rax, %rsi
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movl	$21, %edi
	movq	%rax, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=uindex,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	leaq	280(%rsp), %rdi
	jmp	.LBB12_37
.Lfunc_end12:
	.size	"std::builtin::_format_float::_write_float[::Writer,::DType]($0&,::SIMD[$1, ::Int(1)]){#pop.cast_to_builtin<#pop.simd_xor<#pop.simd_cmp<eq, #pop.simd_and<#pop.cast_from_builtin<#pop.dtype_to_ui8<#lit.struct.extract<:!lit.struct<_std::_builtin::_dtype::_DType> *(0,1), \"_mlir_value\">> : ui8> : !pop.scalar<ui8>, #pop<simd 64> : !pop.scalar<ui8>> : !pop.scalar<ui8>, #pop<simd 0> : !pop.scalar<ui8>> : !pop.scalar<bool>, #pop<simd true> : !pop.scalar<bool>> : !pop.scalar<bool>>},W=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>],dtype=f32", .Lfunc_end12-"std::builtin::_format_float::_write_float[::Writer,::DType]($0&,::SIMD[$1, ::Int(1)]){#pop.cast_to_builtin<#pop.simd_xor<#pop.simd_cmp<eq, #pop.simd_and<#pop.cast_from_builtin<#pop.dtype_to_ui8<#lit.struct.extract<:!lit.struct<_std::_builtin::_dtype::_DType> *(0,1), \"_mlir_value\">> : ui8> : !pop.scalar<ui8>, #pop<simd 64> : !pop.scalar<ui8>> : !pop.scalar<ui8>, #pop<simd 0> : !pop.scalar<ui8>> : !pop.scalar<bool>, #pop<simd true> : !pop.scalar<bool>> : !pop.scalar<bool>>},W=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>],dtype=f32"
	.cfi_endproc

	.p2align	4
	.type	"std::builtin::_format_float::_compute_endpoint[::DType,::Int,::Int,::Int](::Int,::Int,::Bool),CarrierDType=ui32,sig_bits=23,total_bits=32,cache_bits=64",@function
"std::builtin::_format_float::_compute_endpoint[::DType,::Int,::Int,::Int](::Int,::Int,::Bool),CarrierDType=ui32,sig_bits=23,total_bits=32,cache_bits=64":
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$2128, %rsp
	.cfi_def_cfa_offset 2144
	.cfi_offset %rbx, -16
	leaq	78(%rdi), %rax
	testq	%rdi, %rdi
	leaq	static_string_9e82ac40fb677304(%rip), %r8
	movq	$16, 40(%rsp)
	leaq	static_string_acd13d9261b6d2db(%rip), %rcx
	movabsq	$2305843009213693952, %r9
	movq	$29, 16(%rsp)
	movq	$12, 64(%rsp)
	movq	%r8, 32(%rsp)
	leaq	static_string_220f5f6631208dbe(%rip), %r8
	cmovnsq	%rdi, %rax
	movq	%rcx, 8(%rsp)
	movq	%r9, 24(%rsp)
	movq	%r9, 48(%rsp)
	movq	%r8, 56(%rsp)
	movq	%r9, 72(%rsp)
	cmpq	$78, %rax
	jae	.LBB13_1
	leaq	global_constant(%rip), %rcx
	movq	(%rcx,%rax,8), %rax
	movq	%rax, %rdi
	shrq	$25, %rdi
	movq	%rax, %rcx
	shrq	$24, %rcx
	negq	%rdi
	testb	$1, %dl
	cmoveq	%rcx, %rdi
	addq	%rax, %rdi
	movb	$40, %al
	subb	%sil, %al
	shrxq	%rax, %rdi, %rax
	addq	$2128, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB13_1:
	.cfi_def_cfa_offset 2144
	movabsq	$8232973118699499081, %rax
	movabsq	$8746397786379218537, %rcx
	leaq	80(%rsp), %rsi
	movl	$11, %edx
	movq	%rdi, %rbx
	movq	%rax, 80(%rsp)
	leaq	8(%rsp), %rax
	movq	%rcx, 83(%rsp)
	movq	%rax, %rdi
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movq	%rbx, %rdi
	movq	%rax, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	leaq	32(%rsp), %rdi
	movq	%rax, %rsi
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movl	$78, %edi
	movq	%rax, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=uindex,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	leaq	56(%rsp), %rdi
	movq	%rax, %rsi
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movl	$78, %edi
	movq	%rax, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=uindex,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	leaq	1(%rdx), %rcx
	cmpq	$2049, %rcx
	jl	.LBB13_2
	movl	$1, %edi
	callq	"std::io::io::_printf[::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType](*$1,file:::FileDescriptor),fmt={ #interp.memref<{[(#interp.memory_handle<16, \"HEAP_BUFFER_BYTES exceeded, increase with: `mojo -D HEAP_BUFFER_BYTES=4096`\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 76 },types=[]"@PLT
	ud2
.LBB13_2:
	movb	$0, (%rax,%rdx)
	leaq	static_string_96e550f66d8e6995(%rip), %rcx
	movl	$83, %esi
	movl	$61, %edx
	movl	$65, %r8d
	movq	%rax, %rdi
	callq	"std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)"@PLT
.Lfunc_end13:
	.size	"std::builtin::_format_float::_compute_endpoint[::DType,::Int,::Int,::Int](::Int,::Int,::Bool),CarrierDType=ui32,sig_bits=23,total_bits=32,cache_bits=64", .Lfunc_end13-"std::builtin::_format_float::_compute_endpoint[::DType,::Int,::Int,::Int](::Int,::Int,::Bool),CarrierDType=ui32,sig_bits=23,total_bits=32,cache_bits=64"
	.cfi_endproc

	.p2align	4
	.type	"std::builtin::_format_float::_compute_mul_parity[::DType](::SIMD[$0, ::Int(1)],::Int,::Int),CarrierDType=ui64",@function
"std::builtin::_format_float::_compute_mul_parity[::DType](::SIMD[$0, ::Int(1)],::Int,::Int),CarrierDType=ui64":
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$2128, %rsp
	.cfi_def_cfa_offset 2144
	.cfi_offset %rbx, -16
	leaq	619(%rsi), %rax
	testq	%rsi, %rsi
	leaq	static_string_9e82ac40fb677304(%rip), %r8
	movq	$16, 40(%rsp)
	leaq	static_string_acd13d9261b6d2db(%rip), %rcx
	movabsq	$2305843009213693952, %r9
	movq	$29, 16(%rsp)
	movq	$12, 64(%rsp)
	movq	%r8, 32(%rsp)
	leaq	static_string_220f5f6631208dbe(%rip), %r8
	cmovnsq	%rsi, %rax
	movq	%rcx, 8(%rsp)
	movq	%r9, 24(%rsp)
	movq	%r9, 48(%rsp)
	movq	%r8, 56(%rsp)
	movq	%r9, 72(%rsp)
	cmpq	$619, %rax
	jae	.LBB14_1
	shlq	$4, %rax
	leaq	global_constant_0(%rip), %rcx
	movq	(%rax,%rcx), %rsi
	movq	8(%rax,%rcx), %r9
	movq	%rdi, %rax
	shrq	$32, %rax
	movl	%esi, %r8d
	shrq	$32, %rsi
	imulq	%rdi, %r9
	movl	%edi, %edi
	movq	%rsi, %rcx
	imulq	%rax, %rcx
	imulq	%r8, %rax
	imulq	%rdi, %r8
	imulq	%rdi, %rsi
	movl	%r8d, %edi
	shrq	$32, %r8
	addq	%r9, %rcx
	movl	%eax, %r9d
	shrq	$32, %rax
	addq	%r8, %r9
	movl	%esi, %r8d
	addq	%rcx, %rax
	shrq	$32, %rsi
	movb	$64, %cl
	addq	%r9, %r8
	addq	%rax, %rsi
	subb	%dl, %cl
	movq	%r8, %r9
	shrq	$32, %r9
	shlq	$32, %r8
	movzbl	%cl, %eax
	movl	%edx, %ecx
	addq	%r9, %rsi
	orq	%r8, %rdi
	btq	%rax, %rsi
	setb	%al
	shldq	%cl, %rdi, %rsi
	testq	%rsi, %rsi
	sete	%dl
	addq	$2128, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB14_1:
	.cfi_def_cfa_offset 2144
	movabsq	$8232973118699499081, %rax
	movabsq	$8746397786379218537, %rcx
	leaq	8(%rsp), %rdi
	movl	$11, %edx
	movq	%rsi, %rbx
	movq	%rax, 80(%rsp)
	leaq	80(%rsp), %rax
	movq	%rcx, 83(%rsp)
	movq	%rax, %rsi
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movq	%rbx, %rdi
	movq	%rax, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=si64,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	leaq	32(%rsp), %rdi
	movq	%rax, %rsi
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movl	$619, %edi
	movq	%rax, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=uindex,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	leaq	56(%rsp), %rdi
	movq	%rax, %rsi
	callq	"std::collections::string::string::String::write_to[::Writer](::String,$0&),writer.T`2x1=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	movl	$619, %edi
	movq	%rax, %rsi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=uindex,size=1,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferHeap\">>, struct<(pointer<none>, index) memoryOnly>]"@PLT
	leaq	1(%rdx), %rcx
	cmpq	$2049, %rcx
	jl	.LBB14_2
	movl	$1, %edi
	callq	"std::io::io::_printf[::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType](*$1,file:::FileDescriptor),fmt={ #interp.memref<{[(#interp.memory_handle<16, \"HEAP_BUFFER_BYTES exceeded, increase with: `mojo -D HEAP_BUFFER_BYTES=4096`\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 76 },types=[]"@PLT
	ud2
.LBB14_2:
	movb	$0, (%rax,%rdx)
	leaq	static_string_96e550f66d8e6995(%rip), %rcx
	movl	$83, %esi
	movl	$61, %edx
	movl	$65, %r8d
	movq	%rax, %rdi
	callq	"std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)"@PLT
.Lfunc_end14:
	.size	"std::builtin::_format_float::_compute_mul_parity[::DType](::SIMD[$0, ::Int(1)],::Int,::Int),CarrierDType=ui64", .Lfunc_end14-"std::builtin::_format_float::_compute_mul_parity[::DType](::SIMD[$0, ::Int(1)],::Int,::Int),CarrierDType=ui64"
	.cfi_endproc

	.section	.text.unlikely.,"ax",@progbits
	.p2align	4
	.type	"std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)",@function
"std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)":
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$1, %r8d
	movq	%rdi, %rax
	movq	%rcx, %rdi
	movq	%rax, %rcx
	callq	"std::io::io::_printf[::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType](*$1,file:::FileDescriptor),fmt={ #interp.memref<{[(#interp.memory_handle<16, \"At: %s:%llu:%llu: Assert Error: %s\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 35 },types=[[typevalue<#kgen.instref<\"std::memory::unsafe_pointer::UnsafePointer,mut=0,origin._mlir_origin`={  },type=[typevalue<#kgen.instref<\\1B\\22std::builtin::simd::SIMD,dtype=ui8,size=1\\22>>, scalar<ui8>],origin={  },address_space=0\">>, pointer<none>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::memory::unsafe_pointer::UnsafePointer,mut=0,origin._mlir_origin`={  },type=[typevalue<#kgen.instref<\\1B\\22std::builtin::simd::SIMD,dtype=ui8,size=1\\22>>, scalar<ui8>],origin={  },address_space=0\">>, pointer<none>]]"@PLT
	ud2
.Lfunc_end15:
	.size	"std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)", .Lfunc_end15-"std::builtin::debug_assert::_debug_assert_msg[LITImmutOrigin,::Origin[::Bool(False), $0]](::UnsafePointer[::Bool(False), $0, ::SIMD[::DType(uint8), ::Int(1)], $1, ::AddressSpace(::Int(0))],::Int,::SourceLocation)"
	.cfi_endproc

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
.Lfunc_end16:
	.size	"std::io::io::_flush(::FileDescriptor)", .Lfunc_end16-"std::io::io::_flush(::FileDescriptor)"
	.cfi_endproc

	.p2align	4
	.type	"std::io::io::_printf[::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType](*$1,file:::FileDescriptor),fmt={ #interp.memref<{[(#interp.memory_handle<16, \"At: %s:%llu:%llu: Assert Error: %s\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 35 },types=[[typevalue<#kgen.instref<\"std::memory::unsafe_pointer::UnsafePointer,mut=0,origin._mlir_origin`={  },type=[typevalue<#kgen.instref<\\1B\\22std::builtin::simd::SIMD,dtype=ui8,size=1\\22>>, scalar<ui8>],origin={  },address_space=0\">>, pointer<none>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::memory::unsafe_pointer::UnsafePointer,mut=0,origin._mlir_origin`={  },type=[typevalue<#kgen.instref<\\1B\\22std::builtin::simd::SIMD,dtype=ui8,size=1\\22>>, scalar<ui8>],origin={  },address_space=0\">>, pointer<none>]]",@function
"std::io::io::_printf[::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType](*$1,file:::FileDescriptor),fmt={ #interp.memref<{[(#interp.memory_handle<16, \"At: %s:%llu:%llu: Assert Error: %s\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 35 },types=[[typevalue<#kgen.instref<\"std::memory::unsafe_pointer::UnsafePointer,mut=0,origin._mlir_origin`={  },type=[typevalue<#kgen.instref<\\1B\\22std::builtin::simd::SIMD,dtype=ui8,size=1\\22>>, scalar<ui8>],origin={  },address_space=0\">>, pointer<none>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::memory::unsafe_pointer::UnsafePointer,mut=0,origin._mlir_origin`={  },type=[typevalue<#kgen.instref<\\1B\\22std::builtin::simd::SIMD,dtype=ui8,size=1\\22>>, scalar<ui8>],origin={  },address_space=0\">>, pointer<none>]]":
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
	movq	%rdi, %r12
	movl	%r8d, %edi
	movq	%rcx, %rbx
	movq	%rdx, %r14
	movq	%rsi, %r15
	callq	dup@PLT
	leaq	static_string_0d78baac08237ddb(%rip), %rsi
	movl	%eax, %edi
	callq	fdopen@PLT
	leaq	static_string_0dcb71a55f79a509(%rip), %rsi
	movq	%rax, %r13
	movq	%rax, %rdi
	movq	%r12, %rdx
	movq	%r15, %rcx
	movq	%r14, %r8
	movq	%rbx, %r9
	xorl	%eax, %eax
	callq	KGEN_CompilerRT_fprintf@PLT
	movq	%r13, %rdi
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
	jmp	fclose@PLT
.Lfunc_end17:
	.size	"std::io::io::_printf[::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType](*$1,file:::FileDescriptor),fmt={ #interp.memref<{[(#interp.memory_handle<16, \"At: %s:%llu:%llu: Assert Error: %s\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 35 },types=[[typevalue<#kgen.instref<\"std::memory::unsafe_pointer::UnsafePointer,mut=0,origin._mlir_origin`={  },type=[typevalue<#kgen.instref<\\1B\\22std::builtin::simd::SIMD,dtype=ui8,size=1\\22>>, scalar<ui8>],origin={  },address_space=0\">>, pointer<none>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::memory::unsafe_pointer::UnsafePointer,mut=0,origin._mlir_origin`={  },type=[typevalue<#kgen.instref<\\1B\\22std::builtin::simd::SIMD,dtype=ui8,size=1\\22>>, scalar<ui8>],origin={  },address_space=0\">>, pointer<none>]]", .Lfunc_end17-"std::io::io::_printf[::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType](*$1,file:::FileDescriptor),fmt={ #interp.memref<{[(#interp.memory_handle<16, \"At: %s:%llu:%llu: Assert Error: %s\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 35 },types=[[typevalue<#kgen.instref<\"std::memory::unsafe_pointer::UnsafePointer,mut=0,origin._mlir_origin`={  },type=[typevalue<#kgen.instref<\\1B\\22std::builtin::simd::SIMD,dtype=ui8,size=1\\22>>, scalar<ui8>],origin={  },address_space=0\">>, pointer<none>], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::builtin::int::Int\">>, index], [typevalue<#kgen.instref<\"std::memory::unsafe_pointer::UnsafePointer,mut=0,origin._mlir_origin`={  },type=[typevalue<#kgen.instref<\\1B\\22std::builtin::simd::SIMD,dtype=ui8,size=1\\22>>, scalar<ui8>],origin={  },address_space=0\">>, pointer<none>]]"
	.cfi_endproc

	.p2align	4
	.type	"std::io::io::_printf[::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType](*$1,file:::FileDescriptor),fmt={ #interp.memref<{[(#interp.memory_handle<16, \"HEAP_BUFFER_BYTES exceeded, increase with: `mojo -D HEAP_BUFFER_BYTES=4096`\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 76 },types=[]",@function
"std::io::io::_printf[::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType](*$1,file:::FileDescriptor),fmt={ #interp.memref<{[(#interp.memory_handle<16, \"HEAP_BUFFER_BYTES exceeded, increase with: `mojo -D HEAP_BUFFER_BYTES=4096`\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 76 },types=[]":
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	callq	dup@PLT
	leaq	static_string_0d78baac08237ddb(%rip), %rsi
	movl	%eax, %edi
	callq	fdopen@PLT
	leaq	static_string_98e090712d66312f(%rip), %rsi
	movq	%rax, %rbx
	movq	%rax, %rdi
	xorl	%eax, %eax
	callq	KGEN_CompilerRT_fprintf@PLT
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	fclose@PLT
.Lfunc_end18:
	.size	"std::io::io::_printf[::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType](*$1,file:::FileDescriptor),fmt={ #interp.memref<{[(#interp.memory_handle<16, \"HEAP_BUFFER_BYTES exceeded, increase with: `mojo -D HEAP_BUFFER_BYTES=4096`\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 76 },types=[]", .Lfunc_end18-"std::io::io::_printf[::StringSlice[::Bool(False), StaticConstantOrigin, *?],*::AnyType](*$1,file:::FileDescriptor),fmt={ #interp.memref<{[(#interp.memory_handle<16, \"HEAP_BUFFER_BYTES exceeded, increase with: `mojo -D HEAP_BUFFER_BYTES=4096`\\0A\\00\" string>, const_global, [], [])], []}, 0, 0>, 76 },types=[]"
	.cfi_endproc

	.p2align	4
	.type	"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f32,size=16\">>, simd<16, f32>]]",@function
"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f32,size=16\">>, simd<16, f32>]]":
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
	vmovups	%zmm0, 16(%rsp)
	movq	%rcx, %r15
	leaq	8(%rsp), %rcx
	movq	%rsi, %r13
	movl	%r9d, %ebx
	movq	%r8, %r14
	movq	%rdx, %r12
	movq	%rdi, %rsi
	movq	4256(%rsp), %rax
	movq	$0, 4184(%rsp)
	movq	%rcx, 4192(%rsp)
	movq	%rax, 8(%rsp)
	movq	16(%rdi), %rax
	testq	%rax, %rax
	js	.LBB19_1
	movq	8(%rsi), %rdx
	movq	(%rsi), %rsi
	jmp	.LBB19_3
.LBB19_1:
	movl	$1336, %ecx
	bextrq	%rcx, %rax, %rdx
.LBB19_3:
	leaq	88(%rsp), %rbp
	movq	%rbp, %rdi
	vzeroupper
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	%rbp, %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	vmovups	16(%rsp), %zmm0
	movq	%rbp, %rdi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=f32,size=16,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"@PLT
	movq	%rbp, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	vzeroupper
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	4192(%rsp), %rax
	movq	4184(%rsp), %rdx
	movq	%rbp, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	testb	$1, %bl
	je	.LBB19_4
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
.LBB19_4:
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
.Lfunc_end19:
	.size	"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f32,size=16\">>, simd<16, f32>]]", .Lfunc_end19-"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f32,size=16\">>, simd<16, f32>]]"
	.cfi_endproc

	.p2align	4
	.type	"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f32,size=8\">>, simd<8, f32>]]",@function
"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f32,size=8\">>, simd<8, f32>]]":
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
	subq	$4168, %rsp
	.cfi_def_cfa_offset 4224
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	vmovups	%ymm0, 16(%rsp)
	movq	%rcx, %r15
	leaq	8(%rsp), %rcx
	movq	%rsi, %r13
	movl	%r9d, %ebx
	movq	%r8, %r14
	movq	%rdx, %r12
	movq	%rdi, %rsi
	movq	4224(%rsp), %rax
	movq	$0, 4152(%rsp)
	movq	%rcx, 4160(%rsp)
	movq	%rax, 8(%rsp)
	movq	16(%rdi), %rax
	testq	%rax, %rax
	js	.LBB20_1
	movq	8(%rsi), %rdx
	movq	(%rsi), %rsi
	jmp	.LBB20_3
.LBB20_1:
	movl	$1336, %ecx
	bextrq	%rcx, %rax, %rdx
.LBB20_3:
	leaq	56(%rsp), %rbp
	movq	%rbp, %rdi
	vzeroupper
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	%rbp, %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	vmovups	16(%rsp), %ymm0
	movq	%rbp, %rdi
	callq	"std::builtin::simd::SIMD::write_to[::Writer](::SIMD[$0, $1],$2&),dtype=f32,size=8,writer.T`2x=[typevalue<#kgen.instref<\"std::format::_utils::_WriteBufferStack,origin._mlir_origin`={  },origin={  },W=[typevalue<#kgen.instref<\\1B\\22std::io::file_descriptor::FileDescriptor\\22>>, index],stack_buffer_bytes=4096\">>, struct<(struct<(array<4096, scalar<ui8>>) memoryOnly>, index, pointer<index>) memoryOnly>]"@PLT
	movq	%rbp, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	vzeroupper
	callq	"std::format::_utils::_WriteBufferStack::write_string[::Bool,LITOrigin[$4._mlir_value],::Origin[$4, $5]](::_WriteBufferStack[$0, $1, $2, $3]&,::StringSlice[$4, $5, $6]),W=[typevalue<#kgen.instref<\"std::io::file_descriptor::FileDescriptor\">>, index],stack_buffer_bytes=4096,string.mut`2x1=0"@PLT
	movq	4160(%rsp), %rax
	movq	4152(%rsp), %rdx
	movq	%rbp, %rsi
	movq	(%rax), %rdi
	callq	write@PLT
	testb	$1, %bl
	je	.LBB20_4
	movq	8(%rsp), %rdi
	addq	$4168, %rsp
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
.LBB20_4:
	.cfi_def_cfa_offset 4224
	addq	$4168, %rsp
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
.Lfunc_end20:
	.size	"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f32,size=8\">>, simd<8, f32>]]", .Lfunc_end20-"std::io::io::print[*::Writable](*$0,sep:::StringSlice[::Bool(False), StaticConstantOrigin, *?],end:::StringSlice[::Bool(False), StaticConstantOrigin, *?],flush:::Bool,file:::FileDescriptor$),Ts=[[typevalue<#kgen.instref<\"std::collections::string::string::String\">>, struct<(pointer<none>, index, index) memoryOnly>], [typevalue<#kgen.instref<\"std::builtin::simd::SIMD,dtype=f32,size=8\">>, simd<8, f32>]]"
	.cfi_endproc

	.type	static_string_bbe01a6a523daf15,@object
	.section	.rodata,"a",@progbits
	.p2align	4, 0x0
static_string_bbe01a6a523daf15:
	.asciz	"\n"
	.size	static_string_bbe01a6a523daf15, 2

	.type	static_string_a8d4ace0dc8d360e,@object
	.p2align	4, 0x0
static_string_a8d4ace0dc8d360e:
	.asciz	" "
	.size	static_string_a8d4ace0dc8d360e, 2

	.type	static_string_43b6feca8a7883bf,@object
	.p2align	4, 0x0
static_string_43b6feca8a7883bf:
	.asciz	"add8(1..8, 10):"
	.size	static_string_43b6feca8a7883bf, 16

	.type	static_string_2fba8616703f45c4,@object
	.p2align	4, 0x0
static_string_2fba8616703f45c4:
	.asciz	"add16(1..16, 100):"
	.size	static_string_2fba8616703f45c4, 19

	.type	static_string_a61c3395ab9379d9,@object
	.p2align	4, 0x0
static_string_a61c3395ab9379d9:
	.asciz	"Runtime"
	.size	static_string_a61c3395ab9379d9, 8

	.type	static_string_a8e3dd8c929b6eb8,@object
	.p2align	4, 0x0
static_string_a8e3dd8c929b6eb8:
	.asciz	"-"
	.size	static_string_a8e3dd8c929b6eb8, 2

	.type	static_string_978d8d34847e5196,@object
	.p2align	4, 0x0
static_string_978d8d34847e5196:
	.asciz	"0123456789abcdefghijklmnopqrstuvwxyz"
	.size	static_string_978d8d34847e5196, 37

	.type	static_string_e5411518d45eb182,@object
	.p2align	4, 0x0
static_string_e5411518d45eb182:
	.asciz	"nan"
	.size	static_string_e5411518d45eb182, 4

	.type	global_constant,@object
	.p2align	3, 0x0
global_constant:
	.quad	-9093133594791772939
	.quad	-6754730975062328270
	.quad	-3831727700400522433
	.quad	-177973607073265138
	.quad	-7028762532061872567
	.quad	-4174267146649952805
	.quad	-606147914885053102
	.quad	-7296371474444240045
	.quad	-4508778324627912152
	.quad	-1024286887357502286
	.quad	-7557708332239520785
	.quad	-4835449396872013077
	.quad	-1432625727662628442
	.quad	-7812920107430224632
	.quad	-5154464115860392886
	.quad	-1831394126398103204
	.quad	-8062150356639896358
	.quad	-5466001927372482544
	.quad	-2220816390788215276
	.quad	-8305539271883716404
	.quad	-5770238071427257601
	.quad	-2601111570856684097
	.quad	-8543223759426509416
	.quad	-6067343680855748867
	.quad	-2972493582642298179
	.quad	-8775337516792518218
	.quad	-6357485877563259868
	.quad	-3335171328526686932
	.quad	-9002011107970261188
	.quad	-6640827866535438581
	.quad	-3689348814741910323
	.quad	-9223372036854775808
	.quad	-6917529027641081856
	.quad	-4035225266123964416
	.quad	-432345564227567616
	.quad	-7187745005283311616
	.quad	-4372995238176751616
	.quad	-854558029293551616
	.quad	-7451627795949551616
	.quad	-4702848726509551616
	.quad	-1266874889709551616
	.quad	-7709325833709551616
	.quad	-5024971273709551616
	.quad	-1669528073709551616
	.quad	-7960984073709551616
	.quad	-5339544073709551616
	.quad	-2062744073709551616
	.quad	-8206744073709551616
	.quad	-5646744073709551616
	.quad	-2446744073709551616
	.quad	-8446744073709551616
	.quad	-5946744073709551616
	.quad	-2821744073709551616
	.quad	-8681119073709551616
	.quad	-6239712823709551616
	.quad	-3187955011209551616
	.quad	-8910000909647051616
	.quad	-6525815118631426616
	.quad	-3545582879861895366
	.quad	-9133518327554766459
	.quad	-6805211891016070170
	.quad	-3894828845342699809
	.quad	-256850038250986857
	.quad	-7078060301547948642
	.quad	-4235889358507547898
	.quad	-683175679707046969
	.quad	-7344513827457986211
	.quad	-4568956265895094860
	.quad	-1099509313941480671
	.quad	-7604722348854507275
	.quad	-4894216917640746190
	.quad	-1506085128623544834
	.quad	-7858832233030797377
	.quad	-5211854272861108818
	.quad	-1903131822648998118
	.quad	-8106986416796705680
	.quad	-5522047002568494196
	.quad	-2290872734783229841
	.size	global_constant, 624

	.type	static_string_acd13d9261b6d2db,@object
	.p2align	4, 0x0
static_string_acd13d9261b6d2db:
	.asciz	" index out of bounds: index ("
	.size	static_string_acd13d9261b6d2db, 30

	.type	static_string_9e82ac40fb677304,@object
	.p2align	4, 0x0
static_string_9e82ac40fb677304:
	.asciz	") valid range: -"
	.size	static_string_9e82ac40fb677304, 17

	.type	static_string_220f5f6631208dbe,@object
	.p2align	4, 0x0
static_string_220f5f6631208dbe:
	.asciz	" <= index < "
	.size	static_string_220f5f6631208dbe, 13

	.type	static_string_96e550f66d8e6995,@object
	.p2align	4, 0x0
static_string_96e550f66d8e6995:
	.asciz	"oss/modular/mojo/stdlib/std/collections/_index_normalization.mojo"
	.size	static_string_96e550f66d8e6995, 66

	.type	global_constant_0,@object
	.p2align	4, 0x0
global_constant_0:
	.quad	2731688931043774331
	.quad	-38366372719436721
	.quad	8624834609543440813
	.quad	-6941508010590729807
	.quad	-3054014793352862696
	.quad	-4065198994811024355
	.quad	5405853545163697438
	.quad	-469812725086392539
	.quad	5684501474941004851
	.quad	-7211161980820077193
	.quad	2493940825248868160
	.quad	-4402266457597708587
	.quad	7729112049988473104
	.quad	-891147053569747830
	.quad	-9004363024039368022
	.quad	-7474495936122174250
	.quad	2579604275232953684
	.quad	-4731433901725329908
	.quad	3224505344041192105
	.quad	-1302606358729274481
	.quad	8932844867666826922
	.quad	-7731658001846878407
	.quad	-2669001970698630060
	.quad	-5052886483881210105
	.quad	-3336252463373287575
	.quad	-1704422086424124727
	.quad	2526528228819083170
	.quad	-7982792831656159810
	.quad	-6065211750830921845
	.quad	-5366805021142811859
	.quad	1641857348316123501
	.quad	-2096820258001126919
	.quad	-5891368184943504668
	.quad	-8228041688891786181
	.quad	-7364210231179380835
	.quad	-5673366092687344822
	.quad	4629795266307937668
	.quad	-2480021597431793123
	.quad	5199465050656154995
	.quad	-8467542526035952558
	.quad	-2724040723534582064
	.quad	-5972742139117552794
	.quad	-8016736922845615485
	.quad	-2854241655469553088
	.quad	6518754469289960082
	.quad	-8701430062309552536
	.quad	8148443086612450103
	.quad	-6265101559459552766
	.quad	962181821410786820
	.quad	-3219690930897053053
	.quad	-1704479370831952189
	.quad	-8929835859451740015
	.quad	7092772823314835571
	.quad	-6550608805887287114
	.quad	-357406007711231344
	.quad	-3576574988931720989
	.quad	8999993282035256218
	.quad	-9152888395723407474
	.quad	2026619565689294465
	.quad	-6829424476226871438
	.quad	-6690097579743157727
	.quad	-3925094576856201394
	.quad	5472436080603216553
	.quad	-294682202642863838
	.quad	8031958568804398250
	.quad	-7101705404292871755
	.quad	-3795109844276665900
	.quad	-4265445736938701790
	.quad	9091170749936331337
	.quad	-720121152745989333
	.quad	3376138709496513134
	.quad	-7367604748107325189
	.quad	-391512631556746487
	.quad	-4597819916706768583
	.quad	8733981247408842699
	.quad	-1135588877456072824
	.quad	5458738279630526687
	.quad	-7627272076051127371
	.quad	-7011635205744005353
	.quad	-4922404076636521310
	.quad	5070514048102157021
	.quad	-1541319077368263733
	.quad	863228270850154186
	.quad	-7880853450996246689
	.quad	-3532650679864695172
	.quad	-5239380795317920458
	.quad	-9027499368258256869
	.quad	-1937539975720012668
	.quad	-3336344095947716591
	.quad	-8128491512466089774
	.quad	-8782116138362033642
	.quad	-5548928372155224313
	.quad	7469098900757009563
	.quad	-2324474446766642487
	.quad	-2249342214667950879
	.quad	-8370325556870233411
	.quad	6411694268519837209
	.quad	-5851220927660403859
	.quad	-5820440219632367201
	.quad	-2702340141148116920
	.quad	7891439908798240260
	.quad	-8606491615858654931
	.quad	-3970758169284363388
	.quad	-6146428501395930760
	.quad	-351761693178066331
	.quad	-3071349608317525546
	.quad	6697677969404790400
	.quad	-8837122532839535322
	.quad	-851274575098787809
	.quad	-6434717147622031249
	.quad	-1064093218873484761
	.quad	-3431710416100151157
	.quad	8558313775058847833
	.quad	-9062348037703676329
	.quad	6086206200396171887
	.quad	-6716249028702207507
	.quad	-6227300304786948854
	.quad	-3783625267450371480
	.quad	-3172439362556298163
	.quad	-117845565885576446
	.quad	-4288617610811380304
	.quad	-6991182506319567135
	.quad	3862600023340550428
	.quad	-4127292114472071014
	.quad	-4395122007679087773
	.quad	-547429124662700864
	.quad	8782263791269039902
	.quad	-7259672230555269896
	.quad	-7468914334623251739
	.quad	-4462904269766699466
	.quad	4498915137003099038
	.quad	-966944318780986428
	.quad	-6411550076227838909
	.quad	-7521869226879198374
	.quad	5820620459997365076
	.quad	-4790650515171610063
	.quad	-6559282480285457367
	.quad	-1376627125537124675
	.quad	-8711237568605798758
	.quad	-7777920981101784778
	.quad	2946011094524915264
	.quad	-5110715207949843068
	.quad	3682513868156144080
	.quad	-1776707991509915931
	.quad	4607414176811284002
	.quad	-8027971522334779313
	.quad	1147581702586717098
	.quad	-5423278384491086237
	.quad	-3177208890193991531
	.quad	-2167411962186469893
	.quad	7237616480483531101
	.quad	-8272161504007625539
	.quad	-4788037454677749836
	.quad	-5728515861582144020
	.quad	-1373360799919799391
	.quad	-2548958808550292121
	.quad	-858350499949874619
	.quad	-8510628282985014432
	.quad	3538747893490044630
	.quad	-6026599335303880135
	.quad	9035120885289943692
	.quad	-2921563150702462265
	.quad	-5882264492762254952
	.quad	-8743505996830120772
	.quad	-2741144597525430787
	.quad	-6317696477610263061
	.quad	-3426430746906788484
	.quad	-3285434578585440922
	.quad	4776009810824339054
	.quad	-8970925639256982432
	.quad	5970012263530423817
	.quad	-6601971030643840136
	.quad	7462515329413029772
	.quad	-3640777769877412266
	.quad	52386062455755703
	.quad	-9193015133814464522
	.quad	-9157889458785081179
	.quad	-6879582898840692749
	.quad	6999382250228200142
	.quad	-3987792605123478032
	.quad	8749227812785250178
	.quad	-373054737976959636
	.quad	-3755104653863994447
	.quad	-7150688238876681629
	.quad	-4693880817329993059
	.quad	-4326674280168464132
	.quad	-1255665003235103419
	.quad	-796656831783192261
	.quad	8438581409832836171
	.quad	-7415439547505577019
	.quad	-3286831292991118498
	.quad	-4657613415954583370
	.quad	-8720225134666286027
	.quad	-1210330751515841308
	.quad	-3144297699952734815
	.quad	-7673985747338482674
	.quad	-8542058143368306422
	.quad	-4980796165745715438
	.quad	3157485376071780684
	.quad	-1614309188754756393
	.quad	8890957387685944784
	.quad	-7926472270612804602
	.quad	1890324697752655171
	.quad	-5296404319838617848
	.quad	2362905872190818964
	.quad	-2008819381370884406
	.quad	6088502188546649757
	.quad	-8173041140997884610
	.quad	-1612744301171463612
	.quad	-5604615407819967859
	.quad	7207441660390446293
	.quad	-2394083241347571919
	.quad	-2412877989897052923
	.quad	-8413831053483314306
	.quad	-7627783505798704058
	.quad	-5905602798426754978
	.quad	4300328673033783640
	.quad	-2770317479606055818
	.quad	-1923980597781273129
	.quad	-8648977452394866743
	.quad	6818396289628184397
	.quad	-6199535797066195524
	.quad	8522995362035230496
	.quad	-3137733727905356501
	.quad	3021029092058325108
	.quad	-8878612607581929669
	.quad	-835399653354481519
	.quad	-6486579741050024183
	.quad	8179122470161673909
	.quad	-3496538657885142324
	.quad	-4111420493003729615
	.quad	-9102865688819295809
	.quad	-5139275616254662019
	.quad	-6766896092596731857
	.quad	-6424094520318327523
	.quad	-3846934097318526917
	.quad	-8030118150397909404
	.quad	-196981603220770742
	.quad	-7324666853212387329
	.quad	-7040642529654063570
	.quad	4679224488766679550
	.quad	-4189117143640191558
	.quad	-3374341425896426371
	.quad	-624710411122851544
	.quad	-9026492418826348337
	.quad	-7307973034592864071
	.quad	-2059743486678159614
	.quad	-4523280274813692185
	.quad	-2574679358347699518
	.quad	-1042414325089727327
	.quad	3002511419460075706
	.quad	-7569037980822161435
	.quad	8364825292752482536
	.quad	-4849611457600313890
	.quad	1232659579085827362
	.quad	-1450328303573004458
	.quad	-3841273781498745803
	.quad	-7823984217374209643
	.quad	4421779809981343555
	.quad	-5168294253290374149
	.quad	915538744049291539
	.quad	-1848681798185579782
	.quad	5183897733458195116
	.quad	-8072955151507069220
	.quad	6479872166822743895
	.quad	-5479507920956448621
	.quad	3488154190101041965
	.quad	-2237698882768172872
	.quad	2180096368813151228
	.quad	-8316090829371189901
	.quad	-1886565557410948869
	.quad	-5783427518286599473
	.quad	-2358206946763686086
	.quad	-2617598379430861437
	.quad	7749492695127472004
	.quad	-8553528014785370254
	.quad	463493832054564197
	.quad	-6080224000054324913
	.quad	-4032318728359182658
	.quad	-2988593981640518238
	.quad	-4826042214438183113
	.quad	-8785400266166405755
	.quad	3190819268807046917
	.quad	-6370064314280619289
	.quad	-623161932418579258
	.quad	-3350894374423386208
	.quad	-7307005235402693892
	.quad	-9011838011655698236
	.quad	-4522070525825979461
	.quad	-6653111496142234891
	.quad	3570783879572301481
	.quad	-3704703351750405709
	.quad	-148206168962011053
	.quad	-19193171260619233
	.quad	-92628855601256908
	.quad	-6929524759678968877
	.quad	-115786069501571135
	.quad	-4050219931171323192
	.quad	4466953431550423985
	.quad	-451088895536766085
	.quad	486002885505321039
	.quad	-7199459587351560659
	.quad	5219189625309039203
	.quad	-4387638465762062920
	.quad	6523987031636299003
	.quad	-872862063775190746
	.quad	-534194123654701027
	.quad	-7463067817500576073
	.quad	-667742654568376284
	.quad	-4717148753448332187
	.quad	8388693718644305453
	.quad	-1284749923383027329
	.quad	-6286281471915778851
	.quad	-7720497729755473937
	.quad	-7857851839894723564
	.quad	-5038936143766954517
	.quad	8624429273841147160
	.quad	-1686984161281305242
	.quad	778582277723329071
	.quad	-7971894128441897632
	.quad	973227847154161339
	.quad	-5353181642124984136
	.quad	1216534808942701674
	.quad	-2079791034228842266
	.quad	-3851351762838199358
	.quad	-8217398424034108273
	.quad	-4814189703547749197
	.quad	-5660062011615247437
	.quad	-6017737129434686497
	.quad	-2463391496091671392
	.quad	7768129340171790700
	.quad	-8457148712698376476
	.quad	-8736582398494813241
	.quad	-5959749872445582691
	.quad	-1697355961263740744
	.quad	-2838001322129590460
	.quad	1244995533423855987
	.quad	-8691279853972075893
	.quad	-3055441601647567920
	.quad	-6252413799037706963
	.quad	5404070034795315908
	.quad	-3203831230369745799
	.quad	-3539985255894009413
	.quad	-8919923546622172981
	.quad	-4424981569867511767
	.quad	-6538218414850328322
	.quad	8303831092947774003
	.quad	-3561087000135522498
	.quad	578208414664970848
	.quad	-9143208402725783417
	.quad	-3888925500096174344
	.quad	-6817324484979841368
	.quad	-249470856692830026
	.quad	-3909969587797413806
	.quad	-4923524589293425437
	.quad	-275775966319379353
	.quad	-3077202868308390898
	.quad	-7089889006590693952
	.quad	765182433041899282
	.quad	-4250675239810979535
	.quad	5568164059729762006
	.quad	-701658031336336515
	.quad	5785945546544795206
	.quad	-7356065297226292178
	.quad	-1990940103673781801
	.quad	-4583395603105477319
	.quad	6734696907262548557
	.quad	-1117558485454458744
	.quad	4209185567039092848
	.quad	-7616003081050118571
	.quad	-8573576096483297652
	.quad	-4908317832885260310
	.quad	3118087934678041647
	.quad	-1523711272679187483
	.quad	4254647968387469982
	.quad	-7869848573065574033
	.quad	706623942056949573
	.quad	-5225624697904579637
	.quad	-3728406090856200938
	.quad	-1920344853953336643
	.quad	-6941939825212513490
	.quad	-8117744561361917258
	.quad	5157633273766521850
	.quad	-5535494683275008668
	.quad	6447041592208152312
	.quad	-2307682335666372931
	.quad	6335244004343789147
	.quad	-8359830487432564938
	.quad	-1304317031425039374
	.quad	-5838102090863318269
	.quad	-1630396289281299218
	.quad	-2685941595151759932
	.quad	1286845328412881941
	.quad	-8596242524610931813
	.quad	-3003129357911285478
	.quad	-6133617137336276863
	.quad	5469460339465668960
	.quad	-3055335403242958174
	.quad	8030098730593431004
	.quad	-8827113654667930715
	.quad	-3797434642040374957
	.quad	-6422206049907525490
	.quad	9088264752731695016
	.quad	-3416071543957018958
	.quad	-8154892584824854327
	.quad	-9052573742614218705
	.quad	8253128342678483707
	.quad	-6704031159840385477
	.quad	5704724409920716730
	.quad	-3768352931373093942
	.quad	-2092466524453879895
	.quad	-98755145788979524
	.quad	998051431430019018
	.quad	-6979250993759194058
	.quad	-7975807747567252036
	.quad	-4112377723771604669
	.quad	8476984389250486571
	.quad	-528786136287117932
	.quad	-3925256793573221701
	.quad	-7248020362820530564
	.quad	-294884973539139223
	.quad	-4448339435098275301
	.quad	-368606216923924028
	.quad	-948738275445456222
	.quad	-2536221894791146469
	.quad	-7510490449794491995
	.quad	6053094668365842721
	.quad	-4776427043815727089
	.quad	2954682317029915497
	.quad	-1358847786342270957
	.quad	-459166561069996766
	.quad	-7766808894105001205
	.quad	-573958201337495958
	.quad	-5096825099203863602
	.quad	-5329133770099257851
	.quad	-1759345355577441598
	.quad	-5636551615525730109
	.quad	-8017119874876982855
	.quad	2177682517447613172
	.quad	-5409713825168840664
	.quad	2722103146809516465
	.quad	-2150456263033662926
	.quad	6313000485183335695
	.quad	-8261564192037121185
	.quad	3279564588051781714
	.quad	-5715269221619013577
	.quad	-512230283362660762
	.quad	-2532400508596379068
	.quad	1985699082112030976
	.quad	-8500279345513818773
	.quad	-2129562165787349184
	.quad	-6013663163464885563
	.quad	6561419329620589328
	.quad	-2905392935903719049
	.quad	-7428327965055601430
	.quad	-8733399612580906262
	.quad	4549648098962661925
	.quad	-6305063497298744923
	.quad	-8147997931578836306
	.quad	-3269643353196043250
	.quad	1825030320404309165
	.quad	-8961056123388608887
	.quad	6892973918932774360
	.quad	-6589634135808373205
	.quad	4004531380238580046
	.quad	-3625356651333078602
	.quad	-2108853905778275375
	.quad	-9183376934724255983
	.quad	6587304654631931589
	.quad	-6867535149977932074
	.quad	-989241218564861322
	.quad	-3972732919045027189
	.quad	-1236551523206076653
	.quad	-354230130378896082
	.quad	6144684325637283948
	.quad	-7138922859127891907
	.quad	-6154202648235558777
	.quad	-4311967555482476980
	.quad	-3081067291867060567
	.quad	-778273425925708321
	.quad	-1925667057416912854
	.quad	-7403949918844649557
	.quad	-2407083821771141068
	.quad	-4643251380128424042
	.quad	-7620540795641314239
	.quad	-1192378206733142148
	.quad	-2456994988062127447
	.quad	-7662765406849295699
	.quad	6152128301777116499
	.quad	-4966770740134231719
	.quad	-6144897678060768089
	.quad	-1596777406740401745
	.quad	-3840561048787980055
	.quad	-7915514906853832947
	.quad	4422670725869800739
	.quad	-5282707615139903279
	.quad	-8306719647944912789
	.quad	-1991698500497491195
	.quad	8643358275316593219
	.quad	-8162340590452013853
	.quad	6192511825718353620
	.quad	-5591239719637629412
	.quad	7740639782147942025
	.quad	-2377363631119648861
	.quad	2532056854628769814
	.quad	-8403381297090862394
	.quad	-6058300968568813541
	.quad	-5892540602936190089
	.quad	-7572876210711016926
	.quad	-2753989735242849707
	.quad	9102010423587778133
	.quad	-8638772612167862923
	.quad	-2457545025797441046
	.quad	-6186779746782440750
	.quad	-7683617300674189211
	.quad	-3121788665050663033
	.quad	-4802260812921368257
	.quad	-8868646943297746252
	.quad	-1391139997724322417
	.quad	-6474122660694794911
	.quad	7484447039699372787
	.quad	-3480967307441105734
	.quad	-9157278655470055720
	.quad	-9093133594791772940
	.quad	-6834912300910181746
	.quad	-6754730975062328271
	.quad	679731660717048625
	.quad	-3831727700400522434
	.quad	-8373707460958465027
	.quad	-177973607073265139
	.quad	8601490892183123070
	.quad	-7028762532061872568
	.quad	-7694880458480647778
	.quad	-4174267146649952806
	.quad	4216457482181353989
	.quad	-606147914885053103
	.quad	-4282243101277735613
	.quad	-7296371474444240046
	.quad	8482254178684994196
	.quad	-4508778324627912153
	.quad	5991131704928854841
	.quad	-1024286887357502287
	.quad	-3173071712060547580
	.quad	-7557708332239520786
	.quad	-8578025658503072379
	.quad	-4835449396872013078
	.quad	3112525982153323238
	.quad	-1432625727662628443
	.quad	4251171748059520976
	.quad	-7812920107430224633
	.quad	702278666647013315
	.quad	-5154464115860392887
	.quad	5489534351736154548
	.quad	-1831394126398103205
	.quad	1125115960621402641
	.quad	-8062150356639896359
	.quad	6018080969204141205
	.quad	-5466001927372482545
	.quad	2910915193077788602
	.quad	-2220816390788215277
	.quad	-486521013540076076
	.quad	-8305539271883716405
	.quad	-608151266925095095
	.quad	-5770238071427257602
	.quad	-5371875102083756772
	.quad	-2601111570856684098
	.quad	3560107088838733873
	.quad	-8543223759426509417
	.quad	-161552157378970562
	.quad	-6067343680855748868
	.quad	4409745821703674701
	.quad	-2972493582642298180
	.quad	-6467280898289979120
	.quad	-8775337516792518219
	.quad	1139270913992301908
	.quad	-6357485877563259869
	.quad	-3187597375937010519
	.quad	-3335171328526686933
	.quad	7231123676894144234
	.quad	-9002011107970261189
	.quad	4427218577690292388
	.quad	-6640827866535438582
	.quad	-3689348814741910323
	.quad	-3689348814741910324
	.quad	0
	.quad	-9223372036854775808
	.quad	0
	.quad	-6917529027641081856
	.quad	0
	.quad	-4035225266123964416
	.quad	0
	.quad	-432345564227567616
	.quad	0
	.quad	-7187745005283311616
	.quad	0
	.quad	-4372995238176751616
	.quad	0
	.quad	-854558029293551616
	.quad	0
	.quad	-7451627795949551616
	.quad	0
	.quad	-4702848726509551616
	.quad	0
	.quad	-1266874889709551616
	.quad	0
	.quad	-7709325833709551616
	.quad	0
	.quad	-5024971273709551616
	.quad	0
	.quad	-1669528073709551616
	.quad	0
	.quad	-7960984073709551616
	.quad	0
	.quad	-5339544073709551616
	.quad	0
	.quad	-2062744073709551616
	.quad	0
	.quad	-8206744073709551616
	.quad	0
	.quad	-5646744073709551616
	.quad	0
	.quad	-2446744073709551616
	.quad	0
	.quad	-8446744073709551616
	.quad	0
	.quad	-5946744073709551616
	.quad	0
	.quad	-2821744073709551616
	.quad	0
	.quad	-8681119073709551616
	.quad	0
	.quad	-6239712823709551616
	.quad	0
	.quad	-3187955011209551616
	.quad	0
	.quad	-8910000909647051616
	.quad	0
	.quad	-6525815118631426616
	.quad	0
	.quad	-3545582879861895366
	.quad	4611686018427387904
	.quad	-9133518327554766460
	.quad	5764607523034234880
	.quad	-6805211891016070171
	.quad	-6629298651489370112
	.quad	-3894828845342699810
	.quad	5548434740920451072
	.quad	-256850038250986858
	.quad	-1143914305352105984
	.quad	-7078060301547948643
	.quad	7793479155164643328
	.quad	-4235889358507547899
	.quad	-4093209111326359552
	.quad	-683175679707046970
	.quad	4359273333062107136
	.quad	-7344513827457986212
	.quad	5449091666327633920
	.quad	-4568956265895094861
	.quad	2199678564482154496
	.quad	-1099509313941480672
	.quad	1374799102801346560
	.quad	-7604722348854507276
	.quad	1718498878501683200
	.quad	-4894216917640746191
	.quad	6759809616554491904
	.quad	-1506085128623544835
	.quad	6530724019560251392
	.quad	-7858832233030797378
	.quad	-1059967012404461568
	.quad	-5211854272861108819
	.quad	7898413271349198848
	.quad	-1903131822648998119
	.quad	-1981020733047832576
	.quad	-8106986416796705681
	.quad	-2476275916309790720
	.quad	-5522047002568494197
	.quad	-3095344895387238400
	.quad	-2290872734783229842
	.quad	4982938468024057856
	.quad	-8349324486880600507
	.quad	-7606384970252091392
	.quad	-5824969590173362730
	.quad	4327076842467049472
	.quad	-2669525969289315508
	.quad	-6518949010312869888
	.quad	-8585982758446904049
	.quad	-8148686262891087360
	.quad	-6120792429631242157
	.quad	8260886245095692416
	.quad	-3039304518611664792
	.quad	5163053903184807760
	.quad	-8817094351773372351
	.quad	-7381240676301154012
	.quad	-6409681921289327535
	.quad	-3178808521666707
	.quad	-3400416383184271515
	.quad	-4613672773753429595
	.quad	-9042789267131251553
	.quad	-5767090967191786994
	.quad	-6691800565486676537
	.quad	-7208863708989733743
	.quad	-3753064688430957767
	.quad	212292400617608629
	.quad	-79644842111309304
	.quad	132682750386005393
	.quad	-6967307053960650171
	.quad	4777539456409894646
	.quad	-4097447799023424810
	.quad	-3251447716342407501
	.quad	-510123730351893109
	.quad	7191217214140771120
	.quad	-7236356359111015049
	.quad	4377335499248575996
	.quad	-4433759430461380907
	.quad	-8363388681221443717
	.quad	-930513269649338230
	.quad	-7532960934977096275
	.quad	-7499099821171918250
	.quad	4418856886560793368
	.quad	-4762188758037509908
	.quad	5523571108200991710
	.quad	-1341049929119499481
	.quad	-8076983103442849941
	.quad	-7755685233340769032
	.quad	-5484542860876174523
	.quad	-5082920523248573386
	.quad	6979379479186945559
	.quad	-1741964635633328828
	.quad	-4861259862362934834
	.quad	-8006256924911912374
	.quad	7758483227328495170
	.quad	-5396135137712502563
	.quad	-4136954021121544750
	.quad	-2133482903713240300
	.quad	-279753253987271517
	.quad	-8250955842461857044
	.quad	4261994450943298508
	.quad	-5702008784649933400
	.quad	5327493063679123135
	.quad	-2515824962385028846
	.quad	7941369183226839864
	.quad	-8489919629131724885
	.quad	5315025460606161925
	.quad	-6000713517987268202
	.quad	-2579590211097073401
	.quad	-2889205879056697349
	.quad	7611128154919104932
	.quad	-8723282702051517699
	.quad	-4321147861633282547
	.quad	-6292417359137009220
	.quad	-789748808614215279
	.quad	-3253835680493873621
	.quad	8729779031470891259
	.quad	-8951176327949752869
	.quad	6300537770911226169
	.quad	-6577284391509803182
	.quad	-1347699823215743097
	.quad	-3609919470959866074
	.quad	6075216638131242421
	.quad	-9173728696990998152
	.quad	7594020797664053026
	.quad	-6855474852811359786
	.quad	269153960225290474
	.quad	-3957657547586811828
	.quad	336442450281613092
	.quad	-335385916056126881
	.quad	7127805559067090039
	.quad	-7127145225176161157
	.quad	4298070930406474645
	.quad	-4297245513042813542
	.quad	-3850783373846682502
	.quad	-759870872876129024
	.quad	9122475437414293196
	.quad	-7392448323188662496
	.quad	-7043649776941685121
	.quad	-4628874385558440216
	.quad	-4192876202749718497
	.quad	-1174406963520662366
	.quad	-4926390635932268013
	.quad	-7651533379841495835
	.quad	3065383741939440792
	.quad	-4952730706374481889
	.quad	-779956341003086914
	.quad	-1579227364540714458
	.quad	6430056314514152535
	.quad	-7904546130479028392
	.quad	8037570393142690669
	.quad	-5268996644671397586
	.quad	823590954573587528
	.quad	-1974559787411859078
	.quad	5126430365035880109
	.quad	-8151628894773493780
	.quad	6408037956294850136
	.quad	-5577850100039479321
	.quad	3398361426941174766
	.quad	-2360626606621961247
	.quad	-4793553135802847627
	.quad	-8392920656779807636
	.quad	-1380255401326171630
	.quad	-5879464802547371641
	.quad	-1725319251657714538
	.quad	-2737644984756826647
	.quad	3533361486141316318
	.quad	-8628557143114098510
	.quad	-4806670179178130410
	.quad	-6174010410465235234
	.quad	7826720331309500699
	.quad	-3105826994654156138
	.quad	280014188641050033
	.quad	-8858670899299929442
	.quad	-8873354301053463267
	.quad	-6461652605697523899
	.quad	-1868320839462053276
	.quad	-3465379738694516970
	.quad	5749828502977298559
	.quad	-9083391364325154962
	.quad	-2036086408133152610
	.quad	-6742553186979055799
	.quad	6678264026688335046
	.quad	-3816505465296431844
	.quad	8347830033360418807
	.quad	-158945813193151901
	.quad	2911550761636567803
	.quad	-7016870160886801794
	.quad	-5583933584809066055
	.quad	-4159401682681114339
	.quad	2243455055843443239
	.quad	-587566084924005019
	.quad	3708002419115845977
	.quad	-7284757830718584993
	.quad	23317005467419567
	.quad	-4494261269970843337
	.quad	-4582539761593113445
	.quad	-1006140569036166268
	.quad	-558244341782001951
	.quad	-7546366883288685774
	.quad	-5309491445654890343
	.quad	-4821272585683469313
	.quad	-6636864307068612929
	.quad	-1414904713676948737
	.quad	-4148040191917883080
	.quad	-7801844473689174817
	.quad	-5185050239897353851
	.quad	-5140619573684080617
	.quad	-6481312799871692314
	.quad	-1814088448677712867
	.quad	-8662506518347195600
	.quad	-8051334308064652398
	.quad	3006924907348169212
	.quad	-5452481866653427593
	.quad	-853029884242176389
	.quad	-2203916314889396588
	.quad	1772699331562333709
	.quad	-8294976724446954723
	.quad	6827560182880305040
	.quad	-5757034887131305500
	.quad	8534450228600381300
	.quad	-2584607590486743971
	.quad	7639874402088932265
	.quad	-8532908771695296838
	.quad	326470965756389523
	.quad	-6054449946191733143
	.quad	5019774725622874807
	.quad	-2956376414312278525
	.quad	831516194300602803
	.quad	-8765264286586255934
	.quad	-8183976793979022305
	.quad	-6344894339805432014
	.quad	3605087062808385831
	.quad	-3319431906329402113
	.quad	9170708441896323001
	.quad	-8992173969096958177
	.quad	6851699533943015847
	.quad	-6628531442943809817
	.quad	3952938399001381904
	.quad	-3673978285252374367
	.quad	-4446942528265218166
	.quad	-9213765455923815836
	.quad	-946992141904134803
	.quad	-6905520801477381891
	.quad	8039631859474607304
	.quad	-4020214983419339459
	.quad	-3785518230938904582
	.quad	-413582710846786420
	.quad	-60105885123121412
	.quad	-7176018221920323369
	.quad	-75132356403901765
	.quad	-4358336758973016307
	.quad	9129456591349898602
	.quad	-836234930288882479
	.quad	-1211618658047395230
	.quad	-7440175859071633406
	.quad	-6126209340986631941
	.quad	-4688533805412153853
	.quad	-7657761676233289927
	.quad	-1248981238337804412
	.quad	-2480258038432112252
	.quad	-7698142301602209614
	.quad	-7712008566467528219
	.quad	-5010991858575374113
	.quad	8806733365625141342
	.quad	-1652053804791829737
	.quad	-6025006692552756421
	.quad	-7950062655635975442
	.quad	6303799689591218186
	.quad	-5325892301117581398
	.quad	-1343622424865753076
	.quad	-2045679357969588844
	.quad	1466078993672598280
	.quad	-8196078626372074883
	.quad	6444284760518135753
	.quad	-5633412264537705700
	.quad	8055355950647669692
	.quad	-2430079312244744221
	.quad	2728754459941099605
	.quad	-8436328597794046994
	.quad	-5812428961928401301
	.quad	-5933724728815170839
	.quad	1957835834444274181
	.quad	-2805469892591575644
	.quad	-7999724640327104445
	.quad	-8670947710510816634
	.quad	3835402254873283156
	.quad	-6226998619711132888
	.quad	4794252818591603945
	.quad	-3172062256211528206
	.quad	7608094030047140370
	.quad	-8900067937773286985
	.quad	4898431519131537558
	.quad	-6513398903789220827
	.quad	-7712018656367741764
	.quad	-3530062611309138130
	.quad	2097517367411243254
	.quad	-9123818159709293187
	.quad	7233582727691441971
	.quad	-6793086681209228580
	.quad	9041978409614302463
	.quad	-3879672333084147821
	.quad	6690786993590490175
	.quad	-237904397927796872
	.quad	4181741870994056360
	.quad	-7066219276345954901
	.quad	615491320315182545
	.quad	-4221088077005055722
	.quad	-8454007886460797626
	.quad	-664674077828931749
	.quad	3939617107816777292
	.quad	-7332950326284164199
	.quad	-8910536670511192098
	.quad	-4554501889427817345
	.quad	7308573235570561494
	.quad	-1081441343357383777
	.quad	-6961356773836868826
	.quad	-7593429867239446717
	.quad	-8701695967296086033
	.quad	-4880101315621920492
	.quad	-6265433940692719637
	.quad	-1488440626100012711
	.quad	695789805494438131
	.quad	-7847804418953589800
	.quad	869737256868047664
	.quad	-5198069505264599346
	.quad	-8136200465769716229
	.quad	-1885900863153361279
	.quad	-473439272678684739
	.quad	-8096217067111932656
	.quad	4019886927579031981
	.quad	-5508585315462527915
	.quad	-8810199395808373736
	.quad	-2274045625900771990
	.quad	-7812217631593927537
	.quad	-8338807543829064350
	.quad	4069786015789754291
	.quad	-5811823411358942533
	.quad	475546501309804959
	.quad	-2653093245771290262
	.quad	4908902581746016004
	.quad	-8575712306248138270
	.quad	-3087243809672255804
	.quad	-6107954364382784934
	.quad	-8470740780517707659
	.quad	-3023256937051093263
	.quad	-682526969396179382
	.quad	-8807064613298015146
	.quad	-5464844730172612132
	.quad	-6397144748195131028
	.quad	-2219369894288377261
	.quad	-3384744916816525881
	.quad	-1387106183930235788
	.quad	-9032994600651410532
	.quad	2877803288514593169
	.quad	-6679557232386875260
	.quad	3597254110643241461
	.quad	-3737760522056206171
	.quad	9108253656731439730
	.quad	-60514634142869810
	.quad	1080972517029761927
	.quad	-6955350673980375487
	.quad	5962901664714590313
	.quad	-4082502324048081455
	.quad	-6381430974388925821
	.quad	-491441886632713915
	.quad	-8600080377420466542
	.quad	-7224680206786528053
	.quad	7696643601933968438
	.quad	-4419164240055772162
	.quad	397432465562684740
	.quad	-912269281642327298
	.quad	-4363290727450709941
	.quad	-7487697328667536418
	.quad	8380944645968776285
	.quad	-4747935642407032618
	.quad	1252808770606194548
	.quad	-1323233534581402868
	.quad	-8440366555225904215
	.quad	-7744549986754458649
	.quad	7896285879677171347
	.quad	-5069001465015685407
	.quad	-3964700705685699528
	.quad	-1724565812842218855
	.quad	2133748077373825699
	.quad	-7995382660667468640
	.quad	2667185096717282124
	.quad	-5382542307406947896
	.quad	3333981370896602654
	.quad	-2116491865831296966
	.quad	6695424375237764563
	.quad	-8240336443785642460
	.quad	8369280469047205704
	.quad	-5688734536304665171
	.quad	-3373457468973156582
	.quad	-2499232151953443560
	.quad	-9025939945749304720
	.quad	-8479549122611984081
	.quad	7164319141522920716
	.quad	-5987750384837592197
	.quad	4343712908476262991
	.quad	-2873001962619602342
	.quad	7326506586225052274
	.quad	-8713155254278333320
	.quad	9158133232781315342
	.quad	-6279758049420528746
	.quad	2224294504121868369
	.quad	-3238011543348273028
	.quad	-7833187971778608077
	.quad	-8941286242233752499
	.quad	-568112927868484288
	.quad	-6564921784364802720
	.quad	3901544858591782543
	.quad	-3594466212028615495
	.quad	-4479063491021217766
	.quad	-9164070410158966541
	.quad	-5598829363776522208
	.quad	-6843401994271320272
	.quad	-2386850686293264856
	.quad	-3942566474411762436
	.quad	1628122660560806834
	.quad	-316522074587315140
	.quad	-8205795374004271537
	.quad	-7115355324258153819
	.quad	-1033872180650563613
	.quad	-4282508136895304370
	.quad	-5904026244240592420
	.quad	-741449152691742558
	.quad	-5995859411864064214
	.quad	-7380934748073420955
	.quad	1728547772024695540
	.quad	-4614482416664388289
	.quad	-2451001303396518479
	.quad	-1156417002403097458
	.quad	5385653213018257807
	.quad	-7640289654143017767
	.quad	-7102991539009341454
	.quad	-4938676049251384305
	.quad	-8878739423761676818
	.quad	-1561659043136842477
	.quad	3674159897003727797
	.quad	-7893565929601608404
	.quad	4592699871254659746
	.quad	-5255271393574622601
	.quad	1129188820640936779
	.quad	-1957403223540890347
	.quad	3011586022114279439
	.quad	-8140906042354138323
	.quad	8376168546070237203
	.quad	-5564446534515285000
	.quad	-7976533391121755113
	.quad	-2343872149716718346
	.quad	1932195658189984911
	.quad	-8382449121214030822
	.quad	-6808127464117294670
	.quad	-5866375383090150624
	.quad	-3898473311719230433
	.quad	-2721283210435300376
	.quad	9092669226243950739
	.quad	-8618331034163144591
	.quad	-2469221522477225288
	.quad	-6161227774276542835
	.quad	6136845133758244198
	.quad	-3089848699418290639
	.quad	-3082000819042179232
	.quad	-8848684464777513506
	.quad	-8464187042230111944
	.quad	-6449169562544503978
	.quad	3254824252494523782
	.quad	-3449775934753242068
	.quad	-7189106879045698444
	.quad	-9073638986861858149
	.quad	-8986383598807123056
	.quad	-6730362715149934782
	.quad	2602078556773259892
	.quad	-3801267375510030573
	.quad	-1359087822460813039
	.quad	-139898200960150313
	.quad	-849429889038008149
	.quad	-7004965403241175802
	.quad	-5673473379724898090
	.quad	-4144520735624081848
	.quad	-2480155706228734709
	.quad	-568964901102714406
	.quad	-3855940325606653145
	.quad	-7273132090830278360
	.quad	-208239388580928527
	.quad	-4479729095110460046
	.quad	-4871985254153548563
	.quad	-987975350460687153
	.quad	-3044990783845967852
	.quad	-7535013621679011327
	.quad	5417133557047315993
	.quad	-4807081008671376254
	.quad	-2451955090545630817
	.quad	-1397165242411832414
	.quad	-3838314940804713212
	.quad	-7790757304148477115
	.quad	4425478360848884292
	.quad	-5126760611758208489
	.quad	920161932633717461
	.quad	-1796764746270372707
	.quad	2880944217109767366
	.quad	-8040506994060064798
	.quad	-5622191765467566601
	.quad	-5438947724147693094
	.quad	6807318348447705460
	.quad	-2186998636757228463
	.quad	-2662955059861265943
	.quad	-8284403175614349646
	.quad	-7940379843253970333
	.quad	-5743817951090549153
	.quad	8521269269642088700
	.quad	-2568086420435798537
	.quad	-6203421752542164322
	.quad	-8522583040413455942
	.quad	6080780864604458309
	.quad	-6041542782089432023
	.quad	-6234081974526590826
	.quad	-2940242459184402125
	.quad	5327070802775656542
	.quad	-8755180564631333184
	.quad	6658838503469570677
	.quad	-6332289687361778576
	.quad	8323548129336963346
	.quad	-3303676090774835316
	.quad	-4021154456019173716
	.quad	-8982326584375353929
	.quad	-5026443070023967146
	.quad	-6616222212041804507
	.quad	2940318199324816876
	.quad	-3658591746624867729
	.quad	8755227902219092404
	.quad	-9204148869281624187
	.quad	-2891023177508298208
	.quad	-6893500068174642330
	.quad	-8225464990312760664
	.quad	-4005189066790915008
	.quad	-5670145219463562926
	.quad	-394800315061255856
	.quad	7985374283903742932
	.quad	-7164279224554366766
	.quad	758345818024902857
	.quad	-4343663012265570553
	.quad	-3663753745896259333
	.quad	-817892746904575288
	.quad	-9207375118826243939
	.quad	-7428711994456441411
	.quad	-2285846861678029116
	.quad	-4674203974643163860
	.quad	1754377441329851509
	.quad	-1231068949876566920
	.quad	1096485900831157193
	.quad	-7686947121313936181
	.quad	-3241078642388441413
	.quad	-4996997883215032323
	.quad	5172023733869224042
	.quad	-1634561335591402499
	.quad	5538357842881958978
	.quad	-7939129862385708418
	.quad	-2300424733252327085
	.quad	-5312226309554747619
	.quad	6347841120289366951
	.quad	-2028596868516046619
	.quad	6273243709394548297
	.quad	-8185402070463610993
	.quad	3229868618315797467
	.quad	-5620066569652125837
	.quad	-574350245532641070
	.quad	-2413397193637769393
	.quad	-358968903457900669
	.quad	-8425902273664687727
	.quad	8774660907532399972
	.quad	-5920691823653471754
	.quad	1744954097560724157
	.quad	-2789178761139451788
	.quad	-8132775725879323210
	.quad	-8660765753353239224
	.quad	-5554283638921766109
	.quad	-6214271173264161126
	.quad	6892203506629956076
	.quad	-3156152948152813503
	.quad	-2609901835997359308
	.quad	-8890124620236590296
	.quad	1349308723430688769
	.quad	-6500969756868349965
	.quad	-2925050114139026943
	.quad	-3514526177658049553
	.quad	-1828156321336891839
	.quad	-9114107888677362827
	.quad	6938176635183661009
	.quad	-6780948842419315629
	.quad	4061034775552188357
	.quad	-3864500034596756632
	.quad	5076293469440235446
	.quad	-218939024818557886
	.quad	7784369436827535058
	.quad	-7054365918152680535
	.quad	-4104596259247744890
	.quad	-4206271379263462765
	.quad	-5130745324059681112
	.quad	-646153205651940552
	.size	global_constant_0, 9904

	.type	static_string_0dcb71a55f79a509,@object
	.p2align	4, 0x0
static_string_0dcb71a55f79a509:
	.asciz	"At: %s:%llu:%llu: Assert Error: %s\n"
	.size	static_string_0dcb71a55f79a509, 36

	.type	static_string_0d78baac08237ddb,@object
	.p2align	4, 0x0
static_string_0d78baac08237ddb:
	.asciz	"a"
	.size	static_string_0d78baac08237ddb, 2

	.type	static_string_98e090712d66312f,@object
	.p2align	4, 0x0
static_string_98e090712d66312f:
	.asciz	"HEAP_BUFFER_BYTES exceeded, increase with: `mojo -D HEAP_BUFFER_BYTES=4096`\n"
	.size	static_string_98e090712d66312f, 77

	.section	".note.GNU-stack","",@progbits
