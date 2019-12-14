    list	p=16f877a
    #include<p16f877.inc>
    
    ORG 0X00
    
    DEGX  EQU 0X21
    DEGY  EQU 0X22
    SONUC EQU 0X23
 
    MOVLW D'5'
    MOVWF DEGX
    
    MOVFW DEGX
    MOVWF DEGY
    
    CLRW 
    
    DONGU
	ADDWF DEGX, W
	DECFSZ DEGY,F
	GOTO DONGU
	GOTO SONLAN

    SONLAN 
	MOVWF SONUC
	END
