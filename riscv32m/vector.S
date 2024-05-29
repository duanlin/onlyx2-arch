#include "hpm_csr_regs.h"


.section .vector, "ax"

.global _vector
_vector:
	.long trap_exception /* trap and exceptions */
	.long vectored_irq_1 /* GPIO0_A IRQ */
	.long vectored_irq_2 /* GPIO0_B IRQ */
	.long vectored_irq_3 /* GPIO0_C IRQ */
	.long vectored_irq_4 /* GPIO0_D IRQ */
	.long vectored_irq_5 /* GPIO0_X IRQ */
	.long vectored_irq_6 /* GPIO0_Y IRQ */
	.long vectored_irq_7 /* GPIO0_Z IRQ */
	.long vectored_irq_8 /* ADC0 IRQ */
	.long vectored_irq_9 /* ADC1 IRQ */
	.long vectored_irq_10 /* ADC2 IRQ */
	.long vectored_irq_11 /* DAC IRQ */
	.long vectored_irq_12 /* ACMP[0] IRQ */
	.long vectored_irq_13 /* ACMP[1] IRQ */
	.long vectored_irq_14 /* SPI0 IRQ */
	.long vectored_irq_15 /* SPI1 IRQ */
	.long vectored_irq_16 /* SPI2 IRQ */
	.long vectored_irq_17 /* SPI3 IRQ */
	.long vectored_irq_18 /* UART0 IRQ */
	.long vectored_irq_18 /* UART1 IRQ */
	.long vectored_irq_18 /* UART2 IRQ */
	.long vectored_irq_18 /* UART3 IRQ */
	.long vectored_irq_22 /* UART4 IRQ */
	.long vectored_irq_23 /* UART5 IRQ */
	.long vectored_irq_24 /* UART6 IRQ */
	.long vectored_irq_25 /* UART7 IRQ */
	.long vectored_irq_26 /* CAN0 IRQ */
	.long vectored_irq_27 /* CAN1 IRQ */
	.long vectored_irq_28 /* PTPC IRQ */
	.long vectored_irq_29 /* WDG0 IRQ */
	.long vectored_irq_30 /* WDG1 IRQ */
	.long vectored_irq_31 /* TSNS IRQ */
	.long vectored_irq_32 /* MBX0A IRQ */
	.long vectored_irq_33 /* MBX0B IRQ */
	.long vectored_irq_34 /* GPTMR0 IRQ */
	.long vectored_irq_35 /* GPTMR1 IRQ */
	.long vectored_irq_36 /* GPTMR2 IRQ */
	.long vectored_irq_37 /* GPTMR3 IRQ */
	.long vectored_irq_38 /* I2C0 IRQ */
	.long vectored_irq_39 /* I2C1 IRQ */
	.long vectored_irq_40 /* I2C2 IRQ */
	.long vectored_irq_41 /* I2C3 IRQ */
	.long vectored_irq_42 /* PWM0 IRQ */
	.long vectored_irq_43 /* HALL0 IRQ */
	.long vectored_irq_44 /* QEI0 IRQ */
	.long vectored_irq_45 /* PWM1 IRQ */
	.long vectored_irq_46 /* HALL1 IRQ */
	.long vectored_irq_47 /* QEI1 IRQ */
	.long vectored_irq_48 /* SDP IRQ */
	.long vectored_irq_49 /* XPI0 IRQ */
	.long vectored_irq_50 /* XPI1 IRQ */
	.long vectored_irq_51 /* XDMA IRQ */
	.long vectored_irq_52 /* HDMA IRQ */
	.long vectored_irq_53 /* DRAM IRQ */
	.long vectored_irq_54 /* RNG IRQ */
	.long vectored_irq_55 /* I2S0 IRQ */
	.long vectored_irq_56 /* I2S1 IRQ */
	.long vectored_irq_57 /* DAO IRQ */
	.long vectored_irq_58 /* PDM IRQ */
	.long vectored_irq_59 /* FFA IRQ */
	.long vectored_irq_60 /* NTMR0 IRQ */
	.long vectored_irq_61 /* USB0 IRQ */
	.long vectored_irq_62 /* ENET0 IRQ */
	.long vectored_irq_63 /* SDXC0 IRQ */
	.long vectored_irq_64 /* PSEC IRQ */
	.long vectored_irq_65 /* PGPIO IRQ */
	.long vectored_irq_66 /* PWDG IRQ */
	.long vectored_irq_67 /* PTMR IRQ */
	.long vectored_irq_68 /* PUART IRQ */
	.long vectored_irq_69 /* FUSE IRQ */
	.long vectored_irq_70 /* SECMON IRQ */
	.long vectored_irq_71 /* RTC IRQ */
	.long vectored_irq_72 /* BUTN IRQ */
	.long vectored_irq_73 /* BGPIO IRQ */
	.long vectored_irq_74 /* BVIO IRQ */
	.long vectored_irq_75 /* BROWNOUT IRQ */
	.long vectored_irq_76 /* SYSCTL IRQ */
	.long vectored_irq_77 /* DEBUG[0] IRQ */
	.long vectored_irq_78 /* DEBUG[1] IRQ */


