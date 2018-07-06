/**
  ******************************************************************************
  * @author  ��ҫ�Ƽ� ASHINING
  * @version V3.0
  * @date    2016-10-08
  * @brief   BUTTON����C�ļ�
  ******************************************************************************
  * @attention
  *
  * ����	:	http://www.ashining.com
  * �Ա�	:	https://shop105912646.taobao.com
  * ����Ͱ�:	https://cdzeyao.1688.com
  ******************************************************************************
  */


#include "drv_button.h"
#include "drv_delay.h"



/**
  * @brief :������ʼ��
  * @param :��
  * @note  :��
  * @retval:��
  */ 
void drv_button_init( void )
{
	//����Ϊ���� ���� ���ж�
	GPIO_Init( BUTOTN_GPIO_PORT, BUTTON_GPIO_PIN, GPIO_Mode_In_PU_No_IT );
}

/**
  * @brief :������ѯ
  * @param :��
  * @note  :��
  * @retval:
  *			0:����û�а���
  *			1:��⵽��������
  */
uint8_t drv_button_check( void )
{
	//��ѯ��������״̬
	if( BUTTON_GPIO_PIN != ( GPIO_ReadInputData( BUTOTN_GPIO_PORT ) & BUTTON_GPIO_PIN ))	
	{
		drv_delay_ms( 40 );			//消抖
		if( BUTTON_GPIO_PIN != ( GPIO_ReadInputData( BUTOTN_GPIO_PORT ) & BUTTON_GPIO_PIN ))
		{
			return 1;				//��������
		}
	}
	
	return 0;
}
