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
uint8_t g_RF24L01RxBuffer[ 200 ] = { 0 }; 
uint8_t rssi_buffer[15] = {0};
@near int rssi_data[frame_num] = { 0 };
//@near int tmp_value_2[frame_num] = {0 };
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
	uint8_t send_index = 0;
	uint8_t rece_index = 0;
	
	uint8_t loop_num = frame_num/5;
	int index = 0;
	
	//���ڳ�ʼ��
	drv_uart_init( 38400);
	
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
				  drv_delay_ms( 10 );	
					//CC1101_Set_Mode( TX_MODE );
					CC1101_Tx_Packet( (uint8_t *)g_Ashining, 8 , ADDRESS_CHECK );		//ģʽ1���͹̶��ַ�,1Sһ��
					//CC1101_Tx_Packet( (uint8_t *)g_Ashining, 8 , BROADCAST );
					led_red_off( );
					
					
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
			led_red_on( );
			//drv_uart_tx_bytes( g_RF24L01RxBuffer, i );	//������յ����ֽ�
			//drv_uart_tx_bytes( rssi_ascii, 3 );
			
			
			//drv_uart_tx_bytes( changeline, 1 );
		}
	}
	
	//����rssi����
	//led_green_on();
	led_green_off();
	led_red_off();
	/*
	for(i = 0; i < loop_num; i++)
	{
		for(j = 0; j < 5; j++)
		{
			ToAscii(rssi_data[i*5+j],rssi_ascii);
			rssi_buffer[j*3] = rssi_ascii[0];
			rssi_buffer[j*3+1] = rssi_ascii[1];
			rssi_buffer[j*3+2] = rssi_ascii[2];
		}
		
		drv_delay_ms(10);
		CC1101_Tx_Packet( rssi_buffer, 15 , ADDRESS_CHECK );	
		
	}
	*/
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
	//����׼������ģʽ
	while(1)
	{
		//���ȵȴ���Ƶ
		
			i = drv_uart_rx_bytes( g_RF24L01RxBuffer);
		if (i != 0)
		{
			while(send_index < i-60)
			{
				CC1101_Tx_Packet( g_RF24L01RxBuffer+send_index, 60 , ADDRESS_CHECK );
				send_index += 60;
			}
			CC1101_Tx_Packet( g_RF24L01RxBuffer+send_index, i-send_index , ADDRESS_CHECK );
			send_index = 0;
			CC1101_Clear_RxBuffer( );
			CC1101_Set_Mode( RX_MODE );
			while(1)
			{
				
				i = CC1101_Rx_Packet( g_RF24L01RxBuffer,&rssi );
				if(i != 0)
				{
					rece_index += i;
					while(rece_index< g_RF24L01RxBuffer[0]+1)
					{
						CC1101_Clear_RxBuffer( );
			      CC1101_Set_Mode( RX_MODE );
						i = CC1101_Rx_Packet( g_RF24L01RxBuffer+rece_index,&rssi );
						rece_index += i;
					}
					led_green_on();
					drv_uart_tx_bytes(g_RF24L01RxBuffer, rece_index);
					
					rece_index = 0;
					break;
				}
			}
		}
		
	}
	led_green_off( );
	return 0;
	

	
	
		
	
		

	
}

