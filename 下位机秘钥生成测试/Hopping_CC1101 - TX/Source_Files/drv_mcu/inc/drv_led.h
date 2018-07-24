/**
  ******************************************************************************
  * @author  ��ҫ�Ƽ� ASHINING
  * @version V3.0
  * @date    2016-10-08
  * @brief   LED����H�ļ�
  ******************************************************************************
  * @attention
  *
  * ����	:	http://www.ashining.com
  * �Ա�	:	https://shop105912646.taobao.com
  * ����Ͱ�:	https://cdzeyao.1688.com
  ******************************************************************************
  */


#ifndef	__DRV_LED_H__
#define __DRV_LED_H__


#include "stm8l10x_gpio.h"


//LEDӲ������
#define LED_RED_GPIO_PORT			GPIOA								
#define LED_RED_GPIO_PIN			GPIO_Pin_2

#define LED_GREEN_GPIO_PORT			GPIOA							
#define LED_GREEN_GPIO_PIN			GPIO_Pin_3


/** LED���� */
typedef enum LedPort
{
	LED_RED = 0,		//��ɫLED
	LED_GREEN			//��ɫLED
}LedPortType;


void drv_led_init( void );
void drv_led_on( LedPortType LedPort );
void drv_led_off( LedPortType LedPort );
void drv_led_flashing( LedPortType LedPort );

//��ɫLED��������
#define led_red_on( )				drv_led_on( LED_RED )
#define led_red_off( )				drv_led_off( LED_RED )
#define led_red_flashing( )			drv_led_flashing( LED_RED )
//��ɫLED��������
#define led_green_on( )				drv_led_on( LED_GREEN )
#define led_green_off( )			drv_led_off( LED_GREEN )
#define led_green_flashing( )		drv_led_flashing( LED_GREEN )


#endif

