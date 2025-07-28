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
A_BULT1	EQU	33
A_BULT1_E	EQU	36
A_BULT1_H	EQU	34
A_BULT1_U	EQU	35
A_BULT2	EQU	37
A_BULT2_E	EQU	40
A_BULT2_H	EQU	38
A_BULT2_U	EQU	39
BULT1	EQU	41
BULT1_E	EQU	44
BULT1_H	EQU	42
BULT1_U	EQU	43
BULT2	EQU	45
BULT2_E	EQU	48
BULT2_H	EQU	46
BULT2_U	EQU	47
B_BULT1	EQU	49
B_BULT1_E	EQU	52
B_BULT1_H	EQU	50
B_BULT1_U	EQU	51
B_BULT2	EQU	53
B_BULT2_E	EQU	56
B_BULT2_H	EQU	54
B_BULT2_U	EQU	55
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
DIFF	EQU	57
DIFFIVAR	EQU	61
DIFFIVAR2	EQU	63
DIFFIVAR2_H	EQU	64
DIFFIVAR_H	EQU	62
DIFF_E	EQU	60
DIFF_H	EQU	58
DIFF_U	EQU	59
NTC	EQU	65
NTCAVERAGE	EQU	67
NTCAVERAGE_H	EQU	68
NTCX	EQU	69
NTCX_H	EQU	70
NTC_H	EQU	66
OCSDX	EQU	71
OCSDX2	EQU	72
OCX	EQU	73
OCX2	EQU	74
OTX	EQU	75
OTX2	EQU	76
OUTVALUETEMP	EQU	77
OVERCURRENT	EQU	78
OVERCURRENT_E	EQU	81
OVERCURRENT_H	EQU	79
OVERCURRENT_SHUTDOWN	EQU	82
OVERCURRENT_SHUTDOWN_E	EQU	85
OVERCURRENT_SHUTDOWN_H	EQU	83
OVERCURRENT_SHUTDOWN_U	EQU	84
OVERCURRENT_U	EQU	80
PRINTLEN	EQU	86
RDS6	EQU	87
RDS6_H	EQU	88
READAD	EQU	89
READAD12	EQU	90
READAD12_H	EQU	92
SAVEPCLATH	EQU	93
SAVESYSBYTETEMPX	EQU	94
SAVESYSDIVLOOP	EQU	95
SAVESYSLONGTEMPA	EQU	96
SAVESYSLONGTEMPA_E	EQU	97
SAVESYSLONGTEMPA_H	EQU	98
SAVESYSLONGTEMPA_U	EQU	99
SAVESYSLONGTEMPB	EQU	100
SAVESYSLONGTEMPB_E	EQU	101
SAVESYSLONGTEMPB_H	EQU	102
SAVESYSLONGTEMPB_U	EQU	103
SAVESYSLONGTEMPX_E	EQU	104
SAVESYSLONGTEMPX_H	EQU	105
SAVESYSLONGTEMPX_U	EQU	106
SERBIT	EQU	107
SERDELAYLOOP	EQU	108
SERPRINTVAL	EQU	109
SERPRINTVAL_H	EQU	110
SERTEMP	EQU	111
SER_BYTE	EQU	160
SER_DATA	EQU	161
SER_DATA_A	EQU	162
SER_INVERT	EQU	163
SER_INVERT_A	EQU	164
SER_PARITY	EQU	165
SER_PARITY_A	EQU	166
SER_RATE	EQU	167
SER_RATE_A	EQU	168
SER_SELECT	EQU	169
SER_SELECT_OLD	EQU	170
SER_START	EQU	171
SER_START_A	EQU	172
SER_STOP	EQU	173
SER_STOP_A	EQU	174
STRINGPOINTER	EQU	175
SYSBSR	EQU	176
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSCALCTEMPX	EQU	112
SYSCALCTEMPX_H	EQU	113
SYSDIVLOOP	EQU	116
SYSDIVMULTA	EQU	119
SYSDIVMULTA_H	EQU	120
SYSDIVMULTB	EQU	123
SYSDIVMULTB_H	EQU	124
SYSDIVMULTX	EQU	114
SYSDIVMULTX_H	EQU	115
SYSLONGDIVMULTA	EQU	177
SYSLONGDIVMULTA_E	EQU	180
SYSLONGDIVMULTA_H	EQU	178
SYSLONGDIVMULTA_U	EQU	179
SYSLONGDIVMULTB	EQU	181
SYSLONGDIVMULTB_E	EQU	184
SYSLONGDIVMULTB_H	EQU	182
SYSLONGDIVMULTB_U	EQU	183
SYSLONGDIVMULTX	EQU	185
SYSLONGDIVMULTX_E	EQU	188
SYSLONGDIVMULTX_H	EQU	186
SYSLONGDIVMULTX_U	EQU	187
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
SYSPRINTDATAHANDLER	EQU	189
SYSPRINTDATAHANDLER_H	EQU	190
SYSPRINTTEMP	EQU	191
SYSREPEATTEMP1	EQU	192
SYSREPEATTEMP4	EQU	193
SYSREPEATTEMP4_H	EQU	194
SYSSTATUS	EQU	127
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGLENGTH	EQU	118
SYSSTRINGPARAM1	EQU	10220
SYSTEMP1	EQU	195
SYSTEMP1_E	EQU	198
SYSTEMP1_H	EQU	196
SYSTEMP1_U	EQU	197
SYSTEMP2	EQU	199
SYSTEMP3	EQU	200
SYSTEMP3_H	EQU	201
SYSTEMP4	EQU	202
SYSW	EQU	126
SYSWAITTEMP10US	EQU	117
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
SYSWAITTEMPS	EQU	116
SYSWAITTEMPUS	EQU	117
SYSWAITTEMPUS_H	EQU	118
SYSWORDTEMPA	EQU	117
SYSWORDTEMPA_H	EQU	118
SYSWORDTEMPB	EQU	121
SYSWORDTEMPB_H	EQU	122
SYSWORDTEMPX	EQU	112
SYSWORDTEMPX_H	EQU	113
TEMPPARITY	EQU	203
TID0	EQU	204
TID0_H	EQU	205
TID1	EQU	206
TID1_H	EQU	207
TMRNUMBER	EQU	208
TMRPRES	EQU	209
TMRSOURCE	EQU	210

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5
SYSREADAD12WORD	EQU	90
SYSREADAD12WORD_H	EQU	92
SYSREADADBYTE	EQU	89

;********************************************************************************

;Vectors
	ORG	0
	pagesel	BASPROGRAMSTART
	goto	BASPROGRAMSTART
	ORG	4
Interrupt

;********************************************************************************

;Save Context
	movwf	SysW
	swapf	STATUS,W
	movwf	SysSTATUS
	movf	BSR,W
	banksel	STATUS
	banksel	SYSBSR
	movwf	SysBSR
;Store system variables
	movf	SysLongTempA,W
	banksel	SAVESYSLONGTEMPA
	movwf	SaveSysLongTempA
	movf	SysLongTempA_H,W
	movwf	SaveSysLongTempA_H
	movf	SysLongTempA_U,W
	movwf	SaveSysLongTempA_U
	movf	SysLongTempA_E,W
	movwf	SaveSysLongTempA_E
	movf	SysLongTempB,W
	movwf	SaveSysLongTempB
	movf	SysLongTempB_H,W
	movwf	SaveSysLongTempB_H
	movf	SysLongTempB_U,W
	movwf	SaveSysLongTempB_U
	movf	SysLongTempB_E,W
	movwf	SaveSysLongTempB_E
	movf	SysByteTempX,W
	movwf	SaveSysByteTempX
	movf	SysDivLoop,W
	movwf	SaveSysDivLoop
	movf	SysLongTempX_H,W
	movwf	SaveSysLongTempX_H
	movf	SysLongTempX_U,W
	movwf	SaveSysLongTempX_U
	movf	SysLongTempX_E,W
	movwf	SaveSysLongTempX_E
	movf	PCLATH,W
	movwf	SavePCLATH
	clrf	PCLATH
;On Interrupt handlers
	banksel	PIE1
	btfss	PIE1,TMR1IE
	goto	NotTMR1IF
	banksel	PIR1
	btfss	PIR1,TMR1IF
	goto	NotTMR1IF
	pagesel	CALL_MEAS_B1_B2
	call	CALL_MEAS_B1_B2
	pagesel	$
	bcf	PIR1,TMR1IF
	goto	INTERRUPTDONE
NotTMR1IF
;User Interrupt routine
INTERRUPTDONE
;Restore Context
;Restore system variables
	banksel	SAVESYSLONGTEMPA
	movf	SaveSysLongTempA,W
	movwf	SysLongTempA
	movf	SaveSysLongTempA_H,W
	movwf	SysLongTempA_H
	movf	SaveSysLongTempA_U,W
	movwf	SysLongTempA_U
	movf	SaveSysLongTempA_E,W
	movwf	SysLongTempA_E
	movf	SaveSysLongTempB,W
	movwf	SysLongTempB
	movf	SaveSysLongTempB_H,W
	movwf	SysLongTempB_H
	movf	SaveSysLongTempB_U,W
	movwf	SysLongTempB_U
	movf	SaveSysLongTempB_E,W
	movwf	SysLongTempB_E
	movf	SaveSysByteTempX,W
	movwf	SysByteTempX
	movf	SaveSysDivLoop,W
	movwf	SysDivLoop
	movf	SaveSysLongTempX_H,W
	movwf	SysLongTempX_H
	movf	SaveSysLongTempX_U,W
	movwf	SysLongTempX_U
	movf	SaveSysLongTempX_E,W
	movwf	SysLongTempX_E
	movf	SavePCLATH,W
	movwf	PCLATH
	banksel	SYSBSR
	movf	SysBSR,W
	movwf	BSR
	swapf	SysSTATUS,W
	movwf	STATUS
	swapf	SysW,F
	swapf	SysW,W
	retfie
	banksel	STATUS

;********************************************************************************

;Start of program memory page 0
	ORG	91
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
;Enable interrupts
	bsf	INTCON,GIE
	bsf	INTCON,PEIE

;Start of the main program
;
;
;Timer1 = 16bit 2bit prescaler
;0.44655V per Bit
;fullscale:29.26V (33K & 6.8K)
;On  13.0/26V
;Typ 13.5/27V
;Max 13.7/27.4V
;AN3:Bult1
;AN2:Bult2
;Oversampling ADC 16Bit
;n^4   12-16bit = 256ggr (summera 256ggr)
;n^2   12-16bit = X/4 (dela summan med 64)
;----- Config
;#config LVP = Off
;LCD DEBUG
;Dir PORTB.7 Out   'Pin28 (PGD)
	banksel	TRISB
	bcf	TRISB,7
;Dir PORTB.6 In    'Pin27 (PGC)
	bsf	TRISB,6
;Config UART
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
	banksel	STATUS
	pagesel	INITSER
	call	INITSER
	pagesel	$
;'''''' INTERRUPT HANDLING
;InitTimer1 Osc, Ps1_1/4   'orginal 1/0
	movlw	1
	banksel	TMRSOURCE
	movwf	TMRSOURCE
	movlw	32
	movwf	TMRPRES
	banksel	STATUS
	call	INITTIMER1
;On Interrupt Timer1Overflow Call Tidsbas1   ' Ta bort
;On Interrupt Timer1Overflow Call call_Meas_B1_B2
	banksel	PIE1
	bsf	PIE1,TMR1IE
;ClearTimer 1
	movlw	1
	movwf	TMRNUMBER
	banksel	STATUS
	pagesel	CLEARTIMER
	call	CLEARTIMER
	pagesel	$
