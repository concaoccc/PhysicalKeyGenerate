   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  48                     ; 34 void drv_spi_init( void )
  48                     ; 35 {
  50                     	switch	.text
  51  0000               _drv_spi_init:
  55                     ; 37 	GPIO_Init( SPI_CLK_GPIO_PORT, SPI_CLK_GPIO_PIN, GPIO_Mode_Out_PP_Low_Fast  );
  57  0000 4be0          	push	#224
  58  0002 4b20          	push	#32
  59  0004 ae5005        	ldw	x,#20485
  60  0007 cd0000        	call	_GPIO_Init
  62  000a 85            	popw	x
  63                     ; 38 	GPIO_Init( SPI_MOSI_GPIO_PORT, SPI_MOSI_GPIO_PIN, GPIO_Mode_Out_PP_High_Slow  );
  65  000b 4bd0          	push	#208
  66  000d 4b40          	push	#64
  67  000f ae5005        	ldw	x,#20485
  68  0012 cd0000        	call	_GPIO_Init
  70  0015 85            	popw	x
  71                     ; 39 	GPIO_Init( SPI_NSS_GPIO_PORT, SPI_NSS_GPIO_PIN, GPIO_Mode_Out_PP_High_Slow  );
  73  0016 4bd0          	push	#208
  74  0018 4b10          	push	#16
  75  001a ae5005        	ldw	x,#20485
  76  001d cd0000        	call	_GPIO_Init
  78  0020 85            	popw	x
  79                     ; 40 	GPIO_Init( SPI_MISO_GPIO_PORT, SPI_MISO_GPIO_PIN, GPIO_Mode_In_PU_No_IT  );
  81  0021 4b40          	push	#64
  82  0023 4b80          	push	#128
  83  0025 ae5005        	ldw	x,#20485
  84  0028 cd0000        	call	_GPIO_Init
  86  002b 85            	popw	x
  87                     ; 43 	CLK_PeripheralClockConfig( CLK_Peripheral_SPI,ENABLE );		//开SPI时钟
  89  002c ae0001        	ldw	x,#1
  90  002f a610          	ld	a,#16
  91  0031 95            	ld	xh,a
  92  0032 cd0000        	call	_CLK_PeripheralClockConfig
  94                     ; 44 	SPI_DeInit( );		//SPI复位
  96  0035 cd0000        	call	_SPI_DeInit
  98                     ; 46 	SPI_Init( SPI_FirstBit_MSB, SPI_BaudRatePrescaler_8, SPI_Mode_Master, SPI_CPOL_Low, SPI_CPHA_1Edge, SPI_Direction_2Lines_FullDuplex, SPI_NSS_Soft );
 100  0038 4b02          	push	#2
 101  003a 4b00          	push	#0
 102  003c 4b00          	push	#0
 103  003e 4b00          	push	#0
 104  0040 4b04          	push	#4
 105  0042 ae0010        	ldw	x,#16
 106  0045 4f            	clr	a
 107  0046 95            	ld	xh,a
 108  0047 cd0000        	call	_SPI_Init
 110  004a 5b05          	addw	sp,#5
 111                     ; 47 	SPI_Cmd( ENABLE );	//SPI使能
 113  004c a601          	ld	a,#1
 114  004e cd0000        	call	_SPI_Cmd
 116                     ; 48 }
 119  0051 81            	ret
 175                     ; 57 uint8_t drv_spi_read_write_byte( uint8_t TxByte )
 175                     ; 58 {
 176                     	switch	.text
 177  0052               _drv_spi_read_write_byte:
 179  0052 88            	push	a
 180  0053 5203          	subw	sp,#3
 181       00000003      OFST:	set	3
 184                     ; 59 	uint8_t l_Data = 0;
 186                     ; 60 	uint16_t l_WaitTime = 0;
 188  0055 5f            	clrw	x
 189  0056 1f02          	ldw	(OFST-1,sp),x
 191  0058 2018          	jra	L35
 192  005a               L74:
 193                     ; 64 		if( SPI_WAIT_TIMEOUT == ++l_WaitTime )
 195  005a 1e02          	ldw	x,(OFST-1,sp)
 196  005c 1c0001        	addw	x,#1
 197  005f 1f02          	ldw	(OFST-1,sp),x
 198  0061 a3ffff        	cpw	x,#65535
 199  0064 260c          	jrne	L35
 200                     ; 66 			break;			//等待超时
 201  0066               L55:
 202                     ; 69 	SPI_SendData( TxByte );	//发送数据
 204  0066 7b04          	ld	a,(OFST+1,sp)
 205  0068 cd0000        	call	_SPI_SendData
 207                     ; 70 	l_WaitTime = SPI_WAIT_TIMEOUT / 2;
 209  006b ae7fff        	ldw	x,#32767
 210  006e 1f02          	ldw	(OFST-1,sp),x
 212  0070 2020          	jra	L56
 213  0072               L35:
 214                     ; 62 	while( RESET == SPI_GetFlagStatus( SPI_FLAG_TXE ) )		//等待发送缓冲区空
 216  0072 a602          	ld	a,#2
 217  0074 cd0000        	call	_SPI_GetFlagStatus
 219  0077 4d            	tnz	a
 220  0078 27e0          	jreq	L74
 221  007a 20ea          	jra	L55
 222  007c               L16:
 223                     ; 73 		if( SPI_WAIT_TIMEOUT == ++l_WaitTime )
 225  007c 1e02          	ldw	x,(OFST-1,sp)
 226  007e 1c0001        	addw	x,#1
 227  0081 1f02          	ldw	(OFST-1,sp),x
 228  0083 a3ffff        	cpw	x,#65535
 229  0086 260a          	jrne	L56
 230                     ; 75 			break;			//等待超时
 231  0088               L76:
 232                     ; 79 	l_Data = SPI_ReceiveData( );
 234  0088 cd0000        	call	_SPI_ReceiveData
 236  008b 6b01          	ld	(OFST-2,sp),a
 237                     ; 80 	return l_Data;	//返回数据
 239  008d 7b01          	ld	a,(OFST-2,sp)
 242  008f 5b04          	addw	sp,#4
 243  0091 81            	ret
 244  0092               L56:
 245                     ; 71 	while( RESET == SPI_GetFlagStatus( SPI_FLAG_RXNE ) )	//等待接收缓冲区非空
 247  0092 a601          	ld	a,#1
 248  0094 cd0000        	call	_SPI_GetFlagStatus
 250  0097 4d            	tnz	a
 251  0098 27e2          	jreq	L16
 252  009a 20ec          	jra	L76
 310                     ; 92 void drv_spi_read_write_string( uint8_t* ReadBuffer, uint8_t* WriteBuffer, uint16_t Length )
 310                     ; 93 {
 311                     	switch	.text
 312  009c               _drv_spi_read_write_string:
 314  009c 89            	pushw	x
 315       00000000      OFST:	set	0
 318                     ; 94 	GPIO_ResetBits( SPI_NSS_GPIO_PORT, SPI_NSS_GPIO_PIN);			//片选
 320  009d 4b10          	push	#16
 321  009f ae5005        	ldw	x,#20485
 322  00a2 cd0000        	call	_GPIO_ResetBits
 324  00a5 84            	pop	a
 326  00a6 2016          	jra	L321
 327  00a8               L121:
 328                     ; 97 		*ReadBuffer = drv_spi_read_write_byte( *WriteBuffer );		//一个字节的数据收发
 330  00a8 1e05          	ldw	x,(OFST+5,sp)
 331  00aa f6            	ld	a,(x)
 332  00ab ada5          	call	_drv_spi_read_write_byte
 334  00ad 1e01          	ldw	x,(OFST+1,sp)
 335  00af f7            	ld	(x),a
 336                     ; 98 		ReadBuffer++;
 338  00b0 1e01          	ldw	x,(OFST+1,sp)
 339  00b2 1c0001        	addw	x,#1
 340  00b5 1f01          	ldw	(OFST+1,sp),x
 341                     ; 99 		WriteBuffer++;				//地址加1
 343  00b7 1e05          	ldw	x,(OFST+5,sp)
 344  00b9 1c0001        	addw	x,#1
 345  00bc 1f05          	ldw	(OFST+5,sp),x
 346  00be               L321:
 347                     ; 95 	while( Length-- )
 349  00be 1e07          	ldw	x,(OFST+7,sp)
 350  00c0 1d0001        	subw	x,#1
 351  00c3 1f07          	ldw	(OFST+7,sp),x
 352  00c5 1c0001        	addw	x,#1
 353  00c8 a30000        	cpw	x,#0
 354  00cb 26db          	jrne	L121
 355                     ; 101 	GPIO_SetBits( SPI_NSS_GPIO_PORT, SPI_NSS_GPIO_PIN);				//取消片选
 357  00cd 4b10          	push	#16
 358  00cf ae5005        	ldw	x,#20485
 359  00d2 cd0000        	call	_GPIO_SetBits
 361  00d5 84            	pop	a
 362                     ; 102 }
 365  00d6 85            	popw	x
 366  00d7 81            	ret
 379                     	xdef	_drv_spi_read_write_string
 380                     	xdef	_drv_spi_read_write_byte
 381                     	xdef	_drv_spi_init
 382                     	xref	_CLK_PeripheralClockConfig
 383                     	xref	_SPI_GetFlagStatus
 384                     	xref	_SPI_ReceiveData
 385                     	xref	_SPI_SendData
 386                     	xref	_SPI_Cmd
 387                     	xref	_SPI_Init
 388                     	xref	_SPI_DeInit
 389                     	xref	_GPIO_ResetBits
 390                     	xref	_GPIO_SetBits
 391                     	xref	_GPIO_Init
 410                     	end