.global trap_exception
trap_exception:
	csrw	mscratch, sp
	
	// if(!gCurrentTask)
	la	sp, gCurrentTask
	lw	sp, 0(sp)
	beqz	sp, stack_nested_trap
	
	// if(!gNestLayer)
	la	sp, gNestLayer
	lw	sp, 0(sp)
	bnez	sp, stack_nested_trap
	
	// gSchedtoTask = NULL
	la	sp, gSchedtoTask
	sw	zero, 0(sp)
	
	la	sp, _stack
	j	stack_ready_trap
	
stack_nested_trap:
	csrr	sp, mscratch
	
stack_ready_trap:
	//
	// Generic register saving
	//
	addi	sp, sp, -31 * 4
	sw	x1, 0 * 4(sp) // x1 ra
	sw	x3, 2 * 4(sp) // x3 gp
	sw	x4, 3 * 4(sp) // x4 tp
	sw	x5, 4 * 4(sp) // x5 t0
	sw	x6, 5 * 4(sp) // x6 t1
	sw	x7, 6 * 4(sp) // x7 t2
	sw	x8, 7 * 4(sp) // x8 s0/fp
	sw	x9, 8 * 4(sp) // x9 s1
	sw	x10, 9 * 4(sp) // x10 a0
	sw	x11, 10 * 4(sp) // x11 a1
	sw	x12, 11 * 4(sp) // x12 a2
	sw	x13, 12 * 4(sp) // x13 a3
	sw	x14, 13 * 4(sp) // x14 a4
	sw	x15, 14 * 4(sp) // x15 a5
	sw	x16, 15 * 4(sp) // x16 a6
	sw	x17, 16 * 4(sp) // x17 a7
	sw	x18, 17 * 4(sp) // x18 s2
	sw	x19, 18 * 4(sp) // x19 s3
	sw	x20, 19 * 4(sp) // x20 s4
	sw	x21, 20 * 4(sp) // x21 s5
	sw	x22, 21 * 4(sp) // x22 s6
	sw	x23, 22 * 4(sp) // x23 s7
	sw	x24, 23 * 4(sp) // x24 s8
	sw	x25, 24 * 4(sp) // x25 s9
	sw	x26, 25 * 4(sp) // x26 s10
	sw	x27, 26 * 4(sp) // x27 s11
	sw	x28, 27 * 4(sp) // x28 t3
	sw	x29, 28 * 4(sp) // x29 t4
	sw	x30, 29 * 4(sp) // x30 t5
	sw	x31, 30 * 4(sp) // x31 t6
	
	csrr	t1, mscratch
	sw	t1, 1 * 4(sp) // x2 sp
	
	// Resume pc address
	csrr	s1, mepc
	
	// MCAUSE
	csrr	s2, mcause
	
	// Nested layer
	la	s3, gNestLayer
	lw	s4, 0(s3)
	bnez	s4, save_pc
	
	// If trap from ecall
	li	t1, 0x80000000 // MCAUSE[31] INTERRUPT
	and	t1, t1, s2
	bnez	t1, save_pc
	
	andi	t1, s2, -1 // MCAUSE[11:0] Exception code
	
	addi	t2, t1, -8 // ECALL from U-MODE
	beqz	t2, move_pc
	addi	t2, t1, -9 // ECALL from S-MODE
	beqz	t2, move_pc
	addi	t2, t1, -11 // ECALL from M-MODE
	beqz	t2, move_pc
	
	j	save_pc
	
move_pc:
	addi	s1, s1, +4

save_pc:
	addi	sp, sp, -4
	sw	s1, 0(sp)
	
	//
	// Floating register saving
	//
