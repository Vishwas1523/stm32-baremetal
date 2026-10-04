
typedef void (*isr_vector)(void);   /* vector table will be a collection of functions which returns 
                                     * void and take void as arguments */

extern void stack_pointer(void);    /* sets main stack pointer at address 0x00000000U */
void reset_handler(void);           /* reset handler will create the C run time environment */

/*--------------------------Exception handlers----------------------------*/
void default_handler(void);  /* Default handler will get executed if the handler doesnt have any defination */
void NMI_handler(void)  __attribute__((weak, alias("default_handler")));
void MemManage_handler(void)  __attribute__((weak, alias("default_handler")));
void BusFault_handler(void)  __attribute__((weak, alias("default_handler")));
void UsageFault_handler(void)  __attribute__((weak, alias("default_handler")));

//----------------------------------------------------------------------------------------------
isr_vector vector_table[] = {
    &stack_pointer,
    &reset_handler,
    &NMI_handler,
    &MemManage_handler,
    &BusFault_handler,
    &UsageFault_handler
};

/*-------------------------------------------Definitions of handlers-------------------------------------*/
void reset_handler(void){

}

void default_handler(void){
    while(1);
}
