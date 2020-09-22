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
    TOTALES db 'INGRESE EL NUMERO DE PRUEBAS TOTALES',13,10,'$'             ; texto que se mostrara en pantalla para pedir el numero de pruebas totales
    POSITIVOS db 13,10,'INGRESE EL NUMERO DE CASOS POSITIVOS',13,10,'$'     ; texto que se mostrara en pantalla para pedir el numero de pruebas positivas
    FORMATO db 'DE LA FORMA: 000, 011 O 111',13,10,'$'                      ; texto que indica el formato que debe tener la entrada
    ALERTA DB 13,10,'EL NUMERO DE CASOS PRODUCE UNA ALERTA',13,10,'$'       ; texto que se mostrara en pantalla para indicar el tipo de alerta
    VERDE DB 'VERDE' ,13,10,'$'                                             ; tipo de alerta verde    ( 000 - 004 % )
    AMARILLA DB 'AMARILLA' ,13,10,'$'                                       ; tipo de alerta amarilla ( 005 - 014 % )
    NARANJA DB 'NARANJA' ,13,10,'$'                                         ; tipo de alerta naranja  ( 015 - 019 % ) 
    ROJA DB 'ROJA' ,13,10,'$'                                               ; tipo de alerta roja     ( 020 - 100 % )
    pruebasTotales db 0                                                     ; variable para almacenar el numero de pruebas totales
    casosPositivos db 0                                                     ; variable para almacenar el numero de casos positivos
    Porcentaje db 0                                                         ; variable para almacenar el porcentaje de casos positivos
.code
main:
    mov AX, @data
    mov DS, AX
    XOR AX, AX   

        mov dx, offset TOTALES                                              ; se muestra en pantalla el texto para pedir el numero de pruebas totales            
        mov ah, 09h                              
        int 21h                                        
        mov dx, offset FORMATO                                              ; se muestra en pantalla el texto que indica el formato
        mov ah, 09h                                 
        int 21h  
        
        MOV AH,01H                                                          ; se lee el primer digito del numero total de pruebas
        INT 21H
        SUB AL,30H                                                          ; se obtiene el valor real del numero restando 30
        MOV bl,100                                                          ; se multiplica por 100, ya que el primer digito representa las centenas
        MUL bl
        
        MOV pruebasTotales, AL                                              ; se almacena el valor de las centenas
        XOR AX, AX                                                          ; se limpia AX
        
        MOV AH,01H                                                          ; se lee el segundo digito del numero total de pruebas
        INT 21H
        SUB AL,30H                                                          ; se obtiene el valor real del numero restando 30
        MOV bl,10                                                           ; se multiplica por 10, ya que el segundo digito representa las decenas
        MUL bl
        add pruebasTotales, al                                              ; se suman las decenas a las pruebasTotales
        XOR AX, AX                                                          ; se limpia AX
        MOV AH,01H                                                          ; se lee el tercer digito del numero total de pruebas
        INT 21H
        SUB AL,30H                                                          ; se obtiene el valor real del numero restando 30
        add pruebasTotales, al                                              ; se suman las unidades a pruebasTotales
        XOR AX, AX                                                          ; se limpiaAX

        mov dx, offset POSITIVOS                                            ; se muestra en pantalla el texto para pedir el numero de casos positivos            
        mov ah, 09h                              
        int 21h                                        
        mov dx, offset FORMATO                                              ; se muestra en pantalla el texto que indica el formato        
        mov ah, 09h                              
        int 21h  
        
        MOV AH,01H                                                          ; se lee el primer digito del numero de casos positivos
        INT 21H
        SUB AL,30H                                                          ; se obtiene el valor real del numero restando 30
        MOV bl,100                                                          ; se multiplica por 100, ya que el primer digito representa las centenas
        MUL bl
        
        MOV casosPositivos, AL                                              ; se almacena el valor de caos positivos
        XOR AX, AX                                                          ; se limpia AX
        
        MOV AH,01H                                                          ; se lee el segundo digito del numero de casos positivos
        INT 21H
        SUB AL,30H                                                          ; se obtiene el valor real del numero restando 30
        MOV bl,10                                                           ; se multiplica por 10, ya que el primer digito representa las decenas
        MUL bl
        add casosPositivos, al                                              ; se suman las decenas a los casosPositivos
        XOR AX, AX 
        MOV AH,01H                                                          ; se lee el tercer digito del numero de casos positivos
        INT 21H
        SUB AL,30H                                                          ; se obtiene el valor real del numero restando 30
        add casosPositivos, al                                              ; se suman las unidades a los casosPositivos
        XOR AX, AX                                                          ; se limpia AX
        ; ------------------------------- CALCULO DEL PORCENTAJE --------------------------------------        
        mov al, casosPositivos                                              ; se mueve el numero de casos positivos a AL
        mov bl, 100                                                         ; se mueve 100 al bl, para multiplicarlo por los casos positivos y asi obtener el valor del porcentaje        
        mul bl                                                              ; se realiza el producto
        mov casosPositivos,al                                               ; se almacena el resultado del producto
        
        XOR AX, AX                                                          ; se limpia AX
        
        mov al, casosPositivos                                              ; se mueven los casos positivos a AL
        mov bl, pruebasTotales                                              ; se mueven las pruebas totales a Bl
        div bl                                                              ; se realiza la división para obtener el porcentaje
                
        mov Porcentaje, al                                                  ; se almacena el resultado porcentaje

        XOR AX, AX                                                          ; se limpia AX

        mov dx, offset ALERTA                                               ; se muestra en pantalla el mensaje de la alerta
        mov ah, 09h                              
        int 21h
        ; ------------------------------- DEFINICIÓN DEL COCLOR DE LA ALERTA  --------------------------------------   
        
        XOR AX, AX                                                          ; se limpia AX
        mov al, Porcentaje
        CMP AL, 4
        jle aVerde                                                          ; si es menor o igual a 4 se produce una alerta verde
        cmp al, 4                                    
        jg rangoAmarillo                                                    ; si es mayor a 4, se evalua el rango de alerta amarilla

    rangoAmarillo:
        cmp al, 15
        jle aAmarilla                                                        ; si es menor o igual a 15 se produce una alerta amarilla
        cmp al, 15
        jg rangoNaranja                                                     ; si es mayor a 15 se evalua el rango naranja

    rangoNaranja:  
        cmp al, 20
        jl anaranja                                                         ; si es menor que 20 se produce una alterta naranja
        cmp al, 20
        jge aRoja                                                           ; si es mayor o igual a 20 se produce una alerta roja
    
     aRoja:
        XOR AX, AX    
        mov dx, offset ROJA                                                 ; se muestra en pantalla que existe una alerta roja
        mov ah, 09h                                   
        int 21h    
        MOV AH, 4CH                  
        INT 21H                     
        
    aNaranja:
        XOR AX, AX    
        mov dx, offset NARANJA                                              ; se muestra en pantalla que existe una alerta naranja           
        mov ah, 09h                                   
        int 21h    
        MOV AH, 4CH                 
        INT 21H     
   
    aAmarilla:
        XOR AX, AX    
        mov dx, offset AMARILLA                                             ; se muestra en pantalla que existe una alerta amarilla
        mov ah, 09h                                   
        int 21h    
        MOV AH, 4CH                
        INT 21H                    
    
    aVerde:    
        XOR AX, AX    
        mov dx, offset VERDE                                                ; se muestra en pantalla que existe una alerta verde
        mov ah, 09h                                   
        int 21h    
        MOV AH, 4CH                 
        INT 21H                     

    MOV AH, 02H
    INT 21H
        
end main