#if(__riscv_flen)
	addi	sp, sp, -12 // fpad
	
	addi	sp, sp, -4
	csrr	t1, fcsr
	sw	t1, 0(sp)
#endif

#if(__riscv_flen == 32)
	addi	sp, sp, -32 * 4
	fsw	f0, 0 * 4(sp)
	fsw	f1, 1 * 4(sp)
	fsw	f2, 2 * 4(sp)
	fsw	f3, 3 * 4(sp)
	fsw	f4, 4 * 4(sp)
	fsw	f5, 5 * 4(sp)
	fsw	f6, 6 * 4(sp)
	fsw	f7, 7 * 4(sp)
	fsw	f8, 8 * 4(sp)
	fsw	f9, 9 * 4(sp)
	fsw	f10, 10 * 4(sp)
	fsw	f11, 11 * 4(sp)
	fsw	f12, 12 * 4(sp)
	fsw	f13, 13 * 4(sp)
	fsw	f14, 14 * 4(sp)
	fsw	f15, 15 * 4(sp)
	fsw	f16, 16 * 4(sp)
	fsw	f17, 17 * 4(sp)
	fsw	f18, 18 * 4(sp)
	fsw	f19, 19 * 4(sp)
	fsw	f20, 20 * 4(sp)
	fsw	f21, 21 * 4(sp)
	fsw	f22, 22 * 4(sp)
	fsw	f23, 23 * 4(sp)
	fsw	f24, 24 * 4(sp)
	fsw	f25, 25 * 4(sp)
	fsw	f26, 26 * 4(sp)
	fsw	f27, 27 * 4(sp)
	fsw	f28, 28 * 4(sp)
	fsw	f29, 29 * 4(sp)
	fsw	f30, 30 * 4(sp)
	fsw	f31, 31 * 4(sp)
#elif(__riscv_flen == 64)
	addi	sp, sp, -32 * 8
	fsd	f0, 0 * 8(sp)
	fsd	f1, 1 * 8(sp)
	fsd	f2, 2 * 8(sp)
	fsd	f3, 3 * 8(sp)
	fsd	f4, 4 * 8(sp)
	fsd	f5, 5 * 8(sp)
	fsd	f6, 6 * 8(sp)
	fsd	f7, 7 * 8(sp)
	fsd	f8, 8 * 8(sp)
	fsd	f9, 9 * 8(sp)
	fsd	f10, 10 * 8(sp)
	fsd	f11, 11 * 8(sp)
	fsd	f12, 12 * 8(sp)
	fsd	f13, 13 * 8(sp)
	fsd	f14, 14 * 8(sp)
	fsd	f15, 15 * 8(sp)
	fsd	f16, 16 * 8(sp)
	fsd	f17, 17 * 8(sp)
	fsd	f18, 18 * 8(sp)
	fsd	f19, 19 * 8(sp)
	fsd	f20, 20 * 8(sp)
	fsd	f21, 21 * 8(sp)
	fsd	f22, 22 * 8(sp)
	fsd	f23, 23 * 8(sp)
	fsd	f24, 24 * 8(sp)
	fsd	f25, 25 * 8(sp)
	fsd	f26, 26 * 8(sp)
	fsd	f27, 27 * 8(sp)
	fsd	f28, 28 * 8(sp)
	fsd	f29, 29 * 8(sp)
	fsd	f30, 30 * 8(sp)
	fsd	f31, 31 * 8(sp)
#endif

#ifdef __riscv_dsp
	//
	// DSP register saving
	//
	addi	sp, sp, -12 // dpad
	
	addi	sp, sp, -4
	csrr	t1, CSR_UCODE
	sw	t1, 0(sp)
#endif

	// if(!gNestLayer)
	bnez	s4, context_saved_trap
	
	// Save context
	mv	a0, sp
	call	saveContext
	
context_saved_trap:
	// gNestLayer ++
	addi	s4, s4, +1
	sw	s4, 0(s3)
	
	//- MSTATUS[3] MIE
	csrsi	mstatus, 0x8
	//----------------------//
	//- Preemption enabled -//
	
	mv	a0, s2 // mcause
	mv	a1, sp // context
	call trap_exception_isr
	
	//- MSTATUS[3] MIE
	csrci	mstatus, 0x8
	//- Preemption disable -//
	//----------------------//
	
	// gNestLayer --
	addi	s4, s4, -1
	sw	s4, 0(s3)
	bnez	s4, context_recovered_trap
	
	// Recover context
	mv	a0, sp
	call recoverContext
	
