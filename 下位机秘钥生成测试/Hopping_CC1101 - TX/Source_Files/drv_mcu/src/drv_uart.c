/**
  ******************************************************************************
  * @author  泽耀科技 ASHINING
  * @version V3.0
  * @date    2016-10-08
  * @brief   UART配置C文件
  ******************************************************************************
  * @attention
  *
  * 官网	:	http://www.ashining.com
  * 淘宝	:	https://shop105912646.taobao.com
  * 阿里巴巴:	https://cdzeyao.1688.com
  ******************************************************************************
  */


#include "drv_uart.h"



/**
  * @brief :串口初始化
  * @param :无
  * @note  :无
  * @retval:无
  */
void drv_uart_init( uint32_t UartBaudRate )
{
	//串口引脚配置 TX推挽输出 RX上拉输入
	GPIO_Init( UART_TX_GPIO_PORT, UART_TX_GPIO_PIN,GPIO_Mode_Out_PP_High_Slow  );
	GPIO_Init( UART_RX_GPIO_PORT, UART_RX_GPIO_PIN,GPIO_Mode_In_PU_No_IT );
	
	//USART外设配置
	CLK_PeripheralClockConfig( CLK_Peripheral_USART, ENABLE);	//使能串口时钟
	USART_DeInit();		//串口复位
	//串口初始化 8位数据 1个停止位 无校验 发送接收 波特率可变
	USART_Init( UartBaudRate, USART_WordLength_8D, USART_StopBits_1, USART_Parity_No, USART_Mode_Tx | USART_Mode_Rx );
	USART_Cmd(ENABLE);	//使能串口
}

/**
  * @brief :串口发送数据
  * @param :
  *			@TxBuffer:发送数据首地址
  *			@Length:数据长度
  * @note  :无
  * @retval:无
  */
void drv_uart_tx_bytes( uint8_t* TxBuffer, uint8_t Length )
{
	while( Length-- )
	{
		while( RESET == USART_GetFlagStatus( USART_FLAG_TXE ));
		USART_SendData8( * TxBuffer );
		TxBuffer++;
	}
}

/**
  * @brief :串口接收数据
  * @param :
  *			@RxBuffer:发送数据首地址
  * @note  :无
  * @retval:接收到的字节个数
  */
uint8_t drv_uart_rx_bytes( uint8_t* RxBuffer )
{
	uint8_t l_RxLength = 0;
	uint16_t l_UartRxTimOut = 0xFFF;
	
	while( l_UartRxTimOut-- )			//在超时范围内查询数据
	{
		if( RESET != USART_GetFlagStatus( USART_FLAG_RXNE ))
		{
			*RxBuffer = USART_ReceiveData8( );
			RxBuffer++;
			l_RxLength++;
			l_UartRxTimOut = 0xFFF;		//恢复超时等待时间
		}
		if( 100 == l_RxLength )
		{
			break;						//字节不能超过100个字节，由于部分8位机内存较小，接收buffer开得较小
		}
	}
	
	return l_RxLength;					//返回接收到的字节个数
}

