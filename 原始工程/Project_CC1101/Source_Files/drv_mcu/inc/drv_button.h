/**
  ******************************************************************************
  * @author  ��ҫ�Ƽ� ASHINING
  * @version V3.0
  * @date    2016-10-08
  * @brief   BUTTON����H�ļ�
  ******************************************************************************
  * @attention
  *
  * ����	:	http://www.ashining.com
  * �Ա�	:	https://shop105912646.taobao.com
  * ����Ͱ�:	https://cdzeyao.1688.com
  ******************************************************************************
  */


#ifndef __DRV_BUTTON_H__
#define __DRV_BUTTON_H__


#include "stm8l10x_gpio.h"


//����Ӳ���ӿڶ���
#define BUTOTN_GPIO_PORT			GPIOC									
#define BUTTON_GPIO_PIN				GPIO_Pin_1


/** 按键状态定义 */
enum
{
	BUTOTN_UP = 0,		//����û�а���
	BUTOTN_PRESS_DOWN	//��������
};



void drv_button_init( void );
uint8_t drv_button_check( void );

#endif