context_recovered_trap:

#ifdef __riscv_dsp
	//
	// DSP register poping
	//
	lw	t1, 0(sp)
	csrw	CSR_UCODE, t1
	addi	sp, sp, +4
	
	addi	sp, sp, +12 // dpad
#endif

	//
	// Floating register poping
	//
#if(__riscv_flen == 32)
	flw	f0, 0 * 4(sp)
	flw	f1, 1 * 4(sp)
	flw	f2, 2 * 4(sp)
	flw	f3, 3 * 4(sp)
	flw	f4, 4 * 4(sp)
	flw	f5, 5 * 4(sp)
	flw	f6, 6 * 4(sp)
	flw	f7, 7 * 4(sp)
	flw	f8, 8 * 4(sp)
	flw	f9, 9 * 4(sp)
	flw	f10, 10 * 4(sp)
	flw	f11, 11 * 4(sp)
	flw	f12, 12 * 4(sp)
	flw	f13, 13 * 4(sp)
	flw	f14, 14 * 4(sp)
	flw	f15, 15 * 4(sp)
	flw	f16, 16 * 4(sp)
	flw	f17, 17 * 4(sp)
	flw	f18, 18 * 4(sp)
	flw	f19, 19 * 4(sp)
	flw	f20, 20 * 4(sp)
	flw	f21, 21 * 4(sp)
	flw	f22, 22 * 4(sp)
	flw	f23, 23 * 4(sp)
	flw	f24, 24 * 4(sp)
	flw	f25, 25 * 4(sp)
	flw	f26, 26 * 4(sp)
	flw	f27, 27 * 4(sp)
	flw	f28, 28 * 4(sp)
	flw	f29, 29 * 4(sp)
	flw	f30, 30 * 4(sp)
	flw	f31, 31 * 4(sp)
	addi	sp, sp, +32 * 4
#elif(__riscv_flen == 64)
	fld	f0, 0 * 8(sp)
	fld	f1, 1 * 8(sp)
	fld	f2, 2 * 8(sp)
	fld	f3, 3 * 8(sp)
	fld	f4, 4 * 8(sp)
	fld	f5, 5 * 8(sp)
	fld	f6, 6 * 8(sp)
	fld	f7, 7 * 8(sp)
	fld	f8, 8 * 8(sp)
	fld	f9, 9 * 8(sp)
	fld	f10, 10 * 8(sp)
	fld	f11, 11 * 8(sp)
	fld	f12, 12 * 8(sp)
	fld	f13, 13 * 8(sp)
	fld	f14, 14 * 8(sp)
	fld	f15, 15 * 8(sp)
	fld	f16, 16 * 8(sp)
	fld	f17, 17 * 8(sp)
	fld	f18, 18 * 8(sp)
	fld	f19, 19 * 8(sp)
	fld	f20, 20 * 8(sp)
	fld	f21, 21 * 8(sp)
	fld	f22, 22 * 8(sp)
	fld	f23, 23 * 8(sp)
	fld	f24, 24 * 8(sp)
	fld	f25, 25 * 8(sp)
	fld	f26, 26 * 8(sp)
	fld	f27, 27 * 8(sp)
	fld	f28, 28 * 8(sp)
	fld	f29, 29 * 8(sp)
	fld	f30, 30 * 8(sp)
	fld	f31, 31 * 8(sp)
	addi	sp, sp, +32 * 8
#endif

#if(__riscv_flen)
	lw	t1, 0(sp)
	csrw	fcsr, t1
	addi	sp, sp, +4
	
	addi	sp, sp, +12 // fpad
