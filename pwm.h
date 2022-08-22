/*
 * pwm.h
 *
 *  Created on: 2022Äê8ÔÂ14ÈÕ
 *      Author: yekai
 */

#ifndef PWM_H_
#define PWM_H_

#include "stdint.h"

void PWM_Init(void);

void PWM_SetDuty(uint8_t dutyCycle);

#endif /* PWM_H_ */
