# 1 "..\\system\\startup_ldf\\app_heaptab.c"


 















 

# 29 "..\\system\\startup_ldf\\app_heaptab.c"

#pragma file_attr("libData=HeapTable")

# 1 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\stdlib.h"






 
#pragma once
#pragma system_header  
#pragma standard_header  




# 47 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\stdlib.h"


#pragma default_addressed(push)


# 59 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\stdlib.h"













  typedef long unsigned int size_t;




  typedef int wchar_t;







 



# 1 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\stdlib_21xxx.h"






 








 

#pragma once
#pragma system_header





# 41 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\stdlib_21xxx.h"


#pragma default_addressed(push)






 




  long double atold(const char *_nptr);























 




  long long llavg(long long _a, long long _b);
  long long llmax(long long _a, long long _b);
  long long llmin(long long _a, long long _b);
  long long llclip(long long _a, long long _b);



# 99 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\stdlib_21xxx.h"

# 1 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"








 







#pragma system_header  





# 1 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\sys/builtins_support.h"




 

#pragma system_header









#pragma default_addressed(push)







 
# 34 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\sys/builtins_support.h"

# 43 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\sys/builtins_support.h"


#pragma default_addressed(pop)






# 192 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"






# 214 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"


#pragma default_addressed(push)


# 226 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"






typedef int ptrdiff_t;





void * __builtin_memcpyDD(void * __a, const void * __b, size_t  __c);
__pm void * __builtin_memcpyPD(__pm void * __a, const void * __b, size_t  __c);
void * __builtin_memcpyDP(void * __a, const __pm void * __b, size_t  __c);
__pm void * __builtin_memcpyPP(__pm void * __a, const __pm void * __b, size_t  __c);
void * __builtin_memmoveDD(void * __a, const void * __b, size_t  __c);
__pm void * __builtin_memmovePD(__pm void * __a, const void * __b, size_t  __c);
void * __builtin_memmoveDP(void * __a, const __pm void * __b, size_t  __c);
__pm void * __builtin_memmovePP(__pm void * __a, const __pm void * __b, size_t  __c);
char * __builtin_strcpy(char * __a, const char * __b);
size_t  __builtin_strlen(const char * __a);
void * __builtin_va_start(const void * __a, size_t  __b);
float  __builtin_fabsf(float  __a);
long double  __builtin_fabs(long double  __a);
float  __builtin_fminf(float  __a, float  __b);
float  __builtin_fmaxf(float  __a, float  __b);
int  __builtin_abs(int  __a);
long  __builtin_labs(long  __a);
int  __builtin_expected_true(int  __a);
int  __builtin_expected_false(int  __a);
void __builtin_assert(int  __a);
void __builtin_aligned(const void * __a, int  __b);
int  __builtin_funcsize(const void * __a);
ptrdiff_t  __builtin_circindex(ptrdiff_t  __a, ptrdiff_t  __b, size_t  __c);
void * __builtin_circptr(const void * __a, ptrdiff_t  __b, const void * __c, size_t  __d);
void __builtin_pm_aligned(const __pm void * __a, int  __b);
int  __builtin_byteswap4(int  __a);
int  __builtin_max(int  __a, int  __b);
long  __builtin_lmax(long  __a, long  __b);
int  __builtin_min(int  __a, int  __b);
long  __builtin_lmin(long  __a, long  __b);
void * __builtin_alloca(size_t  __a);
void * __builtin_dealloca(size_t  __a);



