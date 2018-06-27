/**
  ******************************************************************************
  * @author  ��ҫ�Ƽ� ASHINING
  * @version V3.0
  * @date    2016-10-08
  * @brief   CC1101����C�ļ�
  ******************************************************************************
  * @attention
  *
  * ����	:	http://www.ashining.com
  * �Ա�	:	https://shop105912646.taobao.com
  * ����Ͱ�:	https://cdzeyao.1688.com
  ******************************************************************************
  */


#include "drv_CC1101.h"
#include "drv_delay.h"


//10, 7, 5, 0, -5, -10, -15, -20, dbm output power, 0x12 == -30dbm
const uint8_t PaTabel[ ] = { 0xc0, 0xC8, 0x84, 0x60, 0x68, 0x34, 0x1D, 0x0E};
static const uint8_t CC1101InitData[ 22 ][ 2 ]= 
{
  { CC1101_IOCFG0,      0x06 },
  { CC1101_FIFOTHR,     0x47 },
  { CC1101_PKTCTRL0,    0x05 },
  { CC1101_CHANNR,      0x96 },	//430M
  { CC1101_FSCTRL1,     0x06 },
  { CC1101_FREQ2,       0x0F },
  { CC1101_FREQ1,       0x62 },
  { CC1101_FREQ0,       0x76 },
  { CC1101_MDMCFG4,     0xF6 },
  { CC1101_MDMCFG3,     0x43 },
  { CC1101_MDMCFG2,     0x13 },
  { CC1101_DEVIATN,     0x15 },
  { CC1101_MCSM0,       0x18 },
  { CC1101_FOCCFG,      0x16 },
  { CC1101_WORCTRL,     0xFB },
  { CC1101_FSCAL3,      0xE9 },
  { CC1101_FSCAL2,      0x2A },
  { CC1101_FSCAL1,      0x00 },
  { CC1101_FSCAL0,      0x1F },
  { CC1101_TEST2,       0x81 },
  { CC1101_TEST1,       0x35 },
  { CC1101_MCSM1,       0x3B },
};


/**
  * @brief :CC1101д����
  * @param :
  *			@Command������
  * @note  :��
  * @retval:��
  */
void CC1101_Write_Cmd( uint8_t Command )
{
    CC1101_SET_CSN_LOW( );					//SPIƬѡ���������иú�����������SPIƬѡ
	
    drv_spi_read_write_byte( Command );		//д����
	
    CC1101_SET_CSN_HIGH( );					//SPIȡ��Ƭѡ���������иú�����������ȡ��SPIƬѡ					
}

/**
  * @brief :CC1101д�Ĵ���
  * @param :
  *			@Addr����ַ
  *			@WriteValue��д��������ֽ�
  * @note  :��
  * @retval:��
  */
void CC1101_Write_Reg( uint8_t Addr, uint8_t WriteValue )
{
	CC1101_SET_CSN_LOW( );					
	
    drv_spi_read_write_byte( Addr );		//д��ַ
    drv_spi_read_write_byte( WriteValue );	//д����
	
    CC1101_SET_CSN_HIGH( );					
}

/**
  * @brief :CC1101����д�Ĵ���
  * @param :
  *			@Addr����ַ
  *			@pWriteBuff��д������ݴ��׵�ַ
  *			@WriteSize��д������ݸ���
  * @note  :��
  * @retval:��
  */
void CC1101_Write_Multi_Reg( uint8_t Addr, uint8_t *pWriteBuff, uint8_t WriteSize )
{
    uint8_t i;
	
    CC1101_SET_CSN_LOW( );					
	
    drv_spi_read_write_byte( Addr | WRITE_BURST );	//����д���� ���׵�ַ
    for( i = 0; i < WriteSize; i ++ )
    {
        drv_spi_read_write_byte( *( pWriteBuff + i ) );	//����д������
    }
	
    CC1101_SET_CSN_HIGH( );					
}

/**
  * @brief :CC1101���Ĵ���
  * @param :
  *			@Addr����ַ
  * @note  :��
  * @retval:�Ĵ���ֵ
  */
