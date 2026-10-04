
typedef void (*isr_vector)(void);
extern void stack_pointer(void);
void reset_handler(void);
void default_handler(void);
void NMI_handler(void)  __attribute__((weak, alias("default_handler")));
void MemManage_handler(void)  __attribute__((weak, alias("default_handler")));
void BusFault_handler(void)  __attribute__((weak, alias("default_handler")));
void UsageFault_handler(void)  __attribute__((weak, alias("default_handler")));

isr_vector vector_table[] = {
    &stack_pointer,
    &reset_handler,
    &NMI_handler,
    &MemManage_handler,
    &BusFault_handler,
    &UsageFault_handler
};

void reset_handler(void){

}

void default_handler(void){
    while(1);
}
