/**
  ******************************************************************************
  * @author  ��ҫ�Ƽ� ASHINING
  * @version V3.0
  * @date    2016-10-08
  * @brief   LED����C�ļ�
  ******************************************************************************
  * @attention
  *
  * ����	:	http://www.ashining.com
  * �Ա�	:	https://shop105912646.taobao.com
  * ����Ͱ�:	https://cdzeyao.1688.com
  ******************************************************************************
  */



#include "drv_led.h"



/**
  * @brief :LED��ʼ��
  * @param :��
  * @note  :��
  * @retval:��
  */ 
void drv_led_init( void )
{
	//��ʼ��LED���� ������� ���� ��ʼ״̬Ϊ��
	GPIO_Init( LED_RED_GPIO_PORT, LED_RED_GPIO_PIN, GPIO_Mode_Out_PP_Low_Fast );
	GPIO_Init( LED_GREEN_GPIO_PORT, LED_GREEN_GPIO_PIN, GPIO_Mode_Out_PP_Low_Fast );	
}

/**
  * @brief :LED��
  * @param :
  *			@LedPort:LEDѡ�񣬺�ɫ����ɫ
  * @note  :��
  * @retval:��
  */
void drv_led_on( LedPortType LedPort )
{
	if( LED_RED == LedPort )	//LED_RED
	{
		GPIO_SetBits( LED_RED_GPIO_PORT, LED_RED_GPIO_PIN );
	}
	else				
	{
		GPIO_SetBits( LED_GREEN_GPIO_PORT, LED_GREEN_GPIO_PIN );
	}
	
}

/**
  * @brief :LED��
  * @param :
  *			@LedPort:LEDѡ�񣬺�ɫ����ɫ
  * @note  :��
  * @retval:��
  */
void drv_led_off( LedPortType LedPort )
{
	if( LED_RED == LedPort )	//LED_RED
	{
		GPIO_ResetBits( LED_RED_GPIO_PORT, LED_RED_GPIO_PIN );	
	}
	else					
	{
		GPIO_ResetBits( LED_GREEN_GPIO_PORT, LED_GREEN_GPIO_PIN );
	}
	
}

/**
  * @brief :LED��˸
  * @param :
  *			@LedPort:LEDѡ�񣬺�ɫ����ɫ
  * @note  :��
  * @retval:��
  */
void drv_led_flashing( LedPortType LedPort )
{
	
	if( LED_RED == LedPort )
	{
		GPIO_ToggleBits( LED_RED_GPIO_PORT, LED_RED_GPIO_PIN );
	}
	else
	{
		GPIO_ToggleBits( LED_GREEN_GPIO_PORT, LED_GREEN_GPIO_PIN );
	}
}