;StartTimer 1
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER
	banksel	STATUS
	pagesel	STARTTIMER
	call	STARTTIMER
	pagesel	$
;----- DEFINE
;#define LED       PortB.3   'Pin24
;#define J2        PortC.4   'Pin15
;#define J3        PortC.5   'Pin16
;#define J4        PortC.6   'Pin17
;#define Gate      PortA.1   'Pin3
;0V--->-----------13.50V-----ON----16.00V---|->----------27.50V----ON----29.10V------>|OVERVOLTAGE|
;|            12VOLT SYSTEM                 |               24 VOLT SYSTEM                       |ABSOLUTE MAX 29,26V
;0V---<---12.80V----ON-----15.50V---------<-|-----25.60V----ON---29.00V--------------<|OVERVOLTAGE|
;'''''' 12VOLT SYSTEM
;#define 12V_LOW     28669 '12.80V MOSFET OFF
;#define 12V_MIDLOW  30237 '13.50V MOSFET ON
;#define 12V_MIDHIGH 34716 '15.50V MOSFET ON
;#define 12V_HIGH    35836 '16.00V MOSFET OFF
;'''''' 24VOLT SYSTEM
;#define 24V_LOW     57338 '25.60V MOSFET OFF
;#define 24V_MIDLOW  61593 '27.50V MOSFET ON
;#define 24V_MIDHIGH 64952 '29.00V MOSFET ON
;#define 24V_HIGH    65064 '29.05V MOSFET OFF
;'''''' ERROR HANDLING
;#define Overvoltage 65333 '29.17V  MOSFET OFF
;#define OverTemp    205 '
;#define Overcurrent 100 ' 100amp 'PM 200515
;#define Overcurrent_shutdown  200 '200amp PM 200515
;'''''' DIMENSION
;Dim Tid0    As Word
;Dim Tid1    As Word
;Dim Ntc     As Word
;Dim NtcX     As Word
;Dim NtcAverage  As Word
;Dim Bult1   As long
;Dim Bult2   As long
;Dim A_Bult1 As long
;Dim A_Bult2 As Long
;Dim B_Bult1 As Long
;Dim B_Bult2 As Long
;Dim C_Bult1 As Long
;Dim C_Bult2 As Long
;Dim Diff    As Long
;Dim A_Diff  As Long
;Dim gate_set As byte
;Dim varA As Byte
;Dim Diffivar As Word
;Dim Diffivar2 As Word
;Dim rds6 As Word
;Dim Overcurrent As Long '100 ' 100amp
;Dim Overcurrent_shutdown As Long '  200 '200amp
;'''''' PORT DIRECTION
;Dir PORTA.12 In 'NTC 47K + 1K8 ANALOG 10bit  Pin21
	banksel	TRISA
	bsf	TRISA,12
;Dir PORTA.3 In  'Bult 1 ANALOG 12bit        Pin4
	bsf	TRISA,3
;Dir PORTA.2 In  'Bult 2 ANALOG 12bit        Pin5
	bsf	TRISA,2
;Dir PORTB.3 Out 'LED                        Pin24
	bcf	TRISB,3
;Dir PORTC.4 In  'J2                         Pin15
	bsf	TRISC,4
;Dir PORTC.5 In  'J3                         Pin16
	bsf	TRISC,5
;Dir PORTC.6 In  'J4                         Pin17
	bsf	TRISC,6
;Dir PORTA.1 Out 'Gate signal                Pin3
	bcf	TRISA,1
;'''''' SETUP
;Ntc = 0
	banksel	NTC
	clrf	NTC
	clrf	NTC_H
;Tid0 = 0
	banksel	TID0
	clrf	TID0
	clrf	TID0_H
;Tid1 = 0
	clrf	TID1
	clrf	TID1_H
;Diffivar2 = 0
	banksel	DIFFIVAR2
	clrf	DIFFIVAR2
	clrf	DIFFIVAR2_H
;Diff = 0
	clrf	DIFF
	clrf	DIFF_H
	clrf	DIFF_U
	clrf	DIFF_E
;set led off
	banksel	LATB
	bcf	LATB,3
;set gate off
	bcf	LATA,1
;'''''' START ''''''
START
;set led on
	banksel	LATB
	bsf	LATB,3
;Diffivar2 = 0
	banksel	DIFFIVAR2
	clrf	DIFFIVAR2
	clrf	DIFFIVAR2_H
;Diff = 0
	clrf	DIFF
	clrf	DIFF_H
	clrf	DIFF_U
	clrf	DIFF_E
;Ntc = 0
	clrf	NTC
	clrf	NTC_H
;If Gate = Off Then Set LED Off
	btfsc	PORTA,1
	goto	ENDIF1
	banksel	LATB
	bcf	LATB,3
ENDIF1
;If Gate = On Then Set LED On
	banksel	PORTA
	btfss	PORTA,1
	goto	ENDIF2
	banksel	LATB
	bsf	LATB,3
ENDIF2
;Call_Meas_B1_B2
;Call_Ntc
	banksel	STATUS
	pagesel	CALL_NTC
	call	CALL_NTC
	pagesel	$
;Diffivar2 = 0    '3Maj test
	clrf	DIFFIVAR2
	clrf	DIFFIVAR2_H
;Call_Diff
	call	CALL_DIFF
	pagesel	$
;Call_Lcd
	call	CALL_LCD
;wait 200 ms '120ms ,kritisk tid p.g.a over_current mätningen
	movlw	200
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Diff 200 motsvarar ungefär 200Amp
;'''If Diff > Overcurrent And Gate = On Then Goto over_current
;If Diffivar2 > Overcurrent_instoff And Gate = On Then Goto Over_current_inst_off
;If Diffivar2 > Overcurrent_total_shutdown And Gate = On Then Goto over_current_tot_shutdown
;If Diffivar2 > Overcurrent_shutdown And Gate = On Then Goto over_current_shutdown
	movf	DIFFIVAR2,W
	movwf	SysLONGTempB
	movf	DIFFIVAR2_H,W
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	movf	OVERCURRENT_SHUTDOWN,W
	movwf	SysLONGTempA
	movf	OVERCURRENT_SHUTDOWN_H,W
	movwf	SysLONGTempA_H
	movf	OVERCURRENT_SHUTDOWN_U,W
	movwf	SysLONGTempA_U
	movf	OVERCURRENT_SHUTDOWN_E,W
	movwf	SysLONGTempA_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	clrf	SysByteTempX
	banksel	PORTA
	btfsc	PORTA,1
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfsc	SysTemp2,0
	goto	OVER_CURRENT_SHUTDOWN
;If Diffivar2 > Overcurrent And Gate = On Then Goto over_current
	banksel	DIFFIVAR2
	movf	DIFFIVAR2,W
	movwf	SysLONGTempB
	movf	DIFFIVAR2_H,W
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	movf	OVERCURRENT,W
	movwf	SysLONGTempA
	movf	OVERCURRENT_H,W
	movwf	SysLONGTempA_H
	movf	OVERCURRENT_U,W
	movwf	SysLONGTempA_U
	movf	OVERCURRENT_E,W
	movwf	SysLONGTempA_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	clrf	SysByteTempX
	banksel	PORTA
	btfsc	PORTA,1
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfsc	SysTemp2,0
	goto	OVER_CURRENT
;> 4 träffar i rad krävs för att Overcurrent_total_shutdown ska lösa ut.
;overcurrent
;octsdx2 = octsdx2 + 1
;If octsdx > 0 And octsdx2 > 4 Or octsdx2 > 4 Then
;octsdx = 0
;octsdx2 = 0
;End If
;> 10 träffar i rad krävs för att overcurrent ska lösa ut.
;overcurrent
;ocx2 = ocx2 + 1
	banksel	OCX2
	incf	OCX2,F
;If ocx > 0 And ocx2 > 10 Or ocx2 > 10 Then
	movf	OCX,W
	movwf	SysBYTETempB
	clrf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	OCX2
	movf	OCX2,W
	movwf	SysBYTETempB
	movlw	10
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	OCX2
	movf	OCX2,W
	movwf	SysBYTETempB
	movlw	10
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysTemp2,W
	movwf	SysTemp3
	iorwf	SysByteTempX,W
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ENDIF5
;ocx = 0
	banksel	OCX
	clrf	OCX
;ocx2 = 0
	clrf	OCX2
;End If
ENDIF5
;> 20 träffar i rad krävs för att overcurrent_shutdown ska lösa ut.
;overcurrent
;ocsdx2 = ocsdx2 + 1
	banksel	OCSDX2
	incf	OCSDX2,F
;If ocsdx > 0 And ocsdx2 > 10 Or ocsdx2 > 10 Then
	movf	OCSDX,W
	movwf	SysBYTETempB
	clrf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	OCSDX2
	movf	OCSDX2,W
	movwf	SysBYTETempB
	movlw	10
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	OCSDX2
	movf	OCSDX2,W
	movwf	SysBYTETempB
	movlw	10
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysTemp2,W
	movwf	SysTemp3
	iorwf	SysByteTempX,W
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ENDIF6
;ocsdx = 0
	banksel	OCSDX
	clrf	OCSDX
;ocsdx2 = 0
	clrf	OCSDX2
;End If
ENDIF6
;> 10 träffar i rad krävs för att overtemp ska lösa ut.
;overtemp
;otx2 = otx2 + 1
	banksel	OTX2
	incf	OTX2,F
;If otx > 0 And otx2 > 10 Or otx2 > 10 Then
	movf	OTX,W
	movwf	SysBYTETempB
	clrf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	OTX2
	movf	OTX2,W
	movwf	SysBYTETempB
	movlw	10
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	OTX2
	movf	OTX2,W
	movwf	SysBYTETempB
	movlw	10
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysTemp2,W
	movwf	SysTemp3
	iorwf	SysByteTempX,W
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ENDIF7
;otx = 0
	banksel	OTX
	clrf	OTX
;otx2 = 0
	clrf	OTX2
;End If
ENDIF7
;''''''''' Ta bort???? Call_CheckCurrent (Diff, VarA)
;If Ntc < Overtemp And Gate = On then Goto Over_Temp
	banksel	NTC
	movf	NTC,W
	movwf	SysWORDTempA
	movf	NTC_H,W
	movwf	SysWORDTempA_H
	movlw	205
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	clrf	SysByteTempX
	banksel	PORTA
	btfsc	PORTA,1
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfsc	SysTemp2,0
	goto	OVER_TEMP
;If J2 = Off And J3 = On Then Goto OnOff
	clrf	SysByteTempX
	banksel	PORTC
	btfss	PORTC,4
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	clrf	SysByteTempX
	banksel	PORTC
	btfsc	PORTC,5
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfsc	SysTemp2,0
	goto	ONOFF
;If J2 = Off And J3 = Off Then goto Override
	clrf	SysByteTempX
	banksel	PORTC
	btfss	PORTC,4
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	clrf	SysByteTempX
	banksel	PORTC
	btfss	PORTC,5
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfsc	SysTemp2,0
	goto	OVERRIDE
;If J2 = On And J3 = Off Then goto Override
	clrf	SysByteTempX
	banksel	PORTC
	btfsc	PORTC,4
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	clrf	SysByteTempX
	banksel	PORTC
	btfss	PORTC,5
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfsc	SysTemp2,0
	goto	OVERRIDE
;If J4 = Off And B_Bult2 >= B_Bult1 Then goto uni
;If J4 = Off And B_Bult2 < 10 Then goto uni
;If B_Bult1 > Overvoltage And B_Bult2 > Overvoltage Then Goto Voltage_error
	banksel	B_BULT1
	movf	B_BULT1,W
	movwf	SysLONGTempB
	movf	B_BULT1_H,W
	movwf	SysLONGTempB_H
	movf	B_BULT1_U,W
	movwf	SysLONGTempB_U
	movf	B_BULT1_E,W
	movwf	SysLONGTempB_E
	movlw	53
	movwf	SysLONGTempA
	movlw	255
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	B_BULT2
	movf	B_BULT2,W
	movwf	SysLONGTempB
	movf	B_BULT2_H,W
	movwf	SysLONGTempB_H
	movf	B_BULT2_U,W
	movwf	SysLONGTempB_U
	movf	B_BULT2_E,W
	movwf	SysLONGTempB_E
	movlw	53
	movwf	SysLONGTempA
	movlw	255
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfsc	SysTemp2,0
	goto	VOLTAGE_ERROR
;12V system
;If B_Bult1 > 12V_LOW And B_Bult1 < 12V_HIGH And Gate = On Then Goto Bult1_12V'
	banksel	B_BULT1
	movf	B_BULT1,W
	movwf	SysLONGTempB
	movf	B_BULT1_H,W
	movwf	SysLONGTempB_H
	movf	B_BULT1_U,W
	movwf	SysLONGTempB_U
	movf	B_BULT1_E,W
	movwf	SysLONGTempB_E
	movlw	253
	movwf	SysLONGTempA
	movlw	111
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	B_BULT1
	movf	B_BULT1,W
	movwf	SysLONGTempA
	movf	B_BULT1_H,W
	movwf	SysLONGTempA_H
	movf	B_BULT1_U,W
	movwf	SysLONGTempA_U
	movf	B_BULT1_E,W
	movwf	SysLONGTempA_E
	movlw	252
	movwf	SysLONGTempB
	movlw	139
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	clrf	SysByteTempX
	banksel	PORTA
	btfsc	PORTA,1
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysTemp2,W
	movwf	SysTemp3
	andwf	SysByteTempX,W
	movwf	SysTemp1
	btfsc	SysTemp1,0
	goto	BULT1_12V
;If B_Bult1 > 12V_MIDLOW AND B_Bult1 <= 12V_MIDHIGH Then goto Bult1_12V'
	banksel	B_BULT1
	movf	B_BULT1,W
	movwf	SysLONGTempB
	movf	B_BULT1_H,W
	movwf	SysLONGTempB_H
	movf	B_BULT1_U,W
	movwf	SysLONGTempB_U
	movf	B_BULT1_E,W
	movwf	SysLONGTempB_E
	movlw	29
	movwf	SysLONGTempA
	movlw	118
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	B_BULT1
	movf	B_BULT1,W
	movwf	SysLONGTempB
	movf	B_BULT1_H,W
	movwf	SysLONGTempB_H
	movf	B_BULT1_U,W
	movwf	SysLONGTempB_U
	movf	B_BULT1_E,W
	movwf	SysLONGTempB_E
	movlw	156
	movwf	SysLONGTempA
	movlw	135
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfsc	SysTemp2,0
	goto	BULT1_12V
;If B_Bult2 > 12V_LOW And B_Bult2 < 12V_HIGH And Gate = On And J4 = On Then goto Bult2_12V'
	banksel	B_BULT2
	movf	B_BULT2,W
	movwf	SysLONGTempB
	movf	B_BULT2_H,W
	movwf	SysLONGTempB_H
	movf	B_BULT2_U,W
	movwf	SysLONGTempB_U
	movf	B_BULT2_E,W
	movwf	SysLONGTempB_E
	movlw	253
	movwf	SysLONGTempA
	movlw	111
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	B_BULT2
	movf	B_BULT2,W
	movwf	SysLONGTempA
	movf	B_BULT2_H,W
	movwf	SysLONGTempA_H
	movf	B_BULT2_U,W
	movwf	SysLONGTempA_U
	movf	B_BULT2_E,W
	movwf	SysLONGTempA_E
	movlw	252
	movwf	SysLONGTempB
	movlw	139
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	clrf	SysByteTempX
	banksel	PORTA
	btfsc	PORTA,1
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	clrf	SysByteTempX
	banksel	PORTC
	btfsc	PORTC,6
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysTemp2,W
	movwf	SysTemp4
	andwf	SysTemp3,W
	movwf	SysTemp1
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfsc	SysTemp2,0
	goto	BULT2_12V
;If B_Bult2 > 12V_MIDLOW AND B_Bult2 <= 12V_MIDHIGH And J4 = On Then goto Bult2_12V'
	banksel	B_BULT2
	movf	B_BULT2,W
	movwf	SysLONGTempB
	movf	B_BULT2_H,W
	movwf	SysLONGTempB_H
	movf	B_BULT2_U,W
	movwf	SysLONGTempB_U
	movf	B_BULT2_E,W
	movwf	SysLONGTempB_E
	movlw	29
	movwf	SysLONGTempA
	movlw	118
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	B_BULT2
	movf	B_BULT2,W
	movwf	SysLONGTempB
	movf	B_BULT2_H,W
	movwf	SysLONGTempB_H
	movf	B_BULT2_U,W
	movwf	SysLONGTempB_U
	movf	B_BULT2_E,W
	movwf	SysLONGTempB_E
	movlw	156
	movwf	SysLONGTempA
	movlw	135
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	clrf	SysByteTempX
	banksel	PORTC
	btfsc	PORTC,6
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysTemp2,W
	movwf	SysTemp3
	andwf	SysByteTempX,W
	movwf	SysTemp1
	btfsc	SysTemp1,0
	goto	BULT2_12V
;24V system
;If B_Bult1 > 24V_LOW And B_Bult1 < 24V_HIGH And Gate = On Then goto Bult1_24V'
	banksel	B_BULT1
	movf	B_BULT1,W
	movwf	SysLONGTempB
	movf	B_BULT1_H,W
	movwf	SysLONGTempB_H
	movf	B_BULT1_U,W
	movwf	SysLONGTempB_U
	movf	B_BULT1_E,W
	movwf	SysLONGTempB_E
	movlw	250
	movwf	SysLONGTempA
	movlw	223
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	B_BULT1
	movf	B_BULT1,W
	movwf	SysLONGTempA
	movf	B_BULT1_H,W
	movwf	SysLONGTempA_H
	movf	B_BULT1_U,W
	movwf	SysLONGTempA_U
	movf	B_BULT1_E,W
	movwf	SysLONGTempA_E
	movlw	40
	movwf	SysLONGTempB
	movlw	254
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	clrf	SysByteTempX
	banksel	PORTA
	btfsc	PORTA,1
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysTemp2,W
	movwf	SysTemp3
	andwf	SysByteTempX,W
	movwf	SysTemp1
	btfsc	SysTemp1,0
	goto	BULT1_24V
;If B_Bult1 > 24V_MIDLOW And B_Bult1 <= 24V_MIDHIGH Then goto Bult1_24V'
	banksel	B_BULT1
	movf	B_BULT1,W
	movwf	SysLONGTempB
	movf	B_BULT1_H,W
	movwf	SysLONGTempB_H
	movf	B_BULT1_U,W
	movwf	SysLONGTempB_U
	movf	B_BULT1_E,W
	movwf	SysLONGTempB_E
	movlw	153
	movwf	SysLONGTempA
	movlw	240
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	B_BULT1
	movf	B_BULT1,W
	movwf	SysLONGTempB
	movf	B_BULT1_H,W
	movwf	SysLONGTempB_H
	movf	B_BULT1_U,W
	movwf	SysLONGTempB_U
	movf	B_BULT1_E,W
	movwf	SysLONGTempB_E
	movlw	184
	movwf	SysLONGTempA
	movlw	253
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfsc	SysTemp2,0
	goto	BULT1_24V
;If B_Bult2 > 24V_LOW And B_Bult2 < 24V_HIGH And Gate = On And J4 = On Then goto Bult2_24V'
	banksel	B_BULT2
	movf	B_BULT2,W
	movwf	SysLONGTempB
	movf	B_BULT2_H,W
	movwf	SysLONGTempB_H
	movf	B_BULT2_U,W
	movwf	SysLONGTempB_U
	movf	B_BULT2_E,W
	movwf	SysLONGTempB_E
	movlw	250
	movwf	SysLONGTempA
	movlw	223
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	B_BULT2
	movf	B_BULT2,W
	movwf	SysLONGTempA
	movf	B_BULT2_H,W
	movwf	SysLONGTempA_H
	movf	B_BULT2_U,W
	movwf	SysLONGTempA_U
	movf	B_BULT2_E,W
	movwf	SysLONGTempA_E
	movlw	40
	movwf	SysLONGTempB
	movlw	254
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	clrf	SysByteTempX
	banksel	PORTA
	btfsc	PORTA,1
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	clrf	SysByteTempX
	banksel	PORTC
	btfsc	PORTC,6
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysTemp2,W
	movwf	SysTemp4
	andwf	SysTemp3,W
	movwf	SysTemp1
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfsc	SysTemp2,0
	goto	BULT2_24V
;If B_Bult2 > 24V_MIDLOW And B_Bult2 <= 24V_MIDHIGH And J4 = On Then goto Bult2_24V'
	banksel	B_BULT2
	movf	B_BULT2,W
	movwf	SysLONGTempB
	movf	B_BULT2_H,W
	movwf	SysLONGTempB_H
	movf	B_BULT2_U,W
	movwf	SysLONGTempB_U
	movf	B_BULT2_E,W
	movwf	SysLONGTempB_E
	movlw	153
	movwf	SysLONGTempA
	movlw	240
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	B_BULT2
	movf	B_BULT2,W
	movwf	SysLONGTempB
	movf	B_BULT2_H,W
	movwf	SysLONGTempB_H
	movf	B_BULT2_U,W
	movwf	SysLONGTempB_U
	movf	B_BULT2_E,W
	movwf	SysLONGTempB_E
	movlw	184
	movwf	SysLONGTempA
	movlw	253
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	clrf	SysByteTempX
	banksel	PORTC
	btfsc	PORTC,6
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysTemp2,W
	movwf	SysTemp3
	andwf	SysByteTempX,W
	movwf	SysTemp1
	btfsc	SysTemp1,0
	goto	BULT2_24V
;Om spänningen sjunker under minimum på sekundärsidan när primärsidan fortfarande
;ligger bra, fortsätt som vanligt. Detta om Bult 2 är primär.
;If B_Bult1 < 24V_LOW And B_Bult2 > 24V_LOW And B_Bult2 < 24V_HIGH Then goto Bult2_24V '
;Om bult 1 är primär
;If B_Bult2 < 24V_LOW And B_Bult1 > 24V_LOW And B_Bult1 < 24V_HIGH Then goto Bult1_24V '
;If B_Bult1 > Overvoltage Then Goto range_error'
;If B_Bult2 > Overvoltage Then Goto range_error'
;goto range_error
	goto	RANGE_ERROR
;Wait 50 ms ' orginal 100 ms
;Goto start
ONOFF
;Set Gate On
	banksel	LATA
	bsf	LATA,1
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	banksel	STATUS
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;goto start
	goto	START
OVERRIDE
;Set gate Off
	banksel	LATA
	bcf	LATA,1
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	banksel	STATUS
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Goto start
	goto	START
;Goto Start
	goto	START
UNI
;Set Gate Off
	banksel	LATA
	bcf	LATA,1
;Set LED Off
	bcf	LATB,3
;wait 100 ms
	movlw	100
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Goto start
	goto	START
BULT1_12V
;Set Gate On
	banksel	LATA
	bsf	LATA,1
;Set LED On
	bsf	LATB,3
