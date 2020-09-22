;   EL SET DE PRUEBAS UTILIZADO PARA ESTE LABORATORIO, PARA CORROBORAR QUE LOS SALTOS SE REALIZEN BIEN ES EL SIGUIENTE:
;   
;    ALTERTA ESPERADA  |  TOTAL DE PRUEBAS  |  TOTAL CASOS POSTIVOS  |  PORCENTAJE
;   ------------------ | ------------------ | ---------------------- | ------------
;          ROJA        |       010          |         002            |     20 %
;   ------------------ | ------------------ | ---------------------- | ------------
;         NARANJA      |       011          |         002            |     18 %
;   ------------------ | ------------------ | ---------------------- | ------------
;        AMARILLA      |       800          |         056            |     07 %
;   ------------------ | ------------------ | ---------------------- | ------------
;         VERDE        |       999          |         035            |     03 %

.model small                             
.stack
.data                                        
    TOTALES         DB 'INGRESE EL NUMERO DE PRUEBAS TOTALES',13,10,'$'         ; texto que se mostrara en pantalla para pedir el numero de pruebas totales
    POSITIVOS       DB 13,10,'INGRESE EL NUMERO DE CASOS POSITIVOS',13,10,'$'   ; texto que se mostrara en pantalla para pedir el numero de pruebas positivas
    FORMATO         DB 'DE LA FORMA: 000, 011 O 111',13,10,'$'                  ; texto que indica el formato que debe tener la entrada
    ALERTA          DB 13,10,'EL NUMERO DE CASOS PRODUCE UNA ALERTA',13,10,'$'  ; texto que se mostrara en pantalla para indicar el tipo de alerta
    VERDE           DB 'VERDE' ,13,10,'$'                                       ; tipo de alerta verde    ( 000 - 004 % )
    AMARILLA        DB 'AMARILLA' ,13,10,'$'                                    ; tipo de alerta amarilla ( 005 - 014 % )
    NARANJA         DB 'NARANJA' ,13,10,'$'                                     ; tipo de alerta naranja  ( 015 - 019 % ) 
    ROJA            DB 'ROJA' ,13,10,'$'                                        ; tipo de alerta roja     ( 020 - 100 % )
    pruebasTotales  DW 0                                                        ; variable para almacenar el numero de pruebas totales
    casosPositivos  DW 0                                                        ; variable para almacenar el numero de casos positivos
    Porcentaje      DW 0                                                        ; variable para almacenar el porcentaje de casos positivos