uint8_t CC1101_Read_Reg( uint8_t Addr )
{
    uint8_t l_RegValue = 0;
	
    CC1101_SET_CSN_LOW( );
	
    drv_spi_read_write_byte( Addr | READ_SINGLE );	//���������� ����ַ
    l_RegValue = drv_spi_read_write_byte( 0xFF );	//��ȡ�Ĵ���
	
    CC1101_SET_CSN_HIGH( );
	
    return l_RegValue;
}

/**
  * @brief :CC1101��һ���Ĵ���״̬
  * @param :
  *			@Addr����ַ
  * @note  :��
  * @retval:�Ĵ���״̬
  */
uint8_t CC1101_Read_Status( uint8_t Addr )
{
    uint8_t l_RegStatus = 0;
	
    CC1101_SET_CSN_LOW( );
	
    drv_spi_read_write_byte( Addr | READ_BURST );	//���������� ����ַ
    l_RegStatus = drv_spi_read_write_byte( 0xFF );	//��ȡ״̬
	
    CC1101_SET_CSN_HIGH( );
	
    return l_RegStatus;
}

/**
  * @brief :CC1101�������Ĵ���
  * @param :
  *			@Addr����ַ
  *			@pReadBuff����ȡ���ݴ���׵�ַ
  *			@ReadSize����ȡ���ݵĸ���
  * @note  :��
  * @retval:��
  */
void CC1101_Read_Multi_Reg( uint8_t Addr, uint8_t *pReadBuff, uint8_t ReadSize )
{
    uint8_t i = 0, j = 0;
	
    CC1101_SET_CSN_LOW( );
	
    drv_spi_read_write_byte( Addr | READ_BURST);	//���������� ���׵�ַ
    for( i = 0; i < ReadSize; i ++ )
    {
        for( j = 0; j < 20; j ++ );
        *( pReadBuff + i ) = drv_spi_read_write_byte( 0xFF );	//������ȡ����
    }
	
    CC1101_SET_CSN_HIGH( );
}

/**
  * @brief :CC1101���ͽ���ģʽ����
  * @param :
  *			@Mode��TX_MODE������ģʽ RX_MODE������ģʽ
  * @note  :��
  * @retval:�Ĵ���״̬
  */
void CC1101_Set_Mode( CC1101_ModeType Mode )
{
	uint8_t WaitTimeOut = 0;
	
    if( Mode == TX_MODE )			//����ģʽ
    {
        CC1101_Write_Reg( CC1101_IOCFG0,0x46 );
        CC1101_Write_Cmd( CC1101_STX );		
    }
    else if( Mode == RX_MODE )		//����ģʽ
    {
        CC1101_Write_Reg(CC1101_IOCFG0,0x46);
        CC1101_Write_Cmd( CC1101_SRX );
    }
	
	while( 0 != CC1101_GET_GDO0_STATUS( ));		//�ȴ����� �� ���տ�ʼ
}

/**
  * @brief :CC1101�������ģʽ
  * @param :��
  * @note  :��
  * @retval:��
  */ 
void CC1101_Set_Idle_Mode( void )
{
    CC1101_Write_Cmd( CC1101_SIDLE );
}

/**
  * @brief :CC1101��ʼ��WOR����
  * @param :��
  * @note  :��
  * @retval:��
  */ 
void C1101_WOR_Init( void )
{
    CC1101_Write_Reg(CC1101_MCSM0,0x18);		
    CC1101_Write_Reg(CC1101_WORCTRL,0x78); 
    CC1101_Write_Reg(CC1101_MCSM2,0x00);
    CC1101_Write_Reg(CC1101_WOREVT1,0x8C);
    CC1101_Write_Reg(CC1101_WOREVT0,0xA0);
	CC1101_Write_Cmd( CC1101_SWORRST );		//д��WOR����
}

/**
  * @brief :CC1101���õ�ַ
  * @param :
  *			@Address�����õ��豸��ֵַ
  *			@AddressMode����ַ���ģʽ
  * @note  :��
  * @retval:��
  */