;Overcurrent = 200 ' 100amp
	movlw	200
	banksel	OVERCURRENT
	movwf	OVERCURRENT
	clrf	OVERCURRENT_H
	clrf	OVERCURRENT_U
	clrf	OVERCURRENT_E
;Overcurrent_shutdown  = 300 '200amp
	movlw	44
	movwf	OVERCURRENT_SHUTDOWN
	movlw	1
	movwf	OVERCURRENT_SHUTDOWN_H
	clrf	OVERCURRENT_SHUTDOWN_U
	clrf	OVERCURRENT_SHUTDOWN_E
;goto Start
	goto	START
BULT2_12V
;Set Gate On
	banksel	LATA
	bsf	LATA,1
;Set LED On
	bsf	LATB,3
;If J4 = Off then Set Gate Off
	banksel	PORTC
	btfsc	PORTC,6
	goto	ENDIF21
	banksel	LATA
	bcf	LATA,1
ENDIF21
;Set Led Off
	banksel	LATB
	bcf	LATB,3
;Overcurrent = 200 ' 100amp
	movlw	200
	banksel	OVERCURRENT
	movwf	OVERCURRENT
	clrf	OVERCURRENT_H
	clrf	OVERCURRENT_U
	clrf	OVERCURRENT_E
;Overcurrent_shutdown  = 300 '200amp
	movlw	44
	movwf	OVERCURRENT_SHUTDOWN
	movlw	1
	movwf	OVERCURRENT_SHUTDOWN_H
	clrf	OVERCURRENT_SHUTDOWN_U
	clrf	OVERCURRENT_SHUTDOWN_E
;goto Start
	goto	START
BULT1_24V
;Set Gate On
	banksel	LATA
	bsf	LATA,1
;Set LED On
	bsf	LATB,3
;Overcurrent = 100 ' 100amp
	movlw	100
	banksel	OVERCURRENT
	movwf	OVERCURRENT
	clrf	OVERCURRENT_H
	clrf	OVERCURRENT_U
	clrf	OVERCURRENT_E
;Overcurrent_shutdown  = 200 '200amp
	movlw	200
	movwf	OVERCURRENT_SHUTDOWN
	clrf	OVERCURRENT_SHUTDOWN_H
	clrf	OVERCURRENT_SHUTDOWN_U
	clrf	OVERCURRENT_SHUTDOWN_E
;goto Start
	goto	START
BULT2_24V
;Set Gate On
	banksel	LATA
	bsf	LATA,1
;Set LED On
	bsf	LATB,3
;Overcurrent = 100 ' 100amp
	movlw	100
	banksel	OVERCURRENT
	movwf	OVERCURRENT
	clrf	OVERCURRENT_H
	clrf	OVERCURRENT_U
	clrf	OVERCURRENT_E
;Overcurrent_shutdown  = 200 '200amp
	movlw	200
	movwf	OVERCURRENT_SHUTDOWN
	clrf	OVERCURRENT_SHUTDOWN_H
	clrf	OVERCURRENT_SHUTDOWN_U
	clrf	OVERCURRENT_SHUTDOWN_E
;If J4 = Off then Set Gate Off : Set Led Off
	btfsc	PORTC,6
	goto	ENDIF22
	banksel	LATA
	bcf	LATA,1
	bcf	LATB,3
ENDIF22
;goto Start
	goto	START
RANGE_ERROR
;Set gate Off
	banksel	LATA
	bcf	LATA,1
;Set Led Off
	bcf	LATB,3
;wait 200 ms
	movlw	200
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Repeat 3
	movlw	3
	banksel	SYSREPEATTEMP1
	movwf	SysRepeatTemp1
SysRepeatLoop1
;Set LED Off
	banksel	LATB
	bcf	LATB,3
;wait 100 ms
	movlw	100
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Set Led On
	banksel	LATB
	bsf	LATB,3
;Wait 100 ms
	movlw	100
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;End Repeat
	banksel	SYSREPEATTEMP1
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;Goto Start
	goto	START
OVER_CURRENT
;ocx = ocx + 1
	banksel	OCX
	incf	OCX,F
;if ocx > 10 Then
	movf	OCX,W
	sublw	10
	btfsc	STATUS, C
	goto	ENDIF23
;ocx = 0
	clrf	OCX
;Set Gate Off
	banksel	LATA
	bcf	LATA,1
;Set LED off
	bcf	LATB,3
;wait 1 s
	movlw	1
	movwf	SysWaitTempS
	banksel	STATUS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;End if
ENDIF23
;Goto Start
	goto	START
OVER_CURRENT_SHUTDOWN
;ocsdx = ocsdx + 1
	banksel	OCSDX
	incf	OCSDX,F
;if ocsdx > 10 Then
	movf	OCSDX,W
	sublw	10
	btfsc	STATUS, C
	goto	ENDIF24
;ocsdx = 0
	clrf	OCSDX
;Set Gate Off
	banksel	LATA
	bcf	LATA,1
;Set LED off
	bcf	LATB,3
;StopTimer 1
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER
	banksel	STATUS
	pagesel	STOPTIMER
	call	STOPTIMER
	pagesel	$
;wait 15 s
	movlw	15
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;StartTimer 1
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER
	banksel	STATUS
	pagesel	STARTTIMER
	call	STARTTIMER
	pagesel	$
;End if
ENDIF24
;StopTimer 1
;Goto Start
	goto	START
;Goto over_current_shutdown
OVER_TEMP
;otx = otx + 1
	banksel	OTX
	incf	OTX,F
;if otx > 10 Then
	movf	OTX,W
	sublw	10
	btfsc	STATUS, C
	goto	ENDIF25
;otx = 0
	clrf	OTX
;If Gate On Then
;set gate off
	banksel	LATA
	bcf	LATA,1
;Repeat 10
	movlw	10
	banksel	SYSREPEATTEMP1
	movwf	SysRepeatTemp1
SysRepeatLoop2
;Set Led Off
	banksel	LATB
	bcf	LATB,3
;wait 200 ms
	movlw	200
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Set Led On
	banksel	LATB
	bsf	LATB,3
;Wait 200 ms
	movlw	200
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;End Repeat
	banksel	SYSREPEATTEMP1
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	banksel	STATUS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;End if
ENDIF25
;Goto Start
	goto	START
VOLTAGE_ERROR
;för att förhindra error vid första starten.
;If Gate On Then
	banksel	PORTA
	btfss	PORTA,1
	goto	ENDIF26
;Repeat 4
	movlw	4
	banksel	SYSREPEATTEMP1
	movwf	SysRepeatTemp1
SysRepeatLoop3
;Set Gate off
	banksel	LATA
	bcf	LATA,1
;Set Led Off
	bcf	LATB,3
;wait 1 s
	movlw	1
	movwf	SysWaitTempS
	banksel	STATUS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;Set Gate On
	banksel	LATA
	bsf	LATA,1
;Set Led On
	bsf	LATB,3
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	banksel	STATUS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;End Repeat
	banksel	SYSREPEATTEMP1
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop3
SysRepeatLoopEnd3
;end if
ENDIF26
;Goto Start
	goto	START
;goto Start
	goto	START
;*******Subrutiner**********
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

CALL_DIFF
;StopTimer 1
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER
	banksel	STATUS
	pagesel	STOPTIMER
	call	STOPTIMER
	pagesel	$
;If B_Bult1 > B_Bult2 Then Diff = B_Bult1 - B_Bult2 'Test a
	movf	B_BULT1,W
	movwf	SysLONGTempB
	movf	B_BULT1_H,W
	movwf	SysLONGTempB_H
	movf	B_BULT1_U,W
	movwf	SysLONGTempB_U
	movf	B_BULT1_E,W
	movwf	SysLONGTempB_E
	movf	B_BULT2,W
	movwf	SysLONGTempA
	movf	B_BULT2_H,W
	movwf	SysLONGTempA_H
	movf	B_BULT2_U,W
	movwf	SysLONGTempA_U
	movf	B_BULT2_E,W
	movwf	SysLONGTempA_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF28
	movf	B_BULT2,W
	subwf	B_BULT1,W
	movwf	DIFF
	movf	B_BULT2_H,W
	subwfb	B_BULT1_H,W
	movwf	DIFF_H
	movf	B_BULT2_U,W
	subwfb	B_BULT1_U,W
	movwf	DIFF_U
	movf	B_BULT2_E,W
	subwfb	B_BULT1_E,W
	movwf	DIFF_E
ENDIF28
;If B_Bult2 > B_Bult1 Then Diff = B_Bult2 - B_Bult1 'Test a
	movf	B_BULT2,W
	movwf	SysLONGTempB
	movf	B_BULT2_H,W
	movwf	SysLONGTempB_H
	movf	B_BULT2_U,W
	movwf	SysLONGTempB_U
	movf	B_BULT2_E,W
	movwf	SysLONGTempB_E
	movf	B_BULT1,W
	movwf	SysLONGTempA
	movf	B_BULT1_H,W
	movwf	SysLONGTempA_H
	movf	B_BULT1_U,W
	movwf	SysLONGTempA_U
	movf	B_BULT1_E,W
	movwf	SysLONGTempA_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF29
	movf	B_BULT1,W
	subwf	B_BULT2,W
	movwf	DIFF
	movf	B_BULT1_H,W
	subwfb	B_BULT2_H,W
	movwf	DIFF_H
	movf	B_BULT1_U,W
	subwfb	B_BULT2_U,W
	movwf	DIFF_U
	movf	B_BULT1_E,W
	subwfb	B_BULT2_E,W
	movwf	DIFF_E
ENDIF29
;Diffivar = Diff * 127 + 727
	movf	DIFF,W
	movwf	SysLONGTempA
	movf	DIFF_H,W
	movwf	SysLONGTempA_H
	movf	DIFF_U,W
	movwf	SysLONGTempA_U
	movf	DIFF_E,W
	movwf	SysLONGTempA_E
	movlw	127
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SysMultSub32
	call	SysMultSub32
	pagesel	$
	movlw	215
	addwf	SysLONGTempX,W
	movwf	DIFFIVAR
	movlw	2
	addwfc	SysLONGTempX_H,W
	movwf	DIFFIVAR_H
;Diffivar2 = Diffivar / 100
;Diffivar2 = ((Diffivar /100) * 250) / rds6
	movf	DIFFIVAR,W
	movwf	SysWORDTempA
	movf	DIFFIVAR_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	movf	SysWORDTempA_H,W
	movwf	SysTemp3_H
	movf	SysTemp3,W
	movwf	SysWORDTempA
	movf	SysTemp3_H,W
	movwf	SysWORDTempA_H
	movlw	250
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysMultSub16
	call	SysMultSub16
	pagesel	$
	movf	SysWORDTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	SysWORDTempX_H,W
	movwf	SysTemp1_H
	movf	SysTemp1,W
	movwf	SysWORDTempA
	movf	SysTemp1_H,W
	movwf	SysWORDTempA_H
	banksel	RDS6
	movf	RDS6,W
	movwf	SysWORDTempB
	movf	RDS6_H,W
	movwf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	movwf	DIFFIVAR2
	movf	SysWORDTempA_H,W
	movwf	DIFFIVAR2_H
;SerPrint 1, " D:"
	movlw	1
	banksel	SER_SELECT
	movwf	SER_SELECT
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable2
	movwf	SysStringA
	movlw	(high StringTable2) & 127
	movwf	SysStringA_H
	banksel	STATUS
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	SERPRINT42
	call	SERPRINT42
	pagesel	$
;Serprint 1, Diffivar2
	movlw	1
	banksel	SER_SELECT
	movwf	SER_SELECT
	banksel	DIFFIVAR2
	movf	DIFFIVAR2,W
	movwf	SERPRINTVAL
	movf	DIFFIVAR2_H,W
	movwf	SERPRINTVAL_H
	pagesel	SERPRINT44
	call	SERPRINT44
	pagesel	$
;StartTimer 1
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER
	banksel	STATUS
	pagesel	STARTTIMER
	goto	STARTTIMER

;********************************************************************************

CALL_LCD
;Diffivar = Diff * 127 + 727
;Diffivar2 = Diffivar / 100
;''Serprint 1, " D:"
;''Serprint 1, Diffivar2
;SerSend 1, 254  ' "kommando"
;SerSend 1, 192  ' "rad två"
;wait 1 ms
;SerPrint 1, "1:"
;SerPrint 1, B_Bult1
;wait 1 ms 'debug orginal:10ms
;SerPrint 1, " 2:"
;SerPrint 1, B_Bult2
	return

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

INITTIMER1
;Asummptions
;- Pwr On Reset State of TxCON for 1/3/5/7 is "0"
;- TXCON Timer REGISTER for 1/3/5/7 are NOT the Same on ALL PICS
;- TMRON is Bit0 on all Chips
;- OSCEN & SOSCEN are always TxCON.3 and perform the same function
;but, of course, see Datasheet for Detailed Register Information
;Handle PICs with Timer1 module have T1CON register
;
;Handle NoVar(T1CLK)
;
;Test for valid Pres parameter
;
;This coding approach uses less memory than multiple boolean "AND" statements
;If TMRPres <> 0 then
	banksel	TMRPRES
	movf	TMRPRES,F
	btfsc	STATUS, Z
	goto	ENDIF97
;IF TMRPres <> 16 then
	movlw	16
	subwf	TMRPRES,W
	btfsc	STATUS, Z
	goto	ENDIF103
;IF TMRPres <> 32 then
	movlw	32
	subwf	TMRPRES,W
	btfsc	STATUS, Z
	goto	ENDIF104
;IF TMRPres <> 48 then
	movlw	48
	subwf	TMRPRES,W
	btfss	STATUS, Z
;TMRPres = 0
	clrf	TMRPRES
;END IF
;END IF
ENDIF104
;END IF
ENDIF103
;END IF
ENDIF97
;Re-Using TMRPres as TxCON Temp Register
;IF TMR1ON = 1 then Set TMRPres.0 ON  'The timer running/ Dont Stop !
	banksel	T1CON
	btfss	T1CON,TMR1ON
	goto	ENDIF98
	banksel	TMRPRES
	bsf	TMRPRES,0
ENDIF98
;Examine parameter TMRSource
;IF TMRSource = OSC then
	banksel	TMRSOURCE
	decf	TMRSOURCE,W
	btfss	STATUS, Z
	goto	ENDIF99
;TMR1CS1 is TXcon.7 on other chips
;Set TMRPres.7 OFF
	bcf	TMRPRES,7
;Assumes that SOSCEN and OSCEN are always Bit 3
;Set TMRPres.3 OFF
	bcf	TMRPRES,3
;END IF
ENDIF99
;IF TMRSource = EXT then
	movlw	2
	subwf	TMRSOURCE,W
	btfss	STATUS, Z
	goto	ENDIF100
;Set TMRPres.7 ON
	bsf	TMRPRES,7
;Set TMRPres.3 OFF
	bcf	TMRPRES,3
;END IF
ENDIF100
;If TMRSource = ExtOsc Then
	movlw	3
	subwf	TMRSOURCE,W
	btfss	STATUS, Z
	goto	ENDIF101
;Set TMRPres.7 ON
	bsf	TMRPRES,7
;Set TMRPres.3 ON
	bsf	TMRPRES,3
;END IF
ENDIF101
;If TMRSource = LFINTOSC Then
	movlw	4
	subwf	TMRSOURCE,W
	btfss	STATUS, Z
	goto	ENDIF102
;Added to resolve missing clock source  LFINTOSC
;Chip requires TMR1CS1 and TMR1CS0
;Set TMRPres.7 ON
	bsf	TMRPRES,7
;Set TMRPres.6 ON
	bsf	TMRPRES,6
;Set TMRPres.3 OFF
	bcf	TMRPRES,3
;END IF
ENDIF102
;Done building Temp Variable. Now write register
;T1CON = TMRPres
	movf	TMRPRES,W
	banksel	T1CON
	movwf	T1CON
	return

;********************************************************************************

;Overloaded signature: BYTE:
FN_READAD8
;ADFM must be OFF! BACKWARDS Compatbility!
;ADFM should be be changed.
;Always LEFT justified
;SET ADFM OFF
	banksel	ADCON1
	bcf	ADCON1,ADFM
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
;***************************************
;Perform conversion
;LLReadAD 1
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
	goto	ENDIF30
	banksel	ADCON0
	bsf	ADCON0,CHS0
ENDIF30
;IF ADReadPort.1 On Then Set CHS1 On
	banksel	ADREADPORT
	btfss	ADREADPORT,1
	goto	ENDIF31
	banksel	ADCON0
	bsf	ADCON0,CHS1
ENDIF31
;IF ADReadPort.2 On Then Set CHS2 On
	banksel	ADREADPORT
	btfss	ADREADPORT,2
	goto	ENDIF32
	banksel	ADCON0
	bsf	ADCON0,CHS2
ENDIF32
;If ADReadPort.3 On Then Set CHS3 On
	banksel	ADREADPORT
	btfss	ADREADPORT,3
	goto	ENDIF33
	banksel	ADCON0
	bsf	ADCON0,CHS3
ENDIF33
;If ADReadPort.4 On Then Set CHS4 On
	banksel	ADREADPORT
	btfss	ADREADPORT,4
	goto	ENDIF34
	banksel	ADCON0
	bsf	ADCON0,CHS4
ENDIF34
;Enable A/D
;SET ADON ON
	banksel	ADCON0
	bsf	ADCON0,ADON
;Acquisition Delay
;Wait AD_Delay
	movlw	2
	movwf	SysWaitTemp10US
	banksel	STATUS
	pagesel	Delay_10US
	call	Delay_10US
	pagesel	$
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
;Support 8-bit differential reads
;Write output
;As we are ALWAYS LEFT JUSTIFIED just return the ADRESH ignoring ADRESL
;ReadAD = ADRESH
	banksel	ADRESH
	movf	ADRESH,W
	banksel	READAD
	movwf	READAD
;
;SET ADFM OFF
	banksel	ADCON1
	bcf	ADCON1,ADFM
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:
FN_READAD1212
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
SysSelect2Case1
	banksel	ADREADPORT
	movf	ADREADPORT,F
	btfss	STATUS, Z
	goto	SysSelect2Case2
	banksel	ANSELA
	bsf	ANSELA,0
;Case 1: Set ANSELA.1 On
	goto	SysSelectEnd2
SysSelect2Case2
	decf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case3
	banksel	ANSELA
	bsf	ANSELA,1
;Case 2: Set ANSELA.2 On
	goto	SysSelectEnd2
SysSelect2Case3
	movlw	2
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case4
	banksel	ANSELA
	bsf	ANSELA,2
;Case 3: Set ANSELA.3 On
	goto	SysSelectEnd2
SysSelect2Case4
	movlw	3
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case5
	banksel	ANSELA
	bsf	ANSELA,3
;Case 4: Set ANSELA.5 On
	goto	SysSelectEnd2
SysSelect2Case5
	movlw	4
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case6
	banksel	ANSELA
	bsf	ANSELA,5
;Case 12: Set ANSELB.0 On
	goto	SysSelectEnd2
SysSelect2Case6
	movlw	12
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case7
	banksel	ANSELB
	bsf	ANSELB,0
;Case 10: Set ANSELB.1 On
	goto	SysSelectEnd2
SysSelect2Case7
	movlw	10
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case8
	banksel	ANSELB
	bsf	ANSELB,1
;Case 8: Set ANSELB.2 On
	goto	SysSelectEnd2
SysSelect2Case8
	movlw	8
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case9
	banksel	ANSELB
	bsf	ANSELB,2
;Case 9: Set ANSELB.3 On
	goto	SysSelectEnd2
SysSelect2Case9
	movlw	9
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case10
	banksel	ANSELB
	bsf	ANSELB,3
;Case 11: Set ANSELB.4 On
	goto	SysSelectEnd2
SysSelect2Case10
	movlw	11
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case11
	banksel	ANSELB
	bsf	ANSELB,4
;Case 13: Set ANSELB.5 On
	goto	SysSelectEnd2
SysSelect2Case11
	movlw	13
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case12
	banksel	ANSELB
	bsf	ANSELB,5
;Case 14: Set ANSELC.2 On
	goto	SysSelectEnd2
SysSelect2Case12
	movlw	14
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case13
	banksel	ANSELC
	bsf	ANSELC,2
;Case 15: Set ANSELC.3 On
	goto	SysSelectEnd2
SysSelect2Case13
	movlw	15
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case14
	banksel	ANSELC
	bsf	ANSELC,3
;Case 16: Set ANSELC.4 On
	goto	SysSelectEnd2
SysSelect2Case14
	movlw	16
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case15
	banksel	ANSELC
	bsf	ANSELC,4
;Case 17: Set ANSELC.5 On
	goto	SysSelectEnd2
SysSelect2Case15
	movlw	17
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case16
	banksel	ANSELC
	bsf	ANSELC,5
;Case 18: Set ANSELC.6 On
	goto	SysSelectEnd2
SysSelect2Case16
	movlw	18
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case17
	banksel	ANSELC
	bsf	ANSELC,6
;Case 19: Set ANSELC.7 On
	goto	SysSelectEnd2
SysSelect2Case17
	movlw	19
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelectEnd2
	banksel	ANSELC
	bsf	ANSELC,7
;End Select  'End Select #1
SysSelectEnd2
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
	goto	ENDIF35
	banksel	ADCON0
	bsf	ADCON0,CHS0
ENDIF35
;IF ADReadPort.1 On Then Set CHS1 On
	banksel	ADREADPORT
	btfss	ADREADPORT,1
	goto	ENDIF36
	banksel	ADCON0
	bsf	ADCON0,CHS1
ENDIF36
;IF ADReadPort.2 On Then Set CHS2 On
	banksel	ADREADPORT
	btfss	ADREADPORT,2
	goto	ENDIF37
	banksel	ADCON0
	bsf	ADCON0,CHS2
ENDIF37
;If ADReadPort.3 On Then Set CHS3 On
	banksel	ADREADPORT
	btfss	ADREADPORT,3
	goto	ENDIF38
	banksel	ADCON0
	bsf	ADCON0,CHS3
ENDIF38
;If ADReadPort.4 On Then Set CHS4 On
	banksel	ADREADPORT
	btfss	ADREADPORT,4
	goto	ENDIF39
	banksel	ADCON0
	bsf	ADCON0,CHS4
ENDIF39
;Enable A/D
;SET ADON ON
	banksel	ADCON0
	bsf	ADCON0,ADON
;Acquisition Delay
;Wait AD_Delay
	movlw	2
	movwf	SysWaitTemp10US
	banksel	STATUS
	pagesel	Delay_10US
	call	Delay_10US
	pagesel	$
;Read A/D
;SET GO_NOT_DONE ON
	banksel	ADCON0
	bsf	ADCON0,GO_NOT_DONE
;nop
	nop
;Wait While GO_NOT_DONE ON
SysWaitLoop2
	btfsc	ADCON0,GO_NOT_DONE
	goto	SysWaitLoop2
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

