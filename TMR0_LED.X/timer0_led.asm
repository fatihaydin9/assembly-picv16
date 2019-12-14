list		p=16f877A
#include	<p16f877A.inc>
	
__CONFIG H'3F31'			;ayarlamalar
	
TMRS	EQU	0x23			;KULLANILACAK DEGISKENLER

w_temp		EQU	0x7D		;shadow temporary degiskenleri
status_temp	EQU	0x7E		
pclath_temp	EQU	0x7F					


	ORG     0x000             	; Baslama vektoru

	nop				; ICD ozelliginin aktif edilmesi icin gereken bekleme 
  	goto    ON_AYARLAR          	; baslama etiketine gir


	ORG     0x004             	; kesme vektoru

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
	COMF   PORTB			; ledin yanmasi icin komplementarysini aldik.
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
	BANKSEL TRISB		;TRISB - BANK1 'e gec
	CLRF	TRISB			;PORTB 'nin tamamini cikis yap
	MOVLW	b'00000110'		;PRESCALER 1:128
	MOVWF	OPTION_REG		;OPTION_REG 'e preskaler degerini ata.
	
	BANKSEL PORTA		;Tekrar BANK0 'a gec.
	CLRF	PORTB			;Portb 'yi temizle
	MOVLW	d'61'			;TMR0 baslangic degeri
	MOVWF	TMR0
	CLRF	TMRS	   
	
	BSF	INTCON,T0IE		;TMR0 kesmeleri aktif
	BSF	INTCON,GIE		;Tum kesmeleri aktiflestir.
	
CALIS
	GOTO	CALIS			;KESME OLMASINI BEKLE
	
	END				; Program sonu

















