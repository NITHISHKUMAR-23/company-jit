#include "asm_sprt.h"
#include "def21569.h"

.section/sw  seg_swco;
.global swap.;
.type swap., STT_FUNC;

swap.:
entry;
i4 = r4;
r0 = 256;
r1 = 0;
r2 = 0;
r8 = 0;
lcntr = r0, do swap until lce;

	r1 = dm(i4,0);
	r2 = dm(1,i4);
	dm(i4,0) = r2;
	dm(1,i4) = r1;
	swap:
	r8 = dm(i4,16); 

exit;

.swap..end:
