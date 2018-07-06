/**
  ******************************************************************************
  * @author  泽耀科技 ASHINING
  * @version V3.0
  * @date    2016-10-08
  * @brief   CC1101配置H文件
  ******************************************************************************
  * @attention
  *
  * 官网	:	http://www.ashining.com
  * 淘宝	:	https://shop105912646.taobao.com
  * 阿里巴巴:	https://cdzeyao.1688.com
  ******************************************************************************
  */



#ifndef __DRV_CC1101_H__
#define __DRV_CC1101_H__


#include "drv_spi.h"
#include "drv_CC1101_Reg.h"


#define PA_TABLE 						{0xc2,0x00,0x00,0x00,0x00,0x00,0x00,0x00,}

/** CC1101硬件接口定义 */
#define CC1101_GDO0_GPIO_PORT			GPIOB
#define CC1101_GDO0_GPIO_PIN			GPIO_Pin_3

#define CC1101_GDO2_GPIO_PORT			GPIOC
#define CC1101_GDO2_GPIO_PIN			GPIO_Pin_0

#define CC1101_CSN_GPIO_PORT			SPI_NSS_GPIO_PORT			//PG7
#define CC1101_CSN_GPIO_PIN				SPI_NSS_GPIO_PIN



/** 口线操作函数定义 */
#define CC1101_SET_CSN_HIGH( )			spi_set_nss_high( )
#define CC1101_SET_CSN_LOW( )			spi_set_nss_low( )

#define CC1101_GET_GDO0_STATUS( )		(( CC1101_GDO0_GPIO_PORT->IDR & (uint32_t)CC1101_GDO0_GPIO_PIN) != CC1101_GDO0_GPIO_PIN ) ? 0 : 1	//GDO0状态
#define CC1101_GET_GDO2_STATUS( )		(( CC1101_GDO2_GPIO_PORT->IDR & (uint32_t)CC1101_GDO2_GPIO_PIN) != CC1101_GDO2_GPIO_PIN ) ? 0 : 1	//GDO2状态

/** 枚举量定义 */
typedef enum 
{ 
	TX_MODE, 
	RX_MODE 
}CC1101_ModeType;

typedef enum 
{ 
	BROAD_ALL, 
	BROAD_NO, 
	BROAD_0, 
	BROAD_0AND255 
}CC1101_AddrModeType;

typedef enum 
{ 
	BROADCAST, 
	ADDRESS_CHECK
} CC1101_TxDataModeType;


void CC1101_Write_Cmd( uint8_t Command );
void CC1101_Write_Reg( uint8_t Addr, uint8_t WriteValue );
void CC1101_Write_Multi_Reg( uint8_t Addr, uint8_t *pWriteBuff, uint8_t WriteSize );
uint8_t CC1101_Read_Reg( uint8_t Addr );
void CC1101_Read_Multi_Reg( uint8_t Addr, uint8_t *pReadBuff, uint8_t ReadSize );
uint8_t CC1101_Read_Status( uint8_t Addr );
void CC1101_Set_Mode( CC1101_ModeType Mode );
void CC1101_Set_Idle_Mode( void );
void C1101_WOR_Init( void );
void CC1101_Set_Address( uint8_t address, CC1101_AddrModeType AddressMode);
void CC1101_Set_Sync( uint16_t Sync );
void CC1101_Clear_TxBuffer( void );
void CC1101_Clear_RxBuffer( void );
void CC1101_Tx_Packet( uint8_t *pTxBuff, uint8_t TxSize, CC1101_TxDataModeType DataMode );
uint8_t CC1101_Get_RxCounter( void );
uint8_t CC1101_Rx_Packet( uint8_t *RxBuff );
void CC1101_Reset( void );
void CC1101_Init( void );


#endif
