/**
  ******************************************************************************
  * @author  泽耀科技 ASHINING
  * @version V3.0
  * @date    2016-10-08
  * @brief   LED配置C文件
  ******************************************************************************
  * @attention
  *
  * 官网	:	http://www.ashining.com
  * 淘宝	:	https://shop105912646.taobao.com
  * 阿里巴巴:	https://cdzeyao.1688.com
  ******************************************************************************
  */



#include "drv_led.h"



/**
  * @brief :LED初始化
  * @param :无
  * @note  :无
  * @retval:无
  */ 
void drv_led_init( void )
{
	//初始化LED引脚 推挽输出 快速 初始状态为高
	GPIO_Init( LED_RED_GPIO_PORT, LED_RED_GPIO_PIN, GPIO_Mode_Out_PP_Low_Fast );
	GPIO_Init( LED_GREEN_GPIO_PORT, LED_GREEN_GPIO_PIN, GPIO_Mode_Out_PP_Low_Fast );	
}

/**
  * @brief :LED亮
  * @param :
  *			@LedPort:LED选择，红色或绿色
  * @note  :无
  * @retval:无
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
  * @brief :LED灭
  * @param :
  *			@LedPort:LED选择，红色或绿色
  * @note  :无
  * @retval:无
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
  * @brief :LED闪烁
  * @param :
  *			@LedPort:LED选择，红色或绿色
  * @note  :无
  * @retval:无
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
