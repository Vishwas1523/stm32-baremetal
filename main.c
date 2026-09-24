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
}GPIO_Type;     /* GPIO register structure */

#define GPIOA       ((GPIO_Type*)0x40020000U)   /* GPIOA peripheral address*/

int main(void){

GPIOA->MODER |= (1U<<10U);      /* Init and set the mode of GPIOA port 5 as output mode */
GPIOA->OTYPER &= ~(1U<<5U);     /* Config the output type of Port 5*/
GPIOA->OSPEEDER |= (2U<<10U);   /* Config the output speed of port 5 */
GPIOA->PUPDR &= ~(3U<<10U);     /* Configuring the push-pull of port 5 */

    while(1){
        GPIOA->BSRR = (1U<<5U);     /* Set the port 5 */
        for(int i = 0; i < 100000; i++)     /* delay loop */
        GPIOA->BSRR = (1U<<21U);    /* Reset the port 5 */
        for(int i = 0; i < 100000; i++) /* delay loop */
    }

return 0;

}