    list p = 16f877a
    #include<p16f877.inc>
    
	;LCD 'YE FATIH AYDIN YAZAN UYGULAMA
    
	;GECIKME DEGISKENLERI
	GECIKME1    EQU	0x20		;1.GECIKME ICIK
        GECIKME2    EQU	0x21		;2.GECIKME ICIN
	GECIKME3    EQU	0x22		;3.GECIKME ICIN
	
	;LCD DEGISKENLERI
	VERI4	      EQU	0X23		;VERININ EN DUSUK 4 BITI
	SAYAC	      EQU	0X24		;DATA TABLE ICIN SAYAC
	LCD_TEMP    EQU	0X25		;LCD TEMP DEGIS.
	LCD_TRIS    EQU	TRISB		;TRISB - TEMSILI
	LCD_PORT    EQU	PORTB		;PORTB - TEMSILI
	
	LCD_RS	    EQU	    4			;RS BITININ TEMSILI
	LCD_E	    EQU	    5			;ENABLE BITI TEMSIL
	    
	ORG 0X000
	NOP
	GOTO BASLA
	
	DUSEN_KENAR
	    BANKSEL	LCD_PORT		;BANK0 SEC.
	    BSF		LCD_PORT,LCD_E	;ONCE E UCUNU 1 YAP
	    CALL	GECIKME_200USN	;GECIKMEYE GIT
	    BCF		LCD_PORT,LCD_E	;E UCUNU 0 YAP KI UYAR
	    RETURN
	    
	KOMUT4_GONDER
	    ANDLW	0x0F			;WREG 'TEN GELEN VERININ EN DUSUK 4 BITINI AL.
	    MOVWF	VERI4			;BU 4 BITLIK PAKETI VERI DEGISKENINE AT.

	    MOVFW	LCD_PORT		;PORTB 'DEKI DEGERI WREG 'E YAZ. 
	    ANDLW	0xF0			;PORTB 'DEKI EN DEGERLI 4BITI AL (AYAR BITLERI)
	
	    IORWF	VERI4,W		;WREG LSB4 + PORTB MSB4 IKI PAKETI BIRLESTIR	
	    MOVWF	LCD_PORT		;BIRLESTIRDIGIN PAKETLERI PORTB 'YE ATA.
	
	    CALL	DUSEN_KENAR		;BU ISLEMLER ICIN ENABLE BITINI DURTMEN GEREKIR
	    CALL	GECIKME_200USN	;100MIKROSANIYE GECIKME
	    RETURN
	    
	KOMUT_GONDER
	    ;2 ASAMADA GONDERME YAPMAK - ICIN BU METOD KULLANILIR.
	
	    MOVWF	LCD_TEMP		; ONCE GONDERILECEK VERIYI SAKLA
	    SWAPF	LCD_TEMP,W		; GONDERILECEK VERININ ILK DOR VE SON DORT BITINI YER DEGISTIR

	    BANKSEL	LCD_PORT		; BANK0 'A GEC
	    BCF		LCD_PORT,LCD_RS	; RS UCUNU 0 A CEK VE KOMUT GONDERECEGINI SOYLE

	    CALL	KOMUT4_GONDER	; BU EN DEGERLIKLI 4 BITI YOLLA

	    MOVF	LCD_TEMP,W		; SIMDI EN DEGERLIKSIZ 4 U GONDER
	    BCF		LCD_PORT,LCD_RS	; RS UCUNU 0 A CEK VE KOMUT GONDERECEGINI SOYLE
	    CALL	KOMUT4_GONDER
	
	    RETURN
	    
	KARAKTER_GONDER
	    MOVWF	LCD_TEMP		; GELEN VERI ICIN SWAP ISLEMI YAPILACAGINDAN KORU
	    SWAPF	LCD_TEMP,W		; EN DEGERLIKLI BITLER ICIN SWAP YAP
	    BANKSEL	LCD_PORT		; BANK0 A GECIYORUZ.
	    BSF		LCD_PORT,LCD_RS	; KARAKTER YAZMA ICIN RS=1
	    CALL	KOMUT4_GONDER	; 4 BIT MODUNDA KARAKTERI GONDER
	    MOVF	LCD_TEMP,W		; SIMDI NORMAL DUSUK DEGERLIKLI BITLERI GONDER
	    CALL	KOMUT4_GONDER
	    RETURN

	LCD_AYARLA
	    MOVLW 0X00
	    MOVWF SAYAC			;DATA TABLE 0'DAN BASLAMALIDIR...
	
	    BANKSEL	LCD_TRIS		;BANK1 SECIYORUZ.
	    CLRF	LCD_TRIS		;B PORTUNU TAMAMEN CIKIS YAP.

	    BANKSEL	LCD_PORT		;BANK0 SECIYORUZ.
	    CALL	GECIKME_50MSN	;ACILIS ICIN 50MS BEKLE.
	    BCF		LCD_PORT,LCD_RS	;RS BITINI 0 YAP (KOMUT)	

	    	    
	    ;GONDERECEGIMIZ KOMUTLAR
	    MOVLW	0x03			;0X03 GONDERMEMIZ GEREK.
	    CALL	KOMUT_GONDER		;KOMUTU GONDERIYORUZ
	    CALL	GECIKME_5MSN		;5MS BEKLIYORUZ.
	    
	    MOVLW	0x02			;0X02 GONDERMEMIZ GEREK.
	    CALL	KOMUT_GONDER		;KOMUTU GONDERIYORUZ
	    CALL	GECIKME_200USN	;BIRAZ BEKLIYORUZ.
	    
	    MOVLW	0x28
	    CALL	KOMUT_GONDER

	    MOVLW	0x10	
	    CALL	KOMUT_GONDER

	    MOVLW	0x01
	    CALL	KOMUT_GONDER

	    MOVLW	0x06
	    CALL	KOMUT_GONDER

	    MOVLW	0x0D
	    CALL	KOMUT_GONDER
	   
	    RETURN
	    
	BASLA
	    CALL	LCD_AYARLA
	    

	DDR
	    MOVFW SAYAC
	    CALL  DATA_TABLE
	    BTFSC STATUS,Z
	    GOTO  DDR2
	    INCF  SAYAC,F
	    CALL  KARAKTER_GONDER
	    CALL  GECIKME_200USN
	    GOTO  DDR
	  
	
	DDR2
	    MOVLW 0XC0
	    CALL KOMUT_GONDER
	    
	    MOVLW 'A'
	    CALL   KARAKTER_GONDER
	    
	    MOVLW 'Y'
	    CALL   KARAKTER_GONDER
	    
	    MOVLW 'D'
	    CALL   KARAKTER_GONDER
	    
	    MOVLW 'I'
	    CALL   KARAKTER_GONDER
	    
	    MOVLW 'N'
	    CALL   KARAKTER_GONDER
	    
	
	CALIS
	    GOTO CALIS
	    
	    
	DATA_TABLE
	    ADDWF PCL,F
	    RETLW 'F'
	    RETLW 'A'
	    RETLW 'T'
	    RETLW 'I'
	    RETLW 'H'
	    BSF    STATUS,Z
	    RETLW 0X00
	    
	DATA_TABLE2
	    ADDWF PCL,F
	    RETLW 'F'
	    RETLW 'A'
	    RETLW 'T'
	    RETLW 'I'
	    RETLW 'H'
	    BSF    STATUS,Z
	    RETLW 0X00
	
;****	GECIKMELERIN TAMAMI ***************************************
	    
	GECIKME_200USN				
	    MOVLW	0xC8
	    MOVWF	GECIKME1
	DNGU1
	    DECFSZ	GECIKME1,1
	    GOTO	DNGU1
	    RETURN
	
	GECIKME_5MSN
	    MOVLW	0xE7
	    MOVWF	GECIKME1
	    MOVLW	0x04
	    MOVWF	GECIKME2
	D5_D
	    DECFSZ	GECIKME1, f
	    GOTO	D5_D
	    DECFSZ	GECIKME2, f
	    GOTO	D5_D
	    RETURN
	
	GECIKME_50MSN
	    MOVLW	0x0F
	    MOVWF	GECIKME1
	    MOVLW	0x28
	    MOVWF	GECIKME2
	D50_D
	    DECFSZ	GECIKME1, f
	    GOTO	D50_D
	    DECFSZ	GECIKME2, f
	    GOTO	D50_D
	    RETURN

	BITIR
END
	