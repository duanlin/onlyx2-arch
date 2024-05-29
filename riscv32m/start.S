/*
 * Copyright (c) 2021-2023 HPMicro
 *
 * SPDX-License-Identifier: BSD-3-Clause
 *
 */
#include "hpm_csr_regs.h"


.section .start, "ax"

.global _start
_start:
	/* Initialize global pointer */
	mv	gp, zero
	mv	tp, zero
	
	/* reset mstatus mscratch to 0 */
	csrw mstatus, zero
	csrw mscratch, zero
	
#ifdef __riscv_flen
	/* Enable FPU */
	li t0, CSR_MSTATUS_FS_MASK
	csrrs t0, mstatus, t0
	
	/* Initialize FCSR */
	fscsr zero
#endif

	/* Initialize stack pointer */
	la t1, _stack
	mv sp, t1
	
	/* System initialize */
	call _init
	bnez	a0, _exit
	
	/* Initial machine trap-vector Base */
	la t0, _vector
	csrw mtvec, t0
	
	/* Enable vectored external PLIC interrupt */
	csrsi CSR_MMISC_CTL, 2
	
	/* System main */
	call _main
	
.weak _exit
.type _exit, @function
_exit:
	call _exit
