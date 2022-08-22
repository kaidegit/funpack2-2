/*
 * timer.c
 *
 *  Created on: 2022Äê8ÔÂ14ÈÕ
 *      Author: yekai
 */

#include "timer.h"
#include "IfxStm.h"

#define ISR_PRIORITY_STM        40

IfxStm_CompareConfig g_STMConf;

void Timer_Init(void) {
    // init timer with default config
    IfxStm_initCompareConfig(&g_STMConf);
    IfxStm_initCompare(&MODULE_STM0, &g_STMConf);
}

void Timer_Delayms(uint16_t ms) {
    uint32 tick = IfxStm_getTicksFromMilliseconds(&MODULE_STM0, ms);
    IfxStm_waitTicks(&MODULE_STM0, tick);
}