SERSEND
;Load configuration data
;if Ser_Select <> Ser_Select_Old then SerCfgLoad(Ser_Select)
	banksel	SER_SELECT_OLD
	movf	SER_SELECT_OLD,W
	subwf	SER_SELECT,W
	btfsc	STATUS, Z
	goto	ENDIF41
	banksel	STATUS
	pagesel	SERCFGLOAD
	call	SERCFGLOAD
	pagesel	$
ENDIF41
;Start bit
;SerTemp = Ser_Start and (not WaitForStart)
	movlw	127
	banksel	SER_START
	andwf	SER_START,W
	banksel	SERTEMP
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
	banksel	SER_INVERT
	movf	SER_INVERT,F
	btfss	STATUS, Z
	goto	ENDIF43
;if Ser_Select = 1 THEN SendALow
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF55
	banksel	LATB
	bcf	LATB,7
ENDIF55
;SerBitDelay
	banksel	STATUS
	pagesel	SERBITDELAY
	call	SERBITDELAY
	pagesel	$
	nop
	nop
	nop
ENDIF43
;if Ser_Invert = invert then SerTxHigh: NOP: NOP  'fst
	banksel	SER_INVERT
	decf	SER_INVERT,W
	btfss	STATUS, Z
	goto	ENDIF44
;if Ser_Select = 1 THEN SendAHigh
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF56
	banksel	LATB
	bsf	LATB,7
ENDIF56
;SerBitDelay
	banksel	STATUS
	pagesel	SERBITDELAY
	call	SERBITDELAY
	pagesel	$
	nop
	nop
ENDIF44
;next
	banksel	SERTEMP
	movf	SERTEMP,W
	subwf	SERBIT,W
	btfss	STATUS, C
	goto	SysForLoop1
SysForLoopEnd1
;Data bits
;TempParity = SerTemp
	movf	SERTEMP,W
	banksel	TEMPPARITY
	movwf	TEMPPARITY
;for SerBit = 1 to Ser_Data
	banksel	SERBIT
	clrf	SERBIT
	movlw	1
	banksel	SER_DATA
	subwf	SER_DATA,W
	btfss	STATUS, C
	goto	SysForLoopEnd2
SysForLoop2
	banksel	SERBIT
	incf	SERBIT,F
;if Ser_Invert = normal then
	banksel	SER_INVERT
	movf	SER_INVERT,F
	btfss	STATUS, Z
	goto	ENDIF47
;if Ser_Byte.0 ON then SerTxHigh: TempParity = TempParity + 1
	btfss	SER_BYTE,0
	goto	ENDIF57
;if Ser_Select = 1 THEN SendAHigh
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF67
	banksel	LATB
	bsf	LATB,7
ENDIF67
;SerBitDelay
	banksel	STATUS
	pagesel	SERBITDELAY
	call	SERBITDELAY
	pagesel	$
	banksel	TEMPPARITY
	incf	TEMPPARITY,F
ENDIF57
;if Ser_Byte.0 OFF then SerTxLow: nop: nop: nop: nop: nop: nop: nop
	btfsc	SER_BYTE,0
	goto	ENDIF58
;if Ser_Select = 1 THEN SendALow
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF68
	banksel	LATB
	bcf	LATB,7
ENDIF68
;SerBitDelay
	banksel	STATUS
	pagesel	SERBITDELAY
	call	SERBITDELAY
	pagesel	$
	nop
	nop
	nop
	nop
	nop
	nop
	nop
ENDIF58
;end if
ENDIF47
;if Ser_Invert = invert then
	banksel	SER_INVERT
	decf	SER_INVERT,W
	btfss	STATUS, Z
	goto	ENDIF48
;if Ser_Byte.0 ON then SerTxLow: TempParity = TempParity + 1
	btfss	SER_BYTE,0
	goto	ENDIF59
;if Ser_Select = 1 THEN SendALow
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF69
	banksel	LATB
	bcf	LATB,7
ENDIF69
;SerBitDelay
	banksel	STATUS
	pagesel	SERBITDELAY
	call	SERBITDELAY
	pagesel	$
	banksel	TEMPPARITY
	incf	TEMPPARITY,F
ENDIF59
;if Ser_Byte.0 OFF then SerTxHigh: nop: nop: nop: nop: nop: nop: nop
	btfsc	SER_BYTE,0
	goto	ENDIF60
;if Ser_Select = 1 THEN SendAHigh
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF70
	banksel	LATB
	bsf	LATB,7
ENDIF70
;SerBitDelay
	banksel	STATUS
	pagesel	SERBITDELAY
	call	SERBITDELAY
	pagesel	$
	nop
	nop
	nop
	nop
	nop
	nop
	nop
ENDIF60
;end if
ENDIF48
;rotate Ser_Byte right
	banksel	SER_BYTE
	rrf	SER_BYTE,F
;next
	movf	SER_DATA,W
	banksel	SERBIT
	subwf	SERBIT,W
	btfss	STATUS, C
	goto	SysForLoop2
SysForLoopEnd2
;Parity Bit
;if Ser_Parity <> 0 THEN
	banksel	SER_PARITY
	movf	SER_PARITY,F
	btfsc	STATUS, Z
	goto	ENDIF50
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
	goto	ENDIF63
;if Ser_Select = 1 THEN SendALow
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF71
	banksel	LATB
	bcf	LATB,7
ENDIF71
;SerBitDelay
	banksel	STATUS
	pagesel	SERBITDELAY
	call	SERBITDELAY
	pagesel	$
ENDIF63
;if TempParity.0 = OFF then SerTxHigh
	banksel	TEMPPARITY
	btfsc	TEMPPARITY,0
	goto	ENDIF64
;if Ser_Select = 1 THEN SendAHigh
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF72
	banksel	LATB
	bsf	LATB,7
ENDIF72
;SerBitDelay
	banksel	STATUS
	pagesel	SERBITDELAY
	call	SERBITDELAY
	pagesel	$
ENDIF64
;end if
ENDIF50
;Stop Bit(s)
;for SerBit = 1 to Ser_Stop
	banksel	SERBIT
	clrf	SERBIT
	movlw	1
	banksel	SER_STOP
	subwf	SER_STOP,W
	btfss	STATUS, C
	goto	SysForLoopEnd3
SysForLoop3
	banksel	SERBIT
	incf	SERBIT,F
;if Ser_Invert = normal then SerTxHigh   'fst
	banksel	SER_INVERT
	movf	SER_INVERT,F
	btfss	STATUS, Z
	goto	ENDIF52
;if Ser_Select = 1 THEN SendAHigh
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF65
	banksel	LATB
	bsf	LATB,7
ENDIF65
;SerBitDelay
	banksel	STATUS
	pagesel	SERBITDELAY
	call	SERBITDELAY
	pagesel	$
ENDIF52
;if Ser_Invert = invert then SerTxLow    'fst
	banksel	SER_INVERT
	decf	SER_INVERT,W
	btfss	STATUS, Z
	goto	ENDIF53
;if Ser_Select = 1 THEN SendALow
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF66
	banksel	LATB
	bcf	LATB,7
ENDIF66
;SerBitDelay
	banksel	STATUS
	pagesel	SERBITDELAY
	call	SERBITDELAY
	pagesel	$
ENDIF53
;next
	banksel	SER_STOP
	movf	SER_STOP,W
	banksel	SERBIT
	subwf	SERBIT,W
	btfss	STATUS, C
	goto	SysForLoop3
SysForLoopEnd3
;Extra delay at end (adds extra stop bit)
;SerBitDelay
	banksel	STATUS
	pagesel	SERBITDELAY
	goto	SERBITDELAY

;********************************************************************************

;Start of program memory page 1
	ORG	2048
CALL_MEAS_B1_B2
;StopTimer 1
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER
	banksel	STATUS
	call	STOPTIMER
;repeat 256
	banksel	SYSREPEATTEMP4
	clrf	SysRepeatTemp4
	movlw	1
	movwf	SysRepeatTemp4_H
SysRepeatLoop4
;repeat 128
;Bult1 = ReadAD12(AN3)
	movlw	3
	banksel	ADREADPORT
	movwf	ADREADPORT
	pagesel	FN_READAD1212
	call	FN_READAD1212
	pagesel	$
	movf	SYSREADAD12WORD,W
	movwf	BULT1
	movf	SYSREADAD12WORD_H,W
	movwf	BULT1_H
	clrf	BULT1_U
	clrf	BULT1_E
;Bult2 = ReadAD12(AN2)
	movlw	2
	movwf	ADREADPORT
	pagesel	FN_READAD1212
	call	FN_READAD1212
	pagesel	$
	movf	SYSREADAD12WORD,W
	movwf	BULT2
	movf	SYSREADAD12WORD_H,W
	movwf	BULT2_H
	clrf	BULT2_U
	clrf	BULT2_E
;A_Bult1 = A_Bult1 + Bult1
	movf	BULT1,W
	addwf	A_BULT1,F
	movf	BULT1_H,W
	addwfc	A_BULT1_H,F
	movf	BULT1_U,W
	addwfc	A_BULT1_U,F
	movf	BULT1_E,W
	addwfc	A_BULT1_E,F
;A_Bult2 = A_Bult2 + Bult2
	movf	BULT2,W
	addwf	A_BULT2,F
	movf	BULT2_H,W
	addwfc	A_BULT2_H,F
	movf	BULT2_U,W
	addwfc	A_BULT2_U,F
	movf	BULT2_E,W
	addwfc	A_BULT2_E,F
;End Repeat
	banksel	SYSREPEATTEMP4
	decfsz	SysRepeatTemp4,F
	goto	SysRepeatLoop4
	decfsz	SysRepeatTemp4_H,F
	goto	SysRepeatLoop4
SysRepeatLoopEnd4
;B_Bult1 = A_Bult1 / 16
	banksel	A_BULT1
	movf	A_BULT1,W
	movwf	SysLONGTempA
	movf	A_BULT1_H,W
	movwf	SysLONGTempA_H
	movf	A_BULT1_U,W
	movwf	SysLONGTempA_U
	movf	A_BULT1_E,W
	movwf	SysLONGTempA_E
	movlw	16
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SysDivSub32
	movf	SysLONGTempA,W
	movwf	B_BULT1
	movf	SysLONGTempA_H,W
	movwf	B_BULT1_H
	movf	SysLONGTempA_U,W
	movwf	B_BULT1_U
	movf	SysLONGTempA_E,W
	movwf	B_BULT1_E
;B_Bult2 = A_Bult2 / 16
	movf	A_BULT2,W
	movwf	SysLONGTempA
	movf	A_BULT2_H,W
	movwf	SysLONGTempA_H
	movf	A_BULT2_U,W
	movwf	SysLONGTempA_U
	movf	A_BULT2_E,W
	movwf	SysLONGTempA_E
	movlw	16
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SysDivSub32
	movf	SysLONGTempA,W
	movwf	B_BULT2
	movf	SysLONGTempA_H,W
	movwf	B_BULT2_H
	movf	SysLONGTempA_U,W
	movwf	B_BULT2_U
	movf	SysLONGTempA_E,W
	movwf	B_BULT2_E
;A_Bult1 = 0
	clrf	A_BULT1
	clrf	A_BULT1_H
	clrf	A_BULT1_U
	clrf	A_BULT1_E
;A_Bult2 = 0
	clrf	A_BULT2
	clrf	A_BULT2_H
	clrf	A_BULT2_U
	clrf	A_BULT2_E
;Call_Diff
;Call_Ntc
;StartTimer 1
	movlw	1
	banksel	TMRNUMBER
	movwf	TMRNUMBER
	banksel	STATUS
	goto	STARTTIMER

