/**
  ******************************************************************************
  * @author  泽耀科技 ASHINING
  * @version V3.0
  * @date    2016-10-08
  * @brief   DELAY配置C文件
  ******************************************************************************
  * @attention
  *
  * 官网	:	http://www.ashining.com
  * 淘宝	:	https://shop105912646.taobao.com
  * 阿里巴巴:	https://cdzeyao.1688.com
  ******************************************************************************
  */



#include "drv_delay.h"



/**
  * @brief :1MS延时函数
  * @param :
  * @note  :12MHz 下1MS延时
  * @retval:无
  */
static void drv_delay_1ms( void )
{
	uint16_t Ms = 1;
	uint32_t j = 30;
	
	while( Ms-- )
	{
		while( j-- );
	}
}

/**
  * @brief :MS延时函数
  * @param :
  *			@Ms:延时的MS数
  * @note  :无
  * @retval:无
  */
void drv_delay_ms( uint16_t Ms )
{
	while( Ms-- )
	{
		drv_delay_1ms( );
	}
}

