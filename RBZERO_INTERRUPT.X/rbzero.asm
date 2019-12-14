; KODLAMA SABLONU

	list		p=16f877A	; hangi pic
	#include	<p16f877A.inc>	; SFR register 'lar?n tan?mland??? kutuphane
	
	__CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_ON & _RC_OSC & _WRT_OFF & _LVP_ON & _CPD_OFF

; WDT, ossilatör gibi register ayarlar?

	
;KULLANILACAK DEGISKENLER

bizimDegisken	EQU 0x20   ;Buradaki ismi degistirebilir ve yenileri eklenebilir


;***** Kesme durumunda kaydedilmesi gereken SFR ler icin kullanilacak yardimci degiskenler
w_temp		EQU	0x7D		
status_temp	EQU	0x7E		
pclath_temp	EQU	0x7F					






;********************************************************************************************
	ORG     0x000             	; Baslama vektoru

	nop			  			  	; ICD ozelliginin aktif edilmesi icin gereken bekleme 
  	goto    BASLA              	; baslama etiketine gir

	
;**********************************************************************************************
	ORG     0x004             	; kesme vektoru

	movwf   w_temp            	; W n?n yedegini al
	movf	STATUS,w          	; Status un yedegini almak icin onu once W ya al
	movwf	status_temp       	; Status u yedek register '?na al
	movf	PCLATH,w	  		; PCLATH '? yedeklemek icin onu once W 'ya al
	movwf	pclath_temp	  		; PCLATH '? yedek register a al

	BANKSEL PORTB
	BTFSS	PORTB,1
	GOTO   BIRYAP
	GOTO	SIFIRYAP
	
	BIRYAP
	    BSF PORTB,1
	    GOTO CIKIS
	    
	SIFIRYAP
	    BCF PORTB,1
	    GOTO CIKIS
	    
	CIKIS

	BCF	INTCON,INTF
	
	movf	pclath_temp,w	  	; Geri donmeden once tum yedekleri geri yukle
	movwf	PCLATH		  		
	movf    status_temp,w     	
	movwf	STATUS            	
	swapf   w_temp,f
	swapf   w_temp,w   
	retfie                    	; Kesme 'den don
;***********************************************************************************************


BASLA
	CALL PROPERTIES
	DONGU
	GOTO DONGU

	
	
PROPERTIES
	BSF INTCON,GIE
	BSF INTCON,INTE
	
	BANKSEL OPTION_REG
	BCF OPTION_REG,INTEDG 
	
	BANKSEL TRISB
	MOVLW b'00000001'
	MOVWF TRISB
	BANKSEL PORTB
	CLRF PORTB
	
	RETURN
	
	END                       ; Program sonu