#endif

	// Resume pc address
	lw	t1, 0(sp)
	csrw	mepc, t1
	addi	sp, sp, +4
	
	// Remain in M-mode after mret
	li	t1, 0x1800 // MSTATUS[12:11] MPP = Machine Mode
	csrs	mstatus, t1
	
	//
	// Generic register poping
	//
	lw	x1, 0 * 4(sp) // x1 ra
	lw	x3, 2 * 4(sp) // x3 gp
	lw	x4, 3 * 4(sp) // x4 tp
	lw	x5, 4 * 4(sp) // x5 t0
	lw	x6, 5 * 4(sp) // x6 t1
	lw	x7, 6 * 4(sp) // x7 t2
	lw	x8, 7 * 4(sp) // x8 s0/fp
	lw	x9, 8 * 4(sp) // x9 s1
	lw	x10, 9 * 4(sp) // x10 a0
	lw	x11, 10 * 4(sp) // x11 a1
	lw	x12, 11 * 4(sp) // x12 a2
	lw	x13, 12 * 4(sp) // x13 a3
	lw	x14, 13 * 4(sp) // x14 a4
	lw	x15, 14 * 4(sp) // x15 a5
	lw	x16, 15 * 4(sp) // x16 a6
	lw	x17, 16 * 4(sp) // x17 a7
	lw	x18, 17 * 4(sp) // x18 s2
	lw	x19, 18 * 4(sp) // x19 s3
	lw	x20, 19 * 4(sp) // x20 s4
	lw	x21, 20 * 4(sp) // x21 s5
	lw	x22, 21 * 4(sp) // x22 s6
	lw	x23, 22 * 4(sp) // x23 s7
	lw	x24, 23 * 4(sp) // x24 s8
	lw	x25, 24 * 4(sp) // x25 s9
	lw	x26, 25 * 4(sp) // x26 s10
	lw	x27, 26 * 4(sp) // x27 s11
	lw	x28, 27 * 4(sp) // x28 t3
	lw	x29, 28 * 4(sp) // x29 t4
	lw	x30, 29 * 4(sp) // x30 t5
	lw	x31, 30 * 4(sp) // x31 t6
	
	lw	x2, 1 * 4(sp) // x2 sp
	
	fence io, io
	mret


.macro VECTORED_IRQ irq

.weak default_isr_\irq
default_isr_\irq:
	ret

.global vectored_irq_\irq
vectored_irq_\irq:
	csrw	mscratch, sp
	
	// if(!gCurrentTask)
	la	sp, gCurrentTask
	lw	sp, 0(sp)
	beqz	sp, stack_nested_34
	
	// if(!gNestLayer)
	la	sp, gNestLayer
	lw	sp, 0(sp)
	bnez	sp, stack_nested_34
	
	// gSchedtoTask = NULL
	la	sp, gSchedtoTask
	sw	zero, 0(sp)
	
	la	sp, _stack
	j	stack_ready_34
	
stack_nested_\irq:
	csrr	sp, mscratch
	
stack_ready_\irq:
	//
	// Generic register saving
	//
	addi	sp, sp, -31 * 4
	sw	x1, 0 * 4(sp) // x1 ra
	sw	x3, 2 * 4(sp) // x3 gp
	sw	x4, 3 * 4(sp) // x4 tp
	sw	x5, 4 * 4(sp) // x5 t0
	sw	x6, 5 * 4(sp) // x6 t1
	sw	x7, 6 * 4(sp) // x7 t2
	sw	x8, 7 * 4(sp) // x8 s0/fp
	sw	x9, 8 * 4(sp) // x9 s1
	sw	x10, 9 * 4(sp) // x10 a0
	sw	x11, 10 * 4(sp) // x11 a1
	sw	x12, 11 * 4(sp) // x12 a2
	sw	x13, 12 * 4(sp) // x13 a3
	sw	x14, 13 * 4(sp) // x14 a4
	sw	x15, 14 * 4(sp) // x15 a5
	sw	x16, 15 * 4(sp) // x16 a6
	sw	x17, 16 * 4(sp) // x17 a7
	sw	x18, 17 * 4(sp) // x18 s2
	sw	x19, 18 * 4(sp) // x19 s3
	sw	x20, 19 * 4(sp) // x20 s4
	sw	x21, 20 * 4(sp) // x21 s5
	sw	x22, 21 * 4(sp) // x22 s6
	sw	x23, 22 * 4(sp) // x23 s7
	sw	x24, 23 * 4(sp) // x24 s8
	sw	x25, 24 * 4(sp) // x25 s9
	sw	x26, 25 * 4(sp) // x26 s10
	sw	x27, 26 * 4(sp) // x27 s11
	sw	x28, 27 * 4(sp) // x28 t3
	sw	x29, 28 * 4(sp) // x29 t4
	sw	x30, 29 * 4(sp) // x30 t5
	sw	x31, 30 * 4(sp) // x31 t6
	
	csrr	t1, mscratch
	sw	t1, 1 * 4(sp) // x2 sp
	
	// Resume pc address
	csrr	t1, mepc
	addi	sp, sp, -4
	sw	t1, 0(sp)
	
	//
	// Floating register saving
	//
