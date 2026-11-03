OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm","elf32-littlearm")

ENTRY(Reset_Handler)    /* Program will start executing from here */

FLASH_SIZE  =   0x80000;    /* 512 KB flash */
RAM_SIZE    =   0x20000;    /* 128 KB RAM */

MEMORY      /* Defining memory sections and their length */
{
    FLASH (rx)   :   ORIGIN = 0x08000000, LENGTH = FLASH_SIZE   /* Flash is readable and executable */
    RAM (xwr)    :   ORIGIN = 0x20000000, LENGTH = RAM_SIZE     /* RAM is executable, writable and readable */
}

_estack = ORIGIN(RAM) + LENGTH(RAM);    /* Pointer to the end of stack */

SECTIONS    /* Different sections of RAM and Flash */
{
    .isr_vector :       /* Vector Table will be the first one to be loaded */
    {   
        . = ALIGN(4);
        KEEP(*(.isr_vector))    /* KEEP is used so that --gc-section flag won't remove these sections during linking */
        . = ALIGN(4);
    } >FLASH

    .text :     /* All the code will be stored in this section */
    {
        . = ALIGN(4);
        *(.text .text.* .gnu.linkonce.t.*)
        . = ALIGN(4);
        KEEP(*(.init))  /* KEEP is used so that --gc-section flag won't remove these sections during linking */
        KEEP(*(.fini))  /* KEEP is used so that --gc-section flag won't remove these sections during linking */
        _etext = .;     /* Pointer to the end of .text section */
    } >FLASH

    .rodata :   /* Read only data like const strings etc */
    {
        . = ALIGN(4);
        *(.rodata .rodata* .gnu.linkonce.r.*)        
        . = ALIGN(4);
    } >FLASH
    
    .ARM.extab (READONLY) : /* ARM specific Section which is read only */
    {
        . = ALIGN(4);
        *(.ARM.extab* .gnu.linkonce.armextab.*)
        . = ALIGN(4);
    } >FLASH

    .ARM (READONLY) : /* ARM specific section which is read only */
    {
        . = ALIGN(4);
        __exidx_start = .;
        *(.ARM.exidx*)
        __exidx_end = .;
        . = ALIGN(4);
      } >FLASH

    .preinit_array (READONLY):  /* For __libc_init_array() in startup file */
    {
        . = ALIGN(4);
        PROVIDE_HIDDEN(__preinit_array_start = .);
        KEEP(*(.preinit_array))
        PROVIDE_HIDDEN(__preinit_array_end = .);
    } > FLASH

    .init_array (READONLY):     /* For __libc_init_array() in startup file */
    {
        . = ALIGN(4);
        PROVIDE_HIDDEN(__init_array_start = .);
        KEEP(*(SORT_BY_INIT_PRIORITY(.init_array.*)))
        KEEP(*(.init_array))
        PROVIDE_HIDDEN(__init_array_end = .);
    } > FLASH

    .fini_array (READONLY):     /* This section is for destructors, runs after main() */
    {
        . = ALIGN(4);
        PROVIDE_HIDDEN(__fini_array_start = .);
        KEEP(*(SORT_BY_INIT_PRIORITY(.fini_array.*)))
        KEEP(*(.fini_array))
        PROVIDE_HIDDEN(__fini_array_end = .);
    } > FLASH

      _sidata = LOADADDR(.data);    /* Pointer to the beginning of .data section in FLASH */

    .data :     /* This section have initialised static and global variables */
    {
        . = ALIGN(4);
        _sdata = .;        /* Pointer to the beginning of .data section in RAM */
        *(.data) 
        *(.data*)
        . = ALIGN(4);
        _edata = .;     /* Pointer to the end of .data section in RAM */
    } >RAM AT> FLASH    /* .data section is copied from Flash to RAM during run time */
  
    .bss (NOLOAD) :     /* This section has uninitialized static and global variables */
    {
        . = ALIGN(4);
        _sbss = .;        /* Pointer to the beginning of .bss section in RAM */
        __bss_start__ = _sbss;
        *(.bss)
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;      /* Pointer to the end of .bss section in RAM */
        __bss_end__ = _ebss;
        . = ALIGN(4);
        end = .;
    } >RAM
}
