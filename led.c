/*
 * led.c
 *
 *  Created on: 2022��8��14��
 *      Author: yekai
 */

#include "led.h"
#include "IfxPort.h"

void LED_Init(void) {
    IfxPort_setPinMode(LED_GPIO_Port, LED_Pin, IfxPort_Mode_outputPushPullGeneral);
}

void LED_SetState(uint8_t state) {
    if (state) {
        IfxPort_setPinState(LED_GPIO_Port, LED_Pin, IfxPort_State_low);
    } else {
        IfxPort_setPinState(LED_GPIO_Port, LED_Pin, IfxPort_State_high);
    }
}

