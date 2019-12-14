;1MS ARALIKLARLA KAYAN KARASIMSEK UYGULAMASI
	
list p = 16f877a
#include<p16f877a.inc>
    
w_temp	       EQU 0x7D
pclath_temp EQU 0X7E
status_temp EQU 0x7F
 
TMRS	EQU 0X21
YON    EQU 0X22
KARASIMSEK EQU 0X20
    
ORG 0X000
NOP
GOTO ON_AYARLAR
    

ORG 0X004
TMR0_KESME
	MOVWF   w_temp            	; yedek_wreg
	MOVF	STATUS,w          	; yedek_status
	MOVWF	status_temp       	
	MOVF	PCLATH,w	  	; yedek_pclath
	MOVWF	pclath_temp	  		
	
	BCF	INTCON,TMR0IF	; tmr0 interrupt calisti, surekli ayni donguye girme
	MOVLW	d'61'			; tmr0 baslangic degeri
	MOVWF	TMR0			
	
	INCF	TMRS,F			; tmr0 'in kac kez calisacagiyla ilgili dongumuz.
	
	MOVLW	d'40'			; 40 kez calismasi icin TMRS degiskenini kullaniyoruz
	SUBWF	TMRS,W			
	BTFSS	STATUS,Z
	GOTO	DONUS			; henuz 40'a gelmemisse is yapmadan dongude calismaya devam etsin.
	CLRF	TMRS			; 40'a gelmisse beklenen sure bitti, hangi islem yapilacak?
	
	BTFSS YON,0
	GOTO  SAG
	GOTO  SOL
		
	GOTO	DONUS			; tekrar donuse gidilmesini sagladik. 
	
DONUS
	MOVF	 pclath_temp,w	;yedekleri geri yukle
	MOVWF	 PCLATH		  		
	MOVF    status_temp,w     	
	MOVWF	 STATUS            	
	SWAPF	 w_temp,f
	SWAPF   w_temp,w 
	RETFIE     
	

ON_AYARLAR
 	BANKSEL TRISB
	CLRF TRISB
	    
	MOVLW b'00000110'
	MOVWF OPTION_REG
	   
	BANKSEL PORTA		;Tekrar BANK0 'a gec.
	CLRF	PORTB			;Portb 'yi temizle
	MOVLW	d'61'			;TMR0 baslangic degeri
	MOVWF	TMR0
	CLRF	TMRS	
	   
	BSF INTCON,GIE
	BSF INTCON,T0IE
	
	MOVLW 0X01
	MOVWF KARASIMSEK
	MOVWF PORTB
	
	MOVLW 0X01
	MOVWF YON
	
CALIS
	
	GOTO CALIS
 
	
SOL
    BCF STATUS,C
    RLF KARASIMSEK,F
    MOVFW KARASIMSEK
    MOVWF PORTB
	    
    BTFSS KARASIMSEK,7
    GOTO DONUS
    MOVLW 0X02
    MOVWF YON
    GOTO DONUS
    
SAG
    BCF STATUS,C
    RRF KARASIMSEK,F
    MOVFW KARASIMSEK
    MOVWF PORTB
	    
    BTFSS KARASIMSEK,0
    GOTO DONUS
    MOVLW 0X01
    MOVWF YON
    GOTO  DONUS
	
END
