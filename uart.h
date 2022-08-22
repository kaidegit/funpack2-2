/*
 * uart.h
 *
 *  Created on: 2022��8��14��
 *      Author: yekai
 */

#ifndef UART_H_
#define UART_H_

#define UART_PIN_RX         IfxAsclin0_RXA_P14_1_IN                 /* UART receive port pin                        */
#define UART_PIN_TX         IfxAsclin0_TX_P14_0_OUT                 /* UART transmit port pin                       */

void Uart_Init(void);

void Uart_SendStr(char* str);

#endif /* UART_H_ */
