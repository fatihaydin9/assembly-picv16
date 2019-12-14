; KODLAMA SABLONU

	list		p=16f877A		; hangi pic
	#include	<p16f877A.inc>	; SFR register 'lar?n tan?mland??? kutuphane
	ORG 0X00

SAYAC	EQU 0x20   


BASLA
	BANKSEL TRISB
	MOVLW d'0'
	MOVWF TRISB
	BANKSEL PORTB
	MOVLW b'01010101'
	MOVWF SAYAC

SAYDIR 
	COMF SAYAC,F
	MOVFW SAYAC
	MOVWF PORTB
	GOTO SAYDIR


	END                       ; Program sonu


