/**
  ******************************************************************************
  * @author  泽耀科技 ASHINING
  * @version V3.0
  * @date    2016-10-08
  * @brief   SPI配置C文件
  ******************************************************************************
  * @attention
  *
  * 官网	:	http://www.ashining.com
  * 淘宝	:	https://shop105912646.taobao.com
  * 阿里巴巴:	https://cdzeyao.1688.com
  ******************************************************************************
  */



#include "drv_spi.h"


#ifndef __USE_SOFT_SPI_INTERFACE__
/** 硬件SPI */

//SPI等待超时
#define SPI_WAIT_TIMEOUT			((uint16_t)0xFFFF)


/**
  * @brief :SPI初始化（硬件）
  * @param :无
  * @note  :无
  * @retval:无
  */
void drv_spi_init( void )
{
	//SPI引脚配置 SCK MOSI NSS 配置为推挽输出 MISO配置为输入
	GPIO_Init( SPI_CLK_GPIO_PORT, SPI_CLK_GPIO_PIN, GPIO_Mode_Out_PP_Low_Fast  );
	GPIO_Init( SPI_MOSI_GPIO_PORT, SPI_MOSI_GPIO_PIN, GPIO_Mode_Out_PP_High_Slow  );
	GPIO_Init( SPI_NSS_GPIO_PORT, SPI_NSS_GPIO_PIN, GPIO_Mode_Out_PP_High_Slow  );
	GPIO_Init( SPI_MISO_GPIO_PORT, SPI_MISO_GPIO_PIN, GPIO_Mode_In_PU_No_IT  );
	
	//SPI外设配置
	CLK_PeripheralClockConfig( CLK_Peripheral_SPI,ENABLE );		//开SPI时钟
	SPI_DeInit( );		//SPI复位
	//SPI外设初始化
	SPI_Init( SPI_FirstBit_MSB, SPI_BaudRatePrescaler_8, SPI_Mode_Master, SPI_CPOL_Low, SPI_CPHA_1Edge, SPI_Direction_2Lines_FullDuplex, SPI_NSS_Soft );
	SPI_Cmd( ENABLE );	//SPI使能
}

/**
  * @brief :SPI收发一个字节
  * @param :
  *			@TxByte: 发送的数据字节
  * @note  :非堵塞式，一旦等待超时，函数会自动退出
  * @retval:接收到的字节
  */
uint8_t drv_spi_read_write_byte( uint8_t TxByte )
{
	uint8_t l_Data = 0;
	uint16_t l_WaitTime = 0;
	
	while( RESET == SPI_GetFlagStatus( SPI_FLAG_TXE ) )		//等待发送缓冲区空
	{
		if( SPI_WAIT_TIMEOUT == ++l_WaitTime )
		{
			break;			//等待超时
		}
	}
	SPI_SendData( TxByte );	//发送数据
	l_WaitTime = SPI_WAIT_TIMEOUT / 2;
	while( RESET == SPI_GetFlagStatus( SPI_FLAG_RXNE ) )	//等待接收缓冲区非空
	{
		if( SPI_WAIT_TIMEOUT == ++l_WaitTime )
		{
			break;			//等待超时
		}
	}
	
	l_Data = SPI_ReceiveData( );
	return l_Data;	//返回数据
}

/**
  * @brief :SPI收发字符串
  * @param :
  *			@ReadBuffer: 接收数据缓冲区地址
  *			@WriteBuffer:发送字节缓冲区地址
  *			@Length:字节长度
  * @note  :非堵塞式，一旦等待超时，函数会自动退出
  * @retval:无
  */
void drv_spi_read_write_string( uint8_t* ReadBuffer, uint8_t* WriteBuffer, uint16_t Length )
{
	GPIO_ResetBits( SPI_NSS_GPIO_PORT, SPI_NSS_GPIO_PIN);			//片选
	while( Length-- )
	{
		*ReadBuffer = drv_spi_read_write_byte( *WriteBuffer );		//一个字节的数据收发
		ReadBuffer++;
		WriteBuffer++;				//地址加1
	}
	GPIO_SetBits( SPI_NSS_GPIO_PORT, SPI_NSS_GPIO_PIN);				//取消片选
}

/** 硬件SPI */
#endif






#ifdef __USE_SOFT_SPI_INTERFACE__
/** 软件SPI */


/**
  * @brief :SPI初始化（软件）
  * @param :无
  * @note  :无
  * @retval:无
  */
void drv_spi_init( void )
{
	//SPI引脚配置 SCK MOSI NSS 配置为推挽输出 MISO配置为输入
	GPIO_Init( SPI_CLK_GPIO_PORT, SPI_CLK_GPIO_PIN, GPIO_Mode_Out_PP_Low_Fast  );
	GPIO_Init( SPI_MOSI_GPIO_PORT, SPI_MOSI_GPIO_PIN, GPIO_Mode_Out_PP_High_Fast  );
	GPIO_Init( SPI_NSS_GPIO_PORT, SPI_NSS_GPIO_PIN, GPIO_Mode_Out_PP_High_Slow  );
	GPIO_Init( SPI_MISO_GPIO_PORT, SPI_MISO_GPIO_PIN, GPIO_Mode_In_PU_No_IT  );
}

/**
  * @brief :SPI收发一个字节
  * @param :
  *			@TxByte: 发送的数据字节
  * @note  :非堵塞式，一旦等待超时，函数会自动退出
  * @retval:接收到的字节
  */
uint8_t drv_spi_read_write_byte( uint8_t TxByte )
{
	uint8_t i = 0, Data = 0;
	
	spi_set_clk_low( );
	
	/** 发送 */
	for( i = 0; i < 8; i++ )			//一个字节8位，循环8次	
	{
		
		if( 0x80 == ( TxByte & 0x80 ))
		{
			spi_set_mosi_hight( );		//bit == 1，口线置高
		}
		else
		{
			spi_set_mosi_low( );		//bit == 0，口线置低
		}
		TxByte <<= 1;					//向右移位，MSB先发
		
		spi_set_clk_high( );			//时钟置高
		
		;
		
		/** 接收 */
		Data <<= 1;						//接收数据右移
		if( 1 == spi_get_miso( ))
		{
			Data |= 0x01;				//如果口线状态为高，则相应bit = 1
		}
		
		spi_set_clk_low( );				//时钟置低
		
		;
	}
	
	return Data;		//返回接收到的数据
}

/**
  * @brief :SPI收发字符串
  * @param :
  *			@ReadBuffer: 接收数据缓冲区地址
  *			@WriteBuffer:发送字节缓冲区地址
  *			@Length:字节长度
  * @note  :非堵塞式，一旦等待超时，函数会自动退出
  * @retval:无
  */
void drv_spi_read_write_string( uint8_t* ReadBuffer, uint8_t* WriteBuffer, uint16_t Length )
{
	spi_set_nss_low( );			//片选
	
	while( Length-- )
	{
		*ReadBuffer = drv_spi_read_write_byte( *WriteBuffer );		//交换一个字节
		ReadBuffer++;
		WriteBuffer++;			//地址加1
	}
	
	spi_set_nss_high( );		//取消片选
}


/** 软件SPI */
#endif


