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
const char *label = "label!!";

uint8_t g_TxMode = 0;
uint8_t g_RF24L01RxBuffer[ 200 ] = { 0 };
uint8_t rssi_buffer[15] = {0};
int rssi=0;
@near int rssi_data[frame_num] = {0};
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
	uint8_t j = 0;
	uint8_t send_index = 0;
	uint8_t rece_index = 0;
	int index = 0;
	uint8_t current_loop = 0;
	uint8_t loop_num = frame_num/5;
	//���ڳ�ʼ��
	drv_uart_init( 38400 );
	
	//LED��ʼ��
	drv_led_init( );
	
	//SPI��ʼ��
	drv_spi_init( );
	
	//CC1101��ʼ��
	CC1101_Init( );
	for( i = 0; i < 8; i++ )
	{
		led_red_flashing( );
		led_green_flashing( );
		drv_delay_ms( 500 );
	}
	
	//�����Լ���RSSI
	led_green_on();
	while(1)
	{
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
			i = CC1101_Rx_Packet( g_RF24L01RxBuffer,&rssi );
			rece_index += i;
			while(rece_index<g_RF24L01RxBuffer[0]+1)
			{
				CC1101_Clear_RxBuffer( );
			  CC1101_Set_Mode( RX_MODE );
				i = CC1101_Rx_Packet( g_RF24L01RxBuffer+rece_index,&rssi );
				rece_index += i;
			}
			drv_uart_tx_bytes(g_RF24L01RxBuffer, rece_index);
		}
	}
	led_green_off();
	
	return 0;
	
		
	
		

	
}

