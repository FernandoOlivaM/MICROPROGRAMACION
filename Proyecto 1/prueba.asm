.model small
.stack
.data
    random db ?
.code
main:
    MOV AX,@DATA
    MOV DS,AX
; PARA LA OBTENCION DEL NUMERO ALEATORIO SE HACE UNA SUMA CON 
; TODOS LOS ELEMENTOS DE LA FECHA Y HORA DEL SISTEMA
; OBTENIENDOLOS Y ALMACENANDOLOS EN UNA VARIABLE
; TAMBIEN SE DIVIDE EL NUMERO OBTENIDO ENTRE 16 PARA OBTENER
; EL RESIDUO Y DEJARLO EN BASE HEXADECIMAL

    MOV AH,2AH      ; Se obtiene la fecha del sistema
    INT 21H
    MOV AL,DL       ; Se obtiene el dia del sistema, esta en DL
    ADD AL,DH       ; Se obtiene el mes del sistema, esta en DH
    ;ADD AL,CH       ; Se obtiene el anio del distema
    
    MOV AH,2CH      ; Se obtiene el tiempo del sistema
    INT 21H
    ADD AL,CH       ; Se obtiene la hora del sistema
    ADD AL,CL       ; Se obtiene el minuto del sistema
    ADD AL,DH       ; Se otiene el segundo de sistema
    MOV RANDOM, AL
    mov al, random
    
    AAM
    MOV BX,AX
    CALL DISP
    
    MOV AH,4CH     
    INT 21H
    
    
    ;Display Part
    DISP PROC
    MOV DL,BH      ; Since the values are in BX, BH Part
    ADD DL,30H     ; ASCII Adjustment
    MOV AH,02H     ; To Print in DOS
    INT 21H
    MOV DL,BL      ; BL Part 
    ADD DL,30H     ; ASCII Adjustment
    MOV AH,02H     ; To Print in DOS
    INT 21H
    RET
    DISP ENDP      ; End Disp Procedure
    
    
end main 