int  __builtin_conv_FtoR(float  __a);
int  __builtin_RxItoI(int  __a, int  __b);
unsigned int  __builtin_llleftz(unsigned long long  __a);
unsigned int  __builtin_lllefto(unsigned long long  __a);
void  __builtin_sysreg_write_nop(int  __a, unsigned int  __b);
void  __builtin_sysreg_bit_set_nop(int  __a, unsigned int  __b);
void  __builtin_sysreg_bit_clr_nop(int  __a, unsigned int  __b);
void  __builtin_sysreg_bit_tgl_nop(int  __a, unsigned int  __b);
void  __builtin_NOP(void);
int  __builtin_avg(int  __a, int  __b);
long  __builtin_lavg(long  __a, long  __b);
int  __builtin_clip(int  __a, int  __b);
long  __builtin_lclip(long  __a, long  __b);
float  __builtin_faddsubf_r1(float  __a, float  __b);
float  __builtin_faddsubf_r2(float  __a);
float  __builtin_faddabsf(float  __a, float  __b);
float  __builtin_fsubabsf(float  __a, float  __b);
float  __builtin_favgf(float  __a, float  __b);
float  __builtin_copysignf(float  __a, float  __b);
float  __builtin_fsignf(float  __a, float  __b);
float  __builtin_fscalbf(float  __a, int  __b);
int  __builtin_mantf(float  __a);
int  __builtin_logbf(float  __a);
int  __builtin_conv_fix_by(float  __a, int  __b);
int  __builtin_conv_fix(float  __a);
int  __builtin_conv_trunc_by(float  __a, int  __b);
float  __builtin_conv_float_by(int  __a, int  __b);
float  __builtin_frecipsf(float  __a);
float  __builtin_frsqrtsf(float  __a);
float  __builtin_fclipf(float  __a, float  __b);
# 468 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"
unsigned int  __builtin_leftz(unsigned int  __a);
unsigned int  __builtin_lefto(unsigned int  __a);
int  __builtin_fpack(float  __a);
float  __builtin_funpack(int  __a);



int  __builtin_load_exclusive_32_r2(unsigned int  __a);



int  __builtin_load_exclusive_64_r2(unsigned long long  __a);



int  __builtin_load_exclusive_8_r2(unsigned char  __a);



int  __builtin_load_exclusive_16_r2(unsigned short  __a);
# 500 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"
unsigned int  __builtin_sysreg_read(int  __a);
void  __builtin_sysreg_write(int  __a, unsigned int  __b);
int  __builtin_sysreg_bit_tst(int  __a, unsigned int  __b);
int  __builtin_sysreg_bit_tst_all(int  __a, unsigned int  __b);
int  __builtin_sysreg_bit_xor(int  __a, unsigned int  __b);
void  __builtin_sysreg_bit_set(int  __a, unsigned int  __b);
void  __builtin_sysreg_bit_clr(int  __a, unsigned int  __b);
void  __builtin_sysreg_bit_tgl(int  __a, unsigned int  __b);
unsigned long long  __builtin_emuclk(void);
void  __builtin_idle(void);
float  __builtin_conv_RtoF(int  __a);
int  __builtin_RxR(int  __a, int  __b);
int  __builtin_RxItoR(int  __a, int  __b);
long long  __builtin_compose_i64(int  __a, int  __b);
int  __builtin_sat_add(int  __a, int  __b);
int  __builtin_sat_sub(int  __a, int  __b);
unsigned int  __builtin_iop_read(volatile void * __a);
void __builtin_iop_write(volatile void * __a, unsigned int  __b);



# 537 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 554 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 571 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 588 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 598 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 608 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 623 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 633 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 643 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 653 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 663 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 683 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"







#pragma inline
#pragma always_inline
#pragma source_position_from_call_site
static int  max(int  __a, int  __b) {
  int  __rval;
  __rval = __builtin_max(__a, __b);
  return __rval;
}









#pragma inline
#pragma always_inline
#pragma source_position_from_call_site
static long  lmax(long  __a, long  __b) {
  long  __rval;
  __rval = __builtin_lmax(__a, __b);
  return __rval;
}









#pragma inline
#pragma always_inline
#pragma source_position_from_call_site
static int  min(int  __a, int  __b) {
  int  __rval;
  __rval = __builtin_min(__a, __b);
  return __rval;
}









#pragma inline
#pragma always_inline
#pragma source_position_from_call_site
static long  lmin(long  __a, long  __b) {
  long  __rval;
  __rval = __builtin_lmin(__a, __b);
  return __rval;
}



