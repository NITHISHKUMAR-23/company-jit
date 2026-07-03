.extern add.;
.section/sw seg_swco;
.global add.;
.type add., STT_FUNC;
add.:
   i0=r4;
   i1=r8;
   i2=r3;
   
   r3=r4+r8;
   
    jump (m14, i12) (db); rframe; nop;
.add..END:



 