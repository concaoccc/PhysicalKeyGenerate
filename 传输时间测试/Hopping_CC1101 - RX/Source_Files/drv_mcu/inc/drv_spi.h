/**
  ******************************************************************************
  * @author  ��ҫ�Ƽ� ASHINING
  * @version V3.0
  * @date    2016-10-08
  * @brief   SPI����H�ļ�
  ******************************************************************************
  * @attention
  *
  * ����	:	http://www.ashining.com
  * �Ա�	:	https://shop105912646.taobao.com
  * ����Ͱ�:	https://cdzeyao.1688.com
  ******************************************************************************
  */


#ifndef __DRV_SPI_H__
#define __DRV_SPI_H__


#ifndef __USE_SOFT_SPI_INTERFACE__
#include "stm8l10x_clk.h"
#endif
#include "stm8l10x_gpio.h"
#include "stm8l10x_spi.h"
#include "main.h"


//SPIӲ���ӿ�IO����
#define SPI_CLK_GPIO_PORT			GPIOB
#define SPI_CLK_GPIO_PIN			GPIO_Pin_5

#define SPI_MISO_GPIO_PORT			GPIOB
#define SPI_MISO_GPIO_PIN			GPIO_Pin_7

#define SPI_MOSI_GPIO_PORT			GPIOB
#define SPI_MOSI_GPIO_PIN			GPIO_Pin_6

#define SPI_NSS_GPIO_PORT			GPIOB
#define SPI_NSS_GPIO_PIN			GPIO_Pin_4


#define spi_set_nss_high( )			GPIO_SetBits( SPI_NSS_GPIO_PORT, SPI_NSS_GPIO_PIN )		//NSS�øߣ�ȡ��Ƭѡ
#define spi_set_nss_low( )			GPIO_ResetBits( SPI_NSS_GPIO_PORT, SPI_NSS_GPIO_PIN )	//NSS�õͣ�Ƭѡ���豸



#ifdef __USE_SOFT_SPI_INTERFACE__					
/** ���ģ��SPI������������ */

#define spi_set_clk_high( )			GPIO_SetBits( SPI_CLK_GPIO_PORT, SPI_CLK_GPIO_PIN )		//ʱ���ø�
#define spi_set_clk_low( )			GPIO_ResetBits( SPI_CLK_GPIO_PORT, SPI_CLK_GPIO_PIN )	//ʱ���õ�

#define spi_set_mosi_hight( )		GPIO_SetBits( SPI_MOSI_GPIO_PORT, SPI_MOSI_GPIO_PIN )	//����øߣ�������
#define spi_set_mosi_low( )			GPIO_ResetBits( SPI_MOSI_GPIO_PORT, SPI_MOSI_GPIO_PIN )	//����õͣ�������

#define spi_get_miso( )				( 0 == GPIO_ReadInputDataBit( SPI_MISO_GPIO_PORT, SPI_MISO_GPIO_PIN )) ? 0 : 1 // ��ȡ����״̬

#endif


void drv_spi_init( void );
uint8_t drv_spi_read_write_byte( uint8_t TxByte );
void drv_spi_read_write_string( uint8_t* ReadBuffer, uint8_t* WriteBuffer, uint16_t Length );


#endif

