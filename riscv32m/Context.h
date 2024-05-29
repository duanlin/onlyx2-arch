#ifndef CONTEXT_H
#define CONTEXT_H


#include <stdint.h>


#ifdef __cplusplus
extern "C"
{
#endif


typedef struct
{
#ifdef __riscv_dsp
	uint32_t ucode;      /* ucode */
	uint32_t dpad[3];    /* stack alignment */
#endif

#if(__riscv_flen == 64)
	double f0;      /* f0  */
	double f1;      /* f1  */
	double f2;      /* f2  */
	double f3;      /* f3  */
	double f4;      /* f4  */
	double f5;      /* f5  */
	double f6;      /* f6  */
	double f7;      /* f7  */
	double f8;      /* f8  */
	double f9;      /* f9  */
	double f10;     /* f10 */
	double f11;     /* f11 */
	double f12;     /* f12 */
	double f13;     /* f13 */
	double f14;     /* f14 */
	double f15;     /* f15 */
	double f16;     /* f16 */
	double f17;     /* f17 */
	double f18;     /* f18 */
	double f19;     /* f19 */
	double f20;     /* f20 */
	double f21;     /* f21 */
	double f22;     /* f22 */
	double f23;     /* f23 */
	double f24;     /* f24 */
	double f25;     /* f25 */
	double f26;     /* f26 */
	double f27;     /* f27 */
	double f28;     /* f28 */
	double f29;     /* f29 */
	double f30;     /* f30 */
	double f31;     /* f31 */

	uint32_t fcsr;       /* fcsr */
	uint32_t fpad[3];    /* stack alignment */

#elif(__riscv_flen == 32)
	float f0;      /* f0  */
	float f1;      /* f1  */
	float f2;      /* f2  */
	float f3;      /* f3  */
	float f4;      /* f4  */
	float f5;      /* f5  */
	float f6;      /* f6  */
	float f7;      /* f7  */
	float f8;      /* f8  */
	float f9;      /* f9  */
	float f10;     /* f10 */
	float f11;     /* f11 */
	float f12;     /* f12 */
	float f13;     /* f13 */
	float f14;     /* f14 */
	float f15;     /* f15 */
	float f16;     /* f16 */
	float f17;     /* f17 */
	float f18;     /* f18 */
	float f19;     /* f19 */
	float f20;     /* f20 */
	float f21;     /* f21 */
	float f22;     /* f22 */
	float f23;     /* f23 */
	float f24;     /* f24 */
	float f25;     /* f25 */
	float f26;     /* f26 */
	float f27;     /* f27 */
	float f28;     /* f28 */
	float f29;     /* f29 */
	float f30;     /* f30 */
	float f31;     /* f31 */

	uint32_t fcsr;       /* fcsr */
	uint32_t fpad[3];    /* stack alignment */
#endif

	uint32_t pc;         /* pc - resume program counter */

	uint32_t ra;         /* x1  - ra     - return address for jumps            */
	uint32_t sp;         /* x2  - sp     - stack pointer                       */
	uint32_t gp;         /* x3  - gp     - global pointer                      */
	uint32_t tp;         /* x4  - tp     - thread pointer                      */
	uint32_t t0;         /* x5  - t0     - temporary register 0                */
	uint32_t t1;         /* x6  - t1     - temporary register 1                */
	uint32_t t2;         /* x7  - t2     - temporary register 2                */
	uint32_t s0_fp;      /* x8  - s0/fp  - saved register 0 or frame pointer   */
	uint32_t s1;         /* x9  - s1     - saved register 1                    */
	uint32_t a0;         /* x10 - a0     - return value or function argument 0 */
	uint32_t a1;         /* x11 - a1     - return value or function argument 1 */
	uint32_t a2;         /* x12 - a2     - function argument 2                 */
	uint32_t a3;         /* x13 - a3     - function argument 3                 */
	uint32_t a4;         /* x14 - a4     - function argument 4                 */
	uint32_t a5;         /* x15 - a5     - function argument 5                 */
	uint32_t a6;         /* x16 - a6     - function argument 6                 */
	uint32_t a7;         /* x17 - a7     - function argument 7                 */
	uint32_t s2;         /* x18 - s2     - saved register 2                    */
	uint32_t s3;         /* x19 - s3     - saved register 3                    */
	uint32_t s4;         /* x20 - s4     - saved register 4                    */
	uint32_t s5;         /* x21 - s5     - saved register 5                    */
	uint32_t s6;         /* x22 - s6     - saved register 6                    */
	uint32_t s7;         /* x23 - s7     - saved register 7                    */
	uint32_t s8;         /* x24 - s8     - saved register 8                    */
	uint32_t s9;         /* x25 - s9     - saved register 9                    */
	uint32_t s10;        /* x26 - s10    - saved register 10                   */
	uint32_t s11;        /* x27 - s11    - saved register 11                   */
	uint32_t t3;         /* x28 - t3     - temporary register 3                */
	uint32_t t4;         /* x29 - t4     - temporary register 4                */
	uint32_t t5;         /* x30 - t5     - temporary register 5                */
	uint32_t t6;         /* x31 - t6     - temporary register 6                */

} Context;


extern unsigned gNestLayer;


void saveContext(const Context* context);
void recoverContext(Context* context);


#ifdef __cplusplus
}
#endif


#endif
