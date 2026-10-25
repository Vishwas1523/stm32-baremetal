OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm","elf32-littlearm")

ENTRY(reset_handler)

FLASH_SIZE  =   0x80000;    /* 512 KB flash */
RAM_SIZE    =   0x20000;    /* 128 KB RAM */
STACK_SIZE  =   0x800;      /* 2KB of stack */    

MEMORY
{
    FLASH (rx)   :   ORIGIN = 0x08000000, LENGTH = FLASH_SIZE
    RAM (rwx)    :   ORIGIN = 0x20000000, LENGTH = RAM_SIZE - STACK_SIZE    
}

_estack = ORIGIN(RAM) + RAM_SIZE;

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
        *(.text .text* .gnu.linkonce.r.*)
        . = ALIGN(4);
        _etext = .;
    } >FLASH

    .rodata :
    {
        . = ALIGN(4);
        *(.rodata .rodata* .gnu.linkonce.r.*)        
        . = ALIGN(4);
    } >FLASH

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
        *(.bss)
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;
    } >RAM
    
}