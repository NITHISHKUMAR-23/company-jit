#include <asm_sprt.h>
.extern add.;
.section/pm seg_opmco;
.type add., STT_FUNC;

add.:
entry;
r0=r4+r8;
exit;
.add..END: