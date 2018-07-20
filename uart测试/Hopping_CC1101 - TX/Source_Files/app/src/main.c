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
uint8_t g_TxMode = 0;
uint8_t g_UartRxBuffer[ 100 ] = { 0 };
uint8_t g_RF24L01RxBuffer[ 32 ] = { 0 }; 

int rssi=0;
uint8_t temp=65;
uint8_t rssi_ascii[3];

uint8_t *right="Right\n";
uint8_t *wrong="Wrong\n";
//uint8_t *changeline='\n';

int sendFlag=1;
int mChannel=0;
/**
  * @brief :������ 
  * @param :��
  * @note  :��
  * @retval:��
  */ 
int main( void )
{	
	uint8_t i = 0;

	//���ڳ�ʼ��
	drv_uart_init(19200);
	
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
	for( i =0; i< 100; i++)
	{
		drv_uart_tx_bytes( right, 6 );
	}
	/*
	//CC1101_Clear_RxBuffer( );
	//CC1101_Set_Mode( RX_MODE );

	while( 1 )	
	{
		
	
			
			//״̬��ʾ����
			led_green_off( );
			led_red_off( );
	
		
			if(sendFlag==1)
			{
				drv_delay_ms( 1000 );
				sendFlag=0;
					
					CC1101_Tx_Packet( (uint8_t *)g_Ashining, 8 , ADDRESS_CHECK );		//ģʽ1���͹̶��ַ�,1Sһ��
					//CC1101_Tx_Packet( (uint8_t *)g_Ashining, 8 , BROADCAST );
					led_red_flashing( );
					
					CC1101_Clear_RxBuffer( );
					CC1101_Set_Mode( RX_MODE );
			}
					
		
		
		i = CC1101_Rx_Packet( g_RF24L01RxBuffer,&rssi );		//�����ֽ�
		
		if( 0 != i )
		{
			if(rssi>128) rssi=rssi-256;
			rssi=rssi-114;
			ToAscii(rssi,rssi_ascii);
			sendFlag=1;
			led_green_flashing( );
			//drv_uart_tx_bytes( g_RF24L01RxBuffer, i );	//������յ����ֽ�
			drv_uart_tx_bytes( rssi_ascii, 3 );
			
			mChannel=mChannel+1;
			if(mChannel==255) return 0;
			setChannel(mChannel);
			//drv_uart_tx_bytes( changeline, 1 );
			/*
			if(rssi>100)
			{
					drv_uart_tx_bytes( wrong, 6 );
			}
			else
			{
					drv_uart_tx_bytes( right, 6 );
			}
			*/
		//}
	
	//}
	

	
	
		
	
		

	
}