void CC1101_Set_Address( uint8_t Address, CC1101_AddrModeType AddressMode)
{
    uint8_t btmp = 0;
	
	btmp = CC1101_Read_Reg( CC1101_PKTCTRL1 ) & ~0x03;	//��ȡCC1101_PKTCTRL1�Ĵ�����ʼֵ
    CC1101_Write_Reg( CC1101_ADDR, Address );			//�����豸��ַ
	
    if( AddressMode == BROAD_ALL )     { }				//������ַ
    else if( AddressMode == BROAD_NO  )
	{ 
		btmp |= 0x01;									//����ַ ���ǲ����㲥
	}
    else if( AddressMode == BROAD_0   )
	{ 
		btmp |= 0x02;									//0x00Ϊ�㲥
	}
    else if( AddressMode == BROAD_0AND255 ) 
	{
		btmp |= 0x03; 									//0x00 0xFFΪ�㲥
	} 

	CC1101_Write_Reg( CC1101_PKTCTRL1, btmp);			//д���ַģʽ	
}

/**
  * @brief :CC1101����ͬ���ֶ�
  * @param :��
  * @note  :��
  * @retval:��
  */
void CC1101_Set_Sync( uint16_t Sync )
{
    CC1101_Write_Reg( CC1101_SYNC1, 0xFF & ( Sync >> 8 ) );
    CC1101_Write_Reg( CC1101_SYNC0, 0xFF & Sync ); 	//д��ͬ���ֶ� 16Bit
}

/**
  * @brief :CC1101��շ��ͻ�����
  * @param :��
  * @note  :��
  * @retval:��
  */ 
void CC1101_Clear_TxBuffer( void )
{
    CC1101_Set_Idle_Mode( );					//���Ƚ���IDLEģʽ
    CC1101_Write_Cmd( CC1101_SFTX );			//д���巢�ͻ���������		
}

/**
  * @brief :CC1101��ս��ջ�����
  * @param :��
  * @note  :��
  * @retval:��
  */
void CC1101_Clear_RxBuffer( void )
{
    CC1101_Set_Idle_Mode();						//���Ƚ���IDLEģʽ
    CC1101_Write_Cmd( CC1101_SFRX );			//д������ջ���������
}

/**
  * @brief :CC1101�������ݰ�
  * @param :
  *			@pTxBuff���������ݻ�����
  *			@TxSize���������ݳ���
  *			@DataMode������ģʽ
  * @note  :��
  * @retval:��
  */ 
void CC1101_Tx_Packet( uint8_t *pTxBuff, uint8_t TxSize, CC1101_TxDataModeType DataMode )
{
    uint8_t Address;
	uint16_t l_RxWaitTimeout = 0;
	
    if( DataMode == BROADCAST )             
	{
		Address = 0; 
	}
    else if( DataMode == ADDRESS_CHECK )    
	{ 
		Address = CC1101_Read_Reg( CC1101_ADDR ); 
	}

    CC1101_Clear_TxBuffer( );
    
    if(( CC1101_Read_Reg( CC1101_PKTCTRL1 ) & 0x03 ) != 0 )	
    {
        CC1101_Write_Reg( CC1101_TXFIFO, TxSize + 1 );		
        CC1101_Write_Reg( CC1101_TXFIFO, Address );			//д�볤�Ⱥ͵�ַ ���ڶ�һ���ֽڵ�ַ��ʱ����Ӧ�ü�1
    }
    else
    {
        CC1101_Write_Reg( CC1101_TXFIFO, TxSize );			//ֻд���� ������ַ
    }

    CC1101_Write_Multi_Reg( CC1101_TXFIFO, pTxBuff, TxSize );	//д������
    CC1101_Set_Mode( TX_MODE );								//����ģʽ
	
	while( 0 == CC1101_GET_GDO0_STATUS( ))		//�ȴ��������
	{
		drv_delay_ms( 1 );
		if( 1000 == l_RxWaitTimeout++ )
		{
			l_RxWaitTimeout = 0;
			CC1101_Init( );
			break; 
		} 
	} 
}

