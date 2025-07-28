;Program compiled by Great Cow BASIC (0.98.06 2019-06-12 (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=12F683, r=DEC
#include <P12F683.inc>
 __CONFIG _CP_OFF & _MCLRE_OFF & _WDTE_OFF & _FOSC_INTOSCIO

;********************************************************************************

;Set aside memory locations for variables
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
I2CACK	EQU	32
I2CACKPOLLSTATE	EQU	33
I2CBYTE	EQU	34
I2CMATCH	EQU	35
I2CSTATE	EQU	36
I2C_LCD_BYTE	EQU	37
LCDBYTE	EQU	38
LCDCOLUMN	EQU	39
LCDLINE	EQU	40
LCD_BACKLIGHT	EQU	41
LCD_I2C_ADDRESS_CURRENT	EQU	42
LCD_STATE	EQU	43
PRINTLEN	EQU	44
STRINGPOINTER	EQU	45
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSLCDTEMP	EQU	46
SYSPRINTDATAHANDLER	EQU	47
SYSPRINTDATAHANDLER_H	EQU	48
SYSPRINTTEMP	EQU	49
SYSREPEATTEMP1	EQU	50
SYSREPEATTEMP2	EQU	51
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGB	EQU	114
SYSSTRINGB_H	EQU	115
SYSSTRINGLENGTH	EQU	118
SYSSTRINGPARAM1	EQU	186
SYSTEMP1	EQU	52
SYSWAITTEMP10US	EQU	117
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
SYSWAITTEMPUS	EQU	117
SYSWAITTEMPUS_H	EQU	118

;********************************************************************************

;Vectors
	ORG	0
	pagesel	BASPROGRAMSTART
	goto	BASPROGRAMSTART
	ORG	4
	retfie

;********************************************************************************

;Start of program memory page 0
	ORG	5
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
	call	INITI2C
	call	INITLCD

;Start of the main program
;#define I2C_MODE Master
;#define I2C_DATA GPIO.0
;#define I2C_CLOCK GPIO.1
;#define I2C_DISABLE_INTERRUPTS ON
;#define LCD_IO 10
;#define LCD_I2C_Address_1 0x7E
;Frequency Signal input >  GP5/T1CK1/PIN2
;locate 0,0: print "test"
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
	movlw	low SYSSTRINGPARAM1
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM1
	movwf	SysStringB_H
	movlw	low StringTable1
	movwf	SysStringA
	movlw	high StringTable1
	movwf	SysStringA_H
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	call	PRINT108
;locate 1,0: print "test2"
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
	movlw	low SYSSTRINGPARAM1
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM1
	movwf	SysStringB_H
	movlw	low StringTable2
	movwf	SysStringA
	movlw	high StringTable2
	movwf	SysStringA_H
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	call	PRINT108
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

CLS
;SET LCD_RS OFF
	bcf	SYSLCDTEMP,1
;Clear screen
;LCDWriteByte (0b00000001)
	movlw	1
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;Wait 4 ms
	movlw	4
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Move to start of visible DDRAM
;LCDWriteByte(0x80)
	movlw	128
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;Wait 12 10us
	movlw	12
	movwf	SysWaitTemp10US
	goto	Delay_10US

;********************************************************************************

Delay_10US
D10US_START
	movlw	5
	movwf	DELAYTEMP
DelayUS0
	decfsz	DELAYTEMP,F
	goto	DelayUS0
	nop
	decfsz	SysWaitTemp10US, F
	goto	D10US_START
	return

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F
DMS_START
	movlw	4
	movwf	DELAYTEMP2
DMS_OUTER
	movlw	165
	movwf	DELAYTEMP
DMS_INNER
	decfsz	DELAYTEMP, F
	goto	DMS_INNER
	decfsz	DELAYTEMP2, F
	goto	DMS_OUTER
	decfsz	SysWaitTempMS, F
	goto	DMS_START
	decfsz	SysWaitTempMS_H, F
	goto	DMS_START
	return

;********************************************************************************

I2CRESTART
;I2CStart
	goto	I2CSTART

;********************************************************************************

I2CSEND
;I2C_CLOCK_LOW                 'begin with SCL=0
	banksel	TRISIO
	bcf	TRISIO,1
	banksel	GPIO
	bcf	GPIO,1
;wait I2C_END_DELAY            'let port settle
	goto	$+1
;repeat 8                      '8 data bits
	movlw	8
	movwf	SysRepeatTemp2
SysRepeatLoop2
;if I2CByte.7 = ON then      'put most significant bit on SDA line
	btfss	I2CBYTE,7
	goto	ELSE18_1
;I2C_DATA_HIGH
	banksel	TRISIO
	bsf	TRISIO,0
;else
	goto	ENDIF18
ELSE18_1
;I2C_DATA_LOW
	banksel	TRISIO
	bcf	TRISIO,0
	banksel	GPIO
	bcf	GPIO,0
;end if
ENDIF18
;rotate I2CByte left         'shift in bit for the next time
	banksel	I2CBYTE
	rlf	I2CBYTE,F
;I2C_CLOCK_HIGH              'now clock it in
	banksel	TRISIO
	bsf	TRISIO,1
;wait while I2C_CLOCK = OFF    'permit clock stretching here
SysWaitLoop1
	banksel	GPIO
	btfss	GPIO,1
	goto	SysWaitLoop1
;wait I2C_CLOCK_DELAY        'clock pulse width given here
	goto	$+1
;I2C_CLOCK_LOW               'done clocking that bit
	banksel	TRISIO
	bcf	TRISIO,1
	banksel	GPIO
	bcf	GPIO,1
;wait I2C_END_DELAY          'time between clock pulses
	goto	$+1
;end repeat                    'then do next bit
	decfsz	SysRepeatTemp2,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
;wait I2C_BIT_DELAY            'pad timing just a little
	goto	$+1
	goto	$+1
;I2C_DATA_HIGH                 'idle SDA to let Slave respond
	banksel	TRISIO
	bsf	TRISIO,0
;wait I2C_END_DELAY            'let SDA port line settle
	goto	$+1
;I2C_CLOCK_HIGH                'clock for the ACK/NAK bit
	bsf	TRISIO,1
;wait while I2C_CLOCK = OFF    'permit clock stretching here
SysWaitLoop2
	banksel	GPIO
	btfss	GPIO,1
	goto	SysWaitLoop2
;restored 'I2CSendState' variable for backwards compatibility
;if I2C_DATA then              'read 9th bit in from Slave
	btfss	GPIO,0
	goto	ELSE19_1
;I2CAck = FALSE              'return a NAK to the program
	clrf	I2CACK
;I2CSendState =  FALSE        'state of target device with respect. Retained for backwards compatibility
	clrf	I2CACKPOLLSTATE
;else
	goto	ENDIF19
ELSE19_1
;I2CAck = TRUE               'else, return an ACK to the program
	movlw	255
	movwf	I2CACK
;I2CSendState =  TRUE        'state of target device with respect. Retained for backwards compatibility
	movlw	255
	movwf	I2CACKPOLLSTATE
;end if
ENDIF19
;I2C_CLOCK_LOW                 'may be more bytes to clock out
	banksel	TRISIO
	bcf	TRISIO,1
	banksel	GPIO
	bcf	GPIO,1
;wait I2C_END_DELAY            'so keep idling both
	goto	$+1
;I2C_DATA_LOW                  'SCL and SDA low
	banksel	TRISIO
	bcf	TRISIO,0
	banksel	GPIO
	bcf	GPIO,0
;wait I2C_BIT_DELAY            'wait the usual bit length
	goto	$+1
	goto	$+1
	return

;********************************************************************************

I2CSTART
;I2C_DATA_HIGH                 'SDA and SCL idle high
	banksel	TRISIO
	bsf	TRISIO,0
;I2C_CLOCK_HIGH
	bsf	TRISIO,1
;wait I2C_END_DELAY            'let settle a while
	goto	$+1
;I2C_DATA_LOW                  'then, SDA low while SCL still high
	bcf	TRISIO,0
	banksel	GPIO
	bcf	GPIO,0
;wait I2C_CLOCK_DELAY          'for this amount of time
	goto	$+1
;I2C_CLOCK_LOW                 'end with SCL low, ready to clock
	banksel	TRISIO
	bcf	TRISIO,1
	banksel	GPIO
	bcf	GPIO,1
	return

;********************************************************************************

I2CSTOP
;I2C_CLOCK_LOW                 'begin with SCL=0 and SDA=0
	banksel	TRISIO
	bcf	TRISIO,1
	banksel	GPIO
	bcf	GPIO,1
;I2C_DATA_LOW
	banksel	TRISIO
	bcf	TRISIO,0
	banksel	GPIO
	bcf	GPIO,0
;wait I2C_END_DELAY            'let ports settle
	goto	$+1
;I2C_CLOCK_HIGH                'make SCL=1 first
	banksel	TRISIO
	bsf	TRISIO,1
;wait I2C_CLOCK_DELAY          'hold for normal clock width time
	goto	$+1
;I2C_DATA_HIGH                 'then make SDA=1 afterwards
	bsf	TRISIO,0
;wait I2C_END_DELAY            'hold for normal between-time
	goto	$+1
;back idling with SCL=1 and SDA=1 at this point
	banksel	STATUS
	return

;********************************************************************************

INITI2C
;Moved to prevent variable defintion when not required
;dim I2COldState, I2CState, I2CMatch, I2CTemp as byte
;dim I2CCount alias I2CState
;I2C_DATA_HIGH                   'release SDA (open drain floats high)
	banksel	TRISIO
	bsf	TRISIO,0
;I2C_CLOCK_HIGH                  'release SCL (open drain floats high)
	bsf	TRISIO,1
;I2CMatch = FALSE                'address doesn't match (Slave mode)
	banksel	I2CMATCH
	clrf	I2CMATCH
	return

;********************************************************************************

INITI2CLCD
;moved to a sub support multiple devices
;wait 15 ms
	movlw	15
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;LCDWriteByte 0x03: wait 5 ms
	movlw	3
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	5
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;LCDWriteByte 0x03: wait 1 ms
	movlw	3
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;LCDWriteByte 0x03: wait 1 ms
	movlw	3
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;LCDWriteByte 0x03: wait 1 ms
	movlw	3
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;LCDWriteByte 0x02: wait 1 ms
	movlw	2
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;LCDWriteByte 0x28: wait 1 ms
	movlw	40
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;LCDWriteByte 0x0c: wait 1 ms
	movlw	12
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;LCDWriteByte 0x01: wait 15 ms
	movlw	1
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	15
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;LCDWriteByte 0x06: wait 1 ms
	movlw	6
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;CLS
	goto	CLS

;********************************************************************************

INITLCD
;Initialization routines based upon code examples in HD44780 datasheet
;Configure RS,Enable & RW pin directions
;***********************************
;I2C pcf8574 initialization routine
;***********************************
;#ifndef LCD_I2C_Address_1
;#define LCD_I2C_Address_1 0x4E
;#endif
;InitI2C       ;call to init i2c is required here!
	call	INITI2C
;LCD_Backlight = LCD_Backlight_On_State
	movlw	1
	movwf	LCD_BACKLIGHT
;wait 2 ms
	movlw	2
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;repeat 2  ; called to ensure reset is complete.  Needed for cheap LCDs!!
	movlw	2
	movwf	SysRepeatTemp1
SysRepeatLoop1
;LCD_I2C_Address_Current = LCD_I2C_Address_1
	movlw	126
	movwf	LCD_I2C_ADDRESS_CURRENT
;initI2CLCD
	call	INITI2CLCD
;end repeat
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;LCD_State = 12
	movlw	12
	movwf	LCD_STATE
	return

;********************************************************************************

INITSYS
;asm showdebug 'OSCCON type is 103 - This part does not have Bit HFIOFS @ ifndef Bit(HFIOFS)
;
;added for 18F(L)K20 -WMR
;OSCCON = OSCCON OR b'01110000'
	movlw	112
	banksel	OSCCON
	iorwf	OSCCON,F
;OSCCON = OSCCON AND b'10001111'
	movlw	143
	andwf	OSCCON,F
;Address the two true tables for IRCF
;[canskip] IRCF2, IRCF1, IRCF0 = b'111'    ;111 = 8 MHz (INTOSC drives clock directly)
	bsf	OSCCON,IRCF2
	bsf	OSCCON,IRCF1
	bsf	OSCCON,IRCF0
;End of type 103 init
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;Commence clearing any ANSEL variants in the part
;ANSEL = 0
	banksel	ANSEL
	clrf	ANSEL
;End clearing any ANSEL variants in the part
;CMCON0 = 7
	movlw	7
	banksel	CMCON0
	movwf	CMCON0
;Turn off all ports
;GPIO = 0
	clrf	GPIO
	return

;********************************************************************************

LCDNORMALWRITEBYTE
;IF LCD_RS = 1 then
	btfss	SYSLCDTEMP,1
	goto	ELSE5_1
;i2c_lcd_rs=1;   ''' Data
	bsf	I2C_LCD_BYTE,0
;ELSE
	goto	ENDIF5
ELSE5_1
;i2c_lcd_rs=0;   ''' Command
	bcf	I2C_LCD_BYTE,0
;end if
ENDIF5
;i2c_lcd_rw  = 0;
	bcf	I2C_LCD_BYTE,1
;i2c_lcd_bl  = LCD_Backlight.0;
	bcf	I2C_LCD_BYTE,3
	btfsc	LCD_BACKLIGHT,0
	bsf	I2C_LCD_BYTE,3
;I2CReStart
	call	I2CRESTART
;I2CSend LCD_I2C_Address_Current
	movf	LCD_I2C_ADDRESS_CURRENT,W
	movwf	I2CBYTE
	call	I2CSEND
;'' Send upper nibble
;i2c_lcd_d7 = LCDByte.7
	bcf	I2C_LCD_BYTE,7
	btfsc	LCDBYTE,7
	bsf	I2C_LCD_BYTE,7
;i2c_lcd_d6 = LCDByte.6
	bcf	I2C_LCD_BYTE,6
	btfsc	LCDBYTE,6
	bsf	I2C_LCD_BYTE,6
;i2c_lcd_d5 = LCDByte.5
	bcf	I2C_LCD_BYTE,5
	btfsc	LCDBYTE,5
	bsf	I2C_LCD_BYTE,5
;i2c_lcd_d4 = LCDByte.4
	bcf	I2C_LCD_BYTE,4
	btfsc	LCDBYTE,4
	bsf	I2C_LCD_BYTE,4
;i2c_lcd_e = 0;
	bcf	I2C_LCD_BYTE,2
;I2CSend i2c_lcd_byte
	movf	I2C_LCD_BYTE,W
	movwf	I2CBYTE
	call	I2CSEND
;i2c_lcd_e = 1;
	bsf	I2C_LCD_BYTE,2
;I2CSend i2c_lcd_byte
	movf	I2C_LCD_BYTE,W
	movwf	I2CBYTE
	call	I2CSEND
;i2c_lcd_e = 0;
	bcf	I2C_LCD_BYTE,2
;I2CSend i2c_lcd_byte
	movf	I2C_LCD_BYTE,W
	movwf	I2CBYTE
	call	I2CSEND
;'' Send lower nibble
;i2c_lcd_d7 = LCDByte.3
	bcf	I2C_LCD_BYTE,7
	btfsc	LCDBYTE,3
	bsf	I2C_LCD_BYTE,7
;i2c_lcd_d6 = LCDByte.2
	bcf	I2C_LCD_BYTE,6
	btfsc	LCDBYTE,2
	bsf	I2C_LCD_BYTE,6
;i2c_lcd_d5 = LCDByte.1
	bcf	I2C_LCD_BYTE,5
	btfsc	LCDBYTE,1
	bsf	I2C_LCD_BYTE,5
;i2c_lcd_d4 = LCDByte.0
	bcf	I2C_LCD_BYTE,4
	btfsc	LCDBYTE,0
	bsf	I2C_LCD_BYTE,4
;i2c_lcd_e = 0;
	bcf	I2C_LCD_BYTE,2
;I2CSend i2c_lcd_byte
	movf	I2C_LCD_BYTE,W
	movwf	I2CBYTE
	call	I2CSEND
;i2c_lcd_e = 1;
	bsf	I2C_LCD_BYTE,2
;I2CSend i2c_lcd_byte
	movf	I2C_LCD_BYTE,W
	movwf	I2CBYTE
	call	I2CSEND
;i2c_lcd_e = 0;
	bcf	I2C_LCD_BYTE,2
;I2CSend i2c_lcd_byte
	movf	I2C_LCD_BYTE,W
	movwf	I2CBYTE
	call	I2CSEND
;I2CStop
	call	I2CSTOP
;LCD_State = 12
	movlw	12
	movwf	LCD_STATE
;character delay settings
;wait slow_us us
	movlw	26
	movwf	DELAYTEMP
DelayUS1
	decfsz	DELAYTEMP,F
	goto	DelayUS1
	nop
;If Register Select is low.  14.02.19
;IF LCD_RS = 0 then
	btfsc	SYSLCDTEMP,1
	goto	ENDIF6
;IF LCDByte < 16 then
	movlw	16
	subwf	LCDBYTE,W
	btfsc	STATUS, C
	goto	ENDIF7
;if LCDByte > 7 then
	movf	LCDBYTE,W
	sublw	7
	btfsc	STATUS, C
	goto	ENDIF8
;LCD_State = LCDByte
	movf	LCDBYTE,W
	movwf	LCD_STATE
;end if
ENDIF8
;END IF
ENDIF7
;END IF
ENDIF6
	return

;********************************************************************************

LOCATE
;Set LCD_RS Off
	bcf	SYSLCDTEMP,1
;If LCDLine > 1 Then
	movf	LCDLINE,W
	sublw	1
	btfsc	STATUS, C
	goto	ENDIF1
;LCDLine = LCDLine - 2
	movlw	2
	subwf	LCDLINE,F
;LCDColumn = LCDColumn + LCD_WIDTH
	movlw	20
	addwf	LCDCOLUMN,F
;End If
ENDIF1
;LCDWriteByte(0x80 or 0x40 * LCDLine + LCDColumn)
	movf	LCDLINE,W
	movwf	SysBYTETempA
	movlw	64
	movwf	SysBYTETempB
	call	SysMultSub
	movf	LCDCOLUMN,W
	addwf	SysBYTETempX,W
	movwf	SysTemp1
	movlw	128
	iorwf	SysTemp1,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;wait 5 10us 'test
	movlw	5
	movwf	SysWaitTemp10US
	goto	Delay_10US

;********************************************************************************

;Overloaded signature: STRING:
PRINT108
;PrintLen = LEN(PrintData$)
;PrintLen = PrintData(0)
	movf	SysPRINTDATAHandler,W
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SysPRINTDATAHandler_H,0
	bsf	STATUS, IRP
	movf	INDF,W
	movwf	PRINTLEN
;If PrintLen = 0 Then Exit Sub
	movf	PRINTLEN,F
	btfsc	STATUS, Z
	return
;Set LCD_RS On
	bsf	SYSLCDTEMP,1
;Write Data
;For SysPrintTemp = 1 To PrintLen
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd1
SysForLoop1
	incf	SYSPRINTTEMP,F
;LCDWriteByte PrintData(SysPrintTemp)
	movf	SYSPRINTTEMP,W
	addwf	SysPRINTDATAHandler,W
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SysPRINTDATAHandler_H,0
	bsf	STATUS, IRP
	movf	INDF,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;Next
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop1
SysForLoopEnd1
	return

;********************************************************************************

SYSMULTSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
MUL8LOOP
;movf SysByteTempA, W
	movf	SYSBYTETEMPA, W
;btfsc SysByteTempB, 0
	btfsc	SYSBYTETEMPB, 0
;addwf SysByteTempX, F
	addwf	SYSBYTETEMPX, F
;bcf STATUS, C
	bcf	STATUS, C
;rrf SysByteTempB, F
	rrf	SYSBYTETEMPB, F
;bcf STATUS, C
	bcf	STATUS, C
;rlf SysByteTempA, F
	rlf	SYSBYTETEMPA, F
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F
;btfss STATUS, Z
	btfss	STATUS, Z
;goto MUL8LOOP
	goto	MUL8LOOP
	return

;********************************************************************************

SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Set pointer
;movf SysStringB, W
	movf	SYSSTRINGB, W
;movwf FSR
	movwf	FSR
;bcf STATUS, IRP
	bcf	STATUS, IRP
;btfsc SysStringB_H, 0
	btfsc	SYSSTRINGB_H, 0
;bsf STATUS, IRP
	bsf	STATUS, IRP
;Get length
;call SysStringTables
	call	SYSSTRINGTABLES
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;movwf INDF
	movwf	INDF
;addwf SysStringB, F
	addwf	SYSSTRINGB, F
;goto SysStringReadCheck
	goto	SYSSTRINGREADCHECK
SYSREADSTRINGPART
;Set pointer
;movf SysStringB, W
	movf	SYSSTRINGB, W
;movwf FSR
	movwf	FSR
;decf FSR,F
;bcf STATUS, IRP
	bcf	STATUS, IRP
;btfsc SysStringB_H, 0
	btfsc	SYSSTRINGB_H, 0
;bsf STATUS, IRP
	bsf	STATUS, IRP
;Get length
;call SysStringTables
	call	SYSSTRINGTABLES
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;addwf SysStringLength,F
	addwf	SYSSTRINGLENGTH,F
;addwf SysStringB,F
	addwf	SYSSTRINGB,F
;Check length
SYSSTRINGREADCHECK
;If length is 0, exit
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F
;btfsc STATUS,Z
	btfsc	STATUS,Z
;return
	return
;Copy
SYSSTRINGREAD
;Get char
;call SysStringTables
	call	SYSSTRINGTABLES
;Set char
;incf FSR, F
	incf	FSR, F
;movwf INDF
	movwf	INDF
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F
;goto SysStringRead
	goto	SYSSTRINGREAD
	return

;********************************************************************************

SysStringTables
	movf	SysStringA_H,W
	movwf	PCLATH
	movf	SysStringA,W
	incf	SysStringA,F
	btfsc	STATUS,Z
	incf	SysStringA_H,F
	movwf	PCL

StringTable1
	retlw	4
	retlw	116	;t
	retlw	101	;e
	retlw	115	;s
	retlw	116	;t


StringTable2
	retlw	5
	retlw	116	;t
	retlw	101	;e
	retlw	115	;s
	retlw	116	;t
	retlw	50	;2


;********************************************************************************


 END
