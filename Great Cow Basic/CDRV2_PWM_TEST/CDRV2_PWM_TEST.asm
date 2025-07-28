;Program compiled by Great Cow BASIC (0.98.06 2019-06-12 (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F1788, r=DEC
#include <P16F1788.inc>
 __CONFIG _CONFIG1, _CLKOUTEN_OFF & _CP_OFF & _MCLRE_OFF & _WDTE_OFF & _FOSC_INTOSC
 __CONFIG _CONFIG2, _LVP_OFF & _PLLEN_OFF & _VCAPEN_OFF

;********************************************************************************

;Set aside memory locations for variables
ADREADPORT	EQU	32
AN11_READ	EQU	33
AN11_READ_E	EQU	36
AN11_READ_H	EQU	34
AN11_READ_U	EQU	35
AN13_READ	EQU	37
AN13_READ_E	EQU	40
AN13_READ_H	EQU	38
AN13_READ_U	EQU	39
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
DUTY	EQU	41
DUTY_E	EQU	44
DUTY_H	EQU	42
DUTY_U	EQU	43
PRINTLEN	EQU	45
READAD12	EQU	46
READAD12_H	EQU	47
SERBIT	EQU	48
SERDELAYLOOP	EQU	49
SERPRINTVAL	EQU	50
SERPRINTVAL_E	EQU	53
SERPRINTVAL_H	EQU	51
SERPRINTVAL_U	EQU	52
SERTEMP	EQU	54
SER_BYTE	EQU	55
SER_DATA	EQU	56
SER_DATA_A	EQU	57
SER_INVERT	EQU	58
SER_INVERT_A	EQU	59
SER_PARITY	EQU	60
SER_PARITY_A	EQU	61
SER_RATE	EQU	62
SER_RATE_A	EQU	63
SER_SELECT	EQU	64
SER_SELECT_OLD	EQU	65
SER_START	EQU	66
SER_START_A	EQU	67
SER_STOP	EQU	68
SER_STOP_A	EQU	69
STRINGPOINTER	EQU	70
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSCALCTEMPA_E	EQU	120
SYSCALCTEMPA_H	EQU	118
SYSCALCTEMPA_U	EQU	119
SYSDIVLOOP	EQU	116
SYSLONGDIVMULTA	EQU	71
SYSLONGDIVMULTA_E	EQU	74
SYSLONGDIVMULTA_H	EQU	72
SYSLONGDIVMULTA_U	EQU	73
SYSLONGDIVMULTB	EQU	75
SYSLONGDIVMULTB_E	EQU	78
SYSLONGDIVMULTB_H	EQU	76
SYSLONGDIVMULTB_U	EQU	77
SYSLONGDIVMULTX	EQU	79
SYSLONGDIVMULTX_E	EQU	82
SYSLONGDIVMULTX_H	EQU	80
SYSLONGDIVMULTX_U	EQU	81
SYSLONGTEMPA	EQU	117
SYSLONGTEMPA_E	EQU	120
SYSLONGTEMPA_H	EQU	118
SYSLONGTEMPA_U	EQU	119
SYSLONGTEMPB	EQU	121
SYSLONGTEMPB_E	EQU	124
SYSLONGTEMPB_H	EQU	122
SYSLONGTEMPB_U	EQU	123
SYSLONGTEMPX	EQU	112
SYSLONGTEMPX_E	EQU	115
SYSLONGTEMPX_H	EQU	113
SYSLONGTEMPX_U	EQU	114
SYSPRINTBUFFER	EQU	10213
SYSPRINTBUFFLEN	EQU	83
SYSPRINTDATAHANDLER	EQU	84
SYSPRINTDATAHANDLER_H	EQU	85
SYSPRINTTEMP	EQU	86
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGLENGTH	EQU	118
SYSSTRINGPARAM1	EQU	10207
SYSTEMP1	EQU	87
SYSTEMP1_E	EQU	90
SYSTEMP1_H	EQU	88
SYSTEMP1_U	EQU	89
SYSWAITTEMP10US	EQU	117
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
SYSWAITTEMPUS	EQU	117
SYSWAITTEMPUS_H	EQU	118
TEMPPARITY	EQU	91
TIME	EQU	92
TIME_E	EQU	95
TIME_H	EQU	93
TIME_U	EQU	94
TOFF	EQU	96
TOFF_E	EQU	99
TOFF_H	EQU	97
TOFF_U	EQU	98
TON	EQU	100
TON_E	EQU	103
TON_H	EQU	101
TON_U	EQU	102

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5
SYSREADAD12WORD	EQU	46
SYSREADAD12WORD_H	EQU	47

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

;Start of the main program
;----- Config
;#define PWM_PIN  PORTA.1   'Pin3
;#define PWM_Delay 350 us
;#define J4 PORTC.6
;#define J3 PORTC.5
;#define SendAHigh Set PORTB.7 ON  'Pin28 (PGD)
;#define SendALow  Set PORTB.7 Off 'Pin28 (PGD)
;#define RecAHigh PORTB.6 ON       'Pin27 (PGC)
;#define RecALow PORTB.6 OFF       'Pin27 (PGC)
;InitSer  1, r9600, 1+WaitForStart, 8, 1, None, Normal
	movlw	1
	movwf	SER_SELECT
	movlw	2
	movwf	SER_RATE
	movlw	129
	movwf	SER_START
	movlw	8
	movwf	SER_DATA
	movlw	1
	movwf	SER_STOP
	clrf	SER_PARITY
	clrf	SER_INVERT
	call	INITSER
;Dir PORTB.7 Out   'Pin28 (PGD)
	banksel	TRISB
	bcf	TRISB,7
;Dir PORTB.6 In    'Pin27 (PGC)
	bsf	TRISB,6
;Dir PORTA.1 Out 'Gate PWM
	bcf	TRISA,1
;Dir PORTB.5 In  'Duty cycle pot
	bsf	TRISB,5
;Dir PORTB.4 In  'cycle pot
	bsf	TRISB,4
;Dir PORTC.6 In 'force on
	bsf	TRISC,6
;Dir PORTC.5 In 'button for serial send
	bsf	TRISC,5
;dim duty as long
;dim time as long
;dim AN13_read as long
;dim AN11_read as long
;dim ton as long
;dim toff as long
;Do Forever
SysDoLoop_S1
;duty = 0
;time = 0
;AN13_read = ReadAD12(AN13)
	movlw	13
	banksel	ADREADPORT
	movwf	ADREADPORT
	call	FN_READAD126
	movf	SYSREADAD12WORD,W
	movwf	AN13_READ
	movf	SYSREADAD12WORD_H,W
	movwf	AN13_READ_H
	clrf	AN13_READ_U
	clrf	AN13_READ_E
;AN11_read = ReadAD12(AN11)
	movlw	11
	movwf	ADREADPORT
	call	FN_READAD126
	movf	SYSREADAD12WORD,W
	movwf	AN11_READ
	movf	SYSREADAD12WORD_H,W
	movwf	AN11_READ_H
	clrf	AN11_READ_U
	clrf	AN11_READ_E
;duty  = (AN13_read * 24400) / 1000000
	movf	AN13_READ,W
	movwf	SysLONGTempA
	movf	AN13_READ_H,W
	movwf	SysLONGTempA_H
	movf	AN13_READ_U,W
	movwf	SysLONGTempA_U
	movf	AN13_READ_E,W
	movwf	SysLONGTempA_E
	movlw	80
	movwf	SysLONGTempB
	movlw	95
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SysMultSub32
	movf	SysLONGTempX,W
	movwf	SysTemp1
	movf	SysLONGTempX_H,W
	movwf	SysTemp1_H
	movf	SysLONGTempX_U,W
	movwf	SysTemp1_U
	movf	SysLONGTempX_E,W
	movwf	SysTemp1_E
	movf	SysTemp1,W
	movwf	SysLONGTempA
	movf	SysTemp1_H,W
	movwf	SysLONGTempA_H
	movf	SysTemp1_U,W
	movwf	SysLONGTempA_U
	movf	SysTemp1_E,W
	movwf	SysLONGTempA_E
	movlw	64
	movwf	SysLONGTempB
	movlw	66
	movwf	SysLONGTempB_H
	movlw	15
	movwf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SysDivSub32
	movf	SysLONGTempA,W
	movwf	DUTY
	movf	SysLONGTempA_H,W
	movwf	DUTY_H
	movf	SysLONGTempA_U,W
	movwf	DUTY_U
	movf	SysLONGTempA_E,W
	movwf	DUTY_E
;time  = (AN11_read * 24400) / 1000000
	movf	AN11_READ,W
	movwf	SysLONGTempA
	movf	AN11_READ_H,W
	movwf	SysLONGTempA_H
	movf	AN11_READ_U,W
	movwf	SysLONGTempA_U
	movf	AN11_READ_E,W
	movwf	SysLONGTempA_E
	movlw	80
	movwf	SysLONGTempB
	movlw	95
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SysMultSub32
	movf	SysLONGTempX,W
	movwf	SysTemp1
	movf	SysLONGTempX_H,W
	movwf	SysTemp1_H
	movf	SysLONGTempX_U,W
	movwf	SysTemp1_U
	movf	SysLONGTempX_E,W
	movwf	SysTemp1_E
	movf	SysTemp1,W
	movwf	SysLONGTempA
	movf	SysTemp1_H,W
	movwf	SysLONGTempA_H
	movf	SysTemp1_U,W
	movwf	SysLONGTempA_U
	movf	SysTemp1_E,W
	movwf	SysLONGTempA_E
	movlw	64
	movwf	SysLONGTempB
	movlw	66
	movwf	SysLONGTempB_H
	movlw	15
	movwf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SysDivSub32
	movf	SysLONGTempA,W
	movwf	TIME
	movf	SysLONGTempA_H,W
	movwf	TIME_H
	movf	SysLONGTempA_U,W
	movwf	TIME_U
	movf	SysLONGTempA_E,W
	movwf	TIME_E
;duty  = scale(ReadAD(AN13), 0, 255, 0, 100)
;time = scale(ReadAD(An11), 0, 255, 0, 100)
;ton = (duty * time) / 100
	movf	DUTY,W
	movwf	SysLONGTempA
	movf	DUTY_H,W
	movwf	SysLONGTempA_H
	movf	DUTY_U,W
	movwf	SysLONGTempA_U
	movf	DUTY_E,W
	movwf	SysLONGTempA_E
	movf	TIME,W
	movwf	SysLONGTempB
	movf	TIME_H,W
	movwf	SysLONGTempB_H
	movf	TIME_U,W
	movwf	SysLONGTempB_U
	movf	TIME_E,W
	movwf	SysLONGTempB_E
	call	SysMultSub32
	movf	SysLONGTempX,W
	movwf	SysTemp1
	movf	SysLONGTempX_H,W
	movwf	SysTemp1_H
	movf	SysLONGTempX_U,W
	movwf	SysTemp1_U
	movf	SysLONGTempX_E,W
	movwf	SysTemp1_E
	movf	SysTemp1,W
	movwf	SysLONGTempA
	movf	SysTemp1_H,W
	movwf	SysLONGTempA_H
	movf	SysTemp1_U,W
	movwf	SysLONGTempA_U
	movf	SysTemp1_E,W
	movwf	SysLONGTempA_E
	movlw	100
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SysDivSub32
	movf	SysLONGTempA,W
	movwf	TON
	movf	SysLONGTempA_H,W
	movwf	TON_H
	movf	SysLONGTempA_U,W
	movwf	TON_U
	movf	SysLONGTempA_E,W
	movwf	TON_E
;toff = time - ton
	movf	TON,W
	subwf	TIME,W
	movwf	TOFF
	movf	TON_H,W
	subwfb	TIME_H,W
	movwf	TOFF_H
	movf	TON_U,W
	subwfb	TIME_U,W
	movwf	TOFF_U
	movf	TON_E,W
	subwfb	TIME_E,W
	movwf	TOFF_E
;If J3 = OFF Then
	btfsc	PORTC,5
	goto	ENDIF1
;SerPrint 1, "AN13 "
	movlw	1
	movwf	SER_SELECT
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable1
	movwf	SysStringA
	movlw	(high StringTable1) & 127
	movwf	SysStringA_H
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	call	SERPRINT36
;SerPrint 1, AN13_read
	movlw	1
	movwf	SER_SELECT
	movf	AN13_READ,W
	movwf	SERPRINTVAL
	movf	AN13_READ_H,W
	movwf	SERPRINTVAL_H
	movf	AN13_READ_U,W
	movwf	SERPRINTVAL_U
	movf	AN13_READ_E,W
	movwf	SERPRINTVAL_E
	call	SERPRINT39
;SerSend 1, 13
	movlw	1
	movwf	SER_SELECT
	movlw	13
	movwf	SER_BYTE
	call	SERSEND
;SerSend 1, 10
	movlw	1
	movwf	SER_SELECT
	movlw	10
	movwf	SER_BYTE
	call	SERSEND
;SerPrint 1, "AN11 "
	movlw	1
	movwf	SER_SELECT
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable2
	movwf	SysStringA
	movlw	(high StringTable2) & 127
	movwf	SysStringA_H
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	call	SERPRINT36
;SerPrint 1, AN11_read
	movlw	1
	movwf	SER_SELECT
	movf	AN11_READ,W
	movwf	SERPRINTVAL
	movf	AN11_READ_H,W
	movwf	SERPRINTVAL_H
	movf	AN11_READ_U,W
	movwf	SERPRINTVAL_U
	movf	AN11_READ_E,W
	movwf	SERPRINTVAL_E
	call	SERPRINT39
;SerSend 1, 13
	movlw	1
	movwf	SER_SELECT
	movlw	13
	movwf	SER_BYTE
	call	SERSEND
;SerSend 1, 10
	movlw	1
	movwf	SER_SELECT
	movlw	10
	movwf	SER_BYTE
	call	SERSEND
;SerPrint 1, "Ton "
	movlw	1
	movwf	SER_SELECT
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable3
	movwf	SysStringA
	movlw	(high StringTable3) & 127
	movwf	SysStringA_H
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	call	SERPRINT36
;SerPrint 1, ton
	movlw	1
	movwf	SER_SELECT
	movf	TON,W
	movwf	SERPRINTVAL
	movf	TON_H,W
	movwf	SERPRINTVAL_H
	movf	TON_U,W
	movwf	SERPRINTVAL_U
	movf	TON_E,W
	movwf	SERPRINTVAL_E
	call	SERPRINT39
;SerSend 1, 13
	movlw	1
	movwf	SER_SELECT
	movlw	13
	movwf	SER_BYTE
	call	SERSEND
;SerSend 1, 10
	movlw	1
	movwf	SER_SELECT
	movlw	10
	movwf	SER_BYTE
	call	SERSEND
;SerPrint 1, "Toff "
	movlw	1
	movwf	SER_SELECT
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable4
	movwf	SysStringA
	movlw	(high StringTable4) & 127
	movwf	SysStringA_H
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	call	SERPRINT36
;SerPrint 1, toff
	movlw	1
	movwf	SER_SELECT
	movf	TOFF,W
	movwf	SERPRINTVAL
	movf	TOFF_H,W
	movwf	SERPRINTVAL_H
	movf	TOFF_U,W
	movwf	SERPRINTVAL_U
	movf	TOFF_E,W
	movwf	SERPRINTVAL_E
	call	SERPRINT39
;SerSend 1, 13
	movlw	1
	movwf	SER_SELECT
	movlw	13
	movwf	SER_BYTE
	call	SERSEND
;SerSend 1, 10
	movlw	1
	movwf	SER_SELECT
	movlw	10
	movwf	SER_BYTE
	call	SERSEND
;SerPrint 1, "Duty "
	movlw	1
	movwf	SER_SELECT
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable5
	movwf	SysStringA
	movlw	(high StringTable5) & 127
	movwf	SysStringA_H
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	call	SERPRINT36
;SerPrint 1, duty
	movlw	1
	movwf	SER_SELECT
	movf	DUTY,W
	movwf	SERPRINTVAL
	movf	DUTY_H,W
	movwf	SERPRINTVAL_H
	movf	DUTY_U,W
	movwf	SERPRINTVAL_U
	movf	DUTY_E,W
	movwf	SERPRINTVAL_E
	call	SERPRINT39
;SerSend 1, 13
	movlw	1
	movwf	SER_SELECT
	movlw	13
	movwf	SER_BYTE
	call	SERSEND
;SerSend 1, 10
	movlw	1
	movwf	SER_SELECT
	movlw	10
	movwf	SER_BYTE
	call	SERSEND
;SerPrint 1, "Time "
	movlw	1
	movwf	SER_SELECT
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable6
	movwf	SysStringA
	movlw	(high StringTable6) & 127
	movwf	SysStringA_H
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	call	SERPRINT36
;SerPrint 1, time
	movlw	1
	movwf	SER_SELECT
	movf	TIME,W
	movwf	SERPRINTVAL
	movf	TIME_H,W
	movwf	SERPRINTVAL_H
	movf	TIME_U,W
	movwf	SERPRINTVAL_U
	movf	TIME_E,W
	movwf	SERPRINTVAL_E
	call	SERPRINT39
;SerSend 1, 13
	movlw	1
	movwf	SER_SELECT
	movlw	13
	movwf	SER_BYTE
	call	SERSEND
;SerSend 1, 10
	movlw	1
	movwf	SER_SELECT
	movlw	10
	movwf	SER_BYTE
	call	SERSEND
;End If
ENDIF1
;If J4 = OFF Then
	btfsc	PORTC,6
	goto	ELSE2_1
;PWM_PIN = on
	banksel	LATA
	bsf	LATA,1
;Else
	goto	ENDIF2
ELSE2_1
;PWM_PIN = on
	banksel	LATA
	bsf	LATA,1
;wait ton ms
	banksel	TON
	movf	TON,W
	movwf	SysWaitTempMS
	movf	TON_H,W
	movwf	SysWaitTempMS_H
	call	Delay_MS
;PWM_PIN = off
	banksel	LATA
	bcf	LATA,1
;wait toff ms
	banksel	TOFF
	movf	TOFF,W
	movwf	SysWaitTempMS
	movf	TOFF_H,W
	movwf	SysWaitTempMS_H
	call	Delay_MS
;End if
ENDIF2
;If J4 = OFF Then
;PWM_PIN = ON
;Else
;duty = ReadAD(AN13)
;cycle = 1
;PWMOut(1, duty, cycle)
;wait 1 ms
;Serprint 1, "D:" duty
;Serprint 1, " C:" cycle
;End If
;Loop
	goto	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

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

INITSER
;This sub sets configuration of the serial routines
;Sample usage for communication with Lego RCX:
;InitSer(1,r2400,1,8,1,odd,invert)
;Ser_Select_Old = Ser_Select
	movf	SER_SELECT,W
	movwf	SER_SELECT_OLD
;if Ser_Select = 1 THEN
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF8
;Ser_Rate_A = Ser_Rate
	movf	SER_RATE,W
	movwf	SER_RATE_A
;ser_Start_A = Ser_Start
	movf	SER_START,W
	movwf	SER_START_A
;Ser_Data_A = Ser_Data
	movf	SER_DATA,W
	movwf	SER_DATA_A
;Ser_Stop_A = Ser_Stop
	movf	SER_STOP,W
	movwf	SER_STOP_A
;Ser_Parity_A = Ser_Parity
	movf	SER_PARITY,W
	movwf	SER_PARITY_A
;Ser_Invert_A = Ser_Invert
	movf	SER_INVERT,W
	movwf	SER_INVERT_A
;END IF
ENDIF8
;ensure lines are settled
;wait SerialInitDelay ms
	movlw	5
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	goto	Delay_MS

;********************************************************************************

INITSYS
;asm showdebug OSCCON type is 105 'Bit(SPLLEN) Or Bit(IRCF3) And NoBit(INTSRC) and ifdef Bit(IRCF3)
;osccon type is 105
;OSCCON = OSCCON AND b'10000111'
;OSCCON = OSCCON OR b'01110000'
;Set IRCF3 On
	banksel	OSCCON
	bsf	OSCCON,IRCF3
;Set IRCF2 On
	bsf	OSCCON,IRCF2
;Set IRCF1 On
	bsf	OSCCON,IRCF1
;Set IRCF0 Off
	bcf	OSCCON,IRCF0
;Set SPLLEN Off
	bcf	OSCCON,SPLLEN
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	bcf	ADCON1,ADFM
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;Commence clearing any ANSEL variants in the part
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELB = 0
	clrf	ANSELB
;ANSELC = 0
	clrf	ANSELC
;End clearing any ANSEL variants in the part
;Set comparator register bits for many MCUs with register CM2CON0
;C2ON = 0
	banksel	CM2CON0
	bcf	CM2CON0,C2ON
;C1ON = 0
	bcf	CM1CON0,C1ON
;Turn off all ports
;PORTA = 0
	banksel	PORTA
	clrf	PORTA
;PORTB = 0
	clrf	PORTB
;PORTC = 0
	clrf	PORTC
;PORTE = 0
	clrf	PORTE
	return

;********************************************************************************

;Overloaded signature: BYTE:
FN_READAD126
;Always RIGHT justified
;Set up A/D format
;SET ADFM ON
	banksel	ADCON1
	bsf	ADCON1,ADFM
;Set A/D Result Mode to 12-Bit
;SET ADRMD OFF
	bcf	ADCON0,ADRMD
;Required by some chips
;A differential ADC
;SetNegativeChannelSelectbits
;CHSN0 = 1
	bsf	ADCON2,CHSN0
;CHSN1 = 1
	bsf	ADCON2,CHSN1
;CHSN2 = 1
	bsf	ADCON2,CHSN2
;CHSN3 = 1
	bsf	ADCON2,CHSN3
;Do conversion
;LLReadAD 0
;ANSEL0/ANSEL
;Code for devcies with ANSELA/ANSELB/ANSELE registers
;Select Case ADReadPort ' #IFDEF Var(ANSELA). ANSELA exists @DebugADC_H
;#ifNdef Bit(CHS5) ChipPins = 28  Or ChipPins = 40 @DebugADC_H
;Case 0: Set ANSELA.0 On
SysSelect1Case1
	banksel	ADREADPORT
	movf	ADREADPORT,F
	btfss	STATUS, Z
	goto	SysSelect1Case2
	banksel	ANSELA
	bsf	ANSELA,0
;Case 1: Set ANSELA.1 On
	goto	SysSelectEnd1
SysSelect1Case2
	decf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
	banksel	ANSELA
	bsf	ANSELA,1
;Case 2: Set ANSELA.2 On
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	2
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
	banksel	ANSELA
	bsf	ANSELA,2
;Case 3: Set ANSELA.3 On
	goto	SysSelectEnd1
SysSelect1Case4
	movlw	3
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case5
	banksel	ANSELA
	bsf	ANSELA,3
;Case 4: Set ANSELA.5 On
	goto	SysSelectEnd1
SysSelect1Case5
	movlw	4
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case6
	banksel	ANSELA
	bsf	ANSELA,5
;Case 12: Set ANSELB.0 On
	goto	SysSelectEnd1
SysSelect1Case6
	movlw	12
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case7
	banksel	ANSELB
	bsf	ANSELB,0
;Case 10: Set ANSELB.1 On
	goto	SysSelectEnd1
SysSelect1Case7
	movlw	10
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case8
	banksel	ANSELB
	bsf	ANSELB,1
;Case 8: Set ANSELB.2 On
	goto	SysSelectEnd1
SysSelect1Case8
	movlw	8
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case9
	banksel	ANSELB
	bsf	ANSELB,2
;Case 9: Set ANSELB.3 On
	goto	SysSelectEnd1
SysSelect1Case9
	movlw	9
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case10
	banksel	ANSELB
	bsf	ANSELB,3
;Case 11: Set ANSELB.4 On
	goto	SysSelectEnd1
SysSelect1Case10
	movlw	11
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case11
	banksel	ANSELB
	bsf	ANSELB,4
;Case 13: Set ANSELB.5 On
	goto	SysSelectEnd1
SysSelect1Case11
	movlw	13
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case12
	banksel	ANSELB
	bsf	ANSELB,5
;Case 14: Set ANSELC.2 On
	goto	SysSelectEnd1
SysSelect1Case12
	movlw	14
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case13
	banksel	ANSELC
	bsf	ANSELC,2
;Case 15: Set ANSELC.3 On
	goto	SysSelectEnd1
SysSelect1Case13
	movlw	15
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case14
	banksel	ANSELC
	bsf	ANSELC,3
;Case 16: Set ANSELC.4 On
	goto	SysSelectEnd1
SysSelect1Case14
	movlw	16
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case15
	banksel	ANSELC
	bsf	ANSELC,4
;Case 17: Set ANSELC.5 On
	goto	SysSelectEnd1
SysSelect1Case15
	movlw	17
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case16
	banksel	ANSELC
	bsf	ANSELC,5
;Case 18: Set ANSELC.6 On
	goto	SysSelectEnd1
SysSelect1Case16
	movlw	18
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case17
	banksel	ANSELC
	bsf	ANSELC,6
;Case 19: Set ANSELC.7 On
	goto	SysSelectEnd1
SysSelect1Case17
	movlw	19
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelectEnd1
	banksel	ANSELC
	bsf	ANSELC,7
;End Select  'End Select #1
SysSelectEnd1
;Set conversion clock - improved to handle ADCS2
;SET ADCS2 OFF
	banksel	ADCON1
	bcf	ADCON1,ADCS2
;SET ADCS1 OFF
	bcf	ADCON1,ADCS1
;SET ADCS0 ON
	bsf	ADCON1,ADCS0
;Choose port
;SET CHS0 OFF
	bcf	ADCON0,CHS0
;SET CHS1 OFF
	bcf	ADCON0,CHS1
;SET CHS2 OFF
	bcf	ADCON0,CHS2
;SET CHS3 OFF
	bcf	ADCON0,CHS3
;SET CHS4 OFF
	bcf	ADCON0,CHS4
;IF ADReadPort.0 On Then Set CHS0 On
	banksel	ADREADPORT
	btfss	ADREADPORT,0
	goto	ENDIF3
	banksel	ADCON0
	bsf	ADCON0,CHS0
ENDIF3
;IF ADReadPort.1 On Then Set CHS1 On
	banksel	ADREADPORT
	btfss	ADREADPORT,1
	goto	ENDIF4
	banksel	ADCON0
	bsf	ADCON0,CHS1
ENDIF4
;IF ADReadPort.2 On Then Set CHS2 On
	banksel	ADREADPORT
	btfss	ADREADPORT,2
	goto	ENDIF5
	banksel	ADCON0
	bsf	ADCON0,CHS2
ENDIF5
;If ADReadPort.3 On Then Set CHS3 On
	banksel	ADREADPORT
	btfss	ADREADPORT,3
	goto	ENDIF6
	banksel	ADCON0
	bsf	ADCON0,CHS3
ENDIF6
;If ADReadPort.4 On Then Set CHS4 On
	banksel	ADREADPORT
	btfss	ADREADPORT,4
	goto	ENDIF7
	banksel	ADCON0
	bsf	ADCON0,CHS4
ENDIF7
;Enable A/D
;SET ADON ON
	banksel	ADCON0
	bsf	ADCON0,ADON
;Acquisition Delay
;Wait AD_Delay
	movlw	2
	movwf	SysWaitTemp10US
	banksel	STATUS
	call	Delay_10US
;Read A/D
;SET GO_NOT_DONE ON
	banksel	ADCON0
	bsf	ADCON0,GO_NOT_DONE
;nop
	nop
;Wait While GO_NOT_DONE ON
SysWaitLoop1
	btfsc	ADCON0,GO_NOT_DONE
	goto	SysWaitLoop1
;Switch off A/D
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;Clear whatever ANSEL variants the chip has
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELB = 0
	clrf	ANSELB
;ANSELC = 0
	clrf	ANSELC
;Write output
;ReadAD12 = ADRESL
	banksel	ADRESL
	movf	ADRESL,W
	banksel	READAD12
	movwf	READAD12
	clrf	READAD12_H
;ReadAD12_H = ADRESH
	banksel	ADRESH
	movf	ADRESH,W
	banksel	READAD12_H
	movwf	READAD12_H
;Put A/D format back to normal
;SET ADFM OFF
	banksel	ADCON1
	bcf	ADCON1,ADFM
	banksel	STATUS
	return

;********************************************************************************

SERBITDELAY
;Predefined rates (more accurate)
;All delays have 10 us taken off to allow processing time
;if Ser_Rate = 1 then Wait SerFullDelay19200 us: exit sub  '19200 (52 us)
	decf	SER_RATE,W
	btfss	STATUS, Z
	goto	ENDIF47
	movlw	22
	movwf	DELAYTEMP
DelayUS1
	decfsz	DELAYTEMP,F
	goto	DelayUS1
	nop
	return
ENDIF47
;if Ser_Rate = 2 then Wait SerFullDelay9600 us: exit sub   '9600 (104 us)
	movlw	2
	subwf	SER_RATE,W
	btfss	STATUS, Z
	goto	ENDIF48
	movlw	55
	movwf	DELAYTEMP
DelayUS2
	decfsz	DELAYTEMP,F
	goto	DelayUS2
	return
ENDIF48
;if Ser_Rate = 4 then Wait SerFullDelay4800 us: exit sub   '4800 (208 us)
	movlw	4
	subwf	SER_RATE,W
	btfss	STATUS, Z
	goto	ENDIF49
	movlw	122
	movwf	DELAYTEMP
DelayUS3
	decfsz	DELAYTEMP,F
	goto	DelayUS3
	nop
	return
ENDIF49
;if Ser_Rate = 8 then Wait SerFullDelay2400 us: exit sub   '2400 (417 us)
	movlw	8
	subwf	SER_RATE,W
	btfss	STATUS, Z
	goto	ENDIF50
	movlw	1
	movwf	DELAYTEMP2
DelayUSO4
	clrf	DELAYTEMP
DelayUS4
	decfsz	DELAYTEMP,F
	goto	DelayUS4
	decfsz	DELAYTEMP2,F
	goto	DelayUSO4
	movlw	2
	movwf	DELAYTEMP
DelayUS5
	decfsz	DELAYTEMP,F
	goto	DelayUS5
	nop
	return
ENDIF50
;if Ser_Rate = 16 then Wait SerFullDelay1200 us: exit sub  '1200 (833 us)
	movlw	16
	subwf	SER_RATE,W
	btfss	STATUS, Z
	goto	ENDIF51
	movlw	2
	movwf	DELAYTEMP2
DelayUSO6
	clrf	DELAYTEMP
DelayUS6
	decfsz	DELAYTEMP,F
	goto	DelayUS6
	decfsz	DELAYTEMP2,F
	goto	DelayUSO6
	movlw	21
	movwf	DELAYTEMP
DelayUS7
	decfsz	DELAYTEMP,F
	goto	DelayUS7
	nop
	return
ENDIF51
;if Ser_Rate = 32 then Wait SerFullDelay600 us: exit sub   '600 (1666 us)
	movlw	32
	subwf	SER_RATE,W
	btfss	STATUS, Z
	goto	ENDIF52
	movlw	4
	movwf	DELAYTEMP2
DelayUSO8
	clrf	DELAYTEMP
DelayUS8
	decfsz	DELAYTEMP,F
	goto	DelayUS8
	decfsz	DELAYTEMP2,F
	goto	DelayUSO8
	movlw	61
	movwf	DELAYTEMP
DelayUS9
	decfsz	DELAYTEMP,F
	goto	DelayUS9
	nop
	return
ENDIF52
;if Ser_Rate = 64 then Wait SerFullDelay300 us: exit sub '300 (3333 us)
	movlw	64
	subwf	SER_RATE,W
	btfss	STATUS, Z
	goto	ENDIF53
	movlw	8
	movwf	DELAYTEMP2
DelayUSO10
	clrf	DELAYTEMP
DelayUS10
	decfsz	DELAYTEMP,F
	goto	DelayUS10
	decfsz	DELAYTEMP2,F
	goto	DelayUSO10
	movlw	145
	movwf	DELAYTEMP
DelayUS11
	decfsz	DELAYTEMP,F
	goto	DelayUS11
	return
ENDIF53
;Other rates
;for SerDelayLoop = 1 to Ser_Rate
	clrf	SERDELAYLOOP
	movlw	1
	subwf	SER_RATE,W
	btfss	STATUS, C
	goto	SysForLoopEnd6
SysForLoop6
	incf	SERDELAYLOOP,F
;Wait 42 us
	movlw	28
	movwf	DELAYTEMP
DelayUS12
	decfsz	DELAYTEMP,F
	goto	DelayUS12
;next
	movf	SER_RATE,W
	subwf	SERDELAYLOOP,W
	btfss	STATUS, C
	goto	SysForLoop6
SysForLoopEnd6
	return

;********************************************************************************

SERCFGLOAD
;Ser_Select_Old = Ser_Select
	movf	SER_SELECT,W
	movwf	SER_SELECT_OLD
;if Ser_Select = 1 THEN
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF46
;Ser_Rate = Ser_Rate_A
	movf	SER_RATE_A,W
	movwf	SER_RATE
;Ser_Start = Ser_Start_A
	movf	SER_START_A,W
	movwf	SER_START
;Ser_Data = Ser_Data_A
	movf	SER_DATA_A,W
	movwf	SER_DATA
;Ser_Stop = Ser_Stop_A
	movf	SER_STOP_A,W
	movwf	SER_STOP
;Ser_Parity = Ser_Parity_A
	movf	SER_PARITY_A,W
	movwf	SER_PARITY
;Ser_Invert = Ser_Invert_A
	movf	SER_INVERT_A,W
	movwf	SER_INVERT
;end if
ENDIF46
	return

;********************************************************************************

;Overloaded signature: BYTE:STRING:
SERPRINT36
;PrintLen = LEN(PrintData$)
;PrintLen = PrintData(0)
	movf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	PRINTLEN
;if PrintLen = 0 then Goto SerPrintStrEnd
	movf	PRINTLEN,F
	btfsc	STATUS, Z
	goto	SERPRINTSTREND
;Write Data
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd4
SysForLoop4
	incf	SYSPRINTTEMP,F
;SerSend(Ser_Select, PrintData(SysPrintTemp))
	movf	SYSPRINTTEMP,W
	addwf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SER_BYTE
	call	SERSEND
;next
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop4
SysForLoopEnd4
;CR
SERPRINTSTREND
	return

;********************************************************************************

;Overloaded signature: BYTE:LONG:
SERPRINT39
;Dim SysCalcTempA As Long
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	clrf	SYSPRINTBUFFLEN
;Do
SysDoLoop_S2
;Divide number by 10, remainder into buffer
;SysPrintBuffLen += 1
	incf	SYSPRINTBUFFLEN,F
;SysPrintBuffer(SysPrintBuffLen) = SerPrintVal % 10
	movlw	low(SYSPRINTBUFFER)
	addwf	SYSPRINTBUFFLEN,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(SYSPRINTBUFFER)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movf	SERPRINTVAL,W
	movwf	SysLONGTempA
	movf	SERPRINTVAL_H,W
	movwf	SysLONGTempA_H
	movf	SERPRINTVAL_U,W
	movwf	SysLONGTempA_U
	movf	SERPRINTVAL_E,W
	movwf	SysLONGTempA_E
	movlw	10
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SysDivSub32
	movf	SysLONGTempX,W
	movwf	INDF0
;SerPrintVal = SysCalcTempA
	movf	SYSCALCTEMPA,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPA_H,W
	movwf	SERPRINTVAL_H
	movf	SYSCALCTEMPA_U,W
	movwf	SERPRINTVAL_U
	movf	SYSCALCTEMPA_E,W
	movwf	SERPRINTVAL_E
;Loop While SerPrintVal <> 0
	movf	serprintval,W
	movwf	SysLONGTempA
	movf	serprintval_H,W
	movwf	SysLONGTempA_H
	movf	serprintval_U,W
	movwf	SysLONGTempA_U
	movf	serprintval_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SysCompEqual32
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
	goto	SysDoLoop_S2
SysDoLoop_E2
;Display
;For SysPrintTemp = SysPrintBuffLen To 1 Step -1
	incf	SYSPRINTBUFFLEN,W
	movwf	SYSPRINTTEMP
	movlw	1
	subwf	SYSPRINTBUFFLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd5
SysForLoop5
	decf	SYSPRINTTEMP,F
;SerSend (Ser_Select,SysPrintBuffer(SysPrintTemp) + 48)
	movlw	low(SYSPRINTBUFFER)
	addwf	SYSPRINTTEMP,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(SYSPRINTBUFFER)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	48
	addwf	INDF0,W
	movwf	SER_BYTE
	call	SERSEND
;Next
	movf	SYSPRINTTEMP,W
	sublw	1
	btfss	STATUS, C
	goto	SysForLoop5
SysForLoopEnd5
;CR
	return

;********************************************************************************

SERSEND
;Load configuration data
;if Ser_Select <> Ser_Select_Old then SerCfgLoad(Ser_Select)
	movf	SER_SELECT_OLD,W
	subwf	SER_SELECT,W
	btfss	STATUS, Z
	call	SERCFGLOAD
;Start bit
;SerTemp = Ser_Start and (not WaitForStart)
	movlw	127
	andwf	SER_START,W
	movwf	SERTEMP
;for SerBit = 1 to SerTemp
	clrf	SERBIT
	movlw	1
	subwf	SERTEMP,W
	btfss	STATUS, C
	goto	SysForLoopEnd1
SysForLoop1
	incf	SERBIT,F
;if Ser_Invert = normal then SerTxLow: NOP: NOP: NOP  'fst
	movf	SER_INVERT,F
	btfss	STATUS, Z
	goto	ENDIF11
;if Ser_Select = 1 THEN SendALow
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF23
	banksel	LATB
	bcf	LATB,7
ENDIF23
;SerBitDelay
	banksel	STATUS
	call	SERBITDELAY
	nop
	nop
	nop
ENDIF11
;if Ser_Invert = invert then SerTxHigh: NOP: NOP  'fst
	decf	SER_INVERT,W
	btfss	STATUS, Z
	goto	ENDIF12
;if Ser_Select = 1 THEN SendAHigh
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF24
	banksel	LATB
	bsf	LATB,7
ENDIF24
;SerBitDelay
	banksel	STATUS
	call	SERBITDELAY
	nop
	nop
ENDIF12
;next
	movf	SERTEMP,W
	subwf	SERBIT,W
	btfss	STATUS, C
	goto	SysForLoop1
SysForLoopEnd1
;Data bits
;TempParity = SerTemp
	movf	SERTEMP,W
	movwf	TEMPPARITY
;for SerBit = 1 to Ser_Data
	clrf	SERBIT
	movlw	1
	subwf	SER_DATA,W
	btfss	STATUS, C
	goto	SysForLoopEnd2
SysForLoop2
	incf	SERBIT,F
;if Ser_Invert = normal then
	movf	SER_INVERT,F
	btfss	STATUS, Z
	goto	ENDIF15
;if Ser_Byte.0 ON then SerTxHigh: TempParity = TempParity + 1
	btfss	SER_BYTE,0
	goto	ENDIF25
;if Ser_Select = 1 THEN SendAHigh
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF35
	banksel	LATB
	bsf	LATB,7
ENDIF35
;SerBitDelay
	banksel	STATUS
	call	SERBITDELAY
	incf	TEMPPARITY,F
ENDIF25
;if Ser_Byte.0 OFF then SerTxLow: nop: nop: nop: nop: nop: nop: nop
	btfsc	SER_BYTE,0
	goto	ENDIF26
;if Ser_Select = 1 THEN SendALow
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF36
	banksel	LATB
	bcf	LATB,7
ENDIF36
;SerBitDelay
	banksel	STATUS
	call	SERBITDELAY
	nop
	nop
	nop
	nop
	nop
	nop
	nop
ENDIF26
;end if
ENDIF15
;if Ser_Invert = invert then
	decf	SER_INVERT,W
	btfss	STATUS, Z
	goto	ENDIF16
;if Ser_Byte.0 ON then SerTxLow: TempParity = TempParity + 1
	btfss	SER_BYTE,0
	goto	ENDIF27
;if Ser_Select = 1 THEN SendALow
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF37
	banksel	LATB
	bcf	LATB,7
ENDIF37
;SerBitDelay
	banksel	STATUS
	call	SERBITDELAY
	incf	TEMPPARITY,F
ENDIF27
;if Ser_Byte.0 OFF then SerTxHigh: nop: nop: nop: nop: nop: nop: nop
	btfsc	SER_BYTE,0
	goto	ENDIF28
;if Ser_Select = 1 THEN SendAHigh
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF38
	banksel	LATB
	bsf	LATB,7
ENDIF38
;SerBitDelay
	banksel	STATUS
	call	SERBITDELAY
	nop
	nop
	nop
	nop
	nop
	nop
	nop
ENDIF28
;end if
ENDIF16
;rotate Ser_Byte right
	rrf	SER_BYTE,F
;next
	movf	SER_DATA,W
	subwf	SERBIT,W
	btfss	STATUS, C
	goto	SysForLoop2
SysForLoopEnd2
;Parity Bit
;if Ser_Parity <> 0 THEN
	movf	SER_PARITY,F
	btfsc	STATUS, Z
	goto	ENDIF18
;if Ser_Parity = odd then TempParity = TempParity + 1
	decf	SER_PARITY,W
	btfsc	STATUS, Z
	incf	TEMPPARITY,F
;if Ser_Invert = invert then TempParity = TempParity + 1
	decf	SER_INVERT,W
	btfsc	STATUS, Z
	incf	TEMPPARITY,F
;if TempParity.0 = ON then SerTxLow
	btfss	TEMPPARITY,0
	goto	ENDIF31
;if Ser_Select = 1 THEN SendALow
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF39
	banksel	LATB
	bcf	LATB,7
ENDIF39
;SerBitDelay
	banksel	STATUS
	call	SERBITDELAY
ENDIF31
;if TempParity.0 = OFF then SerTxHigh
	btfsc	TEMPPARITY,0
	goto	ENDIF32
;if Ser_Select = 1 THEN SendAHigh
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF40
	banksel	LATB
	bsf	LATB,7
ENDIF40
;SerBitDelay
	banksel	STATUS
	call	SERBITDELAY
ENDIF32
;end if
ENDIF18
;Stop Bit(s)
;for SerBit = 1 to Ser_Stop
	clrf	SERBIT
	movlw	1
	subwf	SER_STOP,W
	btfss	STATUS, C
	goto	SysForLoopEnd3
SysForLoop3
	incf	SERBIT,F
;if Ser_Invert = normal then SerTxHigh   'fst
	movf	SER_INVERT,F
	btfss	STATUS, Z
	goto	ENDIF20
;if Ser_Select = 1 THEN SendAHigh
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF33
	banksel	LATB
	bsf	LATB,7
ENDIF33
;SerBitDelay
	banksel	STATUS
	call	SERBITDELAY
ENDIF20
;if Ser_Invert = invert then SerTxLow    'fst
	decf	SER_INVERT,W
	btfss	STATUS, Z
	goto	ENDIF21
;if Ser_Select = 1 THEN SendALow
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF34
	banksel	LATB
	bcf	LATB,7
ENDIF34
;SerBitDelay
	banksel	STATUS
	call	SERBITDELAY
ENDIF21
;next
	movf	SER_STOP,W
	subwf	SERBIT,W
	btfss	STATUS, C
	goto	SysForLoop3
SysForLoopEnd3
;Extra delay at end (adds extra stop bit)
;SerBitDelay
	goto	SERBITDELAY

;********************************************************************************

SYSCOMPEQUAL32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test low, exit if false
;movf SysLongTempA, W
	movf	SYSLONGTEMPA, W
;subwf SysLongTempB, W
	subwf	SYSLONGTEMPB, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test high, exit if false
;movf SysLongTempA_H, W
	movf	SYSLONGTEMPA_H, W
;subwf SysLongTempB_H, W
	subwf	SYSLONGTEMPB_H, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test upper, exit if false
;movf SysLongTempA_U, W
	movf	SYSLONGTEMPA_U, W
;subwf SysLongTempB_U, W
	subwf	SYSLONGTEMPB_U, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test exp, exit if false
;movf SysLongTempA_E, W
	movf	SYSLONGTEMPA_E, W
;subwf SysLongTempB_E, W
	subwf	SYSLONGTEMPB_E, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

SYSCOMPLESSTHAN32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test Exp, exit if more
;movf SysLongTempA_E,W
	movf	SYSLONGTEMPA_E,W
;subwf SysLongTempB_E,W
	subwf	SYSLONGTEMPB_E,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test Upper, exit if more
;movf SysLongTempA_U,W
	movf	SYSLONGTEMPA_U,W
;subwf SysLongTempB_U,W
	subwf	SYSLONGTEMPB_U,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test High, exit if more
;movf SysLongTempA_H,W
	movf	SYSLONGTEMPA_H,W
;subwf SysLongTempB_H,W
	subwf	SYSLONGTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test Low, exit if more or equal
;movf SysLongTempB,W
	movf	SYSLONGTEMPB,W
;subwf SysLongTempA,W
	subwf	SYSLONGTEMPA,W
;btfsc STATUS,C
	btfsc	STATUS,C
;return
	return
SCLT32TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

SYSDIVSUB32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;#ifdef PIC
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;#endif
;SysLongDivMultA = SysLongTempA
	movf	SYSLONGTEMPA,W
	movwf	SYSLONGDIVMULTA
	movf	SYSLONGTEMPA_H,W
	movwf	SYSLONGDIVMULTA_H
	movf	SYSLONGTEMPA_U,W
	movwf	SYSLONGDIVMULTA_U
	movf	SYSLONGTEMPA_E,W
	movwf	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movf	SYSLONGTEMPB,W
	movwf	SYSLONGDIVMULTB
	movf	SYSLONGTEMPB_H,W
	movwf	SYSLONGDIVMULTB_H
	movf	SYSLONGTEMPB_U,W
	movwf	SYSLONGDIVMULTB_U
	movf	SYSLONGTEMPB_E,W
	movwf	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX
	clrf	SYSLONGDIVMULTX_H
	clrf	SYSLONGDIVMULTX_U
	clrf	SYSLONGDIVMULTX_E
;Avoid division by zero
;if SysLongDivMultB = 0 then
	movf	SYSLONGDIVMULTB,W
	movwf	SysLONGTempA
	movf	SYSLONGDIVMULTB_H,W
	movwf	SysLONGTempA_H
	movf	SYSLONGDIVMULTB_U,W
	movwf	SysLONGTempA_U
	movf	SYSLONGDIVMULTB_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SysCompEqual32
	btfss	SysByteTempX,0
	goto	ENDIF58
;SysLongTempA = 0
	clrf	SYSLONGTEMPA
	clrf	SYSLONGTEMPA_H
	clrf	SYSLONGTEMPA_U
	clrf	SYSLONGTEMPA_E
;exit sub
	return
;end if
ENDIF58
;Main calc routine
;SysDivLoop = 32
	movlw	32
	movwf	SYSDIVLOOP
SYSDIV32START
;set C off
	bcf	STATUS,C
;Rotate SysLongDivMultA Left
	rlf	SYSLONGDIVMULTA,F
	rlf	SYSLONGDIVMULTA_H,F
	rlf	SYSLONGDIVMULTA_U,F
	rlf	SYSLONGDIVMULTA_E,F
;Rotate SysLongDivMultX Left
	rlf	SYSLONGDIVMULTX,F
	rlf	SYSLONGDIVMULTX_H,F
	rlf	SYSLONGDIVMULTX_U,F
	rlf	SYSLONGDIVMULTX_E,F
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	movf	SYSLONGDIVMULTB,W
	subwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTB_H,W
	subwfb	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTB_U,W
	subwfb	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTB_E,W
	subwfb	SYSLONGDIVMULTX_E,F
;Set SysLongDivMultA.0 On
	bsf	SYSLONGDIVMULTA,0
;If C Off Then
	btfsc	STATUS,C
	goto	ENDIF59
;Set SysLongDivMultA.0 Off
	bcf	SYSLONGDIVMULTA,0
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	movf	SYSLONGDIVMULTB,W
	addwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTB_H,W
	addwfc	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTB_U,W
	addwfc	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTB_E,W
	addwfc	SYSLONGDIVMULTX_E,F
;End If
ENDIF59
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv32Start
	goto	SYSDIV32START
;SysLongTempA = SysLongDivMultA
	movf	SYSLONGDIVMULTA,W
	movwf	SYSLONGTEMPA
	movf	SYSLONGDIVMULTA_H,W
	movwf	SYSLONGTEMPA_H
	movf	SYSLONGDIVMULTA_U,W
	movwf	SYSLONGTEMPA_U
	movf	SYSLONGDIVMULTA_E,W
	movwf	SYSLONGTEMPA_E
;SysLongTempX = SysLongDivMultX
	movf	SYSLONGDIVMULTX,W
	movwf	SYSLONGTEMPX
	movf	SYSLONGDIVMULTX_H,W
	movwf	SYSLONGTEMPX_H
	movf	SYSLONGDIVMULTX_U,W
	movwf	SYSLONGTEMPX_U
	movf	SYSLONGDIVMULTX_E,W
	movwf	SYSLONGTEMPX_E
	return

;********************************************************************************

SYSMULTSUB32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;Can't use normal SysDivMult variables for 32 bit, they overlap with
;SysLongTemp variables
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;SysLongDivMultA = SysLongTempA
	movf	SYSLONGTEMPA,W
	movwf	SYSLONGDIVMULTA
	movf	SYSLONGTEMPA_H,W
	movwf	SYSLONGDIVMULTA_H
	movf	SYSLONGTEMPA_U,W
	movwf	SYSLONGDIVMULTA_U
	movf	SYSLONGTEMPA_E,W
	movwf	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movf	SYSLONGTEMPB,W
	movwf	SYSLONGDIVMULTB
	movf	SYSLONGTEMPB_H,W
	movwf	SYSLONGDIVMULTB_H
	movf	SYSLONGTEMPB_U,W
	movwf	SYSLONGDIVMULTB_U
	movf	SYSLONGTEMPB_E,W
	movwf	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX
	clrf	SYSLONGDIVMULTX_H
	clrf	SYSLONGDIVMULTX_U
	clrf	SYSLONGDIVMULTX_E
MUL32LOOP
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	btfss	SYSLONGDIVMULTB,0
	goto	ENDIF56
	movf	SYSLONGDIVMULTA,W
	addwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTA_H,W
	addwfc	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTA_U,W
	addwfc	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTA_E,W
	addwfc	SYSLONGDIVMULTX_E,F
ENDIF56
;set STATUS.C OFF
	bcf	STATUS,C
;rotate SysLongDivMultB right
	rrf	SYSLONGDIVMULTB_E,F
	rrf	SYSLONGDIVMULTB_U,F
	rrf	SYSLONGDIVMULTB_H,F
	rrf	SYSLONGDIVMULTB,F
;set STATUS.C off
	bcf	STATUS,C
;rotate SysLongDivMultA left
	rlf	SYSLONGDIVMULTA,F
	rlf	SYSLONGDIVMULTA_H,F
	rlf	SYSLONGDIVMULTA_U,F
	rlf	SYSLONGDIVMULTA_E,F
;if SysLongDivMultB > 0 then goto MUL32LOOP
	movf	SYSLONGDIVMULTB,W
	movwf	SysLONGTempB
	movf	SYSLONGDIVMULTB_H,W
	movwf	SysLONGTempB_H
	movf	SYSLONGDIVMULTB_U,W
	movwf	SysLONGTempB_U
	movf	SYSLONGDIVMULTB_E,W
	movwf	SysLONGTempB_E
	clrf	SysLONGTempA
	clrf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	call	SysCompLessThan32
	btfsc	SysByteTempX,0
	goto	MUL32LOOP
;SysLongTempX = SysLongDivMultX
	movf	SYSLONGDIVMULTX,W
	movwf	SYSLONGTEMPX
	movf	SYSLONGDIVMULTX_H,W
	movwf	SYSLONGTEMPX_H
	movf	SYSLONGDIVMULTX_U,W
	movwf	SYSLONGTEMPX_U
	movf	SYSLONGDIVMULTX_E,W
	movwf	SYSLONGTEMPX_E
	return

;********************************************************************************

SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get length
;call SysStringTables
	call	SYSSTRINGTABLES
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;movwf INDF1
	movwf	INDF1
;goto SysStringReadCheck
	goto	SYSSTRINGREADCHECK
SYSREADSTRINGPART
;Get length
;call SysStringTables
	call	SYSSTRINGTABLES
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;addwf SysStringLength,F
	addwf	SYSSTRINGLENGTH,F
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
;addfsr 1,1
	addfsr	1,1
;movwf INDF1
	movwf	INDF1
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
	retlw	5
	retlw	65	;A
	retlw	78	;N
	retlw	49	;1
	retlw	51	;3
	retlw	32	; 


StringTable2
	retlw	5
	retlw	65	;A
	retlw	78	;N
	retlw	49	;1
	retlw	49	;1
	retlw	32	; 


StringTable3
	retlw	4
	retlw	84	;T
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 


StringTable4
	retlw	5
	retlw	84	;T
	retlw	111	;o
	retlw	102	;f
	retlw	102	;f
	retlw	32	; 


StringTable5
	retlw	5
	retlw	68	;D
	retlw	117	;u
	retlw	116	;t
	retlw	121	;y
	retlw	32	; 


StringTable6
	retlw	5
	retlw	84	;T
	retlw	105	;i
	retlw	109	;m
	retlw	101	;e
	retlw	32	; 


;********************************************************************************

;Start of program memory page 1
	ORG	2048
;Start of program memory page 2
	ORG	4096
;Start of program memory page 3
	ORG	6144
;Start of program memory page 4
	ORG	8192
;Start of program memory page 5
	ORG	10240
;Start of program memory page 6
	ORG	12288
;Start of program memory page 7
	ORG	14336

 END
