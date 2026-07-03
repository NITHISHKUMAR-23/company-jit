MEMORY
{
  MEM_L2_MCAPI_DATA_ICC : ORIGIN = 0x20000000, LENGTH = 4K
  MEM_L2_MCAPI_DATA_CORE0 : ORIGIN = 0x20001000, LENGTH = 16K
  MEM_L2_MCAPI_DATA_CORE2 (r) : ORIGIN = 0x20005000, LENGTH = 64K
  MEM_L2_MCAPI_DATA_CORE1 (r) : ORIGIN = 0x20015000, LENGTH = 64K
  MEM_L2_UNCACHED : ORIGIN = 0x20025000, LENGTH = 108K
  MEM_L2_CACHED : ORIGIN = 0x20040000, LENGTH = 768K
  MEM_L2_CORE2 (r) : ORIGIN = 0x20100000, LENGTH = 512K
  MEM_L2_CORE1 (r) : ORIGIN = 0x20180000, LENGTH = 512K
  MEM_L3_CORE1_NW_CODE (r) : ORIGIN = 0x80000000, LENGTH = 3M
  MEM_L3_CORE2_NW_CODE (r) : ORIGIN = 0x80300000, LENGTH = 3M
  MEM_L3_CORE1_DATA (r) : ORIGIN = 0x80600000, LENGTH = 4M
  MEM_L3_CORE1_VISA_CODE (r) : ORIGIN = 0x80A00000, LENGTH = 3M
  MEM_L3_CORE2_VISA_CODE (r) : ORIGIN = 0x80D00000, LENGTH = 3M
  MEM_L3_CORE1_DATA2 (r) : ORIGIN = 0x81000000, LENGTH = 240M
  MEM_L3_CORE2_DATA2 (r) : ORIGIN = 0x90000000, LENGTH = 256M
  MEM_L3 : ORIGIN = 0xA0000000, LENGTH = 512M
}
SECTIONS {
  __MCAPI_common_start = ORIGIN(MEM_L2_MCAPI_DATA_ICC) ;
  __MCAPI_common_end = ORIGIN(MEM_L2_MCAPI_DATA_ICC) + LENGTH(MEM_L2_MCAPI_DATA_ICC) - 1 ;
  __MCAPI_arm_start = ORIGIN(MEM_L2_MCAPI_DATA_CORE0) ;
  __MCAPI_arm_end = ORIGIN(MEM_L2_MCAPI_DATA_CORE0) + LENGTH(MEM_L2_MCAPI_DATA_CORE0) - 1 ;
  __MCAPI_sharc0_start = ORIGIN(MEM_L2_MCAPI_DATA_CORE1) ;
  __MCAPI_sharc0_end = ORIGIN(MEM_L2_MCAPI_DATA_CORE1) + LENGTH(MEM_L2_MCAPI_DATA_CORE1) - 1 ;
  __MCAPI_sharc1_start = ORIGIN(MEM_L2_MCAPI_DATA_CORE2) ;
  __MCAPI_sharc1_end = ORIGIN(MEM_L2_MCAPI_DATA_CORE2) + LENGTH(MEM_L2_MCAPI_DATA_CORE2) - 1 ;
  __l2_start = 0x20000000 ;
  __l2_end = 0x201FFFFF ;
  __l2_uncached_start = ORIGIN(MEM_L2_MCAPI_DATA_CORE0) ;
  __l2_uncached_end = ORIGIN(MEM_L2_UNCACHED) + LENGTH(MEM_L2_UNCACHED) - 1 ;
  __l2_cached_start = ORIGIN(MEM_L2_CACHED) ;
  __l2_cached_end = ORIGIN(MEM_L2_CORE1) + LENGTH(MEM_L2_CORE1) - 1 ;
}
OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm",
       "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)