;********************************************************************************

CALL_NTC
;Ntc = ReadAD(AN12)
	movlw	12
	movwf	ADREADPORT
	pagesel	FN_READAD8
	call	FN_READAD8
	pagesel	$
	movf	SYSREADADBYTE,W
	movwf	NTC
	clrf	NTC_H
;NtcX = ReadAD(AN12)
	movlw	12
	movwf	ADREADPORT
	pagesel	FN_READAD8
	call	FN_READAD8
	pagesel	$
	movf	SYSREADADBYTE,W
	movwf	NTCX
	clrf	NTCX_H
;NtcAverage = (NtcX + Ntc) / 2
	movf	NTC,W
	addwf	NTCX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	NTC_H
	movf	NTC_H,W
	addwfc	NTCX_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movf	SysTemp1,W
	movwf	SysWORDTempA
	movf	SysTemp1_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	call	SysDivSub16
	movf	SysWORDTempA,W
	movwf	NTCAVERAGE
	movf	SysWORDTempA_H,W
	movwf	NTCAVERAGE_H
;Ntc = NtcAverage
	movf	NTCAVERAGE,W
	movwf	NTC
	movf	NTCAVERAGE_H,W
	movwf	NTC_H
;SerSend 1, 254  ' "kommando"
	movlw	1
	banksel	SER_SELECT
	movwf	SER_SELECT
	movlw	254
	movwf	SER_BYTE
	banksel	STATUS
	pagesel	SERSEND
	call	SERSEND
	pagesel	$
;SerSend 1, 1  ' "Clr"
	movlw	1
	banksel	SER_SELECT
	movwf	SER_SELECT
	movlw	1
	movwf	SER_BYTE
	banksel	STATUS
	pagesel	SERSEND
	call	SERSEND
	pagesel	$
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;SerPrint 1, "T:"
	movlw	1
	banksel	SER_SELECT
	movwf	SER_SELECT
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable1
	movwf	SysStringA
	movlw	(high StringTable1) & 127
	movwf	SysStringA_H
	banksel	STATUS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	SERPRINT42
;SerPrint 1, Ntc
	movlw	1
	banksel	SER_SELECT
	movwf	SER_SELECT
	banksel	NTC
	movf	NTC,W
	movwf	SERPRINTVAL
	movf	NTC_H,W
	movwf	SERPRINTVAL_H
	call	SERPRINT44
;rds6 = (255-Ntc) * 3 + 227
;if ntc < 243 Then rds6 = rds6 - (243 - Ntc)
;rds6 = (255-Ntc) * 3 + 227
	movf	NTC,W
	sublw	255
	banksel	SYSTEMP1
	movwf	SysTemp1
	clrf	SysTemp2
	banksel	NTC_H
	movf	NTC_H,W
	banksel	SYSTEMP2
	subwfb	SysTemp2,W
	movwf	SysTemp1_H
	movf	SysTemp1,W
	movwf	SysWORDTempA
	movf	SysTemp1_H,W
	movwf	SysWORDTempA_H
	movlw	3
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	call	SysMultSub16
	movlw	227
	addwf	SysWORDTempX,W
	movwf	RDS6
	movlw	0
	addwfc	SysWORDTempX_H,W
	movwf	RDS6_H
;if ntc < 225 Then rds6 = rds6 - (243 - Ntc)
;if ntc < 205 Then rds6 = rds6 - (243 - Ntc)
	movf	NTC,W
	movwf	SysWORDTempA
	movf	NTC_H,W
	movwf	SysWORDTempA_H
	movlw	205
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0
	goto	ENDIF27
	movf	NTC,W
	sublw	243
	banksel	SYSTEMP1
	movwf	SysTemp1
	clrf	SysTemp2
	banksel	NTC_H
	movf	NTC_H,W
	banksel	SYSTEMP2
	subwfb	SysTemp2,W
	movwf	SysTemp1_H
	movf	SysTemp1,W
	banksel	RDS6
	subwf	RDS6,F
	banksel	SYSTEMP1_H
	movf	SysTemp1_H,W
	banksel	RDS6_H
	subwfb	RDS6_H,F
ENDIF27
;if ntc < 242 Then rds6 = (255-Ntc) * 3 + 227 - 1
;if ntc < 239 Then rds6 = (255-Ntc) * 3 +    Case  150 To 165: rds6 = 350 '120°C 390
;Case  178 To 193: rds6 = 330 '100°C 312
;Case  194 To 205: rds6 = 320 '90°C  273
;Case  206 To 216: rds6 = 310 '80°C  234
;Case  217 To 225: rds6 = 300 '70°C  195
;Case  225 : rds6 = 311 ' 60
;Case  226 : rds6 = 308 ' 59
;Case  227 : rds6 = 305 ' 58
;Case  228 : rds6 = 302 ' 56 - 57
;Case  229 : rds6 = 299 ' 55
;Case  230 : rds6 = 296 ' 54
;Case  231 : rds6 = 293 ' 52 - 53
;Case  232 : rds6 = 290 ' 51
;Case  233 : rds6 = 287 ' 50
;Case  234 : rds6 = 284 ' 48 - 49       :Cu = 12
;Case  235 : rds6 = 281 ' 46 - 47
;Case  236 : rds6 = 278 ' 45
;Case  238 : rds6 = 272 ' 41 - 42
;Case  239 : rds6 = 267 ' 39 - 40
;Case  240 : rds6 = 263 ' 38            :Cu = 8
;Case  241 : rds6 = 260 ' 35 - 37
;Case  242 : rds6 = 260 ' 33 - 34
;Case  243 : rds6 = 256 ' 31 - 32
;Case  244 : rds6 = 256 ' 28 - 30
;Case  245 : rds6 = 256 ' 26 - 27
;Case  246 : rds6 = 255 ' 23 - 25       :Cu = 4
;Case  247 : rds6 = 252 ' 20 - 22
;Case  248 : rds6 = 249 ' 16 - 19       :Cu = 1
;Case  249 : rds6 = 246 ' 12 - 15
;Case  250 : rds6 = 243 ' 7 - 11
;Case  251 : rds6 = 240 ' 1 - 6         :Cu = 4
;Case  252 : rds6 = 236 ' -6 till 0
;Case  253 : rds6 = 233 ' -16 till -7   :Cu = 8
;Case  254 : rds6 = 230 ' -36 till -17
;Case  255 : rds6 = 227 ' -37
;End Select
	return

;********************************************************************************

CLEARTIMER
;if TMRNumber = 0 then  TMR0 = 0
	banksel	TMRNUMBER
	movf	TMRNUMBER,F
	btfss	STATUS, Z
	goto	ENDIF92
	banksel	TMR0
	clrf	TMR0
ENDIF92
;If TMRNumber = 1 Then
	banksel	TMRNUMBER
	decf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF93
;TMR1H = 0
	banksel	TMR1H
	clrf	TMR1H
;TMR1L = 0
	clrf	TMR1L
;End If
ENDIF93
;If TMRNumber = 2 Then TMR2 = 0
	movlw	2
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF94
	banksel	TMR2
	clrf	TMR2
ENDIF94
	banksel	STATUS
	return

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

Delay_S
DS_START
	movlw	232
	movwf	SysWaitTempMS
	movlw	3
	movwf	SysWaitTempMS_H
	call	Delay_MS
	decfsz	SysWaitTempS, F
	goto	DS_START
	return

;********************************************************************************

INITSER
;This sub sets configuration of the serial routines
;Sample usage for communication with Lego RCX:
;InitSer(1,r2400,1,8,1,odd,invert)
;Ser_Select_Old = Ser_Select
	banksel	SER_SELECT
	movf	SER_SELECT,W
	movwf	SER_SELECT_OLD
;if Ser_Select = 1 THEN
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF40
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
ENDIF40
;ensure lines are settled
;wait SerialInitDelay ms
	movlw	5
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	goto	Delay_MS

;********************************************************************************

SERBITDELAY
;Predefined rates (more accurate)
;All delays have 10 us taken off to allow processing time
;if Ser_Rate = 1 then Wait SerFullDelay19200 us: exit sub  '19200 (52 us)
	banksel	SER_RATE
	decf	SER_RATE,W
	btfss	STATUS, Z
	goto	ENDIF81
	movlw	22
	movwf	DELAYTEMP
DelayUS1
	decfsz	DELAYTEMP,F
	goto	DelayUS1
	nop
	banksel	STATUS
	return
ENDIF81
;if Ser_Rate = 2 then Wait SerFullDelay9600 us: exit sub   '9600 (104 us)
	movlw	2
	subwf	SER_RATE,W
	btfss	STATUS, Z
	goto	ENDIF82
	movlw	55
	movwf	DELAYTEMP
DelayUS2
	decfsz	DELAYTEMP,F
	goto	DelayUS2
	banksel	STATUS
	return
ENDIF82
;if Ser_Rate = 4 then Wait SerFullDelay4800 us: exit sub   '4800 (208 us)
	movlw	4
	subwf	SER_RATE,W
	btfss	STATUS, Z
	goto	ENDIF83
	movlw	122
	movwf	DELAYTEMP
DelayUS3
	decfsz	DELAYTEMP,F
	goto	DelayUS3
	nop
	banksel	STATUS
	return
ENDIF83
;if Ser_Rate = 8 then Wait SerFullDelay2400 us: exit sub   '2400 (417 us)
	movlw	8
	subwf	SER_RATE,W
	btfss	STATUS, Z
	goto	ENDIF84
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
	banksel	STATUS
	return
ENDIF84
;if Ser_Rate = 16 then Wait SerFullDelay1200 us: exit sub  '1200 (833 us)
	movlw	16
	subwf	SER_RATE,W
	btfss	STATUS, Z
	goto	ENDIF85
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
	banksel	STATUS
	return
ENDIF85
;if Ser_Rate = 32 then Wait SerFullDelay600 us: exit sub   '600 (1666 us)
	movlw	32
	subwf	SER_RATE,W
	btfss	STATUS, Z
	goto	ENDIF86
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
	banksel	STATUS
	return
ENDIF86
;if Ser_Rate = 64 then Wait SerFullDelay300 us: exit sub '300 (3333 us)
	movlw	64
	subwf	SER_RATE,W
	btfss	STATUS, Z
	goto	ENDIF87
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
	banksel	STATUS
	return
ENDIF87
;Other rates
;for SerDelayLoop = 1 to Ser_Rate
	banksel	SERDELAYLOOP
	clrf	SERDELAYLOOP
	movlw	1
	banksel	SER_RATE
	subwf	SER_RATE,W
	btfss	STATUS, C
	goto	SysForLoopEnd5
SysForLoop5
	banksel	SERDELAYLOOP
	incf	SERDELAYLOOP,F
;Wait 42 us
	movlw	28
	movwf	DELAYTEMP
DelayUS12
	decfsz	DELAYTEMP,F
	goto	DelayUS12
;next
	banksel	SER_RATE
	movf	SER_RATE,W
	banksel	SERDELAYLOOP
	subwf	SERDELAYLOOP,W
	btfss	STATUS, C
	goto	SysForLoop5
SysForLoopEnd5
	banksel	STATUS
	return

;********************************************************************************

SERCFGLOAD
;Ser_Select_Old = Ser_Select
	banksel	SER_SELECT
	movf	SER_SELECT,W
	movwf	SER_SELECT_OLD
;if Ser_Select = 1 THEN
	decf	SER_SELECT,W
	btfss	STATUS, Z
	goto	ENDIF80
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
ENDIF80
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:STRING:
SERPRINT42
;PrintLen = LEN(PrintData$)
;PrintLen = PrintData(0)
	banksel	SYSPRINTDATAHANDLER
	movf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	PRINTLEN
	movwf	PRINTLEN
