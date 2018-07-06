/**
  ******************************************************************************
  * @author  ��ҫ�Ƽ� ASHINING
  * @version V3.0
  * @date    2016-10-08
  * @brief   ������C�ļ�
  ******************************************************************************
  * @attention
  *
  * ����	:	http://www.ashining.com
  * �Ա�	:	https://shop105912646.taobao.com
  * ����Ͱ�:	https://cdzeyao.1688.com
  ******************************************************************************
  */



#include "main.h"					//main.h �к���TX/RX�����SPI/Ӳ��SPIѡ������ѡ��


const char *g_Ashining = "ashining";
uint8_t g_TxMode = 1;

uint8_t g_UartRxBuffer[ 100 ] = { 0 };
uint8_t g_RF24L01RxBuffer[ 32 ] = { 0 }; 



/**
  * @brief :������ 
  * @param :��
  * @note  :��
  * @retval:��
  */ 
int main( void )
{	
	uint8_t i = 0;
	char *data = "inited!";

	//���ڳ�ʼ��
	drv_uart_init( 9600 );
	
	//LED��ʼ��
	drv_led_init( );
	
	//SPI��ʼ��
	drv_spi_init( );
	
	//CC1101��ʼ��
	CC1101_Init( );
	for( i = 0; i < 6; i++ )
	{
		led_red_flashing( );
		led_green_flashing( );
		drv_delay_ms( 500 );
	}
	drv_uart_tx_bytes(data,7);
	
#ifdef	__CC1101_TX_TEST__		
//=========================================================================================//	
//*****************************************************************************************//
//************************************* ���� **********************************************//
//*****************************************************************************************//
//=========================================================================================//	
	
	//������ʼ��
	drv_button_init( );

	while( 1 )	
	{
		//ģʽ�л�
		if( BUTOTN_PRESS_DOWN == drv_button_check( ))
		{
			g_TxMode = 1 - g_TxMode;		//ģʽ���� TX_MODE_1( 0 ),TX_MODE_2( 1 )֮���л�
			
			//״̬��ʾ����
			led_green_off( );
			led_red_off( );
			
			if( TX_MODE_1 == g_TxMode )
			{
				for( i = 0; i < 6; i++ )		
				{
					led_red_flashing( );	//�̶�����ģʽ�������˸3��
					drv_delay_ms( 500 );		
				}
			}
			else
			{
				for( i = 0; i < 6; i++ )
				{
					led_green_flashing( );	//���ڷ���ģʽ���̵���˸3��
					drv_delay_ms( 500 );
				}
			}
		}
		
		//����
		if( TX_MODE_1 == g_TxMode )
		{
			CC1101_Tx_Packet( (uint8_t *)g_Ashining, 8 , ADDRESS_CHECK );		//ģʽ1���͹̶��ַ�,1Sһ��
			drv_delay_ms( 1000 );	
			led_red_flashing( );			
		}
		else
		{	
			//��ѯ��������
			i = drv_uart_rx_bytes( g_UartRxBuffer );
			
			if( 0 != i )
			{
				CC1101_Tx_Packet( g_UartRxBuffer, i , ADDRESS_CHECK );
				led_red_flashing( );
			}
		}
	}
	
#else		
//=========================================================================================//	
//*****************************************************************************************//
//************************************* ���� **********************************************//
//*****************************************************************************************//
//=========================================================================================//	
	
	while( 1 )
	{
		CC1101_Clear_RxBuffer( );
		CC1101_Set_Mode( RX_MODE );
		i = CC1101_Rx_Packet( g_RF24L01RxBuffer );		//�����ֽ�
		if( 0 != i )
		{
			led_green_flashing( );
			drv_uart_tx_bytes( g_RF24L01RxBuffer, i );	//������յ����ֽ�
		}
	}
		
#endif
	
}

