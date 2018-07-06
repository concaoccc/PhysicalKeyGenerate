   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  15                     	bsct
  16  0000               _g_Ashining:
  17  0000 0008          	dc.w	L3
  18  0002               _g_TxMode:
  19  0002 01            	dc.b	1
  20  0003               _g_UartRxBuffer:
  21  0003 00            	dc.b	0
  22  0004 000000000000  	ds.b	99
  23  0067               _g_RF24L01RxBuffer:
  24  0067 00            	dc.b	0
  25  0068 000000000000  	ds.b	31
  90                     ; 35 int main( void )
  90                     ; 36 {	
  92                     	switch	.text
  93  0000               _main:
  95  0000 5203          	subw	sp,#3
  96       00000003      OFST:	set	3
  99                     ; 37 	uint8_t i = 0;
 101                     ; 38 	char *data = "inited!";
 103  0002 ae0000        	ldw	x,#L53
 104  0005 1f01          	ldw	(OFST-2,sp),x
 105                     ; 41 	drv_uart_init( 9600 );
 107  0007 ae2580        	ldw	x,#9600
 108  000a 89            	pushw	x
 109  000b ae0000        	ldw	x,#0
 110  000e 89            	pushw	x
 111  000f cd0000        	call	_drv_uart_init
 113  0012 5b04          	addw	sp,#4
 114                     ; 44 	drv_led_init( );
 116  0014 cd0000        	call	_drv_led_init
 118                     ; 47 	drv_spi_init( );
 120  0017 cd0000        	call	_drv_spi_init
 122                     ; 50 	CC1101_Init( );
 124  001a cd0000        	call	_CC1101_Init
 126                     ; 51 	for( i = 0; i < 6; i++ )
 128  001d 0f03          	clr	(OFST+0,sp)
 129  001f               L73:
 130                     ; 53 		led_red_flashing( );
 132  001f 4f            	clr	a
 133  0020 cd0000        	call	_drv_led_flashing
 135                     ; 54 		led_green_flashing( );
 137  0023 a601          	ld	a,#1
 138  0025 cd0000        	call	_drv_led_flashing
 140                     ; 55 		drv_delay_ms( 500 );
 142  0028 ae01f4        	ldw	x,#500
 143  002b cd0000        	call	_drv_delay_ms
 145                     ; 51 	for( i = 0; i < 6; i++ )
 147  002e 0c03          	inc	(OFST+0,sp)
 150  0030 7b03          	ld	a,(OFST+0,sp)
 151  0032 a106          	cp	a,#6
 152  0034 25e9          	jrult	L73
 153                     ; 57 	drv_uart_tx_bytes(data,7);
 155  0036 4b07          	push	#7
 156  0038 1e02          	ldw	x,(OFST-1,sp)
 157  003a cd0000        	call	_drv_uart_tx_bytes
 159  003d 84            	pop	a
 160                     ; 67 	drv_button_init( );
 162  003e cd0000        	call	_drv_button_init
 164  0041               L54:
 165                     ; 72 		if( BUTOTN_PRESS_DOWN == drv_button_check( ))
 167  0041 cd0000        	call	_drv_button_check
 169  0044 a101          	cp	a,#1
 170  0046 263e          	jrne	L15
 171                     ; 74 			g_TxMode = 1 - g_TxMode;		//模式会在 TX_MODE_1( 0 ),TX_MODE_2( 1 )之间切换
 173  0048 a601          	ld	a,#1
 174  004a b002          	sub	a,_g_TxMode
 175  004c b702          	ld	_g_TxMode,a
 176                     ; 77 			led_green_off( );
 178  004e a601          	ld	a,#1
 179  0050 cd0000        	call	_drv_led_off
 181                     ; 78 			led_red_off( );
 183  0053 4f            	clr	a
 184  0054 cd0000        	call	_drv_led_off
 186                     ; 80 			if( TX_MODE_1 == g_TxMode )
 188  0057 3d02          	tnz	_g_TxMode
 189  0059 2616          	jrne	L35
 190                     ; 82 				for( i = 0; i < 6; i++ )		
 192  005b 0f03          	clr	(OFST+0,sp)
 193  005d               L55:
 194                     ; 84 					led_red_flashing( );	//固定发送模式，红灯闪烁3次
 196  005d 4f            	clr	a
 197  005e cd0000        	call	_drv_led_flashing
 199                     ; 85 					drv_delay_ms( 500 );		
 201  0061 ae01f4        	ldw	x,#500
 202  0064 cd0000        	call	_drv_delay_ms
 204                     ; 82 				for( i = 0; i < 6; i++ )		
 206  0067 0c03          	inc	(OFST+0,sp)
 209  0069 7b03          	ld	a,(OFST+0,sp)
 210  006b a106          	cp	a,#6
 211  006d 25ee          	jrult	L55
 213  006f 2015          	jra	L15
 214  0071               L35:
 215                     ; 90 				for( i = 0; i < 6; i++ )
 217  0071 0f03          	clr	(OFST+0,sp)
 218  0073               L56:
 219                     ; 92 					led_green_flashing( );	//串口发送模式，绿灯闪烁3次
 221  0073 a601          	ld	a,#1
 222  0075 cd0000        	call	_drv_led_flashing
 224                     ; 93 					drv_delay_ms( 500 );
 226  0078 ae01f4        	ldw	x,#500
 227  007b cd0000        	call	_drv_delay_ms
 229                     ; 90 				for( i = 0; i < 6; i++ )
 231  007e 0c03          	inc	(OFST+0,sp)
 234  0080 7b03          	ld	a,(OFST+0,sp)
 235  0082 a106          	cp	a,#6
 236  0084 25ed          	jrult	L56
 237  0086               L15:
 238                     ; 99 		if( TX_MODE_1 == g_TxMode )
 240  0086 3d02          	tnz	_g_TxMode
 241  0088 2616          	jrne	L37
 242                     ; 101 			CC1101_Tx_Packet( (uint8_t *)g_Ashining, 8 , ADDRESS_CHECK );		//模式1发送固定字符,1S一包
 244  008a 4b01          	push	#1
 245  008c 4b08          	push	#8
 246  008e be00          	ldw	x,_g_Ashining
 247  0090 cd0000        	call	_CC1101_Tx_Packet
 249  0093 85            	popw	x
 250                     ; 102 			drv_delay_ms( 1000 );	
 252  0094 ae03e8        	ldw	x,#1000
 253  0097 cd0000        	call	_drv_delay_ms
 255                     ; 103 			led_red_flashing( );			
 257  009a 4f            	clr	a
 258  009b cd0000        	call	_drv_led_flashing
 261  009e 20a1          	jra	L54
 262  00a0               L37:
 263                     ; 108 			i = drv_uart_rx_bytes( g_UartRxBuffer );
 265  00a0 ae0003        	ldw	x,#_g_UartRxBuffer
 266  00a3 cd0000        	call	_drv_uart_rx_bytes
 268  00a6 6b03          	ld	(OFST+0,sp),a
 269                     ; 110 			if( 0 != i )
 271  00a8 0d03          	tnz	(OFST+0,sp)
 272  00aa 2795          	jreq	L54
 273                     ; 112 				CC1101_Tx_Packet( g_UartRxBuffer, i , ADDRESS_CHECK );
 275  00ac 4b01          	push	#1
 276  00ae 7b04          	ld	a,(OFST+1,sp)
 277  00b0 88            	push	a
 278  00b1 ae0003        	ldw	x,#_g_UartRxBuffer
 279  00b4 cd0000        	call	_CC1101_Tx_Packet
 281  00b7 85            	popw	x
 282                     ; 113 				led_red_flashing( );
 284  00b8 4f            	clr	a
 285  00b9 cd0000        	call	_drv_led_flashing
 287  00bc 2083          	jra	L54
 341                     	xdef	_main
 342                     	xdef	_g_RF24L01RxBuffer
 343                     	xdef	_g_UartRxBuffer
 344                     	xdef	_g_TxMode
 345                     	xdef	_g_Ashining
 346                     	xref	_drv_led_flashing
 347                     	xref	_drv_led_off
 348                     	xref	_drv_led_init
 349                     	xref	_drv_delay_ms
 350                     	xref	_drv_button_check
 351                     	xref	_drv_button_init
 352                     	xref	_drv_uart_rx_bytes
 353                     	xref	_drv_uart_tx_bytes
 354                     	xref	_drv_uart_init
 355                     	xref	_CC1101_Init
 356                     	xref	_CC1101_Tx_Packet
 357                     	xref	_drv_spi_init
 358                     .const:	section	.text
 359  0000               L53:
 360  0000 696e69746564  	dc.b	"inited!",0
 361  0008               L3:
 362  0008 617368696e69  	dc.b	"ashining",0
 382                     	end