;if PrintLen = 0 then Goto SerPrintStrEnd
	movf	PRINTLEN,F
	btfsc	STATUS, Z
	goto	SERPRINTSTREND
;Write Data
;for SysPrintTemp = 1 to PrintLen
	banksel	SYSPRINTTEMP
	clrf	SYSPRINTTEMP
	movlw	1
	banksel	PRINTLEN
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd4
SysForLoop4
	banksel	SYSPRINTTEMP
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
	banksel	STATUS
	pagesel	SERSEND
	call	SERSEND
	pagesel	$
;next
	movf	PRINTLEN,W
	banksel	SYSPRINTTEMP
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop4
SysForLoopEnd4
;CR
SERPRINTSTREND
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:WORD:
SERPRINT44
;Dim SysCalcTempX As Word
;OutValueTemp = 0
	clrf	OUTVALUETEMP
;If SerPrintVal >= 10000 then
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF76
;OutValueTemp = SerPrintVal / 10000 [word]
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPX_H,W
	movwf	SERPRINTVAL_H
;SerSend(Ser_Select, OutValueTemp + 48)
	movlw	48
	addwf	OUTVALUETEMP,W
	banksel	SER_BYTE
	movwf	SER_BYTE
	banksel	STATUS
	pagesel	SERSEND
	call	SERSEND
	pagesel	$
;Goto SerPrintWord1000
	goto	SERPRINTWORD1000
;End If
ENDIF76
;If SerPrintVal >= 1000 then
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF77
SERPRINTWORD1000
;OutValueTemp = SerPrintVal / 1000 [word]
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPX_H,W
	movwf	SERPRINTVAL_H
;SerSend(Ser_Select, OutValueTemp + 48)
	movlw	48
	addwf	OUTVALUETEMP,W
	banksel	SER_BYTE
	movwf	SER_BYTE
	banksel	STATUS
	pagesel	SERSEND
	call	SERSEND
	pagesel	$
;Goto SerPrintWord100
	goto	SERPRINTWORD100
;End If
ENDIF77
;If SerPrintVal >= 100 then
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF78
SERPRINTWORD100
;OutValueTemp = SerPrintVal / 100 [word]
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPX_H,W
	movwf	SERPRINTVAL_H
;SerSend(Ser_Select, OutValueTemp + 48)
	movlw	48
	addwf	OUTVALUETEMP,W
	banksel	SER_BYTE
	movwf	SER_BYTE
	banksel	STATUS
	pagesel	SERSEND
	call	SERSEND
	pagesel	$
;Goto SerPrintWord10:
	goto	SERPRINTWORD10
;End If
ENDIF78
;If SerPrintVal >= 10 then
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF79
SERPRINTWORD10
;OutValueTemp = SerPrintVal / 10 [word]
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPX_H,W
	movwf	SERPRINTVAL_H
;SerSend(Ser_Select, OutValueTemp + 48)
	movlw	48
	addwf	OUTVALUETEMP,W
	banksel	SER_BYTE
	movwf	SER_BYTE
	banksel	STATUS
	pagesel	SERSEND
	call	SERSEND
	pagesel	$
;End If
ENDIF79
;SerSend(Ser_Select, SerPrintVal + 48)
	movlw	48
	addwf	SERPRINTVAL,W
	banksel	SER_BYTE
	movwf	SER_BYTE
	banksel	STATUS
	pagesel	SERSEND
	call	SERSEND
	pagesel	$
;CR
	return

;********************************************************************************

STARTTIMER
;IF TMRNumber = 1 then Set TMR1ON on
	banksel	TMRNUMBER
	decf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF90
	banksel	T1CON
	bsf	T1CON,TMR1ON
ENDIF90
;IF TMRNumber = 2 then Set TMR2ON on
	movlw	2
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF91
	banksel	T2CON
	bsf	T2CON,TMR2ON
ENDIF91
	banksel	STATUS
	return

;********************************************************************************

STOPTIMER
;Timer 0 always runs
;Note: Not Always!  Timer 0 on 18F Can be stopped/started
;If TMRNumber = 1 Then Set TMR1ON OFF
	banksel	TMRNUMBER
	decf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF95
	banksel	T1CON
	bcf	T1CON,TMR1ON
ENDIF95
;If TMRNumber = 2 Then Set TMR2ON OFF
	movlw	2
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF96
	banksel	T2CON
	bcf	T2CON,TMR2ON
ENDIF96
	banksel	STATUS
	return

;********************************************************************************

SYSCOMPEQUAL16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test low, exit if false
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W
;subwf SysWordTempB, W
	subwf	SYSWORDTEMPB, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test high, exit if false
;movf SysWordTempA_H, W
	movf	SYSWORDTEMPA_H, W
;subwf SysWordTempB_H, W
	subwf	SYSWORDTEMPB_H, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

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

SYSCOMPLESSTHAN
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;bsf STATUS, C
	bsf	STATUS, C
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W
;subwf SysByteTempA, W
	subwf	SYSBYTETEMPA, W
;btfss STATUS, C
	btfss	STATUS, C
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

SYSCOMPLESSTHAN16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test High, exit if more
;movf SysWordTempA_H,W
	movf	SYSWORDTEMPA_H,W
;subwf SysWordTempB_H,W
	subwf	SYSWORDTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;Test high, exit true if less
;movf SysWordTempB_H,W
	movf	SYSWORDTEMPB_H,W
;subwf SysWordTempA_H,W
	subwf	SYSWORDTEMPA_H,W
;btfss STATUS,C
	btfss	STATUS,C
;goto SCLT16True
	goto	SCLT16TRUE
;Test Low, exit if more or equal
;movf SysWordTempB,W
	movf	SYSWORDTEMPB,W
;subwf SysWordTempA,W
	subwf	SYSWORDTEMPA,W
;btfsc STATUS,C
	btfsc	STATUS,C
;return
	return
SCLT16TRUE
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

SYSDIVSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	movf	SYSWORDTEMPA,W
	movwf	SYSDIVMULTA
	movf	SYSWORDTEMPA_H,W
	movwf	SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	movf	SYSWORDTEMPB,W
	movwf	SYSDIVMULTB
	movf	SYSWORDTEMPB_H,W
	movwf	SYSDIVMULTB_H
;SysDivMultX = 0
	clrf	SYSDIVMULTX
	clrf	SYSDIVMULTX_H
;Avoid division by zero
;if SysDivMultB = 0 then
	movf	SYSDIVMULTB,W
	movwf	SysWORDTempA
	movf	SYSDIVMULTB_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompEqual16
	btfss	SysByteTempX,0
	goto	ENDIF110
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF110
;Main calc routine
;SysDivLoop = 16
	movlw	16
	movwf	SYSDIVLOOP
SYSDIV16START
;set C off
	bcf	STATUS,C
;Rotate SysDivMultA Left
	rlf	SYSDIVMULTA,F
	rlf	SYSDIVMULTA_H,F
;Rotate SysDivMultX Left
	rlf	SYSDIVMULTX,F
	rlf	SYSDIVMULTX_H,F
;SysDivMultX = SysDivMultX - SysDivMultB
	movf	SYSDIVMULTB,W
	subwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	subwfb	SYSDIVMULTX_H,F
;Set SysDivMultA.0 On
	bsf	SYSDIVMULTA,0
;If C Off Then
	btfsc	STATUS,C
	goto	ENDIF111
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF111
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv16Start
	goto	SYSDIV16START
;SysWordTempA = SysDivMultA
	movf	SYSDIVMULTA,W
	movwf	SYSWORDTEMPA
	movf	SYSDIVMULTA_H,W
	movwf	SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	movf	SYSDIVMULTX,W
	movwf	SYSWORDTEMPX
	movf	SYSDIVMULTX_H,W
	movwf	SYSWORDTEMPX_H
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
	banksel	SYSLONGDIVMULTA
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
	banksel	STATUS
	call	SysCompEqual32
	btfss	SysByteTempX,0
	goto	ENDIF112
;SysLongTempA = 0
	clrf	SYSLONGTEMPA
	clrf	SYSLONGTEMPA_H
	clrf	SYSLONGTEMPA_U
	clrf	SYSLONGTEMPA_E
;exit sub
	return
;end if
ENDIF112
;Main calc routine
;SysDivLoop = 32
	movlw	32
	movwf	SYSDIVLOOP
SYSDIV32START
;set C off
	bcf	STATUS,C
;Rotate SysLongDivMultA Left
	banksel	SYSLONGDIVMULTA
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
	goto	ENDIF113
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
ENDIF113
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
	banksel	STATUS
	return

;********************************************************************************

SYSMULTSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	movf	SYSWORDTEMPA,W
	movwf	SYSDIVMULTA
	movf	SYSWORDTEMPA_H,W
	movwf	SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	movf	SYSWORDTEMPB,W
	movwf	SYSDIVMULTB
	movf	SYSWORDTEMPB_H,W
	movwf	SYSDIVMULTB_H
;SysDivMultX = 0
	clrf	SYSDIVMULTX
	clrf	SYSDIVMULTX_H
MUL16LOOP
;IF SysDivMultB.0 ON then SysDivMultX += SysDivMultA
	btfss	SYSDIVMULTB,0
	goto	ENDIF106
	movf	SYSDIVMULTA,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTA_H,W
	addwfc	SYSDIVMULTX_H,F
ENDIF106
;set STATUS.C OFF
	bcf	STATUS,C
;rotate SysDivMultB right
	rrf	SYSDIVMULTB_H,F
	rrf	SYSDIVMULTB,F
;set STATUS.C off
	bcf	STATUS,C
;rotate SysDivMultA left
	rlf	SYSDIVMULTA,F
	rlf	SYSDIVMULTA_H,F
;if SysDivMultB > 0 then goto MUL16LOOP
	movf	SYSDIVMULTB,W
	movwf	SysWORDTempB
	movf	SYSDIVMULTB_H,W
	movwf	SysWORDTempB_H
	clrf	SysWORDTempA
	clrf	SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	MUL16LOOP
;SysWordTempX = SysDivMultX
	movf	SYSDIVMULTX,W
	movwf	SYSWORDTEMPX
	movf	SYSDIVMULTX_H,W
	movwf	SYSWORDTEMPX_H
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
	banksel	SYSLONGDIVMULTA
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
	banksel	SYSLONGDIVMULTB
	btfss	SYSLONGDIVMULTB,0
	goto	ENDIF108
	movf	SYSLONGDIVMULTA,W
	addwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTA_H,W
	addwfc	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTA_U,W
	addwfc	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTA_E,W
	addwfc	SYSLONGDIVMULTX_E,F
ENDIF108
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
	banksel	STATUS
	call	SysCompLessThan32
	btfsc	SysByteTempX,0
	goto	MUL32LOOP
;SysLongTempX = SysLongDivMultX
	banksel	SYSLONGDIVMULTX
	movf	SYSLONGDIVMULTX,W
	movwf	SYSLONGTEMPX
	movf	SYSLONGDIVMULTX_H,W
	movwf	SYSLONGTEMPX_H
	movf	SYSLONGDIVMULTX_U,W
	movwf	SYSLONGTEMPX_U
	movf	SYSLONGDIVMULTX_E,W
	movwf	SYSLONGTEMPX_E
	banksel	STATUS
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
	retlw	2
	retlw	84	;T
	retlw	58	;:


StringTable2
	retlw	3
	retlw	32	; 
	retlw	68	;D
	retlw	58	;:


;********************************************************************************

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
