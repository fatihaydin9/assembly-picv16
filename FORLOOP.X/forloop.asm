    list      p=16f877a
    #include<p16f877a.inc>
    
    ORG 0X00
    
    INDEX EQU 0X20
    
    MOVLW D'5'
    MOVWF INDEX
    
    DONGU
	DECFSZ INDEX,F
	GOTO DONGU
	GOTO SONLAN
    
    SONLAN
    END


