/**
  ******************************************************************************
  * @author  泽耀科技 ASHINING
  * @version V3.0
  * @date    2016-10-08
  * @brief   LED配置H文件
  ******************************************************************************
  * @attention
  *
  * 官网	:	http://www.ashining.com
  * 淘宝	:	https://shop105912646.taobao.com
  * 阿里巴巴:	https://cdzeyao.1688.com
  ******************************************************************************
  */


#ifndef	__DRV_LED_H__
#define __DRV_LED_H__


#include "stm8l10x_gpio.h"


//LED硬件定义
#define LED_RED_GPIO_PORT			GPIOA								
#define LED_RED_GPIO_PIN			GPIO_Pin_2

#define LED_GREEN_GPIO_PORT			GPIOA							
#define LED_GREEN_GPIO_PIN			GPIO_Pin_3


/** LED定义 */
typedef enum LedPort
{
	LED_RED = 0,		//红色LED
	LED_GREEN			//绿色LED
}LedPortType;


void drv_led_init( void );
void drv_led_on( LedPortType LedPort );
void drv_led_off( LedPortType LedPort );
void drv_led_flashing( LedPortType LedPort );

//红色LED操作函数
#define led_red_on( )				drv_led_on( LED_RED )
#define led_red_off( )				drv_led_off( LED_RED )
#define led_red_flashing( )			drv_led_flashing( LED_RED )
//绿色LED操作函数
#define led_green_on( )				drv_led_on( LED_GREEN )
#define led_green_off( )			drv_led_off( LED_GREEN )
#define led_green_flashing( )		drv_led_flashing( LED_GREEN )


#endif

