	.arch armv6
	.eabi_attribute 27, 3
	.eabi_attribute 28, 1
	.fpu neon
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"neon_search.cpp"
	.text
	.align	2
	.global	_Z10memchrNEONPKvij
	.type	_Z10memchrNEONPKvij, %function
_Z10memchrNEONPKvij:
	.fnstart
.LFB2421:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r2, #15
	stmfd	sp!, {r4, r5}
	bhi	.L2
.L11:
	cmp	r2, #0
	beq	.L15
.L14:
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, r1
	addne	r2, r0, r2
	addne	r3, r0, #1
	bne	.L12
	b	.L3
.L13:
	ldrb	ip, [r0]	@ zero_extendqisi2
	add	r3, r3, #1
	cmp	ip, r1
	beq	.L3
.L12:
	cmp	r3, r2
	mov	r0, r3
	bne	.L13
	mov	r0, #0
.L3:
	ldmfd	sp!, {r4, r5}
	bx	lr
.L2:
	ands	ip, r0, #15
	vdup.8	q11, r1
	bne	.L24
.L6:
	cmp	r2, #31
	bls	.L14
	add	r3, r0, #32
	b	.L10
.L9:
	cmp	r2, #31
	add	r3, r3, #32
	bls	.L11
.L10:
	vldr	d20, [r3, #-16]
	vldr	d21, [r3, #-8]
	vldr	d18, [r3, #-32]
	vldr	d19, [r3, #-24]
	vceq.i8	q10, q10, q11
	vceq.i8	q9, q9, q11
	vorr	q8, q9, q10
	vorr	d16, d17, d16
	fmrrd	r4, r5, d16	@ int
	sub	r2, r2, #32
	sub	ip, r3, #32
	orrs	r0, r4, r5
	mov	r0, r3
	beq	.L9
	vldr	d16, .L26
	vldr	d17, .L26+8
	vand	q9, q9, q8
	vand	q10, q10, q8
	vpadd.i8	d18, d18, d19
	vpadd.i8	d20, d20, d21
	vpadd.i8	d16, d18, d20
	vpadd.i8	d16, d16, d16
	vmov.32	r2, d16[0]
	rsb	r3, r2, #0
	and	r3, r3, r2
	clz	r3, r3
	rsb	r3, r3, #31
	add	r0, ip, r3
	ldmfd	sp!, {r4, r5}
	bx	lr
.L24:
	bic	r3, r0, #15
	vldr	d18, .L26
	vldr	d19, .L26+8
	vld1.64	{d16-d17}, [r3:128]
	vceq.i8	q8, q8, q11
	vand	q8, q8, q9
	vpadd.i8	d16, d16, d17
	vpadd.i8	d16, d16, d16
	vpadd.i8	d16, d16, d16
	vmov.u16	r3, d16[0]
	movs	r3, r3, lsr ip
	bne	.L25
	rsb	ip, ip, #16
	rsb	r2, ip, r2
	add	r0, r0, ip
	b	.L6
.L15:
	mov	r0, r2
	b	.L3
.L25:
	rsb	r2, r3, #0
	and	r3, r3, r2
	clz	r3, r3
	rsb	r3, r3, #31
	add	r0, r0, r3
	b	.L3
.L27:
	.align	3
.L26:
	.byte	1
	.byte	2
	.byte	4
	.byte	8
	.byte	16
	.byte	32
	.byte	64
	.byte	-128
	.byte	1
	.byte	2
	.byte	4
	.byte	8
	.byte	16
	.byte	32
	.byte	64
	.byte	-128
	.cantunwind
	.fnend
	.size	_Z10memchrNEONPKvij, .-_Z10memchrNEONPKvij
	.align	2
	.global	_Z10strlenNEONPKc
	.type	_Z10strlenNEONPKc, %function
_Z10strlenNEONPKc:
	.fnstart
.LFB2422:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, lr}
	ands	r3, r0, #15
	moveq	r2, r0
	moveq	r3, r0
	bne	.L45
.L29:
	tst	r2, #31
	bne	.L46
.L32:
	add	r3, r3, #32
.L35:
	vldr	d20, [r3, #-16]
	vldr	d21, [r3, #-8]
	vldr	d16, [r3, #-32]
	vldr	d17, [r3, #-24]
	vceq.i8	q10, q10, #0
	vceq.i8	q8, q8, #0
	vorr	q9, q8, q10
	vorr	d18, d19, d18
	fmrrd	r4, r5, d18	@ int
	sub	r1, r3, #32
	add	r3, r3, #32
	orrs	r2, r4, r5
	beq	.L35
	vldr	d18, .L49
	vldr	d19, .L49+8
	vand	q8, q8, q9
	vand	q10, q10, q9
	vpadd.i8	d16, d16, d17
	vpadd.i8	d20, d20, d21
	vpadd.i8	d16, d16, d20
	vpadd.i8	d16, d16, d16
	vmov.32	r2, d16[0]
	rsb	r3, r2, #0
	and	r3, r3, r2
	clz	r3, r3
	rsb	r3, r3, #31
	add	r1, r1, r3
	rsb	r0, r0, r1
	ldmfd	sp!, {r3, r4, r5, pc}
.L45:
	bic	r2, r0, #15
	vldr	d18, .L49
	vldr	d19, .L49+8
	vld1.64	{d16-d17}, [r2:128]
	vceq.i8	q8, q8, #0
	vand	q8, q8, q9
	vpadd.i8	d16, d16, d17
	vpadd.i8	d16, d16, d16
	vpadd.i8	d16, d16, d16
	vmov.u16	r2, d16[0]
	movs	r2, r2, lsr r3
	bne	.L47
	rsb	r3, r3, #16
	add	r3, r0, r3
	tst	r3, #15
	mov	r2, r3
	beq	.L29
	ldr	r0, .L49+16
	ldr	r1, .L49+20
	mov	r2, #132
	ldr	r3, .L49+24
	bl	__assert_fail
.L46:
	vld1.64	{d16-d17}, [r3:64]
	vceq.i8	q8, q8, #0
	vorr	d18, d17, d16
	vmov	r4, r5, d18  @ v8qi
	orrs	r2, r4, r5
	bne	.L48
	add	r3, r3, #16
	tst	r3, #31
	beq	.L32
	ldr	r0, .L49+28
	ldr	r1, .L49+20
	mov	r2, #143
	ldr	r3, .L49+24
	bl	__assert_fail
.L47:
	rsb	r3, r2, #0
	and	r0, r2, r3
	clz	r0, r0
	rsb	r0, r0, #31
	ldmfd	sp!, {r3, r4, r5, pc}
.L48:
	vldr	d18, .L49
	vldr	d19, .L49+8
	vand	q8, q8, q9
	vpadd.i8	d16, d16, d17
	vpadd.i8	d16, d16, d16
	vpadd.i8	d16, d16, d16
	vmov.u16	r2, d16[0]
	rsb	r1, r2, #0
	and	r2, r2, r1
	clz	r2, r2
	rsb	r2, r2, #31
	add	r3, r3, r2
	rsb	r0, r0, r3
	ldmfd	sp!, {r3, r4, r5, pc}
.L50:
	.align	3
.L49:
	.byte	1
	.byte	2
	.byte	4
	.byte	8
	.byte	16
	.byte	32
	.byte	64
	.byte	-128
	.byte	1
	.byte	2
	.byte	4
	.byte	8
	.byte	16
	.byte	32
	.byte	64
	.byte	-128
	.word	.LC1
	.word	.LC2
	.word	.LANCHOR0
	.word	.LC3
	.cantunwind
	.fnend
	.size	_Z10strlenNEONPKc, .-_Z10strlenNEONPKc
	.global	__aeabi_idivmod
	.align	2
	.global	_Z11createTablePcji
	.type	_Z11createTablePcji, %function
_Z11createTablePcji:
	.fnstart
.LFB2431:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r1, #0
	stmfd	sp!, {r3, r4, r5, r6, r7, lr}
	beq	.L59
	mov	r6, r2
	mov	r4, r0
	add	r5, r0, r1
	mov	r7, #1
.L54:
	strb	r7, [r4], #1
	bl	rand
	mov	r1, r6
	bl	__aeabi_idivmod
	cmp	r1, #0
	streqb	r1, [r4, #-1]
	cmp	r4, r5
	bne	.L54
.L55:
	mov	r3, #0
	strb	r3, [r5, #-1]
	ldmfd	sp!, {r3, r4, r5, r6, r7, pc}
.L59:
	mov	r5, r0
	b	.L55
	.cantunwind
	.fnend
	.size	_Z11createTablePcji, .-_Z11createTablePcji
	.align	2
	.global	_Z9my_strlenPKc
	.type	_Z9my_strlenPKc, %function
_Z9my_strlenPKc:
	.fnstart
.LFB2437:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldrb	r1, [r0]	@ zero_extendqisi2
	add	r3, r0, #1
	cmp	r1, #0
	beq	.L61
.L62:
	rsb	r1, r0, r3
	ldrb	r2, [r3], #1	@ zero_extendqisi2
	cmp	r2, #0
	bne	.L62
.L61:
	mov	r0, r1
	bx	lr
	.cantunwind
	.fnend
	.size	_Z9my_strlenPKc, .-_Z9my_strlenPKc
	.section	.text._ZNSt6vectorI6ResultSaIS0_EE13_M_insert_auxEN9__gnu_cxx17__normal_iteratorIPS0_S2_EERKS0_,"axG",%progbits,_ZNSt6vectorI6ResultSaIS0_EE13_M_insert_auxEN9__gnu_cxx17__normal_iteratorIPS0_S2_EERKS0_,comdat
	.align	2
	.weak	_ZNSt6vectorI6ResultSaIS0_EE13_M_insert_auxEN9__gnu_cxx17__normal_iteratorIPS0_S2_EERKS0_
	.type	_ZNSt6vectorI6ResultSaIS0_EE13_M_insert_auxEN9__gnu_cxx17__normal_iteratorIPS0_S2_EERKS0_, %function
_ZNSt6vectorI6ResultSaIS0_EE13_M_insert_auxEN9__gnu_cxx17__normal_iteratorIPS0_S2_EERKS0_:
	.fnstart
.LFB2499:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	.save {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	ip, r2
	ldr	r5, [r0, #4]
	ldr	r3, [r0, #8]
	.pad #20
	sub	sp, sp, #20
	cmp	r5, r3
	mov	r8, r0
	mov	r7, r1
	beq	.L66
	cmp	r5, #0
	subne	r4, r5, #16
	mvneq	r4, #15
	ldmneia	r4, {r0, r1, r2, r3}
	rsb	lr, r7, r4
	mov	r6, sp
	mov	lr, lr, asr #4
	stmneia	r5, {r0, r1, r2, r3}
	cmp	lr, #0
	ldmia	ip, {r0, r1, r2, r3}
	add	ip, r5, #16
	str	ip, [r8, #4]
	stmia	sp, {r0, r1, r2, r3}
	ble	.L71
	rsb	r3, lr, lr, asl #28
	sub	lr, lr, #1
	mov	r3, r3, asl #4
	add	r4, r4, r3
	add	r5, r5, r3
.L70:
	mov	ip, lr, asl #4
	add	r3, r4, ip
	sub	lr, lr, #1
	ldmia	r3, {r0, r1, r2, r3}
	add	ip, r5, ip
	cmn	lr, #1
	stmia	ip, {r0, r1, r2, r3}
	bne	.L70
.L71:
	ldmia	r6, {r0, r1, r2, r3}
	stmia	r7, {r0, r1, r2, r3}
.L65:
	add	sp, sp, #20
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L66:
	ldr	lr, [r0]
	mov	r4, r2
	rsb	r3, lr, r5
	mov	r6, r0
	movs	r3, r3, asr #4
	bne	.L105
	rsb	r10, lr, r1
	mov	r8, #16
.L83:
	mov	r0, r8
	bl	_Znwj
	ldr	r5, [r6, #4]
	ldr	lr, [r6]
	mov	r9, r0
	add	fp, r0, #16
.L74:
	adds	ip, r9, r10
	ldmneia	r4, {r0, r1, r2, r3}
	stmneia	ip, {r0, r1, r2, r3}
	cmp	r7, lr
	beq	.L85
	mov	r4, lr
	mov	ip, r9
.L78:
	cmp	ip, #0
	ldmneia	r4, {r0, r1, r2, r3}
	add	r4, r4, #16
	stmneia	ip, {r0, r1, r2, r3}
	cmp	r7, r4
	add	ip, ip, #16
	bne	.L78
	add	r4, lr, #16
	rsb	r4, r4, r7
	bic	r4, r4, #15
	add	r4, r4, #32
	add	r4, r9, r4
.L76:
	cmp	r7, r5
	beq	.L79
	mov	ip, r7
	mov	r10, r4
.L81:
	cmp	r10, #0
	ldmneia	ip, {r0, r1, r2, r3}
	add	ip, ip, #16
	stmneia	r10, {r0, r1, r2, r3}
	cmp	ip, r5
	add	r10, r10, #16
	bne	.L81
	add	r3, r7, #16
	rsb	r3, r3, ip
	bic	r3, r3, #15
	add	r3, r3, #16
	add	r4, r4, r3
.L79:
	cmp	lr, #0
	beq	.L82
	mov	r0, lr
	bl	_ZdlPv
.L82:
	add	r8, r9, r8
	str	r8, [r6, #8]
	str	r9, [r6]
	str	r4, [r6, #4]
	b	.L65
.L105:
	mov	r9, r3, asl #1
	cmp	r3, r9
	bls	.L106
.L73:
	rsb	r10, lr, r7
	mvn	r8, #15
	b	.L83
.L85:
	mov	r4, fp
	b	.L76
.L106:
	cmn	r9, #-268435455
	bhi	.L73
	cmp	r9, #0
	mov	r8, r3, asl #5
	rsb	r10, lr, r1
	moveq	fp, #16
	beq	.L74
	b	.L83
	.fnend
	.size	_ZNSt6vectorI6ResultSaIS0_EE13_M_insert_auxEN9__gnu_cxx17__normal_iteratorIPS0_S2_EERKS0_, .-_ZNSt6vectorI6ResultSaIS0_EE13_M_insert_auxEN9__gnu_cxx17__normal_iteratorIPS0_S2_EERKS0_
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	.fnstart
.LFB2439:
	@ args = 0, pretend = 0, frame = 168
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	.save {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	fstmfdd	sp!, {d8, d9, d10, d11, d12, d13}
	.vsave {d8, d9, d10, d11, d12, d13}
	ldr	r0, .L250+72
	ldr	r5, .L250+40
	fldd	d8, .L250
	.pad #180
	sub	sp, sp, #180
.LEHB0:
	bl	_Znwj
.LEHE0:
	mov	r1, #0
	ldr	r2, .L250+72
	fldd	d9, .L250+8
	fldd	d10, .L250+16
	add	r6, sp, #56
	vldr	d12, .L250+24
	vldr	d13, .L250+32
	mov	r4, r0
	bl	memset
	ldr	r3, .L250+44
	add	ip, sp, #60
	mov	r7, r3
	ldmia	r5!, {r0, r1, r2, r3}
	mov	lr, #0
	sub	r8, r4, #1
	add	r7, r4, r7
	stmia	ip!, {r0, r1, r2, r3}
	vmov.i32	q8, #0  @ v4si
	ldmia	r5!, {r0, r1, r2, r3}
	str	r6, [sp, #12]
	str	r8, [sp, #24]
	stmia	ip!, {r0, r1, r2, r3}
	add	r3, r4, #98304
	str	r3, [sp, #20]
	ldmia	r5!, {r0, r1, r2, r3}
	str	r7, [sp, #28]
	str	lr, [sp, #8]
	ldr	r5, [r5]
	stmia	ip!, {r0, r1, r2, r3}
	str	r6, [sp, #16]
	str	lr, [sp, #160]
	str	r5, [ip]
	str	lr, [sp, #164]
	str	lr, [sp, #168]
	vstr	d16, [sp, #112]
	vstr	d17, [sp, #120]
	vstr	d16, [sp, #128]
	vstr	d17, [sp, #136]
	vstr	d16, [sp, #144]
	vstr	d17, [sp, #152]
.L165:
	ldr	r3, [sp, #16]
	ldr	r9, [sp, #24]
	ldr	r7, [sp, #28]
	ldr	r5, [r3, #4]!
	mov	r6, #1
	str	r3, [sp, #16]
.L109:
	strb	r6, [r9, #1]!
	bl	rand
	mov	r1, r5
	bl	__aeabi_idivmod
	cmp	r1, #0
	streqb	r1, [r9]
	cmp	r9, r7
	bne	.L109
	ldr	r1, [sp, #20]
	mov	r3, #0
	mov	r2, r5
	strb	r3, [r1, #1695]
	ldr	r0, .L250+48
	ldr	r1, [sp, #8]
.LEHB1:
	bl	printf
	ldr	r0, .L250+52
	bl	puts
	add	r5, sp, #40
	mov	r0, r5
	mov	r1, #0
	bl	gettimeofday
	flds	s15, [sp, #40]	@ int
	mov	r9, #0
	mov	r6, r9
	mov	r10, #4000
	fsitod	d11, s15
	flds	s15, [sp, #44]	@ int
	fsitod	d16, s15
	fmacd	d11, d16, d8
.L111:
	ldr	r8, .L250+72
	mov	r7, r4
.L113:
	mov	r0, r7
	bl	strlen
	adds	r7, r7, r0
	beq	.L112
	mvn	r3, r0
	add	r8, r8, r3
	cmp	r8, #0
	add	r6, r6, r0
	add	r9, r9, #1
	add	r7, r7, #1
	bgt	.L113
.L112:
	subs	r10, r10, #1
	bne	.L111
	mov	r1, r10
	mov	r0, r5
	bl	gettimeofday
	fmsr	s15, r6	@ int
	mov	r1, r6
	ldr	r0, .L250+80
	fsitod	d19, s15
	flds	s15, [sp, #40]	@ int
	str	r9, [sp, #40]
	fsitod	d16, s15
	flds	s15, [sp, #44]	@ int
	str	r6, [sp, #44]
	fsitod	d17, s15
	fmsr	s15, r9	@ int
	fsitod	d18, s15
	fmacd	d16, d17, d8
	fdivd	d17, d19, d18
	fsubd	d16, d16, d11
	fmuld	d16, d16, d9
	fdivd	d16, d16, d10
	fmrrd	r2, r3, d17
	fstd	d16, [sp]
	fstd	d16, [sp, #48]
	bl	printf
	ldr	ip, [sp, #116]
	ldr	r3, [sp, #120]
	cmp	ip, r3
	beq	.L115
	cmp	ip, #0
	ldmneia	r5, {r0, r1, r2, r3}
	stmneia	ip, {r0, r1, r2, r3}
	add	ip, ip, #16
	str	ip, [sp, #116]
.L117:
	ldr	r0, .L250+56
	ldr	r6, [sp, #40]
	bl	puts
	mov	r1, #0
	add	r0, sp, #32
	bl	gettimeofday
	flds	s15, [sp, #32]	@ int
	mov	r10, #0
	mov	r9, r10
	mov	r1, #4000
	fsitod	d11, s15
	flds	s15, [sp, #36]	@ int
	fsitod	d16, s15
	fmacd	d11, d16, d8
.L118:
	ldr	lr, .L250+72
	mov	r0, r4
.L124:
	ldrb	r2, [r0]	@ zero_extendqisi2
	add	r3, r0, #1
	cmp	r2, #0
	moveq	r3, r2
	moveq	ip, r3
	beq	.L122
.L119:
	rsb	ip, r0, r3
	ldrb	r2, [r3], #1	@ zero_extendqisi2
	cmp	r2, #0
	bne	.L119
	mov	r3, ip
.L122:
	adds	r0, r0, r3
	beq	.L120
	mvn	ip, ip
	add	lr, lr, ip
	cmp	lr, #0
	add	r9, r9, r3
	add	r10, r10, #1
	add	r0, r0, #1
	bgt	.L124
.L120:
	subs	r1, r1, #1
	bne	.L118
	add	r0, sp, #32
	bl	gettimeofday
	flds	s15, [sp, #32]	@ int
	cmp	r6, r10
	str	r10, [sp, #40]
	str	r9, [sp, #44]
	fsitod	d16, s15
	flds	s15, [sp, #36]	@ int
	fsitod	d17, s15
	fmacd	d16, d17, d8
	fsubd	d16, d16, d11
	fmuld	d16, d16, d9
	fdivd	d16, d16, d10
	fstd	d16, [sp, #48]
	beq	.L175
	mov	r2, r10
	ldr	r0, .L250+76
	mov	r1, r6
	bl	printf
	fldd	d16, [sp, #48]
	ldr	r1, [sp, #44]
	ldr	r3, [sp, #40]
.L125:
	fmsr	s15, r1	@ int
	fstd	d16, [sp]
	ldr	r0, .L250+80
	fsitod	d18, s15
	fmsr	s15, r3	@ int
	fsitod	d17, s15
	fdivd	d16, d18, d17
	fmrrd	r2, r3, d16
	bl	printf
	ldr	ip, [sp, #128]
	ldr	r3, [sp, #132]
	cmp	ip, r3
	beq	.L126
	cmp	ip, #0
	ldmneia	r5, {r0, r1, r2, r3}
	stmneia	ip, {r0, r1, r2, r3}
	add	ip, ip, #16
	str	ip, [sp, #128]
.L128:
	ldr	r0, .L250+60
	bl	puts
	add	r0, sp, #32
	mov	r1, #0
	bl	gettimeofday
	flds	s15, [sp, #32]	@ int
	mov	r10, #0
	mov	r9, r10
	mov	fp, #4000
	fsitod	d11, s15
	flds	s15, [sp, #36]	@ int
	fsitod	d16, s15
	fmacd	d11, d16, d8
.L129:
	ldr	r8, .L250+72
	mov	r7, r4
.L131:
	mov	r0, r7
	bl	_Z10strlenNEONPKc
	adds	r7, r7, r0
	beq	.L130
	mvn	r3, r0
	add	r8, r8, r3
	cmp	r8, #0
	add	r9, r9, r0
	add	r10, r10, #1
	add	r7, r7, #1
	bgt	.L131
.L130:
	subs	fp, fp, #1
	bne	.L129
	mov	r1, fp
	add	r0, sp, #32
	bl	gettimeofday
	flds	s15, [sp, #32]	@ int
	cmp	r6, r10
	str	r10, [sp, #40]
	str	r9, [sp, #44]
	fsitod	d16, s15
	flds	s15, [sp, #36]	@ int
	fsitod	d17, s15
	fmacd	d16, d17, d8
	fsubd	d16, d16, d11
	fmuld	d16, d16, d9
	fdivd	d16, d16, d10
	fstd	d16, [sp, #48]
	beq	.L176
	mov	r2, r10
	ldr	r0, .L250+76
	mov	r1, r6
	bl	printf
	fldd	d16, [sp, #48]
	b	.L251
.L252:
	.align	3
.L250:
	.word	-1598689907
	.word	1051772663
	.word	0
	.word	1093567616
	.word	0
	.word	1085227008
	.byte	1
	.byte	2
	.byte	4
	.byte	8
	.byte	16
	.byte	32
	.byte	64
	.byte	-128
	.byte	1
	.byte	2
	.byte	4
	.byte	8
	.byte	16
	.byte	32
	.byte	64
	.byte	-128
	.word	.LANCHOR0+32
	.word	99999
	.word	.LC4
	.word	.LC5
	.word	.LC7
	.word	.LC9
	.word	.LC10
	.word	.LC11
	.word	100000
	.word	.LC8
	.word	.LC6
	.word	.LC12
	.word	.LC13
	.word	.LC14
	.word	.LANCHOR0+88
	.word	.LC15
	.word	.LC16
.L251:
	ldr	r1, [sp, #44]
	ldr	r3, [sp, #40]
.L133:
	fmsr	s15, r1	@ int
	fstd	d16, [sp]
	ldr	r0, .L250+80
	fsitod	d18, s15
	fmsr	s15, r3	@ int
	fsitod	d17, s15
	fdivd	d16, d18, d17
	fmrrd	r2, r3, d16
	bl	printf
	ldr	ip, [sp, #140]
	ldr	r3, [sp, #144]
	cmp	ip, r3
	beq	.L134
	cmp	ip, #0
	ldmneia	r5, {r0, r1, r2, r3}
	stmneia	ip, {r0, r1, r2, r3}
	add	ip, ip, #16
	str	ip, [sp, #140]
.L136:
	ldr	r0, .L250+64
	bl	puts
	add	r0, sp, #32
	mov	r1, #0
	bl	gettimeofday
	flds	s15, [sp, #32]	@ int
	mov	r10, #0
	mov	r9, r10
	mov	fp, #4000
	fsitod	d11, s15
	flds	s15, [sp, #36]	@ int
	fsitod	d16, s15
	fmacd	d11, d16, d8
.L137:
	ldr	r8, .L250+72
	mov	r7, r4
.L139:
	mov	r0, r7
	mov	r1, #0
	mov	r2, r8
	bl	memchr
	cmp	r0, #0
	beq	.L138
	rsb	r7, r7, r0
	mvn	r3, r7
	add	r8, r8, r3
	cmp	r8, #0
	add	r9, r9, r7
	add	r10, r10, #1
	add	r7, r0, #1
	bgt	.L139
.L138:
	subs	fp, fp, #1
	bne	.L137
	mov	r1, fp
	add	r0, sp, #32
	bl	gettimeofday
	flds	s15, [sp, #32]	@ int
	cmp	r6, r10
	str	r10, [sp, #40]
	str	r9, [sp, #44]
	fsitod	d16, s15
	flds	s15, [sp, #36]	@ int
	fsitod	d17, s15
	fmacd	d16, d17, d8
	fsubd	d16, d16, d11
	fmuld	d16, d16, d9
	fdivd	d16, d16, d10
	fstd	d16, [sp, #48]
	beq	.L177
	mov	r2, r10
	ldr	r0, .L250+76
	mov	r1, r6
	bl	printf
	fldd	d16, [sp, #48]
	ldr	r1, [sp, #44]
	ldr	r3, [sp, #40]
.L141:
	fmsr	s15, r1	@ int
	fstd	d16, [sp]
	ldr	r0, .L250+80
	fsitod	d18, s15
	fmsr	s15, r3	@ int
	fsitod	d17, s15
	fdivd	d16, d18, d17
	fmrrd	r2, r3, d16
	bl	printf
	ldr	ip, [sp, #152]
	ldr	r3, [sp, #156]
	cmp	ip, r3
	beq	.L142
	cmp	ip, #0
	ldmneia	r5, {r0, r1, r2, r3}
	stmneia	ip, {r0, r1, r2, r3}
	add	ip, ip, #16
	str	ip, [sp, #152]
.L144:
	ldr	r0, .L250+68
	bl	puts
	mov	r1, #0
	add	r0, sp, #32
	bl	gettimeofday
	flds	s15, [sp, #32]	@ int
	mov	r10, #0
	mov	r9, r10
	mov	r1, #4000
	fsitod	d11, s15
	flds	s15, [sp, #36]	@ int
	fsitod	d16, s15
	fmacd	d11, d16, d8
.L145:
	ldr	lr, .L250+72
	mov	ip, r4
.L159:
	cmp	lr, #15
	mov	r3, lr
	movle	r2, ip
	bgt	.L246
.L174:
	ldrb	r0, [r2]	@ zero_extendqisi2
	cmp	r0, #0
	addne	r7, r2, r3
	addne	r3, r2, #1
	bne	.L156
	b	.L157
.L158:
	ldrb	r0, [r2]	@ zero_extendqisi2
	add	r3, r3, #1
	cmp	r0, #0
	beq	.L157
.L156:
	cmp	r3, r7
	mov	r2, r3
	bne	.L158
.L153:
	subs	r1, r1, #1
	bne	.L145
.L160:
	add	r0, sp, #32
	bl	gettimeofday
	flds	s15, [sp, #32]	@ int
	cmp	r6, r10
	str	r10, [sp, #40]
	str	r9, [sp, #44]
	fsitod	d17, s15
	flds	s15, [sp, #36]	@ int
	fsitod	d16, s15
	fmacd	d17, d16, d8
	fsubd	d17, d17, d11
	fmuld	d17, d17, d9
	fdivd	d17, d17, d10
	fstd	d17, [sp, #48]
	beq	.L179
	mov	r1, r6
	mov	r2, r10
	ldr	r0, .L250+76
	bl	printf
	fldd	d17, [sp, #48]
	ldr	r1, [sp, #44]
	ldr	r6, [sp, #40]
.L161:
	fmsr	s15, r1	@ int
	fstd	d17, [sp]
	ldr	r0, .L250+80
	fsitod	d18, s15
	fmsr	s15, r6	@ int
	fsitod	d16, s15
	fdivd	d16, d18, d16
	fmrrd	r2, r3, d16
	bl	printf
	ldr	ip, [sp, #164]
	ldr	r3, [sp, #168]
	cmp	ip, r3
	beq	.L162
	cmp	ip, #0
	ldmneia	r5, {r0, r1, r2, r3}
	stmneia	ip, {r0, r1, r2, r3}
	add	ip, ip, #16
	str	ip, [sp, #164]
.L164:
	ldr	r3, [sp, #8]
	add	r3, r3, #1
	cmp	r3, #13
	str	r3, [sp, #8]
	bne	.L165
	ldr	r0, .L250+84
	bl	puts
	ldr	r0, .L250+88
	bl	printf
	add	r5, sp, #108
.L166:
	ldr	r3, [sp, #12]
	ldr	r0, .L250+92
	ldr	r1, [r3, #4]!
	mov	r6, r3
	str	r3, [sp, #12]
	bl	printf
	cmp	r6, r5
	bne	.L166
	mov	r0, #10
	bl	putchar
	ldr	r7, .L250+96
	mov	r6, #0
.L168:
	ldr	r0, .L250+100
	mov	r1, r7
	bl	printf
	mov	r5, #0
.L167:
	add	r3, sp, #112
	ldr	r0, .L250+104
	ldr	r3, [r3, r6]
	add	r3, r3, r5
	ldrd	r2, [r3, #8]
	bl	printf
	add	r5, r5, #16
	cmp	r5, #208
	bne	.L167
	mov	r0, #10
	bl	putchar
	add	r6, r6, #12
	cmp	r6, #60
	add	r7, r7, #16
	bne	.L168
	add	r5, sp, #172
.L170:
	ldr	r0, [r5, #-12]!
	cmp	r0, #0
	beq	.L169
	bl	_ZdlPv
.L169:
	add	r3, sp, #112
	cmp	r5, r3
	bne	.L170
	mov	r0, r4
	bl	_ZdlPv
	mov	r0, #0
	add	sp, sp, #180
	@ sp needed
	fldmfdd	sp!, {d8-d13}
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L246:
	ands	r0, ip, #15
	moveq	r2, ip
	bne	.L247
.L147:
	cmp	r3, #31
	bls	.L150
	add	r0, r2, #32
	mov	r8, r6
	b	.L152
.L151:
	sub	r3, r3, #32
	cmp	r3, #31
	add	r0, r0, #32
	bls	.L248
.L152:
	vldr	d16, [r0, #-16]
	vldr	d17, [r0, #-8]
	vldr	d18, [r0, #-32]
	vldr	d19, [r0, #-24]
	vceq.i8	q8, q8, #0
	vceq.i8	q9, q9, #0
	vorr	q10, q9, q8
	vorr	d20, d21, d20
	fmrrd	r6, r7, d20	@ int
	orrs	r2, r6, r7
	sub	r7, r0, #32
	mov	r2, r0
	beq	.L151
	vand	q9, q9, q6
	vand	q8, q8, q6
	vpadd.i8	d18, d18, d19
	vpadd.i8	d16, d16, d17
	vpadd.i8	d16, d18, d16
	vpadd.i8	d16, d16, d16
	vmov.32	r2, d16[0]
	rsb	r3, r2, #0
	and	r2, r2, r3
	clz	r2, r2
	rsb	r2, r2, #31
	mov	r6, r8
	add	r2, r7, r2
.L149:
	cmp	r2, #0
	beq	.L153
.L157:
	rsb	ip, ip, r2
	mvn	r3, ip
	add	lr, lr, r3
	cmp	lr, #0
	add	r9, r9, ip
	add	r10, r10, #1
	add	ip, r2, #1
	bgt	.L159
	subs	r1, r1, #1
	bne	.L145
	b	.L160
.L248:
	mov	r6, r8
.L150:
	cmp	r3, #0
	bne	.L174
	subs	r1, r1, #1
	bne	.L145
	b	.L160
.L247:
	bic	r3, ip, #15
	vld1.64	{d16-d17}, [r3:128]
	vceq.i8	q8, q8, #0
	vand	q8, q8, q6
	vpadd.i8	d16, d16, d17
	vpadd.i8	d16, d16, d16
	vpadd.i8	d16, d16, d16
	vmov.u16	r3, d16[0]
	movs	r2, r3, lsr r0
	rsbeq	r2, r0, #16
	rsbeq	r3, r2, lr
	addeq	r2, ip, r2
	beq	.L147
.L249:
	rsb	r3, r2, #0
	and	r2, r2, r3
	clz	r2, r2
	rsb	r2, r2, #31
	add	r2, ip, r2
	b	.L149
.L179:
	mov	r1, r9
	b	.L161
.L177:
	mov	r1, r9
	mov	r3, r6
	b	.L141
.L176:
	mov	r1, r9
	mov	r3, r6
	b	.L133
.L175:
	mov	r1, r9
	mov	r3, r6
	b	.L125
.L162:
	mov	r1, ip
	mov	r2, r5
	add	r0, sp, #160
	bl	_ZNSt6vectorI6ResultSaIS0_EE13_M_insert_auxEN9__gnu_cxx17__normal_iteratorIPS0_S2_EERKS0_
	b	.L164
.L142:
	mov	r1, ip
	add	r0, sp, #148
	mov	r2, r5
	bl	_ZNSt6vectorI6ResultSaIS0_EE13_M_insert_auxEN9__gnu_cxx17__normal_iteratorIPS0_S2_EERKS0_
	b	.L144
.L134:
	mov	r1, ip
	add	r0, sp, #136
	mov	r2, r5
	bl	_ZNSt6vectorI6ResultSaIS0_EE13_M_insert_auxEN9__gnu_cxx17__normal_iteratorIPS0_S2_EERKS0_
	b	.L136
.L126:
	mov	r1, ip
	add	r0, sp, #124
	mov	r2, r5
	bl	_ZNSt6vectorI6ResultSaIS0_EE13_M_insert_auxEN9__gnu_cxx17__normal_iteratorIPS0_S2_EERKS0_
	b	.L128
.L115:
	mov	r1, ip
	add	r0, sp, #112
	mov	r2, r5
	bl	_ZNSt6vectorI6ResultSaIS0_EE13_M_insert_auxEN9__gnu_cxx17__normal_iteratorIPS0_S2_EERKS0_
.LEHE1:
	b	.L117
.L180:
	add	r5, sp, #172
.L173:
	ldr	r0, [r5, #-12]!
	cmp	r0, #0
	beq	.L172
	bl	_ZdlPv
.L172:
	add	r3, sp, #112
	cmp	r5, r3
	bne	.L173
	mov	r0, r4
	bl	_ZdlPv
.LEHB2:
	bl	__cxa_end_cleanup
.LEHE2:
	.global	__gxx_personality_v0
	.personality	__gxx_personality_v0
	.handlerdata
.LLSDA2439:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE2439-.LLSDACSB2439
.LLSDACSB2439:
	.uleb128 .LEHB0-.LFB2439
	.uleb128 .LEHE0-.LEHB0
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB1-.LFB2439
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L180-.LFB2439
	.uleb128 0
	.uleb128 .LEHB2-.LFB2439
	.uleb128 .LEHE2-.LEHB2
	.uleb128 0
	.uleb128 0
.LLSDACSE2439:
	.section	.text.startup
	.fnend
	.size	main, .-main
	.section	.rodata
	.align	3
.LANCHOR0 = . + 0
	.type	_ZZ10strlenNEONPKcE19__PRETTY_FUNCTION__, %object
	.size	_ZZ10strlenNEONPKcE19__PRETTY_FUNCTION__, 31
_ZZ10strlenNEONPKcE19__PRETTY_FUNCTION__:
	.ascii	"size_t strlenNEON(const char*)\000"
	.space	1
.LC0:
	.word	2
	.word	5
	.word	7
	.word	10
	.word	12
	.word	16
	.word	20
	.word	32
	.word	64
	.word	128
	.word	256
	.word	512
	.word	1024
	.space	4
	.type	_ZZ4mainE7nameTbl, %object
	.size	_ZZ4mainE7nameTbl, 80
_ZZ4mainE7nameTbl:
	.ascii	"strlenANSI\000"
	.space	5
	.ascii	"strlenBLOG\000"
	.space	5
	.ascii	"strlenNEON\000"
	.space	5
	.ascii	"memchrANSI\000"
	.space	5
	.ascii	"memchrNEON\000"
	.space	5
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC1:
	.ascii	"(reinterpret_cast<size_t>(p) & 15) == 0\000"
.LC2:
	.ascii	"neon_search.cpp\000"
.LC3:
	.ascii	"(reinterpret_cast<size_t>(p) & 31) == 0\000"
.LC4:
	.ascii	"test %d, %d\012\000"
	.space	3
.LC5:
	.ascii	"strlenANSI\000"
	.space	1
.LC6:
	.ascii	"ret=%d(%.1f) time= %f usec\012\000"
.LC7:
	.ascii	"strlenBLOG\000"
	.space	1
.LC8:
	.ascii	"ERROR!!! ok=%d, ng=%d\012\000"
	.space	1
.LC9:
	.ascii	"strlenNEON\000"
	.space	1
.LC10:
	.ascii	"memchrANSI\000"
	.space	1
.LC11:
	.ascii	"memchrNEON\000"
	.space	1
.LC12:
	.ascii	"end\000"
.LC13:
	.ascii	"ave        \000"
.LC14:
	.ascii	"%6d \000"
	.space	3
.LC15:
	.ascii	"%s \000"
.LC16:
	.ascii	"%6.1f \000"
	.ident	"GCC: (Raspbian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",%progbits
