/**
  ******************************************************************************
  * @author  泽耀科技 ASHINING
  * @version V3.0
  * @date    2016-10-08
  * @brief   主函数C文件
  ******************************************************************************
  * @attention
  *
  * 官网	:	http://www.ashining.com
  * 淘宝	:	https://shop105912646.taobao.com
  * 阿里巴巴:	https://cdzeyao.1688.com
  ******************************************************************************
  */



#include "main.h"					//main.h 中含有TX/RX、软件SPI/硬件SPI选择配置选项


const char *g_Ashining = "ashining";
uint8_t g_TxMode = 0;
uint8_t g_UartRxBuffer[ 200 ] = { 0 };
uint8_t send_test[5] = {1, 2, 3, 4, 5};

int rssi=0;
uint8_t temp=65;
uint8_t rssi_ascii[3];

uint8_t *right="Right\n";
uint8_t *wrong="Wrong\n";
//uint8_t *changeline='\n';

int sendFlag=1;
int mChannel=0;
/**
  * @brief :主函数 
  * @param :无
  * @note  :无
  * @retval:无
  */ 
int main( void )
{	
	uint8_t i = 0;
	uint8_t uart_receive_len = 0;

	//串口初始化
	drv_uart_init(38400);
	
	//LED初始化
	drv_led_init( );
	
	//SPI初始化
	drv_spi_init( );
	
	//CC1101初始化
	CC1101_Init( );
	for( i = 0; i < 6; i++ )
	{
		led_red_flashing( );
		led_green_flashing( );
		drv_delay_ms( 500 );
	}
	uart_receive_len = drv_uart_rx_bytes(g_UartRxBuffer);
	drv_uart_tx_bytes(g_UartRxBuffer ,uart_receive_len );
	
}

