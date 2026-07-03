#include <asm_sprt.h>
 
.extern array1.;
.extern array2.;
.extern add_two_array.;

.extern multiplication.;

.extern expression.;
.extern transfer_data.;

.section/pm seg_pmco;
.type add_two_array., STT_FUNC;
.type expression., STT_FUNC;
.type transfer_data., STT_FUNC;
.type multiplication., STT_FUNC;

add_two_array.:
entry;
save_reg;
i1 = r4;
i2 = r8;
i3 = r12;
r5 = 5;
lcntr = r5; do loop_ctr until lce;
 
r2 = dm(i1 , m6);
r3 = dm(i2 , m6);
 
r0 = r2 + r3;
 
loop_ctr: dm(i3 , m6) = r0;
restore_reg;
exit;
.add_two_array..end:  
 
multiplication.:
entry;

r0 = 0;
r0 = r4 * r8(ssi);

exit;
.multiplication..END:
 
expression.:
entry;

	r1 = r4;
	r2 = r8;
	r3 = r12;
	r4 = reads(1);
	r5 = reads(2);
	r6 = reads(3);
	r13 = r1 + r2;
	r14 = r3 - r4;
	r15 = r5 - r6;
    r0 = 0;
	r0 = r0 + r13;
	r0 = r0 + r14;
	r0 = r0 - r15;

exit;
.expression..END:
 
 
transfer_data.:
entry;

r0 = r4;

exit;
.transfer_data..end:
