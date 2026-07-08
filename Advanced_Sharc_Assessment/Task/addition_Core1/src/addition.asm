#include <asm_sprt.h>
.extern sub.;
.extern add.;
.section/pm seg_pmco;
.type add., STT_FUNC;
//.var result.;
add.:
entry;
f0 = f4 + f8;
f4 = f0;
f2 = f0;
call sub.;
//dm(result.)=f0;
f0 = f2;
exit;
.add..END: