 .model small 
.stack
.data
menuTxt     db  13,10,13,10,'INGRESE EL NUMERO DE EJERCICIO A REALIZAR',13,10                     ; texto para solicitar una opcion en el menu
            db  '1. Multiplicar Dos Numeros',13,10,'2. Dividir Dos Numeros',13,10
            db  '3. Obtener Factores de un Numero',13,10,'4. Convertir un Numero a Binario'
            db  13,10,'5. Salir',13,10,'> $'       
optMul      db  13,10,'MULTIPLICACION DE DOS NUMEROS',13,10,'$' 
optDiv      db  13,10,'DIVISION DE DOS NUMEROS',13,10,'$'                                            
optFac      db  13,10,'OBTENER FACTORES DE UN NUMERO',13,10,'$'                                        
optBin      db  13,10,'CONVERTIR NUMERO A BINARIO',13,10,'$'
optRes      db  13,10,'EL RESULTADO DE LA OPERACION ES: ',13,10,'$'
residuo     db  13,10,'El RESIDUO DE LA OPERACION ES:',13,10,'$'
inMul1      db  13,10,'INGRESE EL PRIMER FACTOR',13,10,'DE LA FORMA: 01 o 99',13,10,'> $'
inMul2      db  13,10,'INGRESE EL SEGUNDO FACTOR',13,10,'DE LA FORMA: 01 o 99',13,10,'> $'
inDiv1      db  13,10,'INGRESE EL DIVIDENDO',13,10,'DE LA FORMA: 01 o 99',13,10,'> $'
inDiv2      db  13,10,'INGRESE EL DIVISOR',13,10,'DE LA FORMA: 01 o 99',13,10,'> $'
inFac       db  13,10,'INGRESE EL NUMERO DEL QUE SE OBTENDRAN LOS FACTORES',13,10,'DE LA FORMA: 01 o 99',13,10,'> $'
inCon       db  13,10,'INGRESE EL NUMERO A CONVERTIR A BINARIO',13,10,'DE LA FORMA: 01 o 99',13,10,'> $'
num1        dw  0
num2        dw  0
result      dw  0
cosiente    dw  0
decenas     db  0
factor      dw  2
.code
main:
        mov   ax,@data
        mov   ds,ax

    Menu:       
        lea     dx, menuTxt                                                                 ; se muestra el texto del menu principal
        mov     ah, 09h 
        int     21h     
            
    leerOpcion:                     
        mov     ah, 01H                                                                     ; se lee la opcion del menu
        int     21h        

        cmp     al, '1'
        je      optMultiplicar                                                              ; Opcion para multiplicar
        cmp     al, '2'
        je      optDividir                                                                  ; Opcion para dividir
        cmp     al, '3'
        je      optFactores                                                                 ; Opcion para encontrar factores
        cmp     al, '4'
        je      optConversion                                                               ; Opcion para convertir a binario
        cmp     al, '5'                                                                      
        jmp     Salir                                                                       ; si la opcion ingresada es cinco se saldra del programa
      
    optMultiplicar:    

        lea     dx, optMul                                                                  ; multiplicacion de dos numeros                                              
        mov     ah, 09h 
        int     21h 
        
        lea     dx, inMul1                                                                  ; se solicita el primer factor
        mov     ah, 09h 
        int     21h 
        xor     dx,dx
        
        call    leernum1                                                                    ; se llama al procedimiento para la lectura el primer numero
        
        
        lea     dx, inMul2                                                                  ; se solicita el segundo factor
        mov     ah, 09h 
        int     21h 
        xor     dx,dx
        
        call    leernum2                                                                    ; se llama al procedimiento para la lectura el segundo numero
        
        lea     dx, optRes                                                                  ; resultado de la operacion
        mov     ah, 09h 
        int     21h 
        xor     dx,dx
        call    multiplicar    
        jmp     Menu                                                                        ; se retorna al menu principal
        
    optDividir:       
        lea     dx, optDiv                                                                  ; division de dos numeros
        mov     ah, 09h 
        int     21h 
        
        lea     dx, inDiv1                                                                  ; se solitia el dividendo     
        mov     ah, 09h     
        int     21h   
        
        call    leernum1                                                                    ; se llama al procedimiento para la lectura el primer numero
        
        lea     dx, inDiv2                                                                  ; se solicita el divisor
        mov     ah, 09h 
        int     21h 
        
        call    leernum2                                                                    ; se llama al procedimiento para la lectura el segundo numero
        
        lea     dx, optRes                                                                  ; resultado de la operacion
        mov     ah, 09h 
        int     21h

        call    dividir
        
        jmp     Menu                                                                        ; se retorna al menu principal
        
    optFactores:       
        lea     dx, optFac                                                                  ; obtener factores de un numero                                  
        mov     ah, 09h 
        int     21h    

        lea     dx, inFac                                                                   ; se solicta el numero                                                             
        mov     ah, 09h 
        int     21h 
        
        call    leernum1                                                                    ; se llama el procedimiento para leer el numero

        lea     dx, optRes                                                                  ; resultado de la operacion
        mov     ah, 09h 
        int     21h

        call    factorizar
        
        jmp     Menu                                                                        ; se retorna al menu principal
    optConversion:       
        lea     dx, optBin                                                                  ; convertir un numero a binario                                            
        mov     ah, 09h 
        int     21h  

        lea     dx, inCon                                                                   ; se solicita el numero a convertir
        mov     ah, 09h 
        int     21h   

        call    leernum1                                                                    ; se llama al procedimiento para leer el numero

        lea     dx, optRes                                                                  ; resultado de la operacion
        mov     ah, 09h 
        int     21h
    
        call    convertir
        
        jmp     Menu                                                                        ; se retorna al menu principal      

    multiplicar proc near
        xor     bx, bx                                                                      ; se limpia bx 
        xor     cx, cx                                                                      ; se limpia cx previamente a armar el loop
        mov     cx, num2                                                                    ; se mueve num2 a cx, se asigna el numero de iteraciones
        sub     cx, 1                                                                       ; se resta uno para que el contador finalice en cero
        
        mov     ah, 02
        mov     dl,0Ah
        int     21h

        mov     bx, num1                                                                    ; se mueve num1 a bx

        mult:
                add     bx, num1                                                            ; se adiciona a bx num1
            loop mult                                                                       ; se crea el loop
    
        call    disp                                                                        ; se llama al procedimiento para imprimir lo contenido en bx    
        ret                                                                                 ; se retorna
    multiplicar endp
    
    dividir proc near
        mov     cosiente, 0                                                                 ; se limpia el cosiente
        restar:
            mov     ax, num2                                                                ; se mueve el divisor                                             
            cmp     num1, ax                                                                ; se compara el dividendo y divisor
            jl      imprimirDivision                                                        ; si es menor se imprimern los resultados          
            sub     num1, ax                                                                ; se resta num2 a num1
            inc     cosiente                                                                ; se incrementa el cosiente en uno
            jmp     restar                                                                  ; se hace un salto a restar
        imprimirDivision:
            lea     dx, optRes                                                              ; resultado de la operacion
            mov     ah, 09h 
            int     21h
            mov     bx, cosiente                                                            ; se mueve el cosiente a bx 
            call    disp                                                                    ; se llama al procedimiento para imprimir lo contenido en bx    
            lea     dx, residuo                                                             ; residuo de la operacion
            mov     ah, 09h 
            int     21h
            mov     bx, num1                                                                ; se mueve el residuo a bx
            call    disp                                                                    ; se llama al procedimiento para imprimir lo contenido en bx    

        ret
    dividir endp
    
    factorizar proc near
        mov     factor, 2                                                                   ; se reinicia factor
        factores:
            xor     ax,ax                                                                   ; se limpia ax
            xor     bx,bx                                                                   ; se limpia bx
            mov     ax, factor                                                              ; se calcula el valor para factor²
            mov     bx, factor
            mul     bx
            
            cmp     ax, num1                                                                ; se compara factor² con num1
            jle     obtener                                                                 ; si es menor o igual se hace un salto a obtener
            cmp     num1, 1                                                                 ; se compara num1 con uno
            jg      imprimirNum                                                             ; si num1 es mayor que uno se salta a imprimirNum
        obtener:
            mov     ax, num1                                                                ; se mueve num1 a ax
            mov     cx, factor                                                              ; se mueve factor a cs
            div     cx                                                                      ; se realiza una division
            cmp     dx, 0                                                                   ; se compara el residuo de la division y cero
            je      imprimirFactor                                                          ; si es igual a cero se hace un salto a imprimirFactor
            cmp     dx, 0                                                                   ; se compara el residuo de la division y cero
            jne     aumentarFactor                                                          ; si es distinto a cero se hace un salto a aumentarFactor
        aumentarFactor:
            inc     factor                                                                  ; se incrementa el factor
            jmp     factores                                                                ; se salta a factores nuevamnete
        imprimirFactor:
            mov     bx, factor                                                              ; se mueve el factor a bx
            mov     num1, ax                                                                ; se mueve el cosiente de la division a num1, para la siguiente iteracion
            call    disp                                                                    ; se llama al procedimiento para imprimir lo contenido en bx    
            mov     dl, 2Ch                                                                 ; se imprime una coma
            mov     ah, 02h
            int     21h
            mov     dl, 20h                                                                 ; se imprime un espacio
            mov     ah, 02h
            int     21h
            jmp     factores                                                                ; se salta a factores nuevamente
        imprimirNum:
            mov     bx,num1                                                                 ; se mueve num1 a bx
            call    disp                                                                    ; se llama al procedimiento para imprimir lo contenido en bx     
        ret
    factorizar endp
    
    convertir proc near
        mov     bx, num1                                                                    ; se mueve el numero a convertir
        mov     cx, 8                                                                       ; se establece que los numeros son de 8 bits
        binario:
            mov     ah, 02h                                                                 ; se mueve 02h a ah, ya que es la base del sistema a convertir
            shl     bl, 1                                                                   ; se hace un desplazamiento a la izquierda
            jc      imprimirUno                                                             ; si se desplaza se hace un salto para imprimir uno                      
            mov     dl, 30h                                                                 ; si no hay desplazamiento, se mueve 30h a dl, ya que alli arrancan los numeros en ascii
            jmp     imprimirCero                                                            ; se hace un salto para imprimir cero
            imprimirUno:
                    mov     dl,31h                                                          ; se imprime un uno
            imprimirCero:   
                    int     21h                                                             ; se imprime un cero (este valor ya viene dado previo al salto)
                loop binario
        ret
    convertir endp

    leernum1 proc near
        mov     num1, 0                                                                     ; se limpia num1
        MOV     AH, 01H                                                                     ; se lee el primer digito del numero primer numero
        INT     21H
        SUB     AX, 30H                                                                     ; se obtiene el valor real del numero restando 30
        MOV     Dl, 10                                                                      ; se multiplica por 10, ya que el primer digito representa las decenas
        MUL     Dl
        
        MOV     num1, AX                                                                    ; se almacena el valor de las decenas
        XOR     AX, AX                                                                      ; se limpia AX

        MOV     AH, 01H                                                                     ; se lee el segundo digito del primer numero
        INT     21H
        MOV     AH, 00h
        SUB     AX, 30H                                                                     ; se obtiene el valor real del numero restando 30
        ADD     num1, AX                                                                    ; se suman las unidades al primer numero
        XOR     AX, AX 
        ret                                                                                 ; se regresa a donde fue llamado
    leernum1 endp
    leernum2 proc near
        mov     num2, 0                                                                     ; se limpia num2
        MOV     AH, 01H                                                                     ; se lee el primer digito del segundo numero
        INT     21H
        SUB     AX, 30H                                                                     ; se obtiene el valor real del numero restando 30
        MOV     Dl, 10                                                                      ; se multiplica por 10, ya que el primer digito representa las decenas
        MUL     Dl
        
        MOV     num2, AX                                                                    ; se almacena el valor de las decenas
        XOR     AX, AX                                                                      ; se limpia AX

        MOV     AH, 01H                                                                     ; se lee el segundo digito del segundo numero
        INT     21H
        MOV     AH, 00h
        SUB     AX, 30H                                                                     ; se obtiene el valor real del numero restando 30
        ADD     num2, AX                                                                    ; se suman las unidades al segundo numero
        XOR     AX, AX 
        ret                                                                                 ; se regresa a donde fue llamado
    leernum2 endp
    
    disp proc near
    cmp bl, 9h
    jle unDigito
    cmp bl, 9h
    jg dosDigitos
    dosDigitos:
        inc decenas
        sub bl, 10
        cmp bl, 9h
        jle unDigito
        cmp bl, 9h
        jg dosDigitos
    unDigito:
        mov dl, decenas
        add dl, 30h
        mov ah,02h
        int 21h
        xor dx,dx
        mov decenas,0
        mov dl,bl
        add dl, 30h
        mov ah, 02h
        int 21h   
    ret
    disp endp

    Salir: 
        mov   ah,4ch                                                                        ; se termina la ejecucion del programa
        int   21h  
END MAIN
