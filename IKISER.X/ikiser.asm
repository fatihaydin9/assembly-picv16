    list    p=16f877a
    #include<p16f877a.inc>
    
    ;55den 0a ikiser ikiser sayan program
    
    DEG1 EQU 0X20
    DEG2 EQU 0X21
    
    MOVLW D'55'
    MOVWF DEG1
    
    MOVLW D'2'
    MOVWF DEG2
    
    ;GETTING VALUES
    DONGU
	MOVFW DEG2
	BSF STATUS,C
	SUBWF DEG1,F
	BTFSS STATUS,C
	GOTO SONLAN
	GOTO DONGU
	
    SONLAN
	END
    
    