#if(__riscv_flen)
	addi	sp, sp, -12 // fpad
	
	addi	sp, sp, -4
	csrr	t1, fcsr
	sw	t1, 0(sp)
#endif

#if(__riscv_flen == 32)
	addi	sp, sp, -32 * 4
	fsw	f0, 0 * 4(sp)
	fsw	f1, 1 * 4(sp)
	fsw	f2, 2 * 4(sp)
	fsw	f3, 3 * 4(sp)
	fsw	f4, 4 * 4(sp)
	fsw	f5, 5 * 4(sp)
	fsw	f6, 6 * 4(sp)
	fsw	f7, 7 * 4(sp)
	fsw	f8, 8 * 4(sp)
	fsw	f9, 9 * 4(sp)
	fsw	f10, 10 * 4(sp)
	fsw	f11, 11 * 4(sp)
	fsw	f12, 12 * 4(sp)
	fsw	f13, 13 * 4(sp)
	fsw	f14, 14 * 4(sp)
	fsw	f15, 15 * 4(sp)
	fsw	f16, 16 * 4(sp)
	fsw	f17, 17 * 4(sp)
	fsw	f18, 18 * 4(sp)
	fsw	f19, 19 * 4(sp)
	fsw	f20, 20 * 4(sp)
	fsw	f21, 21 * 4(sp)
	fsw	f22, 22 * 4(sp)
	fsw	f23, 23 * 4(sp)
	fsw	f24, 24 * 4(sp)
	fsw	f25, 25 * 4(sp)
	fsw	f26, 26 * 4(sp)
	fsw	f27, 27 * 4(sp)
	fsw	f28, 28 * 4(sp)
	fsw	f29, 29 * 4(sp)
	fsw	f30, 30 * 4(sp)
	fsw	f31, 31 * 4(sp)
#elif(__riscv_flen == 64)
	addi	sp, sp, -32 * 8
	fsd	f0, 0 * 8(sp)
	fsd	f1, 1 * 8(sp)
	fsd	f2, 2 * 8(sp)
	fsd	f3, 3 * 8(sp)
	fsd	f4, 4 * 8(sp)
	fsd	f5, 5 * 8(sp)
	fsd	f6, 6 * 8(sp)
	fsd	f7, 7 * 8(sp)
	fsd	f8, 8 * 8(sp)
	fsd	f9, 9 * 8(sp)
	fsd	f10, 10 * 8(sp)
	fsd	f11, 11 * 8(sp)
	fsd	f12, 12 * 8(sp)
	fsd	f13, 13 * 8(sp)
	fsd	f14, 14 * 8(sp)
	fsd	f15, 15 * 8(sp)
	fsd	f16, 16 * 8(sp)
	fsd	f17, 17 * 8(sp)
	fsd	f18, 18 * 8(sp)
	fsd	f19, 19 * 8(sp)
	fsd	f20, 20 * 8(sp)
	fsd	f21, 21 * 8(sp)
	fsd	f22, 22 * 8(sp)
	fsd	f23, 23 * 8(sp)
	fsd	f24, 24 * 8(sp)
	fsd	f25, 25 * 8(sp)
	fsd	f26, 26 * 8(sp)
	fsd	f27, 27 * 8(sp)
	fsd	f28, 28 * 8(sp)
	fsd	f29, 29 * 8(sp)
	fsd	f30, 30 * 8(sp)
	fsd	f31, 31 * 8(sp)
#endif

#ifdef __riscv_dsp
	//
	// DSP register saving
	//
	addi	sp, sp, -12 // dpad
	
	addi	sp, sp, -4
	csrr	t1, CSR_UCODE
	sw	t1, 0(sp)
#endif

	// if(!gNestLayer)
	la	s1, gNestLayer
	lw	s2, 0(s1)
	bnez	s2, context_saved_\irq
	
	// Save context
	mv	a0, sp
	call	saveContext
	
context_saved_\irq:
	// gNestLayer ++
	addi	s2, s2, +1
	sw	s2, 0(s1)
	
	//- MSTATUS[3] MIE = 1
	csrsi	mstatus, 0x8
	//----------------------//
	//- Preemption enabled -//
	
	call	default_isr_\irq
	
	//- MSTATUS[3] MIE = 0
	csrci	mstatus, 0x8
	//- Preemption disable -//
	//----------------------//
	
	// gNestLayer --
	addi	s2, s2, -1
	sw	s2, 0(s1)
	bnez	s2, context_recovered_\irq
	
	// Recover context
	mv	a0, sp
	call recoverContext
	
