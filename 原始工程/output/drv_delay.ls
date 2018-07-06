   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  63                     ; 28 static void drv_delay_1ms( void )
  63                     ; 29 {
  65                     	switch	.text
  66  0000               L3_drv_delay_1ms:
  68  0000 5206          	subw	sp,#6
  69       00000006      OFST:	set	6
  72                     ; 30 	uint16_t Ms = 1;
  74  0002 ae0001        	ldw	x,#1
  75  0005 1f01          	ldw	(OFST-5,sp),x
  76                     ; 31 	uint32_t j = 30;
  78  0007 ae001e        	ldw	x,#30
  79  000a 1f05          	ldw	(OFST-1,sp),x
  80  000c ae0000        	ldw	x,#0
  81  000f 1f03          	ldw	(OFST-3,sp),x
  83  0011 2015          	jra	L14
  84  0013               L74:
  85                     ; 35 		while( j-- );
  87  0013 96            	ldw	x,sp
  88  0014 1c0003        	addw	x,#OFST-3
  89  0017 cd0000        	call	c_ltor
  91  001a 96            	ldw	x,sp
  92  001b 1c0003        	addw	x,#OFST-3
  93  001e a601          	ld	a,#1
  94  0020 cd0000        	call	c_lgsbc
  96  0023 cd0000        	call	c_lrzmp
  98  0026 26eb          	jrne	L74
  99  0028               L14:
 100                     ; 33 	while( Ms-- )
 102  0028 1e01          	ldw	x,(OFST-5,sp)
 103  002a 1d0001        	subw	x,#1
 104  002d 1f01          	ldw	(OFST-5,sp),x
 105  002f 1c0001        	addw	x,#1
 106  0032 a30000        	cpw	x,#0
 107  0035 26dc          	jrne	L74
 108                     ; 37 }
 111  0037 5b06          	addw	sp,#6
 112  0039 81            	ret
 147                     ; 46 void drv_delay_ms( uint16_t Ms )
 147                     ; 47 {
 148                     	switch	.text
 149  003a               _drv_delay_ms:
 151  003a 89            	pushw	x
 152       00000000      OFST:	set	0
 155  003b 2002          	jra	L37
 156  003d               L17:
 157                     ; 50 		drv_delay_1ms( );
 159  003d adc1          	call	L3_drv_delay_1ms
 161  003f               L37:
 162                     ; 48 	while( Ms-- )
 164  003f 1e01          	ldw	x,(OFST+1,sp)
 165  0041 1d0001        	subw	x,#1
 166  0044 1f01          	ldw	(OFST+1,sp),x
 167  0046 1c0001        	addw	x,#1
 168  0049 a30000        	cpw	x,#0
 169  004c 26ef          	jrne	L17
 170                     ; 52 }
 173  004e 85            	popw	x
 174  004f 81            	ret
 187                     	xdef	_drv_delay_ms
 206                     	xref	c_lrzmp
 207                     	xref	c_lgsbc
 208                     	xref	c_ltor
 209                     	end
