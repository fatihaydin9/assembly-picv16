    list    p=16f877a
    #include<p16f877a.inc>
    
    ORG 0x00
    
    DEG1 EQU 0X20
    DEG2 EQU 0X21
 
    
    MOVLW D'5'
    MOVWF DEG1
    
    MOVLW D'1'
    MOVWF DEG2
 
    BSF STATUS,C
    SUBWF DEG1,F
    BTFSS STATUS,C
    GOTO DEG2BUYUKDEG1
    GOTO DEG1BUYUKDEG2
    
    DEG1BUYUKDEG2
    
    DEG2BUYUKDEG1
    
    END
 
    
    