# 761 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 771 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 790 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 807 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 824 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 844 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 864 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 878 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 892 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 906 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 920 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 935 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"







#pragma inline
#pragma always_inline
#pragma source_position_from_call_site
static int  avg(int  __a, int  __b) {
  int  __rval;
  __rval = __builtin_avg(__a, __b);
  return __rval;
}









#pragma inline
#pragma always_inline
#pragma source_position_from_call_site
static long  lavg(long  __a, long  __b) {
  long  __rval;
  __rval = __builtin_lavg(__a, __b);
  return __rval;
}









#pragma inline
#pragma always_inline
#pragma source_position_from_call_site
static int  clip(int  __a, int  __b) {
  int  __rval;
  __rval = __builtin_clip(__a, __b);
  return __rval;
}









#pragma inline
#pragma always_inline
#pragma source_position_from_call_site
static long  lclip(long  __a, long  __b) {
  long  __rval;
  __rval = __builtin_lclip(__a, __b);
  return __rval;
}



# 1021 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1038 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1055 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1072 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1089 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1106 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1123 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1140 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1157 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1174 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1191 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1208 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1225 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1242 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1259 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1276 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1295 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1314 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1333 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1352 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1371 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1390 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1409 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1428 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1447 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1466 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1485 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1504 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1523 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1542 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1561 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1580 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1599 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1618 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1637 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1656 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1675 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1694 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1713 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1732 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1751 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1770 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1789 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1808 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1827 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1846 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1865 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1884 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1903 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1922 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1941 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1960 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1979 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1998 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2017 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2036 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2055 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2074 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2093 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2112 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2131 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2150 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2169 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2188 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2207 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2226 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2245 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2264 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2283 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2302 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2321 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2341 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2361 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2382 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2403 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2423 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2443 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2463 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2483 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2502 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2521 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2540 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2559 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2569 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2579 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2589 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2599 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2609 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2619 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2629 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2639 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2656 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2671 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2688 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2705 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2722 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2742 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2762 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2782 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2805 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2826 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"




#pragma default_addressed(pop)






# 101 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\stdlib_21xxx.h"



   
  #pragma inline
  #pragma always_inline
  long long llmax(long long _a, long long _b)
  {
    return ((_a < _b) ? _b : _a );
  }

  #pragma inline
  #pragma always_inline
  long long llmin(long long _a, long long _b)
  {
    return ((_a > _b) ? _b : _a );
  }











 




#pragma noreturn
#pragma misra_func(system)
  void  adi_fatal_error(int _general_code, int _specific_code, int _value);

#pragma noreturn
#pragma misra_func(system)
  void adi_fatal_exception(int _general_code, int _specific_code, int _value);












 




#pragma misra_func(heap)
#pragma function_name _heap_calloc
  void  *heap_calloc(int _heap_index, size_t _nelem, size_t _size);

#pragma misra_func(heap)
#pragma function_name _heap_free
  void   heap_free(int _heap_index, void *_ptr);

#pragma misra_func(heap)
#pragma function_name _heap_malloc
  void  *heap_malloc(int _heap_index, size_t _size);

#pragma misra_func(heap)
#pragma function_name _heap_realloc
  void  *heap_realloc(int _heap_index, void *_ptr, size_t _size);

#pragma misra_func(heap)
#pragma function_name _heap_install
  int    heap_install(void *_base, size_t _length, int _userid);

#pragma misra_func(heap)
#pragma function_name _heap_init
  int    heap_init(int _heap_index);

#pragma misra_func(heap)
#pragma function_name _heap_lookup
  int    heap_lookup(int _userid);







#pragma misra_func(heap)
#pragma function_name _heap_space_unused
  int    heap_space_unused(int _heap_index);

#pragma misra_func(heap)
#pragma function_name _space_unused
  int    space_unused(void);



 
typedef struct __heap_desc {
  void *base;
  size_t length;
  int userid;
} __heap_desc_t;


#pragma byte_addressed