context_recovered_\irq:

#ifdef __riscv_dsp
	//
	// DSP register poping
	//
	lw	t1, 0(sp)
	csrw	CSR_UCODE, t1
	addi	sp, sp, +4
	
	addi	sp, sp, +12 // dpad
#endif

	//
	// Floating register poping
	//
#if(__riscv_flen == 32)
	flw	f0, 0 * 4(sp)
	flw	f1, 1 * 4(sp)
	flw	f2, 2 * 4(sp)
	flw	f3, 3 * 4(sp)
	flw	f4, 4 * 4(sp)
	flw	f5, 5 * 4(sp)
	flw	f6, 6 * 4(sp)
	flw	f7, 7 * 4(sp)
	flw	f8, 8 * 4(sp)
	flw	f9, 9 * 4(sp)
	flw	f10, 10 * 4(sp)
	flw	f11, 11 * 4(sp)
	flw	f12, 12 * 4(sp)
	flw	f13, 13 * 4(sp)
	flw	f14, 14 * 4(sp)
	flw	f15, 15 * 4(sp)
	flw	f16, 16 * 4(sp)
	flw	f17, 17 * 4(sp)
	flw	f18, 18 * 4(sp)
	flw	f19, 19 * 4(sp)
	flw	f20, 20 * 4(sp)
	flw	f21, 21 * 4(sp)
	flw	f22, 22 * 4(sp)
	flw	f23, 23 * 4(sp)
	flw	f24, 24 * 4(sp)
	flw	f25, 25 * 4(sp)
	flw	f26, 26 * 4(sp)
	flw	f27, 27 * 4(sp)
	flw	f28, 28 * 4(sp)
	flw	f29, 29 * 4(sp)
	flw	f30, 30 * 4(sp)
	flw	f31, 31 * 4(sp)
	addi	sp, sp, +32 * 4
#elif(__riscv_flen == 64)
	fld	f0, 0 * 8(sp)
	fld	f1, 1 * 8(sp)
	fld	f2, 2 * 8(sp)
	fld	f3, 3 * 8(sp)
	fld	f4, 4 * 8(sp)
	fld	f5, 5 * 8(sp)
	fld	f6, 6 * 8(sp)
	fld	f7, 7 * 8(sp)
	fld	f8, 8 * 8(sp)
	fld	f9, 9 * 8(sp)
	fld	f10, 10 * 8(sp)
	fld	f11, 11 * 8(sp)
	fld	f12, 12 * 8(sp)
	fld	f13, 13 * 8(sp)
	fld	f14, 14 * 8(sp)
	fld	f15, 15 * 8(sp)
	fld	f16, 16 * 8(sp)
	fld	f17, 17 * 8(sp)
	fld	f18, 18 * 8(sp)
	fld	f19, 19 * 8(sp)
	fld	f20, 20 * 8(sp)
	fld	f21, 21 * 8(sp)
	fld	f22, 22 * 8(sp)
	fld	f23, 23 * 8(sp)
	fld	f24, 24 * 8(sp)
	fld	f25, 25 * 8(sp)
	fld	f26, 26 * 8(sp)
	fld	f27, 27 * 8(sp)
	fld	f28, 28 * 8(sp)
	fld	f29, 29 * 8(sp)
	fld	f30, 30 * 8(sp)
	fld	f31, 31 * 8(sp)
	addi	sp, sp, +32 * 8
#endif

#if(__riscv_flen)
	lw	t1, 0(sp)
	csrw	fcsr, t1
	addi	sp, sp, +4
	
	addi	sp, sp, +12 // fpad
