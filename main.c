#include "gpio.h"
#define RCC_AHB1ENR (*(volatile uint32_t *)0x40023830U)

int main(void){
RCC_AHB1ENR |= (1U << 0U);  // Enable GPIOA clock
GPIOA->MODER |= (1U<<10U);      /* Init and set the mode of GPIOA port 5 as output mode */
GPIOA->OTYPER &= ~(1U<<5U);     /* Config the output type of Port 5*/
GPIOA->OSPEEDER |= (2U<<10U);   /* Config the output speed of port 5 */
GPIOA->PUPDR &= ~(3U<<10U);     /* Configuring the push-pull of port 5 */

    while(1){
        for(int i = 0; i < 100000; i++) /* delay loop */
        GPIOA->BSRR = (1U<<5U);     /* Set the port 5 */
        for(int i = 0; i < 100000; i++)     /* delay loop */
        GPIOA->BSRR = (1U<<21U);    /* Reset the port 5 */
    }

return 0;

}