SECTIONS
{
  .interp : { *(.interp) }
  .hash : { *(.hash) }
  .dynsym : { *(.dynsym) }
  .dynstr : { *(.dynstr) }
  .gnu.version : { *(.gnu.version) }
  .gnu.version_d : { *(.gnu.version_d) }
  .gnu.version_r : { *(.gnu.version_r) }
  .rel.init : { *(.rel.init) }
  .rela.init : { *(.rela.init) }
  .rel.text :
    {
      *(.rel.text)
      *(.rel.text.*)
      *(.rel.gnu.linkonce.t*)
    }
  .rela.text :
    {
      *(.rela.text)
      *(.rela.text.*)
      *(.rela.gnu.linkonce.t*)
    }
  .rel.fini : { *(.rel.fini) }
  .rela.fini : { *(.rela.fini) }
  .rel.rodata :
    {
      *(.rel.rodata)
      *(.rel.rodata.*)
      *(.rel.gnu.linkonce.r*)
    }
  .rela.rodata :
    {
      *(.rela.rodata)
      *(.rela.rodata.*)
      *(.rela.gnu.linkonce.r*)
    }
  .rel.data :
    {
      *(.rel.data)
      *(.rel.data.*)
      *(.rel.gnu.linkonce.d*)
    }
  .rela.data :
    {
      *(.rela.data)
      *(.rela.data.*)
      *(.rela.gnu.linkonce.d*)
    }
  .rel.ctors : { *(.rel.ctors) }
  .rela.ctors : { *(.rela.ctors) }
  .rel.dtors : { *(.rel.dtors) }
  .rela.dtors : { *(.rela.dtors) }
  .rel.got : { *(.rel.got) }
  .rela.got : { *(.rela.got) }
  .rel.sdata :
    {
      *(.rel.sdata)
      *(.rel.sdata.*)
      *(.rel.gnu.linkonce.s*)
    }
  .rela.sdata :
    {
      *(.rela.sdata)
      *(.rela.sdata.*)
      *(.rela.gnu.linkonce.s*)
    }
  .rel.sbss : { *(.rel.sbss) }
  .rela.sbss : { *(.rela.sbss) }
  .rel.bss : { *(.rel.bss) }
  .rela.bss : { *(.rela.bss) }
  .rel.plt : { *(.rel.plt) }
  .rela.plt : { *(.rela.plt) }
  .plt : { *(.plt) }
  .l2_uncached :
  {
    *(.l2_uncached_crt)
    *(.l2_uncached_code)
    *(.l2_uncached_data)
  } >MEM_L2_UNCACHED = 0
  .l2_mmu_table (NOLOAD) :
  {
    *page_table_mem.o(.bss .bss*)
  } >MEM_L2_CACHED = 0
  .l2_cached :
  {
    *(.l2_cached_crt)
    *(.l2_cached_code)
    *(.l2_cached_data)
  } >MEM_L2_CACHED = 0
  .l3 :
  {
    *(.l3_code)
    *(.l3_data)
  } >MEM_L3 = 0
  .mmu_config :
  {
    KEEP (*(.mmu_config))
  } >MEM_L2_CACHED = 0
  .heap (NOLOAD) :
  {
    __heap_start = . ;
    *(.heap)
    __heap_end = . ;
  } >MEM_L2_CACHED = 0
  .stack_sys (NOLOAD) :
  {
    __stack_sys_end = . ;
    KEEP(*(.stack_sys))
    __stack_sys_start = . ;
  } > MEM_L2_CACHED = 0
  .stack_sup (NOLOAD) :
  {
    __stack_sup_end = . ;
    KEEP(*(.stack_sup))
    __stack_sup_start = . ;
  } > MEM_L2_CACHED = 0
  .stack_fiq (NOLOAD) :
  {
    __stack_fiq_end = . ;
    KEEP(*(.stack_fiq))
    __stack_fiq_start = . ;
  } > MEM_L2_CACHED = 0
  .stack_irq (NOLOAD) :
  {
    __stack_irq_end = . ;
    KEEP(*(.stack_irq))
    __stack_irq_start = . ;
  } > MEM_L2_CACHED = 0
  .stack_abort (NOLOAD) :
  {
    __stack_abort_end = . ;
    KEEP(*(.stack_abort))
    __stack_abort_start = . ;
  } > MEM_L2_CACHED = 0
  .stack_undef (NOLOAD) :
  {
    __stack_undef_end = . ;
    KEEP(*(.stack_undef))
    __stack_undef_start = . ;
  } > MEM_L2_CACHED = 0
  .mcapi_data_icc :
  {
    *(.mcapi_data_icc)
  } >MEM_L2_MCAPI_DATA_ICC
  .mcapi_data_core0 :
  {
    *(.mcapi_data_core0)
  } >MEM_L2_MCAPI_DATA_CORE0
  .text :
  {
    *(.text)
    *(.text.*)
    *(.stub)
    *(.gnu.warning)
    *(.gnu.linkonce.t*)
    *(.glue_7t) *(.glue_7)
  } >MEM_L2_CACHED =0
  .init :
  {
    KEEP (*(.init))
  } >MEM_L2_CACHED =0
  _etext = .;
  PROVIDE (etext = .);
  .fini :
  {
    KEEP (*(.fini))
  } >MEM_L2_CACHED =0
  .rodata : { *(.rodata) *(.rodata.*) *(.gnu.linkonce.r*) } >MEM_L2_CACHED =0
  .rodata1 : { *(.rodata1) } >MEM_L2_CACHED =0
  .eh_frame_hdr : { *(.eh_frame_hdr) } >MEM_L2_CACHED =0
  .ARM.extab : { *(.ARM.extab* .gnu.linkonce.armextab.*) } >MEM_L2_CACHED =0
  .ARM.exidx : {
    __exidx_start = .;
    *(.ARM.exidx* .gnu.linkonce.armexidx.*)
    __exidx_end = .;
  } >MEM_L2_CACHED =0
  . = ALIGN(256) + (. & (256 - 1));
  .data :
  {
    *(.data)
    *(.data.*)
    *(.gnu.linkonce.d*)
    SORT(CONSTRUCTORS)
  } >MEM_L2_CACHED =0
  .data1 : { *(.data1) } >MEM_L2_CACHED =0
  .eh_frame : { KEEP (*(.eh_frame)) } >MEM_L2_CACHED =0
  .gcc_except_table : { *(.gcc_except_table) } >MEM_L2_CACHED =0
  .preinit_array :
  {
    PROVIDE_HIDDEN (__preinit_array_start = .);
    KEEP (*(.preinit_array))
    PROVIDE_HIDDEN (__preinit_array_end = .);
  } >MEM_L2_CACHED =0
  .init_array :
  {
     PROVIDE_HIDDEN (__init_array_start = .);
     KEEP (*(SORT(.init_array.*)))
     KEEP (*(.init_array))
     PROVIDE_HIDDEN (__init_array_end = .);
  } >MEM_L2_CACHED =0
  .fini_array :
  {
    PROVIDE_HIDDEN (__fini_array_start = .);
    KEEP (*(.fini_array))
    KEEP (*(SORT(.fini_array.*)))
    PROVIDE_HIDDEN (__fini_array_end = .);
  } >MEM_L2_CACHED =0
  .ctors :
  {
    KEEP (*crtbegin.o(.ctors))
    KEEP (*(EXCLUDE_FILE (*crtend.o ) .ctors))
    KEEP (*(SORT(.ctors.*)))
    KEEP (*(.ctors))
  } >MEM_L2_CACHED =0
   .dtors :
  {
    KEEP (*crtbegin.o(.dtors))
    KEEP (*(EXCLUDE_FILE (*crtend.o ) .dtors))
    KEEP (*(SORT(.dtors.*)))
    KEEP (*(.dtors))
  } >MEM_L2_CACHED =0
  .jcr : { KEEP (*(.jcr)) } >MEM_L2_CACHED =0
  .got : { *(.got.plt) *(.got) } >MEM_L2_CACHED =0
  .dynamic : { *(.dynamic) } >MEM_L2_CACHED =0
  .sdata :
  {
    *(.sdata)
    *(.sdata.*)
    *(.gnu.linkonce.s.*)
  } >MEM_L2_CACHED =0
  _edata = .;
  PROVIDE (edata = .);
  __bss_start = .;
  __bss_start__ = .;
  .sbss :
  {
    *(.dynsbss)
    *(.sbss)
    *(.sbss.*)
    *(.scommon)
  } >MEM_L2_CACHED =0
  .bss :
  {
   *(.dynbss)
   *(.bss)
   *(.bss.*)
   *(COMMON)
   . = ALIGN(32 / 8);
  } >MEM_L2_CACHED =0
  _bss_end__ = . ; __bss_end__ = . ;
  .debug 0 : { *(.debug) }
  .line 0 : { *(.line) }
  .debug_srcinfo 0 : { *(.debug_srcinfo) }
  .debug_sfnames 0 : { *(.debug_sfnames) }
  .debug_aranges 0 : { *(.debug_aranges) }
  .debug_pubnames 0 : { *(.debug_pubnames) }
  .debug_info 0 : { *(.debug_info) }
  .debug_abbrev 0 : { *(.debug_abbrev) }
  .debug_line 0 : { *(.debug_line) }
  .debug_frame 0 : { *(.debug_frame) }
  .debug_str 0 : { *(.debug_str) }
  .debug_loc 0 : { *(.debug_loc) }
  .debug_macinfo 0 : { *(.debug_macinfo) }
  .debug_ranges 0 : { *(.debug_ranges) }
  .debug_weaknames 0 : { *(.debug_weaknames) }
  .debug_funcnames 0 : { *(.debug_funcnames) }
  .debug_typenames 0 : { *(.debug_typenames) }
  .debug_varnames 0 : { *(.debug_varnames) }
}