/**
  * @brief :CC1101��ȡ���յ����ֽ���
  * @param :��
  * @note  :��
  * @retval:���յ������ݸ���
  */
uint8_t CC1101_Get_RxCounter( void )
{
    return ( CC1101_Read_Status( CC1101_RXBYTES ) & BYTES_IN_RXFIFO );	
}

/**
  * @brief :CC1101�������ݰ�
  * @param :
  *			@RxBuff���������ݻ�����
  * @note  :��
  * @retval�����յ����ֽ�����0��ʾ������
  */
uint8_t CC1101_Rx_Packet( uint8_t *RxBuff )
{
	uint8_t l_PktLen = 0;
    uint8_t l_Status[ 2 ] = { 0 };
	uint16_t l_RxWaitTimeout = 0;

	while( 0 == CC1101_GET_GDO0_STATUS( ))		//�ȴ��������
	{
		drv_delay_ms( 1 );
		if( 3000 == l_RxWaitTimeout++ )
		{
			l_RxWaitTimeout = 0;
			CC1101_Init( );
			break; 
		} 
	}
		
    if( 0 != CC1101_Get_RxCounter( ))
    {
        l_PktLen = CC1101_Read_Reg( CC1101_RXFIFO );           // ��ȡ������Ϣ
		
		if( ( CC1101_Read_Reg( CC1101_PKTCTRL1 ) & 0x03 ) != 0 )
        {
           CC1101_Read_Reg( CC1101_RXFIFO );					//������ݰ��а�����ַ��Ϣ �����ȡ��ַ��Ϣ
        }
        if( l_PktLen == 0 )           
		{
			return 0;			//������
		}
        else 
		{
			l_PktLen--; 		//��ȥһ����ַ�ֽ�
		}
        CC1101_Read_Multi_Reg( CC1101_RXFIFO, RxBuff, l_PktLen ); 	//��ȡ����
        CC1101_Read_Multi_Reg( CC1101_RXFIFO, l_Status, 2 );		//��ȡ���ݰ�������������ֽڣ���һ��ΪCRC��־λ

        CC1101_Clear_RxBuffer( );

        if( l_Status[ 1 ] & CRC_OK )
		{   
			return l_PktLen; 
		}
        else
		{   
			return 0; 
		}
    }
    else   
	{  
		return 0; 
	}                              
}

/**
  * @brief :CC1101��λ
  * @param :��
  * @note  :��
  * @retval:��
  */
void CC1101_Reset( void )
{
	CC1101_SET_CSN_HIGH( );
	CC1101_SET_CSN_LOW( );
	CC1101_SET_CSN_HIGH( );
	drv_delay_ms( 1 );
	CC1101_Write_Cmd( CC1101_SRES );
}

/**
  * @brief :CC1101���ų�ʼ��
  * @param :��
  * @note  :��
  * @retval:��
  */ 
static void CC1101_Gpio_Init( void )
{
	//GDO0 GDO2����Ϊ��������
	GPIO_Init( CC1101_GDO0_GPIO_PORT, CC1101_GDO0_GPIO_PIN, GPIO_Mode_In_PU_No_IT  );
	GPIO_Init( CC1101_GDO2_GPIO_PORT, CC1101_GDO2_GPIO_PIN, GPIO_Mode_In_PU_No_IT  );
}

/**
  * @brief :CC1101��ʼ��
  * @param :��
  * @note  :��
  * @retval:��
  */
void CC1101_Init( void )
{
	uint8_t i = 0;

	CC1101_Gpio_Init( );
	CC1101_Reset( );    

	for( i = 0; i < 22; i++ )
	{
		CC1101_Write_Reg( CC1101InitData[i][0], CC1101InitData[i][1] );
	}
	CC1101_Set_Address( 0x05, BROAD_0AND255 );	//�豸��ַ �� ��ַ���ģʽ����
	CC1101_Set_Sync( 0x8799 );					//ͬ���ֶ�����
	CC1101_Write_Reg(CC1101_MDMCFG1, 0x72);		//���ƽ��������

	CC1101_Write_Multi_Reg( CC1101_PATABLE, (uint8_t*)PaTabel, 8 );
}
