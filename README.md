# FunPack第二季第二期 

使用TC275制作一个速度可变的呼吸灯

## 硬件平台介绍

本次使用的平台是来自英飞凌的KIT_AURIX_TC275_LITE开发板。这块开发板搭载了一个有丰富外设和存储空间的三核处理器。板载一个FT2232调试器，连接到芯片的调试端口和串口。

## 实现的功能

本次我选择的是任务二：

设计一个呼吸灯，通过旋转板卡上的电位计，改变呼吸灯闪烁速率，同时将ADC采集的数据通过串口/CAN，发送到另一台设备上显示。

具体可以分为以下几个部分

* 使用ADC获取电位计的变化
* 使用PWM输出控制LED的亮度
* 控制LED的亮度变化速度
* 使用串口发送
* 上位机显示ADC数据

## 各部分的实现

本次开发主要使用了ads作为开发环境，简单封装了一些需要用到的iLLD函数。

### ADC部分代码

ADC部分主要有初始化，运行和读取ADC数值。代码主要参考`ADC_Single_Channel_1_KIT_TC275_LK`例程

```c
#define VADC_GROUP                  IfxVadc_GroupId_0           /* Use the ADC group 0                              */
#define CHANNEL_ID                  0                           /* Use the Channel 0                                */
#define CHANNEL_RESULT_REGISTER     5

ApplicationVadcBackgroundScan g_vadcBackgroundScan;

void Adc_Init(void) {
    /* VADC module configuration */
    /* Create VADC configuration */
    IfxVadc_Adc_Config adcConfig;

    /* Initialize the VADC configuration with default values */
    IfxVadc_Adc_initModuleConfig(&adcConfig, &MODULE_VADC);

    /* Initialize the VADC module using the VADC configuration */
    IfxVadc_Adc_initModule(&g_vadcBackgroundScan.vadc, &adcConfig);

    /* VADC group configuration */
    /* Create group configuration */
    IfxVadc_Adc_GroupConfig adcGroupConfig;

    /* Initialize the group configuration with default values */
    IfxVadc_Adc_initGroupConfig(&adcGroupConfig, &g_vadcBackgroundScan.vadc);

    /* Define which ADC group is going to be used */
    adcGroupConfig.groupId = VADC_GROUP;
    adcGroupConfig.master = VADC_GROUP;

    /* Enable background scan source */
    adcGroupConfig.arbiter.requestSlotBackgroundScanEnabled = TRUE;

    /* Enable background auto scan mode */
    adcGroupConfig.backgroundScanRequest.autoBackgroundScanEnabled = TRUE;

    /* Enable the gate in "always" mode (no edge detection) */
    adcGroupConfig.backgroundScanRequest.triggerConfig.gatingMode = IfxVadc_GatingMode_always;

    /* Initialize the group using the group configuration */
    IfxVadc_Adc_initGroup(&g_vadcBackgroundScan.adcGroup, &adcGroupConfig);
}

/* The input channels to be used are setup and the VADC is set into run mode */
void Adc_Run(void) {
    /* Initialize the channel configuration of application handle g_vadcBackgroundScan with default values */
    IfxVadc_Adc_initChannelConfig(&g_vadcBackgroundScan.adcChannelConfig, &g_vadcBackgroundScan.adcGroup);

    g_vadcBackgroundScan.adcChannelConfig.channelId = (IfxVadc_ChannelId)CHANNEL_ID;
    g_vadcBackgroundScan.adcChannelConfig.resultRegister = (IfxVadc_ChannelResult)CHANNEL_RESULT_REGISTER;
    g_vadcBackgroundScan.adcChannelConfig.backgroundChannel = TRUE;

    /* Initialize the channel of application handle g_VadcBackgroundScan using the channel configuration */
    IfxVadc_Adc_initChannel(&g_vadcBackgroundScan.adcChannel, &g_vadcBackgroundScan.adcChannelConfig);

    /* Enable background scan for the channel */
    IfxVadc_Adc_setBackgroundScan(&g_vadcBackgroundScan.vadc,
                                  &g_vadcBackgroundScan.adcGroup,
                                  (1 << (IfxVadc_ChannelId)CHANNEL_ID),
                                  (1 << (IfxVadc_ChannelId)CHANNEL_ID));

    /* Start background scan conversion */
    IfxVadc_Adc_startBackgroundScan(&g_vadcBackgroundScan.vadc);
}

#define RETRY_MAX 0xf000

uint32_t Adc_GetValue(void) {
    Ifx_VADC_RES conversionResult;
    uint16_t retry = 0;
    do {
        conversionResult = IfxVadc_Adc_getResult(&g_vadcBackgroundScan.adcChannel);
        if (retry++ > RETRY_MAX) {
            return 0xffffffff;
        }
    } while (!conversionResult.B.VF);
    return conversionResult.B.RESULT;
}
```

