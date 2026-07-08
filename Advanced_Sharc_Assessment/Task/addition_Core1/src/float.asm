
/*

.global fix_to_float_conversion.;
 
fix_to_float_conversion.:
	i4 = r4;
	r2 = r8;	
	r1 = r12;	 
	r1 = r2*r1(ssi);
	r1 = lshift r1 by -1;
	
	bit set MODE1 BITM_REGF_MODE1_PEYEN;
	nop;
	 
	nop;
	
	r2 = -31;
	 
	lcntr = r1, do fixtofloat until lce;
	 
	r4= dm(i4,m5);
	 
	f4 =float r4 by r2;
	 
	fixtofloat:dm(14,2) = f4;
	 
	bit clr MODE1 BITM_REGF_MODE1_PEYEN;
	 
	nop;
	 
	nop;
	 
	i12=dm(m7,16);
	 
	jump (m14,i12) (db); rframe; nop;
 
fix_to_float_conversion..end:




*/