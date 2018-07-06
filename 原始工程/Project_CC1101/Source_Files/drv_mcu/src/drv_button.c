/**
  ******************************************************************************
  * @author  泽耀科技 ASHINING
  * @version V3.0
  * @date    2016-10-08
  * @brief   BUTTON配置C文件
  ******************************************************************************
  * @attention
  *
  * 官网	:	http://www.ashining.com
  * 淘宝	:	https://shop105912646.taobao.com
  * 阿里巴巴:	https://cdzeyao.1688.com
  ******************************************************************************
  */


#include "drv_button.h"
#include "drv_delay.h"



/**
  * @brief :按键初始化
  * @param :无
  * @note  :无
  * @retval:无
  */ 
void drv_button_init( void )
{
	//配置为输入 上拉 无中断
	GPIO_Init( BUTOTN_GPIO_PORT, BUTTON_GPIO_PIN, GPIO_Mode_In_PU_No_IT );
}

/**
  * @brief :按键查询
  * @param :无
  * @note  :无
  * @retval:
  *			0:按键没有按下
  *			1:检测到按键动作
  */
uint8_t drv_button_check( void )
{
	//查询引脚输入状态
	if( BUTTON_GPIO_PIN != ( GPIO_ReadInputData( BUTOTN_GPIO_PORT ) & BUTTON_GPIO_PIN ))	
	{
		drv_delay_ms( 40 );			//娑堟姈
		if( BUTTON_GPIO_PIN != ( GPIO_ReadInputData( BUTOTN_GPIO_PORT ) & BUTTON_GPIO_PIN ))
		{
			return 1;				//按键按下
		}
	}
	
	return 0;
}