extern const __heap_desc_t heap_table[];













 




  int count_ones(int _x);

  #pragma function_name count_ones
  int lcount_ones(long _x);

  int llcount_ones(long long _x);






#pragma default_addressed(pop)






# 90 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\stdlib.h"





typedef struct {int quot; int rem;} div_t;
typedef struct {long int quot; long int rem;} ldiv_t;
typedef struct {long long quot; long long rem;} lldiv_t;





  #pragma function_name _div
  div_t  div(int _numer, int _denom);

  #pragma function_name _ldiv
  ldiv_t ldiv(long _numer, long _denom);

  lldiv_t lldiv(long long _numer, long long _denom);





# 125 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\stdlib.h"












 




#pragma misra_func(string_conv)
  int atoi(const char *_nptr);

#pragma misra_func(string_conv)
#pragma function_name atoi
  long atol(const char *_nptr);

#pragma misra_func(string_conv)
  long long atoll(const char *_nptr);

#pragma compatible_pm_dm_params
  long strtol(const char *_nptr, char **_endptr, int _base);

#pragma compatible_pm_dm_params
  unsigned long strtoul(const char *_nptr, char **_endptr, int _base);

#pragma compatible_pm_dm_params
  long long strtoll(const char *_nptr, char **_endptr, int _base);

#pragma compatible_pm_dm_params
  unsigned long long strtoull(const char *_nptr, char **_endptr, int _base);













 







#pragma misra_func(string_conv)
  double atof(const char *_nptr);





#pragma compatible_pm_dm_params
  double strtod(const char *_nptr, char **_endptr);

#pragma compatible_pm_dm_params
  long double strtold(const char *_nptr, char **_endptr);












 




  long long llabs(long long _a);






# 1 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"








 







#pragma system_header  





# 1 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\sys/builtins_support.h"




 

#pragma system_header









#pragma default_addressed(push)







 
# 34 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\sys/builtins_support.h"

# 43 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\sys/builtins_support.h"


#pragma default_addressed(pop)






# 192 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"






# 214 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"


#pragma default_addressed(push)


# 226 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 234 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"




void * __builtin_memcpyDD(void * __a, const void * __b, size_t  __c);
__pm void * __builtin_memcpyPD(__pm void * __a, const void * __b, size_t  __c);
void * __builtin_memcpyDP(void * __a, const __pm void * __b, size_t  __c);
__pm void * __builtin_memcpyPP(__pm void * __a, const __pm void * __b, size_t  __c);
void * __builtin_memmoveDD(void * __a, const void * __b, size_t  __c);
__pm void * __builtin_memmovePD(__pm void * __a, const void * __b, size_t  __c);
void * __builtin_memmoveDP(void * __a, const __pm void * __b, size_t  __c);
__pm void * __builtin_memmovePP(__pm void * __a, const __pm void * __b, size_t  __c);
char * __builtin_strcpy(char * __a, const char * __b);
size_t  __builtin_strlen(const char * __a);
void * __builtin_va_start(const void * __a, size_t  __b);
float  __builtin_fabsf(float  __a);
long double  __builtin_fabs(long double  __a);
float  __builtin_fminf(float  __a, float  __b);
float  __builtin_fmaxf(float  __a, float  __b);
int  __builtin_abs(int  __a);
long  __builtin_labs(long  __a);
int  __builtin_expected_true(int  __a);
int  __builtin_expected_false(int  __a);
void __builtin_assert(int  __a);
void __builtin_aligned(const void * __a, int  __b);
int  __builtin_funcsize(const void * __a);
ptrdiff_t  __builtin_circindex(ptrdiff_t  __a, ptrdiff_t  __b, size_t  __c);
void * __builtin_circptr(const void * __a, ptrdiff_t  __b, const void * __c, size_t  __d);
void __builtin_pm_aligned(const __pm void * __a, int  __b);
int  __builtin_byteswap4(int  __a);
int  __builtin_max(int  __a, int  __b);
long  __builtin_lmax(long  __a, long  __b);
int  __builtin_min(int  __a, int  __b);
long  __builtin_lmin(long  __a, long  __b);
void * __builtin_alloca(size_t  __a);
void * __builtin_dealloca(size_t  __a);



