OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm","elf32-littlearm")

ENTRY(reset_handler)

FLASH_SIZE  =   0x80000;    /* 512 KB flash */
RAM_SIZE    =   0x20000;    /* 128 KB RAM */
STACK_SIZE  =   0x800;      /* 2KB of stack */    
HEAP_SIZE   =   0x800;      /* 2KB of heap */

MEMORY
{
    FLASH (rx)   :   ORIGIN = 0x08000000, LENGTH = FLASH_SIZE
    RAM (xwr)    :   ORIGIN = 0x20000000, LENGTH = RAM_SIZE    
}

_estack = ORIGIN(RAM) + LENGTH(RAM);

SECTIONS
{
    .isr_vector :
    {   
        . = ALIGN(4);
        KEEP(*(.isr_vector))
        . = ALIGN(4);
    } >FLASH

    .text :
    {
        . = ALIGN(4);
        *(.text .text.* .gnu.linkonce.t.*)
        . = ALIGN(4);
        KEEP(*(.init))
        KEEP(*(.fini))
        _etext = .;
    } >FLASH

    .rodata :
    {
        . = ALIGN(4);
        *(.rodata .rodata* .gnu.linkonce.r.*)        
        . = ALIGN(4);
    } >FLASH
    
    .ARM.extab (READONLY) : 
    {
        . = ALIGN(4);
        *(.ARM.extab* .gnu.linkonce.armextab.*)
        . = ALIGN(4);
    } >FLASH

    .ARM (READONLY) : 
    {
        . = ALIGN(4);
        __exidx_start = .;
        *(.ARM.exidx*)
        __exidx_end = .;
        . = ALIGN(4);
      } >FLASH

    .preinit_array (READONLY):
    {
        . = ALIGN(4);
        PROVIDE_HIDDEN(__preinit_array_start = .);
        KEEP(*(.preinit_array))
        PROVIDE_HIDDEN(__preinit_array_end = .);
    } > FLASH

    .init_array (READONLY):
    {
        . = ALIGN(4);
        PROVIDE_HIDDEN(__init_array_start = .);
        KEEP(*(SORT_BY_INIT_PRIORITY(.init_array.*)))
        KEEP(*(.init_array))
        PROVIDE_HIDDEN(__init_array_end = .);
    } > FLASH

    .fini_array (READONLY):
    {
        . = ALIGN(4);
        PROVIDE_HIDDEN(__fini_array_start = .);
        KEEP(*(SORT_BY_INIT_PRIORITY(.fini_array.*)))
        KEEP(*(.fini_array))
        PROVIDE_HIDDEN(__fini_array_end = .);
    } > FLASH

      _sidata = LOADADDR(.data);

    .data :
    {
        . = ALIGN(4);
        _sdata = .;        
        *(.data) 
        *(.data*)
        . = ALIGN(4);
        _edata = .;
    } >RAM AT> FLASH
  
    .bss (NOLOAD) :
    {
        . = ALIGN(4);
        _sbss = .;        
        __bss_start__ = _sbss;
        *(.bss)
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;
        __bss_end__ = _ebss;
        . = ALIGN(4);
        end = .;
    } >RAM

    ._user_heap_stack :
    {
        . = ALIGN(8);
        PROVIDE ( end = . );
        PROVIDE ( _end = . );
        . = . + HEAP_SIZE;
        . = . + STACK_SIZE;
        . = ALIGN(8);
    } >RAM

}
