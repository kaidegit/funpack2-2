/*
 * pwm.c
 *
 *  Created on: 2022Äê8ÔÂ14ÈÕ
 *      Author: yekai
 */

#include "pwm.h"
#include "IfxGtm_Tom_Pwm.h"

#define LED                 IfxGtm_TOM1_4_TOUT14_P00_5_OUT
#define PWM_PERIOD          50000

IfxGtm_Tom_Pwm_Config g_tomConfig;
IfxGtm_Tom_Pwm_Driver g_tomDriver;

void PWM_Init(void) {
    IfxGtm_enable(&MODULE_GTM);                                     /* Enable GTM                                   */

    IfxGtm_Cmu_enableClocks(&MODULE_GTM, IFXGTM_CMU_CLKEN_FXCLK);   /* Enable the FXU clock                         */

    /* Initialize the configuration structure with default parameters */
    IfxGtm_Tom_Pwm_initConfig(&g_tomConfig, &MODULE_GTM);

    g_tomConfig.tom = LED.tom;                                      /* Select the TOM depending on the LED          */
    g_tomConfig.tomChannel = LED.channel;                           /* Select the channel depending on the LED      */
    g_tomConfig.period = PWM_PERIOD;                                /* Set the timer period                         */
    g_tomConfig.pin.outputPin = &LED;                               /* Set the LED port pin as output               */
    g_tomConfig.synchronousUpdateEnabled = TRUE;                    /* Enable synchronous update                    */

    IfxGtm_Tom_Pwm_init(&g_tomDriver, &g_tomConfig);                /* Initialize the GTM TOM                       */
    IfxGtm_Tom_Pwm_start(&g_tomDriver, TRUE);
}

// duty should be between 0 and 100
void PWM_SetDuty(uint8_t dutyCycle) {
    g_tomConfig.dutyCycle = dutyCycle * PWM_PERIOD / 100;           /* Change the value of the duty cycle           */
    IfxGtm_Tom_Pwm_init(&g_tomDriver, &g_tomConfig);                /* Re-initialize the PWM                        */
}