int  __builtin_conv_FtoR(float  __a);
int  __builtin_RxItoI(int  __a, int  __b);
unsigned int  __builtin_llleftz(unsigned long long  __a);
unsigned int  __builtin_lllefto(unsigned long long  __a);
void  __builtin_sysreg_write_nop(int  __a, unsigned int  __b);
void  __builtin_sysreg_bit_set_nop(int  __a, unsigned int  __b);
void  __builtin_sysreg_bit_clr_nop(int  __a, unsigned int  __b);
void  __builtin_sysreg_bit_tgl_nop(int  __a, unsigned int  __b);
void  __builtin_NOP(void);
int  __builtin_avg(int  __a, int  __b);
long  __builtin_lavg(long  __a, long  __b);
int  __builtin_clip(int  __a, int  __b);
long  __builtin_lclip(long  __a, long  __b);
float  __builtin_faddsubf_r1(float  __a, float  __b);
float  __builtin_faddsubf_r2(float  __a);
float  __builtin_faddabsf(float  __a, float  __b);
float  __builtin_fsubabsf(float  __a, float  __b);
float  __builtin_favgf(float  __a, float  __b);
float  __builtin_copysignf(float  __a, float  __b);
float  __builtin_fsignf(float  __a, float  __b);
float  __builtin_fscalbf(float  __a, int  __b);
int  __builtin_mantf(float  __a);
int  __builtin_logbf(float  __a);
int  __builtin_conv_fix_by(float  __a, int  __b);
int  __builtin_conv_fix(float  __a);
int  __builtin_conv_trunc_by(float  __a, int  __b);
float  __builtin_conv_float_by(int  __a, int  __b);
float  __builtin_frecipsf(float  __a);
float  __builtin_frsqrtsf(float  __a);
float  __builtin_fclipf(float  __a, float  __b);
# 468 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"
unsigned int  __builtin_leftz(unsigned int  __a);
unsigned int  __builtin_lefto(unsigned int  __a);
int  __builtin_fpack(float  __a);
float  __builtin_funpack(int  __a);



int  __builtin_load_exclusive_32_r2(unsigned int  __a);



int  __builtin_load_exclusive_64_r2(unsigned long long  __a);



int  __builtin_load_exclusive_8_r2(unsigned char  __a);



int  __builtin_load_exclusive_16_r2(unsigned short  __a);
# 500 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"
unsigned int  __builtin_sysreg_read(int  __a);
void  __builtin_sysreg_write(int  __a, unsigned int  __b);
int  __builtin_sysreg_bit_tst(int  __a, unsigned int  __b);
int  __builtin_sysreg_bit_tst_all(int  __a, unsigned int  __b);
int  __builtin_sysreg_bit_xor(int  __a, unsigned int  __b);
void  __builtin_sysreg_bit_set(int  __a, unsigned int  __b);
void  __builtin_sysreg_bit_clr(int  __a, unsigned int  __b);
void  __builtin_sysreg_bit_tgl(int  __a, unsigned int  __b);
unsigned long long  __builtin_emuclk(void);
void  __builtin_idle(void);
float  __builtin_conv_RtoF(int  __a);
int  __builtin_RxR(int  __a, int  __b);
int  __builtin_RxItoR(int  __a, int  __b);
long long  __builtin_compose_i64(int  __a, int  __b);
int  __builtin_sat_add(int  __a, int  __b);
int  __builtin_sat_sub(int  __a, int  __b);
unsigned int  __builtin_iop_read(volatile void * __a);
void __builtin_iop_write(volatile void * __a, unsigned int  __b);



# 537 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 554 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"







#pragma inline
#pragma always_inline
#pragma source_position_from_call_site
static int  abs(int  __a) {
  int  __rval;
  __rval = __builtin_abs(__a);
  return __rval;
}









