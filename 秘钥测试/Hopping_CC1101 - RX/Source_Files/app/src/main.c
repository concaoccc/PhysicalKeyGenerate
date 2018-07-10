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
uint8_t rssi_buffer[15] = {0};
@near int rssi_data[frame_num] = { 0 };
int rssi=0;
uint8_t temp=65;
uint8_t rssi_ascii[3];

uint8_t *right="Right\n";
uint8_t *wrong="Wrong\n";
//uint8_t *changeline='\n';

int sendFlag=0;
uint8_t mChannel=0;
/**
  * @brief :������ 
  * @param :��
  * @note  :��
  * @retval:��
  */ 
int main( void )
{	
	uint8_t i = 0;
	uint8_t j = 0;
	
	uint8_t loop_num = frame_num/5;
	int index = 0;
	
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
	
	CC1101_Clear_RxBuffer( );
	CC1101_Set_Mode( RX_MODE );

	while( 1 )	
	{
		
	
			
			//״̬��ʾ����
			led_green_off( );
			led_red_off( );
	
		
			if(sendFlag==1)
			{
				sendFlag=0;
				//drv_delay_ms( 1000 );	
					//CC1101_Set_Mode( TX_MODE );
					CC1101_Tx_Packet( (uint8_t *)g_Ashining, 8 , ADDRESS_CHECK );		//ģʽ1���͹̶��ַ�,1Sһ��
					//CC1101_Tx_Packet( (uint8_t *)g_Ashining, 8 , BROADCAST );
					led_red_flashing( );
					
					
					mChannel=mChannel+1;
					if(mChannel==frame_num) break;
					setChannel(mChannel);
					CC1101_Clear_RxBuffer( );
					CC1101_Set_Mode( RX_MODE );
			}
					
		
		
		i = CC1101_Rx_Packet( g_RF24L01RxBuffer,&rssi );		//�����ֽ�
		
		if( 0 != i )
		{
			if(rssi>128) rssi=rssi-256;
			rssi=rssi-114;
			rssi_data[index] = rssi;
			index++;
			//ToAscii(rssi,rssi_ascii);
			sendFlag=1;
			led_red_flashing( );
			//drv_uart_tx_bytes( g_RF24L01RxBuffer, i );	//������յ����ֽ�
			//drv_uart_tx_bytes( rssi_ascii, 3 );
			
			
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
		}
	}
	
	//����rssi����
	for(i = 0; i < loop_num; i++)
	{
		for(j = 0; j < 5; j++)
		{
			ToAscii(rssi_data[i*5+j],rssi_ascii);
			rssi_buffer[j*3] = rssi_ascii[0];
			rssi_buffer[j*3+1] = rssi_ascii[1];
			rssi_buffer[j*3+2] = rssi_ascii[2];
		}
		drv_uart_tx_bytes( rssi_buffer, 15 );
	}
	return 0;
	

	
	
		
	
		

	
}

