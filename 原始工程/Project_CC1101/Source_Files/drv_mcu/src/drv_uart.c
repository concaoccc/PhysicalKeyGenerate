/**
  ******************************************************************************
  * @author  ��ҫ�Ƽ� ASHINING
  * @version V3.0
  * @date    2016-10-08
  * @brief   UART����C�ļ�
  ******************************************************************************
  * @attention
  *
  * ����	:	http://www.ashining.com
  * �Ա�	:	https://shop105912646.taobao.com
  * ����Ͱ�:	https://cdzeyao.1688.com
  ******************************************************************************
  */


#include "drv_uart.h"



/**
  * @brief :���ڳ�ʼ��
  * @param :��
  * @note  :��
  * @retval:��
  */
void drv_uart_init( uint32_t UartBaudRate )
{
	//������������ TX������� RX��������
	GPIO_Init( UART_TX_GPIO_PORT, UART_TX_GPIO_PIN,GPIO_Mode_Out_PP_High_Slow  );
	GPIO_Init( UART_RX_GPIO_PORT, UART_RX_GPIO_PIN,GPIO_Mode_In_PU_No_IT );
	
	//USART��������
	CLK_PeripheralClockConfig( CLK_Peripheral_USART, ENABLE);	//ʹ�ܴ���ʱ��
	USART_DeInit();		//���ڸ�λ
	//���ڳ�ʼ�� 8λ���� 1��ֹͣλ ��У�� ���ͽ��� �����ʿɱ�
	USART_Init( UartBaudRate, USART_WordLength_8D, USART_StopBits_1, USART_Parity_No, USART_Mode_Tx | USART_Mode_Rx );
	USART_Cmd(ENABLE);	//ʹ�ܴ���
}

/**
  * @brief :���ڷ�������
  * @param :
  *			@TxBuffer:���������׵�ַ
  *			@Length:���ݳ���
  * @note  :��
  * @retval:��
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
  * @brief :���ڽ�������
  * @param :
  *			@RxBuffer:���������׵�ַ
  * @note  :��
  * @retval:���յ����ֽڸ���
  */
uint8_t drv_uart_rx_bytes( uint8_t* RxBuffer )
{
	uint8_t l_RxLength = 0;
	uint16_t l_UartRxTimOut = 0xFFF;
	
	while( l_UartRxTimOut-- )			//�ڳ�ʱ��Χ�ڲ�ѯ����
	{
		if( RESET != USART_GetFlagStatus( USART_FLAG_RXNE ))
		{
			*RxBuffer = USART_ReceiveData8( );
			RxBuffer++;
			l_RxLength++;
			l_UartRxTimOut = 0xFFF;		//�ָ���ʱ�ȴ�ʱ��
		}
		if( 100 == l_RxLength )
		{
			break;						//�ֽڲ��ܳ���100���ֽڣ����ڲ���8λ���ڴ��С������buffer���ý�С
		}
	}
	
	return l_RxLength;					//���ؽ��յ����ֽڸ���
}