#pragma inline
#pragma always_inline
#pragma source_position_from_call_site
static long  labs(long  __a) {
  long  __rval;
  __rval = __builtin_labs(__a);
  return __rval;
}



# 598 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 608 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 623 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 633 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 643 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 653 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 663 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 683 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 700 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 717 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 734 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 751 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 761 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 771 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 790 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 807 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 824 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 844 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 864 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 878 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 892 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 906 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 920 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 935 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 952 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 969 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 986 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1003 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1021 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1038 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1055 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1072 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1089 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1106 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1123 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1140 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1157 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1174 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1191 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1208 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1225 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1242 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1259 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1276 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1295 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1314 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1333 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1352 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1371 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1390 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1409 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1428 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1447 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1466 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1485 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1504 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1523 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1542 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1561 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1580 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1599 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1618 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1637 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1656 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1675 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1694 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1713 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1732 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1751 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1770 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1789 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1808 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1827 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1846 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1865 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1884 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1903 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1922 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1941 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1960 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1979 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 1998 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2017 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2036 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2055 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2074 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2093 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2112 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2131 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2150 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2169 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2188 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2207 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2226 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2245 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2264 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2283 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2302 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2321 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2341 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2361 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2382 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2403 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2423 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2443 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2463 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2483 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2502 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2521 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2540 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2559 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2569 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2579 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2589 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2599 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2609 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2619 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2629 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2639 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2656 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2671 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2688 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2705 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2722 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2742 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2762 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2782 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2805 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"

# 2826 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\builtins.h"




#pragma default_addressed(pop)






# 221 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\stdlib.h"



   
  #pragma inline
  #pragma always_inline
  long long llabs(long long _a)
  {
    return ((_a < 0) ? -_a : _a );
  }











 




  int  rand(void);
  void srand(unsigned int _seed);













 




#pragma misra_func(heap)
  void *calloc(size_t _nmemb, size_t _size);

#pragma misra_func(heap)
  void *malloc(size_t _size);

#pragma misra_func(heap)
  void *realloc(void *_ptr, size_t _size);

#pragma misra_func(heap)
  void  free(void *_ptr);

















 




#pragma noreturn
#pragma misra_func(system)
  void  abort(void);

#pragma noreturn
#pragma misra_func(system)
  void  exit(int _status);

#pragma noreturn
#pragma misra_func(system)

#pragma word_addressed

  void  _Exit(int _exit_value);

#pragma misra_func(system)
  char *getenv(const char *_name);
#pragma misra_func(system)
  int   system(const char *_command);


  typedef void _t_atexit_fp(void);

  int   atexit(_t_atexit_fp _func);















 




  typedef int _t_compare_fp(const void *, const void *);

  void *bsearch(const void *_key, const void *_base,
                size_t _nelem, size_t _size, _t_compare_fp _func);

  void  qsort(void *_base, size_t _nelem, size_t _size, _t_compare_fp _func);

# 389 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\stdlib.h"








 






typedef int errno_t;


typedef void (*constraint_handler_t)(const char *msg,
                                     void *ptr,
                                     errno_t error);

constraint_handler_t set_constraint_handler_s(constraint_handler_t handler);

void ignore_handler_s(const char *msg,
                      void *ptr,
                      errno_t error);








#pragma default_addressed(pop)






# 33 "..\\system\\startup_ldf\\app_heaptab.c"
# 1 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\limits.h"






 

 




#pragma system_header  
#pragma standard_header  







#pragma default_addressed(push)








# 40 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\limits.h"

# 48 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\limits.h"

# 61 "C:\\analog\\cces\\3.0.1\\SHARC\\include\\limits.h"















#pragma default_addressed(pop)






# 34 "..\\system\\startup_ldf\\app_heaptab.c"

extern "asm" unsigned long ldf_heap_space;
extern "asm" unsigned long ldf_heap_length;

const __heap_desc_t heap_table[2] =
{

  { &ldf_heap_space, (unsigned long) &ldf_heap_length, 0 },

  { (void *)0, (size_t)0, 0 }  
};