### 串口部分

串口部分主要参考`OneEye_UART_Oscilloscope_1_KIT_TC275_LK`和`ASCLIN_UART_1_KIT_TC275_LK`，根据前者的IO，主要参考后者。

```c
/* This function initializes the ASCLIN UART module */
void Uart_Init(void) {
    /* Initialize an instance of IfxAsclin_Asc_Config with default values */
    IfxAsclin_Asc_Config ascConfig;
    IfxAsclin_Asc_initModuleConfig(&ascConfig, &MODULE_ASCLIN0);

    /* Set the desired baud rate */
    ascConfig.baudrate.baudrate = 115200;

    /* ISR priorities and interrupt target */
    ascConfig.interrupt.txPriority = INTPRIO_ASCLIN0_TX;
    ascConfig.interrupt.rxPriority = INTPRIO_ASCLIN0_RX;
    ascConfig.interrupt.typeOfService = IfxCpu_Irq_getTos(IfxCpu_getCoreIndex());

    /* FIFO configuration */
    ascConfig.txBuffer = &g_ascTxBuffer;
    ascConfig.txBufferSize = UART_TX_BUFFER_SIZE;
    ascConfig.rxBuffer = &g_ascRxBuffer;
    ascConfig.rxBufferSize = UART_RX_BUFFER_SIZE;

    /* Pin configuration */
    const IfxAsclin_Asc_Pins pins = {
            .rx        = &UART_PIN_RX,
            .rxMode    = IfxPort_InputMode_noPullDevice,
            .tx        = &UART_PIN_TX,
            .txMode    = IfxPort_OutputMode_pushPull,
            .cts       = NULL_PTR,
            .ctsMode   = IfxPort_InputMode_noPullDevice,
            .rts       = NULL_PTR,
            .rtsMode   = IfxPort_OutputMode_pushPull,
            .pinDriver = IfxPort_PadDriver_cmosAutomotiveSpeed1
    };
    ascConfig.pins = &pins;

    IfxAsclin_Asc_initModule(&g_ascHandle, &ascConfig); /* Initialize module with above parameters */
}

void Uart_SendStr(char* str) {
    Ifx_SizeT len = (Ifx_SizeT)strlen(str);
    IfxAsclin_Asc_write(&g_ascHandle, str, &len, TIME_INFINITE);   /* Transmit data via TX */
}
```

### PWM输出

PWM输出我使用了GTM，也就是通用定时器的PWM模式输出。主要参考`GTM_TOM_PWM_1_KIT_TC275_LK`

```c
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

```

### 精确定时

精确定时我使用了STM，也就是系统定时器实现。主要参考了`STM_Interrupt_1_KIT_TC275_LK`。

```c
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
```

### 主要实现

主循环是在不断地将占空比从0变化到100，再从100变化到0。根据ADC获取到的值来决定每次变化所需要的时间。同时统计时间，间隔约500ms上报ADC值。

```c
    while(1) {
        // adc value should be between 0 and 4095
        // 基准时间：adc_val = 2048， 呼吸灯周期2s，每个占空比延时10ms
        // 最短周期：adc_val = 0， 呼吸灯周期0.5s，每个占空比延时2.5ms
        // 最长周期：adc_val = 4095，呼吸灯周期8s，每个占空比延时40ms
        // 每个占空比延时t = 2.5 + adc_val
        // 500ms上报ADC数值
        for (uint8_t i = 0; i < 100; i++) {
            PWM_SetDuty(i);
            adc_val = Adc_GetValue();
            delay = 2.5 * pow(2, adc_val / 1024.0);
            Timer_Delayms(delay);
            send_count += delay;
            if (send_count >= 500) {
                send_count -= 500;
                sprintf(ch, "adc_val:%d\r\n", (int)adc_val);
                Uart_SendStr(ch);
            }
        }
        for (uint8_t i = 100; i > 0; i--) {
            PWM_SetDuty(i);
            delay = 2.5 * pow(2, adc_val / 1024.0);
            Timer_Delayms(delay);
            send_count += delay;
            if (send_count >= 500) {
                send_count -= 500;
                sprintf(ch, "adc_val:%d\r\n", (int)adc_val);
                Uart_SendStr(ch);
            }
        }
    }
```

## 心得

英飞凌的核心似乎较为独特，然而开发环境也包装的和常见的单片机类似。单片机有三个核心，外设众多，例程齐全，能快速地使用各类外设实现功能。