.code
main:
    mov AX, @data
    mov DS, AX
    XOR AX, AX   

        mov dx, offset TOTALES                                                  ; se muestra en pantalla el texto para pedir el numero de pruebas totales            
        mov ah, 09h                              
        int 21h                                        
        mov dx, offset FORMATO                                                  ; se muestra en pantalla el texto que indica el formato
        mov ah, 09h                                 
        int 21h  
        XOR AX, AX   
    
        MOV AH,01H                                                              ; se lee el primer digito del numero total de pruebas
        INT 21H
        SUB AX,30H                                                              ; se obtiene el valor real del numero restando 30
        MOV Dl,100                                                              ; se multiplica por 100, ya que el primer digito representa las centenas
        MUL Dl
        
        MOV pruebasTotales, AX                                                  ; se almacena el valor de las centenas
        XOR AX, AX                                                              ; se limpia AX
        XOR DX, DX                                                              ; se limpia DX
    
        MOV AH, 01h                                                             ; se lee el segundo digito del numero total de pruebas
        INT 21h
        MOV AH, 00h
        SUB AX,30H                                                              ; se obtiene el valor real del numero restando 30
        MOV Dl,10                                                               ; se multiplica por 10, ya que el segundo digito representa las decenas
        MUL Dl

        ADD pruebasTotales, AX                                                  ; se suman las decenas a las pruebasTotales
        XOR AX,AX                                                               ; se limpia AX
        XOR DX,DX                                                               ; se limpia DX

        MOV AH,01H                                                              ; se lee el tercer digito del numero total de pruebas
        INT 21H
        MOV AH, 00h
        SUB AX,30H                                                              ; se obtiene el valor real del numero restando 30
        add pruebasTotales, aX                                                  ; se suman las unidades a pruebasTotales
        XOR AX, AX            
        xor dx,dx   
        MOV DL, 0Ah
        MOV AH, 02h
        INT 21h

        mov dx, offset POSITIVOS                                                ; se muestra en pantalla el texto para pedir el numero de pruebas totales            
        mov ah, 09h                              
        int 21h                                        
        mov dx, offset FORMATO                                                  ; se muestra en pantalla el texto que indica el formato
        mov ah, 09h                                 
        int 21h  
    
	MOV AH,01H                                                              ; se lee el primer digito del numero de casos positivos
        INT 21H
        SUB AX,30H                                                              ; se obtiene el valor real del numero restando 30
        MOV Dl,100                                                              ; se multiplica por 100, ya que el primer digito representa las centenas
        MUL Dl
        
        MOV casosPositivos, AX                                                  ; se almacena el valor de las centenas
        XOR AX, AX                                                              ; se limpia AX
        XOR DX, DX                                                              ; se limpia DX
    
        MOV AH, 01h                                                             ; se lee el segundo digito del numero de casos positivos
        INT 21h
        MOV AH, 00h
        SUB AX,30H                                                              ; se obtiene el valor real del numero restando 30
        MOV Dl,10                                                               ; se multiplica por 10, ya que el segundo digito representa las decenas
        MUL Dl

        ADD casosPositivos, AX                                                  ; se suman las decenas a las pruebasTotales
        XOR AX,AX                                                               ; se limpia AX
        XOR DX,DX                                                               ; se limpia DX

        MOV AH,01H                                                              ; se lee el tercer digito del numero de casos positivos
        INT 21H
        MOV AH, 00h
        SUB AX,30H                                                              ; se obtiene el valor real del numero restando 30
        add casosPositivos, aX                                                  ; se suman las unidades a pruebasTotales
        XOR AX, AX                                                              ; se limpia AX
        xor dx,dx                                                               ; se limpia DX
        MOV DL, 0Ah
        MOV AH, 02h
        INT 21h

       ; ------------------------------- CALCULO DEL PORCENTAJE --------------------------------------     
        XOR BX,BX                                                               ; se limpia BX
        MOV AX, casosPositivos                                                  ; se mueve el numero de casos positivos a AX
        MOV BX, 100                                                             ; se mueve 100 al bX, para multiplicarlo por los casos positivos y asi obtener el valor del porcentaje 
        MUL BX                                                                  ; se realiza el producto
        XOR BX,BX                                                               ; se limpia BX
        MOV BX, pruebasTotales                                                  ; se mueven las pruebas totales a BX
        DIV BX                                                                  ; se realiza la división para obtener el porcentaje
		mov Porcentaje, AX                                                      ; se almacena el resultado porcentaje
        XOR AX, AX                                                              ; se limpia AX

        mov dx, offset ALERTA                                                   ; se muestra en pantalla el mensaje de la alerta
        mov ah, 09h                              
        int 21h                                                            
        ; ------------------------------- DEFINICIÓN DEL COLOR DE LA ALERTA  --------------------------------------   
        CMP Porcentaje, 4
        JLE aVerde                                                              ; si es menor o igual a 4 se produce una alerta verde
        
        CMP Porcentaje, 15
        JLE aAmarilla                                                           ; si es menor o igual a 15 se produce una alerta amarilla

        CMP Porcentaje, 20
        JL aNaranja                                                             ; si es menor a 20 se produce una alerta naranja

        CMP Porcentaje, 20
        JGE aRoja                                                               ; si es mayor o igual a 20 se produce una alerta roja

     aRoja:
        XOR AX, AX    
        mov dx, offset ROJA                                                     ; se muestra en pantalla que existe una alerta roja
        mov ah, 09h                                   
        int 21h    
        MOV AH, 4CH                  
        INT 21H                     
        
    aNaranja:
        XOR AX, AX    
        mov dx, offset NARANJA                                                  ; se muestra en pantalla que existe una alerta naranja           
        mov ah, 09h                                   
        int 21h    
        MOV AH, 4CH                 
        INT 21H     
   
    aAmarilla:
        XOR AX, AX    
        mov dx, offset AMARILLA                                                 ; se muestra en pantalla que existe una alerta amarilla
        mov ah, 09h                                   
        int 21h    
        MOV AH, 4CH                
        INT 21H                    
    
    aVerde:    
        XOR AX, AX    
        mov dx, offset VERDE                                                	; se muestra en pantalla que existe una alerta verde
        mov ah, 09h                                   
        int 21h    
        MOV AH, 4CH                 
        INT 21H                     
    MOV AH, 02H
    INT 21H
END main
