#include <stdint.h>

typedef struct{
    volatile uint32_t MODER;
    volatile uint32_t OTYPER;
    volatile uint32_t OSPEEDER;
    volatile uint32_t PUPDR;
    volatile uint32_t IDR;
    volatile uint32_t ODR;
    volatile uint32_t BSRR;
    volatile uint32_t LCKR;
    volatile uint32_t AFRL;
    volatile uint32_t AFRH;
}GPIO_Type;

#define GPIOA       ((GPIO_Type*)0x40020000U)

int main(void){

GPIOA->MODER |= (1U<<10U);
GPIOA->OTYPER &= ~(1U<<5U);
GPIOA->OSPEEDER |= (2U<<10U);
GPIOA->PUPDR &= ~(3U<<10U);

    while(1){
        GPIOA->BSRR = (1U<<5U);
        for(int i = 0; i < 100000; i++)
        GPIOA->BSRR = (1U<<21U);
        for(int i = 0; i < 100000; i++)
    }

return 0;

}