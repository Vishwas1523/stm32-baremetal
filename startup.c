#include <stdint.h>

/* main() func declaration */
extern int main(void);  

/* start address for the initialization values of the .data section. defined in linker script */
extern uint32_t _sidata;

/* start address for the .data section. defined in linker script */  
extern uint32_t _sdata;

/* end address for the .data section. defined in linker script */
extern uint32_t _edata;

/* start address for the .bss section. defined in linker script */
extern uint32_t _sbss;

/* end address for the .bss section. defined in linker script */
extern uint32_t _ebss; 

/* vector table will be a collection of functions which returns void and take void as arguments */
typedef void (*isr_vector)(void);   

void reset_handler(void);           /* reset handler will create the C run time environment */

/*--------------------------Exception handlers----------------------------*/
void default_handler(void);  /* Default handler will get executed if the handler doesnt have any defination */
void NMI_handler(void)  __attribute__((weak, alias("default_handler")));
void MemManage_handler(void)  __attribute__((weak, alias("default_handler")));
void BusFault_handler(void)  __attribute__((weak, alias("default_handler")));
void UsageFault_handler(void)  __attribute__((weak, alias("default_handler")));

//----------------------------------------------------------------------------------------------
const isr_vector vector_table[] = {
    &reset_handler,
    &NMI_handler,
    &MemManage_handler,
    &BusFault_handler,
    &UsageFault_handler
};  /* It is necessary to make vector table const so that linker script won't force it into RAM */

/*-------------------------------------------Definitions of handlers-------------------------------------*/
void reset_handler(void){
    
    setData();  /* Sets the .data section */
    setBSS();   /* Sets the .bss section */

    main();     /* Calls main() func */

    while(1);   /* If execution returns from main() it will fall into this loop forver */
}

void default_handler(void){
    while(1);
}
