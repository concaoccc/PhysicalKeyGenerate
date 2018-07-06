   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  15                     .const:	section	.text
  16  0000               _PaTabel:
  17  0000 c0            	dc.b	192
  18  0001 c8            	dc.b	200
  19  0002 84            	dc.b	132
  20  0003 60            	dc.b	96
  21  0004 68            	dc.b	104
  22  0005 34            	dc.b	52
  23  0006 1d            	dc.b	29
  24  0007 0e            	dc.b	14
  25  0008               L3_CC1101InitData:
  26  0008 02            	dc.b	2
  27  0009 06            	dc.b	6
  28  000a 03            	dc.b	3
  29  000b 47            	dc.b	71
  30  000c 08            	dc.b	8
  31  000d 05            	dc.b	5
  32  000e 0a            	dc.b	10
  33  000f 96            	dc.b	150
  34  0010 0b            	dc.b	11
  35  0011 06            	dc.b	6
  36  0012 0d            	dc.b	13
  37  0013 0f            	dc.b	15
  38  0014 0e            	dc.b	14
  39  0015 62            	dc.b	98
  40  0016 0f            	dc.b	15
  41  0017 76            	dc.b	118
  42  0018 10            	dc.b	16
  43  0019 f6            	dc.b	246
  44  001a 11            	dc.b	17
  45  001b 43            	dc.b	67
  46  001c 12            	dc.b	18
  47  001d 13            	dc.b	19
  48  001e 15            	dc.b	21
  49  001f 15            	dc.b	21
  50  0020 18            	dc.b	24
  51  0021 18            	dc.b	24
  52  0022 19            	dc.b	25
  53  0023 16            	dc.b	22
  54  0024 20            	dc.b	32
  55  0025 fb            	dc.b	251
  56  0026 23            	dc.b	35
  57  0027 e9            	dc.b	233
  58  0028 24            	dc.b	36
  59  0029 2a            	dc.b	42
  60  002a 25            	dc.b	37
  61  002b 00            	dc.b	0
  62  002c 26            	dc.b	38
  63  002d 1f            	dc.b	31
  64  002e 2c            	dc.b	44
  65  002f 81            	dc.b	129
  66  0030 2d            	dc.b	45
  67  0031 35            	dc.b	53
  68  0032 17            	dc.b	23
  69  0033 3b            	dc.b	59
 112                     ; 57 void CC1101_Write_Cmd( uint8_t Command )
 112                     ; 58 {
 114                     	switch	.text
 115  0000               _CC1101_Write_Cmd:
 117  0000 88            	push	a
 118       00000000      OFST:	set	0
 121                     ; 59     CC1101_SET_CSN_LOW( );					//SPI片选，本工程中该函数都是用作SPI片选
 123  0001 4b10          	push	#16
 124  0003 ae5005        	ldw	x,#20485
 125  0006 cd0000        	call	_GPIO_ResetBits
 127  0009 84            	pop	a
 128                     ; 61     drv_spi_read_write_byte( Command );		//写命令
 130  000a 7b01          	ld	a,(OFST+1,sp)
 131  000c cd0000        	call	_drv_spi_read_write_byte
 133                     ; 63     CC1101_SET_CSN_HIGH( );					//SPI取消片选，本工程中该函数都是用作取消SPI片选					
 135  000f 4b10          	push	#16
 136  0011 ae5005        	ldw	x,#20485
 137  0014 cd0000        	call	_GPIO_SetBits
 139  0017 84            	pop	a
 140                     ; 64 }
 143  0018 84            	pop	a
 144  0019 81            	ret
 190                     ; 74 void CC1101_Write_Reg( uint8_t Addr, uint8_t WriteValue )
 190                     ; 75 {
 191                     	switch	.text
 192  001a               _CC1101_Write_Reg:
 194  001a 89            	pushw	x
 195       00000000      OFST:	set	0
 198                     ; 76 	CC1101_SET_CSN_LOW( );					
 200  001b 4b10          	push	#16
 201  001d ae5005        	ldw	x,#20485
 202  0020 cd0000        	call	_GPIO_ResetBits
 204  0023 84            	pop	a
 205                     ; 78     drv_spi_read_write_byte( Addr );		//写地址
 207  0024 7b01          	ld	a,(OFST+1,sp)
 208  0026 cd0000        	call	_drv_spi_read_write_byte
 210                     ; 79     drv_spi_read_write_byte( WriteValue );	//写数据
 212  0029 7b02          	ld	a,(OFST+2,sp)
 213  002b cd0000        	call	_drv_spi_read_write_byte
 215                     ; 81     CC1101_SET_CSN_HIGH( );					
 217  002e 4b10          	push	#16
 218  0030 ae5005        	ldw	x,#20485
 219  0033 cd0000        	call	_GPIO_SetBits
 221  0036 84            	pop	a
 222                     ; 82 }
 225  0037 85            	popw	x
 226  0038 81            	ret
 292                     ; 93 void CC1101_Write_Multi_Reg( uint8_t Addr, uint8_t *pWriteBuff, uint8_t WriteSize )
 292                     ; 94 {
 293                     	switch	.text
 294  0039               _CC1101_Write_Multi_Reg:
 296  0039 88            	push	a
 297  003a 88            	push	a
 298       00000001      OFST:	set	1
 301                     ; 97     CC1101_SET_CSN_LOW( );					
 303  003b 4b10          	push	#16
 304  003d ae5005        	ldw	x,#20485
 305  0040 cd0000        	call	_GPIO_ResetBits
 307  0043 84            	pop	a
 308                     ; 99     drv_spi_read_write_byte( Addr | WRITE_BURST );	//连续写命令 及首地址
 310  0044 7b02          	ld	a,(OFST+1,sp)
 311  0046 aa40          	or	a,#64
 312  0048 cd0000        	call	_drv_spi_read_write_byte
 314                     ; 100     for( i = 0; i < WriteSize; i ++ )
 316  004b 0f01          	clr	(OFST+0,sp)
 318  004d 2011          	jra	L111
 319  004f               L501:
 320                     ; 102         drv_spi_read_write_byte( *( pWriteBuff + i ) );	//连续写入数据
 322  004f 7b05          	ld	a,(OFST+4,sp)
 323  0051 97            	ld	xl,a
 324  0052 7b06          	ld	a,(OFST+5,sp)
 325  0054 1b01          	add	a,(OFST+0,sp)
 326  0056 2401          	jrnc	L21
 327  0058 5c            	incw	x
 328  0059               L21:
 329  0059 02            	rlwa	x,a
 330  005a f6            	ld	a,(x)
 331  005b cd0000        	call	_drv_spi_read_write_byte
 333                     ; 100     for( i = 0; i < WriteSize; i ++ )
 335  005e 0c01          	inc	(OFST+0,sp)
 336  0060               L111:
 339  0060 7b01          	ld	a,(OFST+0,sp)
 340  0062 1107          	cp	a,(OFST+6,sp)
 341  0064 25e9          	jrult	L501
 342                     ; 105     CC1101_SET_CSN_HIGH( );					
 344  0066 4b10          	push	#16
 345  0068 ae5005        	ldw	x,#20485
 346  006b cd0000        	call	_GPIO_SetBits
 348  006e 84            	pop	a
 349                     ; 106 }
 352  006f 85            	popw	x
 353  0070 81            	ret
 399                     ; 115 uint8_t CC1101_Read_Reg( uint8_t Addr )
 399                     ; 116 {
 400                     	switch	.text
 401  0071               _CC1101_Read_Reg:
 403  0071 88            	push	a
 404  0072 88            	push	a
 405       00000001      OFST:	set	1
 408                     ; 117     uint8_t l_RegValue = 0;
 410                     ; 119     CC1101_SET_CSN_LOW( );
 412  0073 4b10          	push	#16
 413  0075 ae5005        	ldw	x,#20485
 414  0078 cd0000        	call	_GPIO_ResetBits
 416  007b 84            	pop	a
 417                     ; 121     drv_spi_read_write_byte( Addr | READ_SINGLE );	//单独读命令 及地址
 419  007c 7b02          	ld	a,(OFST+1,sp)
 420  007e aa80          	or	a,#128
 421  0080 cd0000        	call	_drv_spi_read_write_byte
 423                     ; 122     l_RegValue = drv_spi_read_write_byte( 0xFF );	//读取寄存器
 425  0083 a6ff          	ld	a,#255
 426  0085 cd0000        	call	_drv_spi_read_write_byte
 428  0088 6b01          	ld	(OFST+0,sp),a
 429                     ; 124     CC1101_SET_CSN_HIGH( );
 431  008a 4b10          	push	#16
 432  008c ae5005        	ldw	x,#20485
 433  008f cd0000        	call	_GPIO_SetBits
 435  0092 84            	pop	a
 436                     ; 126     return l_RegValue;
 438  0093 7b01          	ld	a,(OFST+0,sp)
 441  0095 85            	popw	x
 442  0096 81            	ret
 488                     ; 136 uint8_t CC1101_Read_Status( uint8_t Addr )
 488                     ; 137 {
 489                     	switch	.text
 490  0097               _CC1101_Read_Status:
 492  0097 88            	push	a
 493  0098 88            	push	a
 494       00000001      OFST:	set	1
 497                     ; 138     uint8_t l_RegStatus = 0;
 499                     ; 140     CC1101_SET_CSN_LOW( );
 501  0099 4b10          	push	#16
 502  009b ae5005        	ldw	x,#20485
 503  009e cd0000        	call	_GPIO_ResetBits
 505  00a1 84            	pop	a
 506                     ; 142     drv_spi_read_write_byte( Addr | READ_BURST );	//连续读命令 及地址
 508  00a2 7b02          	ld	a,(OFST+1,sp)
 509  00a4 aac0          	or	a,#192
 510  00a6 cd0000        	call	_drv_spi_read_write_byte
 512                     ; 143     l_RegStatus = drv_spi_read_write_byte( 0xFF );	//读取状态
 514  00a9 a6ff          	ld	a,#255
 515  00ab cd0000        	call	_drv_spi_read_write_byte
 517  00ae 6b01          	ld	(OFST+0,sp),a
 518                     ; 145     CC1101_SET_CSN_HIGH( );
 520  00b0 4b10          	push	#16
 521  00b2 ae5005        	ldw	x,#20485
 522  00b5 cd0000        	call	_GPIO_SetBits
 524  00b8 84            	pop	a
 525                     ; 147     return l_RegStatus;
 527  00b9 7b01          	ld	a,(OFST+0,sp)
 530  00bb 85            	popw	x
 531  00bc 81            	ret
 606                     ; 159 void CC1101_Read_Multi_Reg( uint8_t Addr, uint8_t *pReadBuff, uint8_t ReadSize )
 606                     ; 160 {
 607                     	switch	.text
 608  00bd               _CC1101_Read_Multi_Reg:
 610  00bd 88            	push	a
 611  00be 89            	pushw	x
 612       00000002      OFST:	set	2
 615                     ; 161     uint8_t i = 0, j = 0;
 619                     ; 163     CC1101_SET_CSN_LOW( );
 621  00bf 4b10          	push	#16
 622  00c1 ae5005        	ldw	x,#20485
 623  00c4 cd0000        	call	_GPIO_ResetBits
 625  00c7 84            	pop	a
 626                     ; 165     drv_spi_read_write_byte( Addr | READ_BURST);	//连续读命令 及首地址
 628  00c8 7b03          	ld	a,(OFST+1,sp)
 629  00ca aac0          	or	a,#192
 630  00cc cd0000        	call	_drv_spi_read_write_byte
 632                     ; 166     for( i = 0; i < ReadSize; i ++ )
 634  00cf 0f01          	clr	(OFST-1,sp)
 636  00d1 201f          	jra	L322
 637  00d3               L712:
 638                     ; 168         for( j = 0; j < 20; j ++ );
 640  00d3 0f02          	clr	(OFST+0,sp)
 641  00d5               L722:
 645  00d5 0c02          	inc	(OFST+0,sp)
 648  00d7 7b02          	ld	a,(OFST+0,sp)
 649  00d9 a114          	cp	a,#20
 650  00db 25f8          	jrult	L722
 651                     ; 169         *( pReadBuff + i ) = drv_spi_read_write_byte( 0xFF );	//连续读取数据
 653  00dd 7b06          	ld	a,(OFST+4,sp)
 654  00df 97            	ld	xl,a
 655  00e0 7b07          	ld	a,(OFST+5,sp)
 656  00e2 1b01          	add	a,(OFST-1,sp)
 657  00e4 2401          	jrnc	L22
 658  00e6 5c            	incw	x
 659  00e7               L22:
 660  00e7 02            	rlwa	x,a
 661  00e8 89            	pushw	x
 662  00e9 a6ff          	ld	a,#255
 663  00eb cd0000        	call	_drv_spi_read_write_byte
 665  00ee 85            	popw	x
 666  00ef f7            	ld	(x),a
 667                     ; 166     for( i = 0; i < ReadSize; i ++ )
 669  00f0 0c01          	inc	(OFST-1,sp)
 670  00f2               L322:
 673  00f2 7b01          	ld	a,(OFST-1,sp)
 674  00f4 1108          	cp	a,(OFST+6,sp)
 675  00f6 25db          	jrult	L712
 676                     ; 172     CC1101_SET_CSN_HIGH( );
 678  00f8 4b10          	push	#16
 679  00fa ae5005        	ldw	x,#20485
 680  00fd cd0000        	call	_GPIO_SetBits
 682  0100 84            	pop	a
 683                     ; 173 }
 686  0101 5b03          	addw	sp,#3
 687  0103 81            	ret
 753                     ; 182 void CC1101_Set_Mode( CC1101_ModeType Mode )
 753                     ; 183 {
 754                     	switch	.text
 755  0104               _CC1101_Set_Mode:
 757  0104 88            	push	a
 758  0105 88            	push	a
 759       00000001      OFST:	set	1
 762                     ; 184 	uint8_t WaitTimeOut = 0;
 764  0106 0f01          	clr	(OFST+0,sp)
 765                     ; 186     if( Mode == TX_MODE )			//发送模式
 767  0108 4d            	tnz	a
 768  0109 2610          	jrne	L762
 769                     ; 188         CC1101_Write_Reg( CC1101_IOCFG0,0x46 );
 771  010b ae0046        	ldw	x,#70
 772  010e a602          	ld	a,#2
 773  0110 95            	ld	xh,a
 774  0111 cd001a        	call	_CC1101_Write_Reg
 776                     ; 189         CC1101_Write_Cmd( CC1101_STX );		
 778  0114 a635          	ld	a,#53
 779  0116 cd0000        	call	_CC1101_Write_Cmd
 782  0119 2014          	jra	L772
 783  011b               L762:
 784                     ; 191     else if( Mode == RX_MODE )		//接收模式
 786  011b 7b02          	ld	a,(OFST+1,sp)
 787  011d a101          	cp	a,#1
 788  011f 260e          	jrne	L772
 789                     ; 193         CC1101_Write_Reg(CC1101_IOCFG0,0x46);
 791  0121 ae0046        	ldw	x,#70
 792  0124 a602          	ld	a,#2
 793  0126 95            	ld	xh,a
 794  0127 cd001a        	call	_CC1101_Write_Reg
 796                     ; 194         CC1101_Write_Cmd( CC1101_SRX );
 798  012a a634          	ld	a,#52
 799  012c cd0000        	call	_CC1101_Write_Cmd
 801  012f               L772:
 802                     ; 197 	while( 0 != CC1101_GET_GDO0_STATUS( ));		//等待发送 或 接收开始
 804  012f c65006        	ld	a,20486
 805  0132 a408          	and	a,#8
 806  0134 a108          	cp	a,#8
 807  0136 27f7          	jreq	L772
 808                     ; 198 }
 811  0138 85            	popw	x
 812  0139 81            	ret
 837                     ; 206 void CC1101_Set_Idle_Mode( void )
 837                     ; 207 {
 838                     	switch	.text
 839  013a               _CC1101_Set_Idle_Mode:
 843                     ; 208     CC1101_Write_Cmd( CC1101_SIDLE );
 845  013a a636          	ld	a,#54
 846  013c cd0000        	call	_CC1101_Write_Cmd
 848                     ; 209 }
 851  013f 81            	ret
 876                     ; 217 void C1101_WOR_Init( void )
 876                     ; 218 {
 877                     	switch	.text
 878  0140               _C1101_WOR_Init:
 882                     ; 219     CC1101_Write_Reg(CC1101_MCSM0,0x18);		
 884  0140 ae0018        	ldw	x,#24
 885  0143 a618          	ld	a,#24
 886  0145 95            	ld	xh,a
 887  0146 cd001a        	call	_CC1101_Write_Reg
 889                     ; 220     CC1101_Write_Reg(CC1101_WORCTRL,0x78); 
 891  0149 ae0078        	ldw	x,#120
 892  014c a620          	ld	a,#32
 893  014e 95            	ld	xh,a
 894  014f cd001a        	call	_CC1101_Write_Reg
 896                     ; 221     CC1101_Write_Reg(CC1101_MCSM2,0x00);
 898  0152 5f            	clrw	x
 899  0153 a616          	ld	a,#22
 900  0155 95            	ld	xh,a
 901  0156 cd001a        	call	_CC1101_Write_Reg
 903                     ; 222     CC1101_Write_Reg(CC1101_WOREVT1,0x8C);
 905  0159 ae008c        	ldw	x,#140
 906  015c a61e          	ld	a,#30
 907  015e 95            	ld	xh,a
 908  015f cd001a        	call	_CC1101_Write_Reg
 910                     ; 223     CC1101_Write_Reg(CC1101_WOREVT0,0xA0);
 912  0162 ae00a0        	ldw	x,#160
 913  0165 a61f          	ld	a,#31
 914  0167 95            	ld	xh,a
 915  0168 cd001a        	call	_CC1101_Write_Reg
 917                     ; 224 	CC1101_Write_Cmd( CC1101_SWORRST );		//写入WOR命令
 919  016b a63c          	ld	a,#60
 920  016d cd0000        	call	_CC1101_Write_Cmd
 922                     ; 225 }
 925  0170 81            	ret
1014                     ; 235 void CC1101_Set_Address( uint8_t Address, CC1101_AddrModeType AddressMode)
1014                     ; 236 {
1015                     	switch	.text
1016  0171               _CC1101_Set_Address:
1018  0171 89            	pushw	x
1019  0172 88            	push	a
1020       00000001      OFST:	set	1
1023                     ; 237     uint8_t btmp = 0;
1025                     ; 239 	btmp = CC1101_Read_Reg( CC1101_PKTCTRL1 ) & ~0x03;	//读取CC1101_PKTCTRL1寄存器初始值
1027  0173 a607          	ld	a,#7
1028  0175 cd0071        	call	_CC1101_Read_Reg
1030  0178 a4fc          	and	a,#252
1031  017a 6b01          	ld	(OFST+0,sp),a
1032                     ; 240     CC1101_Write_Reg( CC1101_ADDR, Address );			//设置设备地址
1034  017c 7b02          	ld	a,(OFST+1,sp)
1035  017e 97            	ld	xl,a
1036  017f a609          	ld	a,#9
1037  0181 95            	ld	xh,a
1038  0182 cd001a        	call	_CC1101_Write_Reg
1040                     ; 242     if( AddressMode == BROAD_ALL )     { }				//不检测地址
1042  0185 0d03          	tnz	(OFST+2,sp)
1043  0187 2728          	jreq	L763
1045                     ; 243     else if( AddressMode == BROAD_NO  )
1047  0189 7b03          	ld	a,(OFST+2,sp)
1048  018b a101          	cp	a,#1
1049  018d 2608          	jrne	L173
1050                     ; 245 		btmp |= 0x01;									//检测地址 但是不带广播
1052  018f 7b01          	ld	a,(OFST+0,sp)
1053  0191 aa01          	or	a,#1
1054  0193 6b01          	ld	(OFST+0,sp),a
1056  0195 201a          	jra	L763
1057  0197               L173:
1058                     ; 247     else if( AddressMode == BROAD_0   )
1060  0197 7b03          	ld	a,(OFST+2,sp)
1061  0199 a102          	cp	a,#2
1062  019b 2608          	jrne	L573
1063                     ; 249 		btmp |= 0x02;									//0x00为广播
1065  019d 7b01          	ld	a,(OFST+0,sp)
1066  019f aa02          	or	a,#2
1067  01a1 6b01          	ld	(OFST+0,sp),a
1069  01a3 200c          	jra	L763
1070  01a5               L573:
1071                     ; 251     else if( AddressMode == BROAD_0AND255 ) 
1073  01a5 7b03          	ld	a,(OFST+2,sp)
1074  01a7 a103          	cp	a,#3
1075  01a9 2606          	jrne	L763
1076                     ; 253 		btmp |= 0x03; 									//0x00 0xFF为广播
1078  01ab 7b01          	ld	a,(OFST+0,sp)
1079  01ad aa03          	or	a,#3
1080  01af 6b01          	ld	(OFST+0,sp),a
1081  01b1               L763:
1082                     ; 256 	CC1101_Write_Reg( CC1101_PKTCTRL1, btmp);			//写入地址模式	
1084  01b1 7b01          	ld	a,(OFST+0,sp)
1085  01b3 97            	ld	xl,a
1086  01b4 a607          	ld	a,#7
1087  01b6 95            	ld	xh,a
1088  01b7 cd001a        	call	_CC1101_Write_Reg
1090                     ; 257 }
1093  01ba 5b03          	addw	sp,#3
1094  01bc 81            	ret
1129                     ; 265 void CC1101_Set_Sync( uint16_t Sync )
1129                     ; 266 {
1130                     	switch	.text
1131  01bd               _CC1101_Set_Sync:
1133  01bd 89            	pushw	x
1134       00000000      OFST:	set	0
1137                     ; 267     CC1101_Write_Reg( CC1101_SYNC1, 0xFF & ( Sync >> 8 ) );
1139  01be 9e            	ld	a,xh
1140  01bf 97            	ld	xl,a
1141  01c0 a604          	ld	a,#4
1142  01c2 95            	ld	xh,a
1143  01c3 cd001a        	call	_CC1101_Write_Reg
1145                     ; 268     CC1101_Write_Reg( CC1101_SYNC0, 0xFF & Sync ); 	//写入同步字段 16Bit
1147  01c6 7b02          	ld	a,(OFST+2,sp)
1148  01c8 a4ff          	and	a,#255
1149  01ca 97            	ld	xl,a
1150  01cb a605          	ld	a,#5
1151  01cd 95            	ld	xh,a
1152  01ce cd001a        	call	_CC1101_Write_Reg
1154                     ; 269 }
1157  01d1 85            	popw	x
1158  01d2 81            	ret
1184                     ; 277 void CC1101_Clear_TxBuffer( void )
1184                     ; 278 {
1185                     	switch	.text
1186  01d3               _CC1101_Clear_TxBuffer:
1190                     ; 279     CC1101_Set_Idle_Mode( );					//首先进入IDLE模式
1192  01d3 cd013a        	call	_CC1101_Set_Idle_Mode
1194                     ; 280     CC1101_Write_Cmd( CC1101_SFTX );			//写入清发送缓冲区命令		
1196  01d6 a63b          	ld	a,#59
1197  01d8 cd0000        	call	_CC1101_Write_Cmd
1199                     ; 281 }
1202  01db 81            	ret
1228                     ; 289 void CC1101_Clear_RxBuffer( void )
1228                     ; 290 {
1229                     	switch	.text
1230  01dc               _CC1101_Clear_RxBuffer:
1234                     ; 291     CC1101_Set_Idle_Mode();						//首先进入IDLE模式
1236  01dc cd013a        	call	_CC1101_Set_Idle_Mode
1238                     ; 292     CC1101_Write_Cmd( CC1101_SFRX );			//写入清接收缓冲区命令
1240  01df a63a          	ld	a,#58
1241  01e1 cd0000        	call	_CC1101_Write_Cmd
1243                     ; 293 }
1246  01e4 81            	ret
1345                     ; 304 void CC1101_Tx_Packet( uint8_t *pTxBuff, uint8_t TxSize, CC1101_TxDataModeType DataMode )
1345                     ; 305 {
1346                     	switch	.text
1347  01e5               _CC1101_Tx_Packet:
1349  01e5 89            	pushw	x
1350  01e6 5203          	subw	sp,#3
1351       00000003      OFST:	set	3
1354                     ; 307 	uint16_t l_RxWaitTimeout = 0;
1356  01e8 5f            	clrw	x
1357  01e9 1f02          	ldw	(OFST-1,sp),x
1358                     ; 309     if( DataMode == BROADCAST )             
1360  01eb 0d09          	tnz	(OFST+6,sp)
1361  01ed 2604          	jrne	L705
1362                     ; 311 		Address = 0; 
1364  01ef 0f01          	clr	(OFST-2,sp)
1366  01f1 200d          	jra	L115
1367  01f3               L705:
1368                     ; 313     else if( DataMode == ADDRESS_CHECK )    
1370  01f3 7b09          	ld	a,(OFST+6,sp)
1371  01f5 a101          	cp	a,#1
1372  01f7 2607          	jrne	L115
1373                     ; 315 		Address = CC1101_Read_Reg( CC1101_ADDR ); 
1375  01f9 a609          	ld	a,#9
1376  01fb cd0071        	call	_CC1101_Read_Reg
1378  01fe 6b01          	ld	(OFST-2,sp),a
1379  0200               L115:
1380                     ; 318     CC1101_Clear_TxBuffer( );
1382  0200 add1          	call	_CC1101_Clear_TxBuffer
1384                     ; 320     if(( CC1101_Read_Reg( CC1101_PKTCTRL1 ) & 0x03 ) != 0 )	
1386  0202 a607          	ld	a,#7
1387  0204 cd0071        	call	_CC1101_Read_Reg
1389  0207 a503          	bcp	a,#3
1390  0209 2715          	jreq	L515
1391                     ; 322         CC1101_Write_Reg( CC1101_TXFIFO, TxSize + 1 );		
1393  020b 7b08          	ld	a,(OFST+5,sp)
1394  020d 4c            	inc	a
1395  020e 97            	ld	xl,a
1396  020f a63f          	ld	a,#63
1397  0211 95            	ld	xh,a
1398  0212 cd001a        	call	_CC1101_Write_Reg
1400                     ; 323         CC1101_Write_Reg( CC1101_TXFIFO, Address );			//写入长度和地址 由于多一个字节地址此时长度应该加1
1402  0215 7b01          	ld	a,(OFST-2,sp)
1403  0217 97            	ld	xl,a
1404  0218 a63f          	ld	a,#63
1405  021a 95            	ld	xh,a
1406  021b cd001a        	call	_CC1101_Write_Reg
1409  021e 2009          	jra	L715
1410  0220               L515:
1411                     ; 327         CC1101_Write_Reg( CC1101_TXFIFO, TxSize );			//只写长度 不带地址
1413  0220 7b08          	ld	a,(OFST+5,sp)
1414  0222 97            	ld	xl,a
1415  0223 a63f          	ld	a,#63
1416  0225 95            	ld	xh,a
1417  0226 cd001a        	call	_CC1101_Write_Reg
1419  0229               L715:
1420                     ; 330     CC1101_Write_Multi_Reg( CC1101_TXFIFO, pTxBuff, TxSize );	//写入数据
1422  0229 7b08          	ld	a,(OFST+5,sp)
1423  022b 88            	push	a
1424  022c 1e05          	ldw	x,(OFST+2,sp)
1425  022e 89            	pushw	x
1426  022f a63f          	ld	a,#63
1427  0231 cd0039        	call	_CC1101_Write_Multi_Reg
1429  0234 5b03          	addw	sp,#3
1430                     ; 331     CC1101_Set_Mode( TX_MODE );								//发送模式
1432  0236 4f            	clr	a
1433  0237 cd0104        	call	_CC1101_Set_Mode
1436  023a 201b          	jra	L325
1437  023c               L125:
1438                     ; 335 		drv_delay_ms( 1 );
1440  023c ae0001        	ldw	x,#1
1441  023f cd0000        	call	_drv_delay_ms
1443                     ; 336 		if( 1000 == l_RxWaitTimeout++ )
1445  0242 1e02          	ldw	x,(OFST-1,sp)
1446  0244 1c0001        	addw	x,#1
1447  0247 1f02          	ldw	(OFST-1,sp),x
1448  0249 1d0001        	subw	x,#1
1449  024c a303e8        	cpw	x,#1000
1450  024f 2606          	jrne	L325
1451                     ; 338 			l_RxWaitTimeout = 0;
1453                     ; 339 			CC1101_Init( );
1455  0251 cd0331        	call	_CC1101_Init
1457                     ; 340 			break; 
1458  0254               L525:
1459                     ; 343 }
1462  0254 5b05          	addw	sp,#5
1463  0256 81            	ret
1464  0257               L325:
1465                     ; 333 	while( 0 == CC1101_GET_GDO0_STATUS( ))		//等待发送完成
1467  0257 c65006        	ld	a,20486
1468  025a a408          	and	a,#8
1469  025c a108          	cp	a,#8
1470  025e 26dc          	jrne	L125
1471  0260 20f2          	jra	L525
1496                     ; 351 uint8_t CC1101_Get_RxCounter( void )
1496                     ; 352 {
1497                     	switch	.text
1498  0262               _CC1101_Get_RxCounter:
1502                     ; 353     return ( CC1101_Read_Status( CC1101_RXBYTES ) & BYTES_IN_RXFIFO );	
1504  0262 a63b          	ld	a,#59
1505  0264 cd0097        	call	_CC1101_Read_Status
1507  0267 a47f          	and	a,#127
1510  0269 81            	ret
1513                     	switch	.const
1514  0034               L145_l_Status:
1515  0034 00            	dc.b	0
1516  0035 00            	ds.b	1
1583                     ; 363 uint8_t CC1101_Rx_Packet( uint8_t *RxBuff )
1583                     ; 364 {
1584                     	switch	.text
1585  026a               _CC1101_Rx_Packet:
1587  026a 89            	pushw	x
1588  026b 5205          	subw	sp,#5
1589       00000005      OFST:	set	5
1592                     ; 365 	uint8_t l_PktLen = 0;
1594                     ; 366     uint8_t l_Status[ 2 ] = { 0 };
1596  026d c60034        	ld	a,L145_l_Status
1597  0270 6b01          	ld	(OFST-4,sp),a
1598  0272 c60035        	ld	a,L145_l_Status+1
1599  0275 6b02          	ld	(OFST-3,sp),a
1600                     ; 367 	uint16_t l_RxWaitTimeout = 0;
1602  0277 5f            	clrw	x
1603  0278 1f04          	ldw	(OFST-1,sp),x
1605  027a 2034          	jra	L106
1606  027c               L575:
1607                     ; 371 		drv_delay_ms( 1 );
1609  027c ae0001        	ldw	x,#1
1610  027f cd0000        	call	_drv_delay_ms
1612                     ; 372 		if( 3000 == l_RxWaitTimeout++ )
1614  0282 1e04          	ldw	x,(OFST-1,sp)
1615  0284 1c0001        	addw	x,#1
1616  0287 1f04          	ldw	(OFST-1,sp),x
1617  0289 1d0001        	subw	x,#1
1618  028c a30bb8        	cpw	x,#3000
1619  028f 261f          	jrne	L106
1620                     ; 374 			l_RxWaitTimeout = 0;
1622                     ; 375 			CC1101_Init( );
1624  0291 cd0331        	call	_CC1101_Init
1626                     ; 376 			break; 
1627  0294               L306:
1628                     ; 380     if( 0 != CC1101_Get_RxCounter( ))
1630  0294 adcc          	call	_CC1101_Get_RxCounter
1632  0296 4d            	tnz	a
1633  0297 2757          	jreq	L706
1634                     ; 382         l_PktLen = CC1101_Read_Reg( CC1101_RXFIFO );           // 获取长度信息
1636  0299 a63f          	ld	a,#63
1637  029b cd0071        	call	_CC1101_Read_Reg
1639  029e 6b03          	ld	(OFST-2,sp),a
1640                     ; 384 		if( ( CC1101_Read_Reg( CC1101_PKTCTRL1 ) & 0x03 ) != 0 )
1642  02a0 a607          	ld	a,#7
1643  02a2 cd0071        	call	_CC1101_Read_Reg
1645  02a5 a503          	bcp	a,#3
1646  02a7 2712          	jreq	L116
1647                     ; 386            CC1101_Read_Reg( CC1101_RXFIFO );					//如果数据包中包含地址信息 ，则读取地址信息
1649  02a9 a63f          	ld	a,#63
1650  02ab cd0071        	call	_CC1101_Read_Reg
1652  02ae 200b          	jra	L116
1653  02b0               L106:
1654                     ; 369 	while( 0 == CC1101_GET_GDO0_STATUS( ))		//等待接收完成
1656  02b0 c65006        	ld	a,20486
1657  02b3 a408          	and	a,#8
1658  02b5 a108          	cp	a,#8
1659  02b7 26c3          	jrne	L575
1660  02b9 20d9          	jra	L306
1661  02bb               L116:
1662                     ; 388         if( l_PktLen == 0 )           
1664  02bb 0d03          	tnz	(OFST-2,sp)
1665  02bd 2603          	jrne	L316
1666                     ; 390 			return 0;			//无数据
1668  02bf 4f            	clr	a
1670  02c0 2028          	jra	L05
1671  02c2               L316:
1672                     ; 394 			l_PktLen--; 		//减去一个地址字节
1674  02c2 0a03          	dec	(OFST-2,sp)
1675                     ; 396         CC1101_Read_Multi_Reg( CC1101_RXFIFO, RxBuff, l_PktLen ); 	//读取数据
1677  02c4 7b03          	ld	a,(OFST-2,sp)
1678  02c6 88            	push	a
1679  02c7 1e07          	ldw	x,(OFST+2,sp)
1680  02c9 89            	pushw	x
1681  02ca a63f          	ld	a,#63
1682  02cc cd00bd        	call	_CC1101_Read_Multi_Reg
1684  02cf 5b03          	addw	sp,#3
1685                     ; 397         CC1101_Read_Multi_Reg( CC1101_RXFIFO, l_Status, 2 );		//读取数据包最后两个额外字节，后一个为CRC标志位
1687  02d1 4b02          	push	#2
1688  02d3 96            	ldw	x,sp
1689  02d4 1c0002        	addw	x,#OFST-3
1690  02d7 89            	pushw	x
1691  02d8 a63f          	ld	a,#63
1692  02da cd00bd        	call	_CC1101_Read_Multi_Reg
1694  02dd 5b03          	addw	sp,#3
1695                     ; 399         CC1101_Clear_RxBuffer( );
1697  02df cd01dc        	call	_CC1101_Clear_RxBuffer
1699                     ; 401         if( l_Status[ 1 ] & CRC_OK )
1701  02e2 7b02          	ld	a,(OFST-3,sp)
1702  02e4 a580          	bcp	a,#128
1703  02e6 2705          	jreq	L716
1704                     ; 403 			return l_PktLen; 
1706  02e8 7b03          	ld	a,(OFST-2,sp)
1708  02ea               L05:
1710  02ea 5b07          	addw	sp,#7
1711  02ec 81            	ret
1712  02ed               L716:
1713                     ; 407 			return 0; 
1715  02ed 4f            	clr	a
1717  02ee 20fa          	jra	L05
1718  02f0               L706:
1719                     ; 412 		return 0; 
1721  02f0 4f            	clr	a
1723  02f1 20f7          	jra	L05
1750                     ; 422 void CC1101_Reset( void )
1750                     ; 423 {
1751                     	switch	.text
1752  02f3               _CC1101_Reset:
1756                     ; 424 	CC1101_SET_CSN_HIGH( );
1758  02f3 4b10          	push	#16
1759  02f5 ae5005        	ldw	x,#20485
1760  02f8 cd0000        	call	_GPIO_SetBits
1762  02fb 84            	pop	a
1763                     ; 425 	CC1101_SET_CSN_LOW( );
1765  02fc 4b10          	push	#16
1766  02fe ae5005        	ldw	x,#20485
1767  0301 cd0000        	call	_GPIO_ResetBits
1769  0304 84            	pop	a
1770                     ; 426 	CC1101_SET_CSN_HIGH( );
1772  0305 4b10          	push	#16
1773  0307 ae5005        	ldw	x,#20485
1774  030a cd0000        	call	_GPIO_SetBits
1776  030d 84            	pop	a
1777                     ; 427 	drv_delay_ms( 1 );
1779  030e ae0001        	ldw	x,#1
1780  0311 cd0000        	call	_drv_delay_ms
1782                     ; 428 	CC1101_Write_Cmd( CC1101_SRES );
1784  0314 a630          	ld	a,#48
1785  0316 cd0000        	call	_CC1101_Write_Cmd
1787                     ; 429 }
1790  0319 81            	ret
1814                     ; 437 static void CC1101_Gpio_Init( void )
1814                     ; 438 {
1815                     	switch	.text
1816  031a               L536_CC1101_Gpio_Init:
1820                     ; 440 	GPIO_Init( CC1101_GDO0_GPIO_PORT, CC1101_GDO0_GPIO_PIN, GPIO_Mode_In_PU_No_IT  );
1822  031a 4b40          	push	#64
1823  031c 4b08          	push	#8
1824  031e ae5005        	ldw	x,#20485
1825  0321 cd0000        	call	_GPIO_Init
1827  0324 85            	popw	x
1828                     ; 441 	GPIO_Init( CC1101_GDO2_GPIO_PORT, CC1101_GDO2_GPIO_PIN, GPIO_Mode_In_PU_No_IT  );
1830  0325 4b40          	push	#64
1831  0327 4b01          	push	#1
1832  0329 ae500a        	ldw	x,#20490
1833  032c cd0000        	call	_GPIO_Init
1835  032f 85            	popw	x
1836                     ; 442 }
1839  0330 81            	ret
1881                     ; 450 void CC1101_Init( void )
1881                     ; 451 {
1882                     	switch	.text
1883  0331               _CC1101_Init:
1885  0331 88            	push	a
1886       00000001      OFST:	set	1
1889                     ; 452 	uint8_t i = 0;
1891                     ; 454 	CC1101_Gpio_Init( );
1893  0332 ade6          	call	L536_CC1101_Gpio_Init
1895                     ; 455 	CC1101_Reset( );    
1897  0334 adbd          	call	_CC1101_Reset
1899                     ; 457 	for( i = 0; i < 22; i++ )
1901  0336 0f01          	clr	(OFST+0,sp)
1902  0338               L566:
1903                     ; 459 		CC1101_Write_Reg( CC1101InitData[i][0], CC1101InitData[i][1] );
1905  0338 7b01          	ld	a,(OFST+0,sp)
1906  033a 5f            	clrw	x
1907  033b 97            	ld	xl,a
1908  033c 58            	sllw	x
1909  033d d60009        	ld	a,(L3_CC1101InitData+1,x)
1910  0340 97            	ld	xl,a
1911  0341 7b01          	ld	a,(OFST+0,sp)
1912  0343 905f          	clrw	y
1913  0345 9097          	ld	yl,a
1914  0347 9058          	sllw	y
1915  0349 90d60008      	ld	a,(L3_CC1101InitData,y)
1916  034d 95            	ld	xh,a
1917  034e cd001a        	call	_CC1101_Write_Reg
1919                     ; 457 	for( i = 0; i < 22; i++ )
1921  0351 0c01          	inc	(OFST+0,sp)
1924  0353 7b01          	ld	a,(OFST+0,sp)
1925  0355 a116          	cp	a,#22
1926  0357 25df          	jrult	L566
1927                     ; 461 	CC1101_Set_Address( 0x05, BROAD_0AND255 );	//设备地址 和 地址检测模式设置
1929  0359 ae0003        	ldw	x,#3
1930  035c a605          	ld	a,#5
1931  035e 95            	ld	xh,a
1932  035f cd0171        	call	_CC1101_Set_Address
1934                     ; 462 	CC1101_Set_Sync( 0x8799 );					//同步字段设置
1936  0362 ae8799        	ldw	x,#34713
1937  0365 cd01bd        	call	_CC1101_Set_Sync
1939                     ; 463 	CC1101_Write_Reg(CC1101_MDMCFG1, 0x72);		//调制解调器配置
1941  0368 ae0072        	ldw	x,#114
1942  036b a613          	ld	a,#19
1943  036d 95            	ld	xh,a
1944  036e cd001a        	call	_CC1101_Write_Reg
1946                     ; 465 	CC1101_Write_Multi_Reg( CC1101_PATABLE, (uint8_t*)PaTabel, 8 );
1948  0371 4b08          	push	#8
1949  0373 ae0000        	ldw	x,#_PaTabel
1950  0376 89            	pushw	x
1951  0377 a63e          	ld	a,#62
1952  0379 cd0039        	call	_CC1101_Write_Multi_Reg
1954  037c 5b03          	addw	sp,#3
1955                     ; 466 }
1958  037e 84            	pop	a
1959  037f 81            	ret
1995                     	xdef	_PaTabel
1996                     	xdef	_CC1101_Init
1997                     	xdef	_CC1101_Reset
1998                     	xdef	_CC1101_Rx_Packet
1999                     	xdef	_CC1101_Get_RxCounter
2000                     	xdef	_CC1101_Tx_Packet
2001                     	xdef	_CC1101_Clear_RxBuffer
2002                     	xdef	_CC1101_Clear_TxBuffer
2003                     	xdef	_CC1101_Set_Sync
2004                     	xdef	_CC1101_Set_Address
2005                     	xdef	_C1101_WOR_Init
2006                     	xdef	_CC1101_Set_Idle_Mode
2007                     	xdef	_CC1101_Set_Mode
2008                     	xdef	_CC1101_Read_Status
2009                     	xdef	_CC1101_Read_Multi_Reg
2010                     	xdef	_CC1101_Read_Reg
2011                     	xdef	_CC1101_Write_Multi_Reg
2012                     	xdef	_CC1101_Write_Reg
2013                     	xdef	_CC1101_Write_Cmd
2014                     	xref	_drv_spi_read_write_byte
2015                     	xref	_drv_delay_ms
2016                     	xref	_GPIO_ResetBits
2017                     	xref	_GPIO_SetBits
2018                     	xref	_GPIO_Init
2037                     	end
