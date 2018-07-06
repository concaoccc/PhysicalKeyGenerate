   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  44                     ; 28 void drv_led_init( void )
  44                     ; 29 {
  46                     	switch	.text
  47  0000               _drv_led_init:
  51                     ; 31 	GPIO_Init( LED_RED_GPIO_PORT, LED_RED_GPIO_PIN, GPIO_Mode_Out_PP_Low_Fast );
  53  0000 4be0          	push	#224
  54  0002 4b04          	push	#4
  55  0004 ae5000        	ldw	x,#20480
  56  0007 cd0000        	call	_GPIO_Init
  58  000a 85            	popw	x
  59                     ; 32 	GPIO_Init( LED_GREEN_GPIO_PORT, LED_GREEN_GPIO_PIN, GPIO_Mode_Out_PP_Low_Fast );	
  61  000b 4be0          	push	#224
  62  000d 4b08          	push	#8
  63  000f ae5000        	ldw	x,#20480
  64  0012 cd0000        	call	_GPIO_Init
  66  0015 85            	popw	x
  67                     ; 33 }
  70  0016 81            	ret
 126                     ; 42 void drv_led_on( LedPortType LedPort )
 126                     ; 43 {
 127                     	switch	.text
 128  0017               _drv_led_on:
 132                     ; 44 	if( LED_RED == LedPort )	//LED_RED
 134  0017 4d            	tnz	a
 135  0018 260b          	jrne	L74
 136                     ; 46 		GPIO_SetBits( LED_RED_GPIO_PORT, LED_RED_GPIO_PIN );
 138  001a 4b04          	push	#4
 139  001c ae5000        	ldw	x,#20480
 140  001f cd0000        	call	_GPIO_SetBits
 142  0022 84            	pop	a
 144  0023 2009          	jra	L15
 145  0025               L74:
 146                     ; 50 		GPIO_SetBits( LED_GREEN_GPIO_PORT, LED_GREEN_GPIO_PIN );
 148  0025 4b08          	push	#8
 149  0027 ae5000        	ldw	x,#20480
 150  002a cd0000        	call	_GPIO_SetBits
 152  002d 84            	pop	a
 153  002e               L15:
 154                     ; 53 }
 157  002e 81            	ret
 193                     ; 62 void drv_led_off( LedPortType LedPort )
 193                     ; 63 {
 194                     	switch	.text
 195  002f               _drv_led_off:
 199                     ; 64 	if( LED_RED == LedPort )	//LED_RED
 201  002f 4d            	tnz	a
 202  0030 260b          	jrne	L17
 203                     ; 66 		GPIO_ResetBits( LED_RED_GPIO_PORT, LED_RED_GPIO_PIN );	
 205  0032 4b04          	push	#4
 206  0034 ae5000        	ldw	x,#20480
 207  0037 cd0000        	call	_GPIO_ResetBits
 209  003a 84            	pop	a
 211  003b 2009          	jra	L37
 212  003d               L17:
 213                     ; 70 		GPIO_ResetBits( LED_GREEN_GPIO_PORT, LED_GREEN_GPIO_PIN );
 215  003d 4b08          	push	#8
 216  003f ae5000        	ldw	x,#20480
 217  0042 cd0000        	call	_GPIO_ResetBits
 219  0045 84            	pop	a
 220  0046               L37:
 221                     ; 73 }
 224  0046 81            	ret
 260                     ; 82 void drv_led_flashing( LedPortType LedPort )
 260                     ; 83 {
 261                     	switch	.text
 262  0047               _drv_led_flashing:
 266                     ; 85 	if( LED_RED == LedPort )
 268  0047 4d            	tnz	a
 269  0048 260b          	jrne	L311
 270                     ; 87 		GPIO_ToggleBits( LED_RED_GPIO_PORT, LED_RED_GPIO_PIN );
 272  004a 4b04          	push	#4
 273  004c ae5000        	ldw	x,#20480
 274  004f cd0000        	call	_GPIO_ToggleBits
 276  0052 84            	pop	a
 278  0053 2009          	jra	L511
 279  0055               L311:
 280                     ; 91 		GPIO_ToggleBits( LED_GREEN_GPIO_PORT, LED_GREEN_GPIO_PIN );
 282  0055 4b08          	push	#8
 283  0057 ae5000        	ldw	x,#20480
 284  005a cd0000        	call	_GPIO_ToggleBits
 286  005d 84            	pop	a
 287  005e               L511:
 288                     ; 93 }
 291  005e 81            	ret
 304                     	xdef	_drv_led_flashing
 305                     	xdef	_drv_led_off
 306                     	xdef	_drv_led_on
 307                     	xdef	_drv_led_init
 308                     	xref	_GPIO_ToggleBits
 309                     	xref	_GPIO_ResetBits
 310                     	xref	_GPIO_SetBits
 311                     	xref	_GPIO_Init
 330                     	end
