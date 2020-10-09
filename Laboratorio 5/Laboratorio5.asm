.model small 
.stack
.data
INGRESO     db 13,10,13,10,'CALCULO DE FACTORIAL',13,10,
            db 'INGRESESE EL NUMERO AL QUE DESEA CALCULAR EL FACTORIAL',13,10,  ; texto para solicitar el numero a calcular el facctorial
            db 'DE LA FORMA: 000, 011 O 111',13,10,'> $'    
RESULTADO   db 13,10,'EL FACTORIAL CALCULADO ES:',13,10,'$' 
cadena      dw 128 DUP ('$')                  
Num         dw 0
.code
main:
    mov     ax,@data
    mov     ds,ax     
    lea     dx, INGRESO                                                     ; se solicita el numero
    mov     ah, 09h 
    int     21h 
    XOR     AX, AX
    MOV     AH,01H                                                          ; se lee el primer digito del numero 
    INT     21H
    SUB     AX,30H                                                          ; se obtiene el valor real del numero restando 30
    MOV     Dl,100                                                          ; se multiplica por 100, ya que el primer digito representa las centenas
    MUL     Dl

    MOV     Num, AX                                                         ; se almacena el valor de las centenas
    XOR     AX, AX                                                          ; se limpia AX
    XOR     DX, DX                                                          ; se limpia DX

    MOV     AH, 01h                                                         ; se lee el segundo digito del numero 
    INT     21h
    MOV     AH, 00h
    SUB     AX,30H                                                          ; se obtiene el valor real del numero restando 30
    MOV     Dl,10                                                           ; se multiplica por 10, ya que el segundo digito representa las decenas
    MUL     Dl

    ADD     Num, AX                                                         ; se suman las decenas a num
    XOR     AX,AX                                                           ; se limpia AX
    XOR     DX,DX                                                           ; se limpia DX

    MOV     AH,01H                                                          ; se lee el tercer digito del numero 
    INT     21H
    MOV     AH, 00h
    SUB     AX,30H                                                          ; se obtiene el valor real del numero restando 30
    add     Num, aX                                                         ; se suman las unidades a num
    XOR     AX, AX            
    xor     dx,dx 
    mov     dx, offset RESULTADO                                            ; se muestra en pantalla el dar a conocer el resultado            
    mov     ah, 09h                              
    int     21h
    xor     dx,dx                                                           ; se limpia dx

    mov     bx, num                                                         ; se mueve el numero leido a bx
    xor     dx, dx                                                          ; se limpia dx
    mov     ax, 1                                                           ; se partira del numero 1
    mov     cx, 1                                                           ; se partira multiplicando por 1
    cicloFor:
        call multiplicar                                                    ; se llama el procedimiento
        inc cx                                                              ; se incrementa el contador
        cmp cx, bx                                                          ; se compara el contador y el numero ingresado
        jbe cicloFor                                                        ; se realiza un salto a L1 si no son iguales cx y bx

    mov     di, OFFSET cadena                                               ; se mueve la cadena a di
    call    convertirDecimal                                                    ; se llama el procedimiento
    mov     dx, OFFSET cadena                                               ; se manda a imprimir el factorial
    mov     ah, 9
    int     21h

    mov     ax, 4C00h                                                       ; se termina la ejecucion del programa
    int     21h

multiplicar PROC                                                         ; DX:AX multiplicando, CX multiplicador
    push    dx                                                              ; parte baja
    mul     cx                                                              ; se multiplica DX y CX
    mov     si, dx                                                          ; se almacena el resultado de la multiplicacion
    mov     di, ax                          
    pop     ax                                                              ; parte alta
    mul     cx                                                              ; se multiplica AX y CX
    add     ax, si                                                          ; se añade el resultado de la parte alta de la multiplicacion a la parte baja
    adc     dx, 0

    mov     si, dx                                                          ; se preparan los valores para añadirl el resultado a la cadena
    mov     dx, ax
    mov     ax, di
    ret                                                                     ; se retorna
multiplicar ENDP

convertirDecimal PROC                       

    mov     cs:target, di                                                   ; se fija el objetivo
    mov     si, ax                                                          ; se mueve la cadena calculada previamente en el procedimiento multiplicar
    mov     di, dx

    mov     cs:counter, 0                                                   ; se fija el contador en 0
    mov     bx, 10
    ascii:
        inc     cs:counter
        xor     dx, dx
        mov     ax, di                                                      ; parte alta de la palabra
        mov     cx, ax
        div     bx                                                          ; se realiza la division
        mov     di, ax                                                      ; se almacena la parte alta
        mul     bx                                                          ; se multiplica
        sub     cx, ax                                                      ; se resta el valor divisible a la parte alta

        mov     dx, cx
        mov     ax, si                                                      ; parte baja de la palabra
        div     bx                              
        or      dl, 30h                                                     ; se convierte al ascii corespondiente
        push    dx                                                          ; se hace push
        mov     si, ax                                                      ; se almacena la parte baja
        or      ax, di                                                      ; se comprueba si aun hay algo mas para convertir
        jnz     ascii                                                       ; si aun hay que convertir se salta a ascci

    mov     di, cs:target                                                   ; se mueve el objetivo
    mov     cx, cs:counter                                                  ; se mueve el contador
    limpiarPila:
        pop     ax                                                          ; se hace un pop
        mov     [di], al    
        inc     di                                                          ; se incrementa di
        loop    limpiarPila                                                 ; se hace loop
    mov BYTE PTR [di], '$'                                                  ; se finaliza
    ret                                                                     ; se retorna
    counter     dw 0                                                        ; se limpia el contador
    target      dw 0                                                        ; se limpia el objetivo
convertirDecimal ENDP
end main