#endif

	// Resume pc address
	lw	t1, 0(sp)
	csrw	mepc, t1
	addi	sp, sp, +4
	
	// Remain in M-mode after mret
	li	t1, 0x1800 // MSTATUS[12:11] MPP = Machine Mode
	csrs	mstatus, t1
	
	//
	// Generic register poping
	//
	lw	x1, 0 * 4(sp) // x1 ra
	lw	x3, 2 * 4(sp) // x3 gp
	lw	x4, 3 * 4(sp) // x4 tp
	lw	x5, 4 * 4(sp) // x5 t0
	lw	x6, 5 * 4(sp) // x6 t1
	lw	x7, 6 * 4(sp) // x7 t2
	lw	x8, 7 * 4(sp) // x8 s0/fp
	lw	x9, 8 * 4(sp) // x9 s1
	lw	x10, 9 * 4(sp) // x10 a0
	lw	x11, 10 * 4(sp) // x11 a1
	lw	x12, 11 * 4(sp) // x12 a2
	lw	x13, 12 * 4(sp) // x13 a3
	lw	x14, 13 * 4(sp) // x14 a4
	lw	x15, 14 * 4(sp) // x15 a5
	lw	x16, 15 * 4(sp) // x16 a6
	lw	x17, 16 * 4(sp) // x17 a7
	lw	x18, 17 * 4(sp) // x18 s2
	lw	x19, 18 * 4(sp) // x19 s3
	lw	x20, 19 * 4(sp) // x20 s4
	lw	x21, 20 * 4(sp) // x21 s5
	lw	x22, 21 * 4(sp) // x22 s6
	lw	x23, 22 * 4(sp) // x23 s7
	lw	x24, 23 * 4(sp) // x24 s8
	lw	x25, 24 * 4(sp) // x25 s9
	lw	x26, 25 * 4(sp) // x26 s10
	lw	x27, 26 * 4(sp) // x27 s11
	lw	x28, 27 * 4(sp) // x28 t3
	lw	x29, 28 * 4(sp) // x29 t4
	lw	x30, 29 * 4(sp) // x30 t5
	lw	x31, 30 * 4(sp) // x31 t6
	
	lw	x2, 1 * 4(sp) // x2 sp
	
	fence io, io
	mret
.endm

	VECTORED_IRQ 1
	VECTORED_IRQ 2
	VECTORED_IRQ 3
	VECTORED_IRQ 4
	VECTORED_IRQ 5
	VECTORED_IRQ 6
	VECTORED_IRQ 7
	VECTORED_IRQ 8
	VECTORED_IRQ 9
	VECTORED_IRQ 10
	VECTORED_IRQ 11
	VECTORED_IRQ 12
	VECTORED_IRQ 13
	VECTORED_IRQ 14
	VECTORED_IRQ 15
	VECTORED_IRQ 16
	VECTORED_IRQ 17
	VECTORED_IRQ 18
	VECTORED_IRQ 19
	VECTORED_IRQ 20
	VECTORED_IRQ 21
	VECTORED_IRQ 22
	VECTORED_IRQ 23
	VECTORED_IRQ 24
	VECTORED_IRQ 25
	VECTORED_IRQ 26
	VECTORED_IRQ 27
	VECTORED_IRQ 28
	VECTORED_IRQ 29
	VECTORED_IRQ 30
	VECTORED_IRQ 31
	VECTORED_IRQ 32
	VECTORED_IRQ 33
	VECTORED_IRQ 34
	VECTORED_IRQ 35
	VECTORED_IRQ 36
	VECTORED_IRQ 37
	VECTORED_IRQ 38
	VECTORED_IRQ 39
	VECTORED_IRQ 40
	VECTORED_IRQ 41
	VECTORED_IRQ 42
	VECTORED_IRQ 43
	VECTORED_IRQ 44
	VECTORED_IRQ 45
	VECTORED_IRQ 46
	VECTORED_IRQ 47
	VECTORED_IRQ 48
	VECTORED_IRQ 49
	VECTORED_IRQ 50
	VECTORED_IRQ 51
	VECTORED_IRQ 52
	VECTORED_IRQ 53
	VECTORED_IRQ 54
	VECTORED_IRQ 55
	VECTORED_IRQ 56
	VECTORED_IRQ 57
	VECTORED_IRQ 58
	VECTORED_IRQ 59
	VECTORED_IRQ 60
	VECTORED_IRQ 61
	VECTORED_IRQ 62
	VECTORED_IRQ 63
	VECTORED_IRQ 64
	VECTORED_IRQ 65
	VECTORED_IRQ 66
	VECTORED_IRQ 67
	VECTORED_IRQ 68
	VECTORED_IRQ 69
	VECTORED_IRQ 70
	VECTORED_IRQ 71
	VECTORED_IRQ 72
	VECTORED_IRQ 73
	VECTORED_IRQ 74
	VECTORED_IRQ 75
	VECTORED_IRQ 76
	VECTORED_IRQ 77
	VECTORED_IRQ 78


.global sysCall
sysCall:
	ecall
	ret
