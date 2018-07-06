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
uint8_t g_TxMode = 1;

uint8_t g_UartRxBuffer[ 100 ] = { 0 };
uint8_t g_RF24L01RxBuffer[ 32 ] = { 0 }; 



/**
  * @brief :主函数 
  * @param :无
  * @note  :无
  * @retval:无
  */ 
int main( void )
{	
	uint8_t i = 0;
	char *data = "inited!";

	//串口初始化
	drv_uart_init( 9600 );
	
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
	drv_uart_tx_bytes(data,7);
	
#ifdef	__CC1101_TX_TEST__		
//=========================================================================================//	
//*****************************************************************************************//
//************************************* 发送 **********************************************//
//*****************************************************************************************//
//=========================================================================================//	
	
	//按键初始化
	drv_button_init( );

	while( 1 )	
	{
		//模式切换
		if( BUTOTN_PRESS_DOWN == drv_button_check( ))
		{
			g_TxMode = 1 - g_TxMode;		//模式会在 TX_MODE_1( 0 ),TX_MODE_2( 1 )之间切换
			
			//状态显示清零
			led_green_off( );
			led_red_off( );
			
			if( TX_MODE_1 == g_TxMode )
			{
				for( i = 0; i < 6; i++ )		
				{
					led_red_flashing( );	//固定发送模式，红灯闪烁3次
					drv_delay_ms( 500 );		
				}
			}
			else
			{
				for( i = 0; i < 6; i++ )
				{
					led_green_flashing( );	//串口发送模式，绿灯闪烁3次
					drv_delay_ms( 500 );
				}
			}
		}
		
		//发送
		if( TX_MODE_1 == g_TxMode )
		{
			CC1101_Tx_Packet( (uint8_t *)g_Ashining, 8 , ADDRESS_CHECK );		//模式1发送固定字符,1S一包
			drv_delay_ms( 1000 );	
			led_red_flashing( );			
		}
		else
		{	
			//查询串口数据
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
//************************************* 接收 **********************************************//
//*****************************************************************************************//
//=========================================================================================//	
	
	while( 1 )
	{
		CC1101_Clear_RxBuffer( );
		CC1101_Set_Mode( RX_MODE );
		i = CC1101_Rx_Packet( g_RF24L01RxBuffer );		//接收字节
		if( 0 != i )
		{
			led_green_flashing( );
			drv_uart_tx_bytes( g_RF24L01RxBuffer, i );	//输出接收到的字节
		}
	}
		
#endif
	
}

