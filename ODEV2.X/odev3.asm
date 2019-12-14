;2 adet 7-segment display kullanarak 0-59 aras?nda saniye-saniye sürekli sayan
;59 olunca tekrar 0 dan saymaya ba?layan program? yaz?n?z.  
;2 adet 7-Segment display in data pinleri PORTB ye ve seçme uçlar? 
;PORTA n?n en anlams?z iki bitine ba?l?d?r. 
;Not : i?lemcinin Fosc = 4 MHz dir ve TIMER kesmeleri kullan?lmak zorundad?r. 
	
list p = 16f877a
#include<p16f877a.inc>
    
__CONFIG H'3F31'			;ayarlamalar

SAG	EQU	0X20			;kullanilacak degiskenler
SOL	EQU	0X21
LTEMP	EQU	0X22
TMRS	EQU	0x23
DEG1   EQU	0X24
DEG2   EQU	0X25

w_temp		EQU	0x7D		;shadow temporary degiskenler
status_temp	EQU	0x7E		
pclath_temp	EQU	0x7F 
	
ORG 0X000
NOP
GOTO ON_AYARLAR
	
ORG 0X004
KESME
	MOVWF   w_temp            	; yedek_wreg
	MOVF	STATUS,w          	; yedek_status
	MOVWF	status_temp       	
	MOVF	PCLATH,w	  	; yedek_pclath
	MOVWF	pclath_temp	  	
	
	BCF PIR1,0			;bayragi indir
	MOVLW 0X0B
	MOVWF TMR1H
	MOVLW 0XDB
	MOVWF TMR1L
	
	INCF TMRS,F
	MOVLW D'2'
	BCF STATUS,Z
	SUBWF TMRS,W
	BTFSS STATUS,Z
	GOTO DONUS
	
	
	CLRF TMRS
	MOVLW 0X02
	MOVWF PORTA
	MOVFW SAG
	CALL LOOK_UP
	MOVWF PORTB
	CALL  GECIKME
	
	MOVLW 0X01
	MOVWF PORTA
	MOVFW SOL
	CALL LOOK_UP
	MOVWF PORTB
	CALL GECIKME 

	INCF SAG,F
	MOVLW D'10'
	SUBWF SAG,W
	BTFSC STATUS,Z
	CALL SOL_ARTIR
	
	GOTO DONUS
	

DONUS
	MOVF	 pclath_temp,w	;yedekleri geri yukle
	MOVWF	 PCLATH		  		
	MOVF    status_temp,w     	
	MOVWF	 STATUS            	
	SWAPF	 w_temp,f
	SWAPF   w_temp,w 
	RETFIE     
	

ON_AYARLAR
	MOVLW 0X08
	MOVWF DEG1
    
	MOVLW 0X03
	MOVWF DEG2
	
	BANKSEL TRISB
	CLRF TRISB
	MOVLW 0X06
	MOVWF ADCON1		    ;A portu dijital olarak ayarlandi
	CLRF  TRISA		    ;A portu cikis olarak ayarlandi
	BSF PIE1,TMR1IE	    ;interrupt enable biti aktif
	
	BANKSEL PORTA
	
	MOVLW 0X00
	MOVWF SOL
	MOVWF SAG
	CALL  LOOK_UP
	MOVWF PORTB

	MOVLW b'00110000'	    ;preskaler ayari
	MOVWF T1CON		    ;timer1 preskaler
	BSF T1CON,0		    ;tmr1 aktif edildi
	CLRF TMRS		    ;sayaci sifirlayalim
	
	MOVLW 0X0B
	MOVWF TMR1H
	MOVLW 0XDB
	MOVWF TMR1L
	
	BSF INTCON,GIE
	BSF INTCON,PEIE

CALIS		
	GOTO CALIS
	
LOOK_UP
	ADDWF	PCL,F
	RETLW	0x3F
	RETLW	0x06
	RETLW	0x5B
	RETLW	0x4F
	RETLW	0x66
	RETLW	0x6D
	RETLW	0x7D
	RETLW	0x07
	RETLW	0x7F
	RETLW	0x6F
	
GECIKME
	DECFSZ DEG1,F
	GOTO DEG2AZALT
	MOVLW 0X08
	MOVWF DEG1
	MOVLW 0X03
	MOVWF DEG2
	RETURN
	
DEG2AZALT
	DECFSZ DEG2,F
	GOTO DEG2AZALT
	GOTO GECIKME
	
SOL_ARTIR
	CLRF SAG
	INCF SOL
	
	MOVLW 0X06
	BCF STATUS,Z
	SUBWF SOL,W
	BTFSC STATUS,Z
	GOTO ON_AYARLAR
	RETURN
	
END