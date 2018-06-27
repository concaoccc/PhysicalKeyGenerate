   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  59                     ; 27 void drv_uart_init( uint32_t UartBaudRate )
  59                     ; 28 {
  61                     	switch	.text
  62  0000               _drv_uart_init:
  64       00000000      OFST:	set	0
  67                     ; 30 	GPIO_Init( UART_TX_GPIO_PORT, UART_TX_GPIO_PIN,GPIO_Mode_Out_PP_High_Slow  );
  69  0000 4bd0          	push	#208
  70  0002 4b08          	push	#8
  71  0004 ae500a        	ldw	x,#20490
  72  0007 cd0000        	call	_GPIO_Init
  74  000a 85            	popw	x
  75                     ; 31 	GPIO_Init( UART_RX_GPIO_PORT, UART_RX_GPIO_PIN,GPIO_Mode_In_PU_No_IT );
  77  000b 4b40          	push	#64
  78  000d 4b04          	push	#4
  79  000f ae500a        	ldw	x,#20490
  80  0012 cd0000        	call	_GPIO_Init
  82  0015 85            	popw	x
  83                     ; 34 	CLK_PeripheralClockConfig( CLK_Peripheral_USART, ENABLE);	//使能串口时钟
  85  0016 ae0001        	ldw	x,#1
  86  0019 a620          	ld	a,#32
  87  001b 95            	ld	xh,a
  88  001c cd0000        	call	_CLK_PeripheralClockConfig
  90                     ; 35 	USART_DeInit();		//串口复位
  92  001f cd0000        	call	_USART_DeInit
  94                     ; 37 	USART_Init( UartBaudRate, USART_WordLength_8D, USART_StopBits_1, USART_Parity_No, USART_Mode_Tx | USART_Mode_Rx );
  96  0022 4b0c          	push	#12
  97  0024 4b00          	push	#0
  98  0026 4b00          	push	#0
  99  0028 4b00          	push	#0
 100  002a 1e09          	ldw	x,(OFST+9,sp)
 101  002c 89            	pushw	x
 102  002d 1e09          	ldw	x,(OFST+9,sp)
 103  002f 89            	pushw	x
 104  0030 cd0000        	call	_USART_Init
 106  0033 5b08          	addw	sp,#8
 107                     ; 38 	USART_Cmd(ENABLE);	//使能串口
 109  0035 a601          	ld	a,#1
 110  0037 cd0000        	call	_USART_Cmd
 112                     ; 39 }
 115  003a 81            	ret
 161                     ; 49 void drv_uart_tx_bytes( uint8_t* TxBuffer, uint8_t Length )
 161                     ; 50 {
 162                     	switch	.text
 163  003b               _drv_uart_tx_bytes:
 165  003b 89            	pushw	x
 166       00000000      OFST:	set	0
 169  003c 2016          	jra	L35
 170  003e               L16:
 171                     ; 53 		while( RESET == USART_GetFlagStatus( USART_FLAG_TXE ));
 173  003e ae0080        	ldw	x,#128
 174  0041 cd0000        	call	_USART_GetFlagStatus
 176  0044 4d            	tnz	a
 177  0045 27f7          	jreq	L16
 178                     ; 54 		USART_SendData8( * TxBuffer );
 180  0047 1e01          	ldw	x,(OFST+1,sp)
 181  0049 f6            	ld	a,(x)
 182  004a cd0000        	call	_USART_SendData8
 184                     ; 55 		TxBuffer++;
 186  004d 1e01          	ldw	x,(OFST+1,sp)
 187  004f 1c0001        	addw	x,#1
 188  0052 1f01          	ldw	(OFST+1,sp),x
 189  0054               L35:
 190                     ; 51 	while( Length-- )
 192  0054 7b05          	ld	a,(OFST+5,sp)
 193  0056 0a05          	dec	(OFST+5,sp)
 194  0058 4d            	tnz	a
 195  0059 26e3          	jrne	L16
 196                     ; 57 }
 199  005b 85            	popw	x
 200  005c 81            	ret
 255                     ; 66 uint8_t drv_uart_rx_bytes( uint8_t* RxBuffer )
 255                     ; 67 {
 256                     	switch	.text
 257  005d               _drv_uart_rx_bytes:
 259  005d 89            	pushw	x
 260  005e 5203          	subw	sp,#3
 261       00000003      OFST:	set	3
 264                     ; 68 	uint8_t l_RxLength = 0;
 266  0060 0f03          	clr	(OFST+0,sp)
 267                     ; 69 	uint16_t l_UartRxTimOut = 0xFFF;
 269  0062 ae0fff        	ldw	x,#4095
 270  0065 1f01          	ldw	(OFST-2,sp),x
 272  0067 2028          	jra	L711
 273  0069               L311:
 274                     ; 73 		if( RESET != USART_GetFlagStatus( USART_FLAG_RXNE ))
 276  0069 ae0020        	ldw	x,#32
 277  006c cd0000        	call	_USART_GetFlagStatus
 279  006f 4d            	tnz	a
 280  0070 2714          	jreq	L321
 281                     ; 75 			*RxBuffer = USART_ReceiveData8( );
 283  0072 cd0000        	call	_USART_ReceiveData8
 285  0075 1e04          	ldw	x,(OFST+1,sp)
 286  0077 f7            	ld	(x),a
 287                     ; 76 			RxBuffer++;
 289  0078 1e04          	ldw	x,(OFST+1,sp)
 290  007a 1c0001        	addw	x,#1
 291  007d 1f04          	ldw	(OFST+1,sp),x
 292                     ; 77 			l_RxLength++;
 294  007f 0c03          	inc	(OFST+0,sp)
 295                     ; 78 			l_UartRxTimOut = 0xFFF;		//恢复超时等待时间
 297  0081 ae0fff        	ldw	x,#4095
 298  0084 1f01          	ldw	(OFST-2,sp),x
 299  0086               L321:
 300                     ; 80 		if( 100 == l_RxLength )
 302  0086 7b03          	ld	a,(OFST+0,sp)
 303  0088 a164          	cp	a,#100
 304  008a 2605          	jrne	L711
 305                     ; 82 			break;						//字节不能超过100个字节，由于部分8位机内存较小，接收buffer开得较小
 306  008c               L121:
 307                     ; 86 	return l_RxLength;					//返回接收到的字节个数
 309  008c 7b03          	ld	a,(OFST+0,sp)
 312  008e 5b05          	addw	sp,#5
 313  0090 81            	ret
 314  0091               L711:
 315                     ; 71 	while( l_UartRxTimOut-- )			//在超时范围内查询数据
 317  0091 1e01          	ldw	x,(OFST-2,sp)
 318  0093 1d0001        	subw	x,#1
 319  0096 1f01          	ldw	(OFST-2,sp),x
 320  0098 1c0001        	addw	x,#1
 321  009b a30000        	cpw	x,#0
 322  009e 26c9          	jrne	L311
 323  00a0 20ea          	jra	L121
 336                     	xdef	_drv_uart_rx_bytes
 337                     	xdef	_drv_uart_tx_bytes
 338                     	xdef	_drv_uart_init
 339                     	xref	_CLK_PeripheralClockConfig
 340                     	xref	_USART_GetFlagStatus
 341                     	xref	_USART_SendData8
 342                     	xref	_USART_ReceiveData8
 343                     	xref	_USART_Cmd
 344                     	xref	_USART_Init
 345                     	xref	_USART_DeInit
 346                     	xref	_GPIO_Init
 365                     	end
