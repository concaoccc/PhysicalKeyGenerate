/**
  ******************************************************************************
  * @author  ÔóÒ«¿Æ¼¼ ASHINING
  * @version V3.0
  * @date    2016-10-08
  * @brief   BUTTONÅäÖÃHÎÄ¼ş
  ******************************************************************************
  * @attention
  *
  * ¹ÙÍø	:	http://www.ashining.com
  * ÌÔ±¦	:	https://shop105912646.taobao.com
  * °¢Àï°Í°Í:	https://cdzeyao.1688.com
  ******************************************************************************
  */


#ifndef __DRV_BUTTON_H__
#define __DRV_BUTTON_H__


#include "stm8l10x_gpio.h"


//°´¼üÓ²¼ş½Ó¿Ú¶¨Òå
#define BUTOTN_GPIO_PORT			GPIOC									
#define BUTTON_GPIO_PIN				GPIO_Pin_1


/** æŒ‰é”®çŠ¶æ€å®šä¹‰ */
enum
{
	BUTOTN_UP = 0,		//°´¼üÃ»ÓĞ°´ÏÂ
	BUTOTN_PRESS_DOWN	//°´¼ü°´ÏÂ
};



void drv_button_init( void );
uint8_t drv_button_check( void );

#endif

