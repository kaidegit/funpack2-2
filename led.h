/*
 * led.h
 *
 *  Created on: 2022Äê8ÔÂ14ÈÕ
 *      Author: yekai
 */

#ifndef LED_H_
#define LED_H_

#include "stdint.h"

#define LED_GPIO_Port &MODULE_P00
#define LED_Pin 5

void LED_SetState(uint8_t state);

void LED_Init(void);

#endif /* LED_H_ */
