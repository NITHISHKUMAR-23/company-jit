#include <asm_sprt.h>
#include "def21593.h"

.section/DM  seg_dmda;
  
.var save.;
.endseg;

.section/sw seg_swco;

.global copy.;
.type copy.,STT_FUNC;



copy.:

/*entry;
b4 = r4;
b5 = r8;
m2 = 2;
bit set MODE1 BITM_REGF_MODE1_PEYEN;  // simd enable

lcntr = r12, do copy until lce;

	r0 = dm(i4,m5);
copy: dm(i5,2) = r0; 

exit;*/

/*entry;

 b4 = r4;
 i4 = b4;
 l4 = 24;
 
 b5 = r8;

r0 = 0;
r1 = 7;
f1 = reads(1);
 bit set MODE1 BITM_REGF_MODE1_CBUFEN;  // circular buffer enable
 
 lcntr = 8, do change until lce;
 r0 = r0 AND r1;
 i4 = b4;
 m0 = r0; 
 r8 = dm(i4,m0);
 	lcntr = 6, do copy until lce;
 	r8 = dm(i4,8);
 	copy: dm(i5,m6) = r8;
change: r0 = r0+1;
exit;*/
/*************mela irukuratha lam reference ahh summa vachiko circular buffer and SIMD example dhan athuvum************/
entry;

dm(save.) = i5;
i4 = r4;
i5 = r8;
i3 = r12;
m2 = 2;
bit set mode1 BITM_REGF_MODE1_PEYEN;
lcntr = 5,do multiply until lce;  // lcntr = 5 because of SIMD // in SIMD the S register is a background register that will fetch the next location of the r register.
		r1 = dm(i4,m2);		  // r1 = 1; s1 = 2;
		r2 = dm(i5,m2);		  // r2 = 2; s2 = 2;
		r0 = r1*r2(ssi);	  // r0 = r1*r2;  s0 = s1*s2; 
multiply: dm(i3,m2) = r0;         //result[0] = r0 ; result[1] = s0;

bit clr mode1 BITM_REGF_MODE1_PEYEN;
i5 = dm(save.);
exit;
.copy..end:
.endseg;


.global cicrcular_buffer_copy.;
.type cicrcular_buffer_copy.,STT_FUNC;

.section/pm seg_pmco;
cicrcular_buffer_copy.:
entry;
b1 = r4;
i1 = b1;
l1 = r12;

i5 = r8;
r2 = reads(1);
bit set MODE1 BITM_REGF_MODE1_CBUFEN;

lcntr = r2,do circular_copy until lce;

	r0 = dm(i1,m6);
circular_copy: dm(i5,m6) = r0;

bit clr MODE1 BITM_REGF_MODE1_CBUFEN;
exit;
.cicrcular_buffer_copy..end:
.endseg;
