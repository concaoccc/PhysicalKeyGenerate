   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  44                     ; 28 void drv_button_init( void )
  44                     ; 29 {
  46                     	switch	.text
  47  0000               _drv_button_init:
  51                     ; 31 	GPIO_Init( BUTOTN_GPIO_PORT, BUTTON_GPIO_PIN, GPIO_Mode_In_PU_No_IT );
  53  0000 4b40          	push	#64
  54  0002 4b02          	push	#2
  55  0004 ae500a        	ldw	x,#20490
  56  0007 cd0000        	call	_GPIO_Init
  58  000a 85            	popw	x
  59                     ; 32 }
  62  000b 81            	ret
  87                     ; 42 uint8_t drv_button_check( void )
  87                     ; 43 {
  88                     	switch	.text
  89  000c               _drv_button_check:
  93                     ; 45 	if( BUTTON_GPIO_PIN != ( GPIO_ReadInputData( BUTOTN_GPIO_PORT ) & BUTTON_GPIO_PIN ))	
  95  000c ae500a        	ldw	x,#20490
  96  000f cd0000        	call	_GPIO_ReadInputData
  98  0012 a402          	and	a,#2
  99  0014 a102          	cp	a,#2
 100  0016 2715          	jreq	L13
 101                     ; 47 		drv_delay_ms( 40 );			//æ¶ˆæŠ–
 103  0018 ae0028        	ldw	x,#40
 104  001b cd0000        	call	_drv_delay_ms
 106                     ; 48 		if( BUTTON_GPIO_PIN != ( GPIO_ReadInputData( BUTOTN_GPIO_PORT ) & BUTTON_GPIO_PIN ))
 108  001e ae500a        	ldw	x,#20490
 109  0021 cd0000        	call	_GPIO_ReadInputData
 111  0024 a402          	and	a,#2
 112  0026 a102          	cp	a,#2
 113  0028 2703          	jreq	L13
 114                     ; 50 			return 1;				//°´¼ü°´ÏÂ
 116  002a a601          	ld	a,#1
 119  002c 81            	ret
 120  002d               L13:
 121                     ; 54 	return 0;
 123  002d 4f            	clr	a
 126  002e 81            	ret
 139                     	xref	_drv_delay_ms
 140                     	xdef	_drv_button_check
 141                     	xdef	_drv_button_init
 142                     	xref	_GPIO_ReadInputData
 143                     	xref	_GPIO_Init
 162                     	end
