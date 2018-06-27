/**
  ******************************************************************************
  * @author  泽耀科技 ASHINING
  * @version V3.0
  * @date    2016-10-08
  * @brief   UART配置H文件
  ******************************************************************************
  * @attention
  *
  * 官网	:	http://www.ashining.com
  * 淘宝	:	https://shop105912646.taobao.com
  * 阿里巴巴:	https://cdzeyao.1688.com
  ******************************************************************************
  */


#ifndef __DRV_UART_H__
#define __DRV_UART_H__


#include "stm8l10x_clk.h"
#include "stm8l10x_gpio.h"
#include "stm8l10x_usart.h"


//UART硬件接口IO定义
#define UART_TX_GPIO_PORT			GPIOC
#define UART_TX_GPIO_PIN			GPIO_Pin_3

#define UART_RX_GPIO_PORT			GPIOC
#define UART_RX_GPIO_PIN			GPIO_Pin_2


void drv_uart_init( uint32_t UartBaudRate );
void drv_uart_tx_bytes( uint8_t* TxBuffer, uint8_t Length );
uint8_t drv_uart_rx_bytes( uint8_t* RxBuffer );



#endif



