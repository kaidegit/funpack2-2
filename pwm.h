/*
 * pwm.h
 *
 *  Created on: 2022��8��14��
 *      Author: yekai
 */

#ifndef PWM_H_
#define PWM_H_

#include "stdint.h"

void PWM_Init(void);

void PWM_SetDuty(uint8_t dutyCycle);

#endif /* PWM_H_ */
