
typedef void (*isr_vector)(void);
void reset_handler(void);
void default_handler(void);
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
