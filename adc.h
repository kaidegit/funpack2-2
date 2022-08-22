/*
 * adc.h
 *
 *  Created on: 2022��8��14��
 *      Author: yekai
 */

#ifndef ADC_H_
#define ADC_H_

#include "stdint.h"
#include "IfxVadc_Adc.h"

typedef struct
{
    IfxVadc_Adc               vadc;               /* VADC configuration     */
    IfxVadc_Adc_Group         adcGroup;           /* Group configuration    */
    IfxVadc_Adc_ChannelConfig adcChannelConfig;   /* Channel configuration  */
    IfxVadc_Adc_Channel       adcChannel;         /* Channel                */
} ApplicationVadcBackgroundScan;

void Adc_Init(void);

void Adc_Run(void);

uint32_t Adc_GetValue(void);

#endif /* ADC_H_ */
