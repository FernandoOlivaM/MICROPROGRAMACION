.model small
.stack 
.data
menuTxt      db  13,10,13,10,'INGRESE EL NUMERO DE OPCION A REALIZAR',13,10                 ; texto del menu principal
             db  '1. GENERAR UUID',13,10,'2. VALIDAR UUID',13,10,'3. SALIR',13,10,'> $'       
validarUUID  db  13,10,'INGRESE EL UUID A VALIDAR',13,10,'> $'                              ; texto para opcion de validar
generarUUID  db  13,10,'SE GENERO EL UUID:',13,10,'$'                                       ; texto para UUID generado
opcionNV     db  13,10,'LA OPCION INGRESADA NO ES VALIDA',13,10,'$'                         ; texto para indicar que la opcion del menu no es valida
uuidNv       db  13,10,'EL UUID INGRESADO NO ES VALIDO',13,10,'$'                           ; texto para indicar que el UUID ingresado no es correcto
uuidValido   db  13,10,'EL UUDI INGRESADO ES VALIDO',13,10,'$'                              ; texto para indicar que el UUID ingresado es correcto
ticks        dw  0                                                                          ; variable para almacenar el numero de ticks, sevira para generar el random
contador     db  0                                                                          ; variable para la longitud del bloque del UUID
.code
    MAIN proc near
        mov     ax,@data                                                                    ; direccion de inicio de segmento de datos
        mov     ds,ax

    Menu:                                                                                   ; menu principal
        lea     dx, menuTxt                                                                 ; se muestra el texto del menu principal
        mov     ah, 09h 
        int     21h     
            
        mov     ah, 1                                                                       ; se lee la opcion del menu
        int     21h        
        
        cmp     al, '1'                                                                     ; se compara la opcion ingresada con uno
        jl      OptNoValida                                                                 ; si es menor a 1 se vuelve a mostrar el menu, ya que no es valida
        cmp     al, '3'                                                                     ; se compara la opcion ingresada con tres
        jg      OptNoValida                                                                 ; si es mayor a 3 se vuelve a mostrar el menu, ya que no es valida
            
        cmp     al, '1'
        je      Generar                                                                     ; si la opcion ingresada es uno se generara un UUID
        cmp     al, '2'
        je      Validar                                                                     ; si la opcion ingresada es dos se validara un UUID
        cmp     al, '3'                                                                     
        jmp     Salir                                                                       ; si la opcion ingresada es tres se saldra del programa
            
    Generar:
        lea     dx, generarUUID                                                             ; se muestra el texto de la opcion del menu
        mov     ah, 09h 
        int     21h  
        call    genUUID                                                                     ; se llama al procedimiento genUUID
        jmp     Menu                                                                        ; se hace un salto para volver al menu princiapl

    Validar:       
        lea     dx, validarUUID                                                             ; se muestra el texto de la opcion del menu
        mov     ah, 09h 
        int     21h
        call    valUUID                                                                     ; se llama al procedimiento valUUID
        jmp     Menu                                                                        ; se retorna al menu principal
        
    OptNoValida:       
        lea     dx, opcionNV                                                                ; se muestra que la opcion ingresada no es valida
        mov     ah, 09h 
        int     21h    
        jmp     Menu                                                                        ; se retorna al menu principal
    uuidNoValido:
        lea     dx, uuidNv                                                                  ; se da a conocer que el uuid validado no es correcto
        mov     ah, 09h
        int     21h
        jmp     Menu                                                                        ; se retorna al menu principal
    Salir: 
        mov   ah,4ch                                                                        ; se termina la ejecucion del programa
        int   21h   
        
    MAIN endp
    
    ;validar el UUID ingresado

    valUUID proc near                                                                       ; procedimiento para validar un uuid ingresado (opcion 2)
    
    mov contador, 8                                                                         ; se indica la longitud del primer bloque (8)
        call    bloque                                                                      ; se llama al procedimiento bloque
        mov     dl, '-'                                                                     ; se imprime un guion en pantalla para iniciar el siguiente bloque
        mov     ah, 02h
        int     21h  
    mov contador, 4                                                                         ; se indica la longitud del segundo bloque (4)
        call    bloque                                                                      ; se llama al procedimiento bloque
        mov     dl, '-'                                                                     ; se imprime un guion en pantalla para iniciar el siguiente bloque
        mov     ah, 02h
        int     21h  
    mov contador, 3                                                                         ; se fija el contador en 3, ya que el tercer bloque debe iniciar con 1
        mov     ah, 1                                                                       ; se lee el caracter ingresado
        int     21h 
        cmp     al, '1'                                                                     ; se compara el caracter ingresado con 1
        je      v3                                                                          ; si el caracter es igual a 1 se hace un salto a v3
        jmp     uuidNoValido                                                                ; de lo contrario, el uuid no es valido
    v3: 
        call    bloque                                                                      ; se llama al procedimiento bloque
        mov     dl, '-'                                                                     ; se imprime un guion en pantalla para iniciar el siguiente bloque
        mov     ah, 02h
        int     21h  
    mov contador,3                                                                          ; se fija el contador en 3, ya que el cuarto bloque debe iniciar con 8,9,a,b
        mov     ah, 1                                                                       ; se lee el caracter ingresado 
        int     21h 
        cmp     al, '8'                                                                     ; se compara el caracter ingresado con 8
        je      v4                                                                          ; si el caracter es 8 se hace un salto a v4
        jmp     cmp9                                                                        ; de lo contario, se hace un salto a cmp9
    cmp9:
        cmp     al, '9'                                                                     ; se compara el caracter ingresado con 9
        je      v4                                                                          ; si el caracter es 9 se hace un salto a v4
        jmp     cmpa                                                                        ; de lo contario, se hace un salto a cmpa
    cmpa:
        cmp     al, 'a'                                                                     ; se compara el caracter ingresado con a
        je      v4                                                                          ; si el caracter es a se hace un salto a v4
        jmp     cmpb                                                                        ; de lo contrario, se hace un salto a cmpb
    cmpb:
        cmp     al, 'b'                                                                     ; se compara el caracter ingresado con b
        je      v4                                                                          ; si el caracter es b se hace un satlo a v4
        jne     uuidNoValido                                                                ; de lo contario, se salta a uuidNoValido
    v4:
        call    bloque                                                                      ; se llama al procedimiento bloque
        mov     dl, '-'                                                                     ; se imprime un guion en pantalla para iniciar el siguiente bloque
        mov     ah, 02h
        int     21h 
    mov contador,12                                                                         ; se fija el contador en 12, ya que es la longitud del quinto bloque
        call    bloque                                                                      ; se llama al procedimiento bloque
        lea     dx, uuidValido                                                              ; se muestra que el uuid es valido si llega a esta parte del programa
        mov     ah, 09h 
        int     21h     
    ret                                                                                     ; se retorna
    valUUID endp                                                                            ; fin del procedimiento
    
    rangos proc near                                                                        ; procedimiento para evaluar que un caracter del uuid este dentro del rango permitido
        mov     ah, 1 
        int     21h   

    m0:
        cmp     al, '0'                                                                     ; se compara el caracter ingresado con 0
        jge     r1                                                                          ; si es mayor o igual que 0 se salta a r1
        jmp     nv                                                                          ; de lo contario, el caracter no es valido y se salta a nv
    nv: 
        jmp     uuidNoValido                                                                ; se salta a uuidNoValido
    r1:
        cmp     al, '9'                                                                     ; se compara el caracter ingresado con 9
        jg      r2                                                                          ; si es mayor que 9 se salta a r2
        jmp     vv                                                                          ; de lo contario, el caracter es valido y se salta a vv
    r2:
        cmp     al, 'a'                                                                     ; se compara el caracter ingresado con a
        jge     r3                                                                          ; si es mayor o igual que a se salta a r3
        jmp     nv                                                                          ; de lo contrario, el caracter no es valido y se salta a nv
    r3:
        cmp     al, 'f'                                                                     ; se compara al caracter ingresado con f
        jg      nv                                                                          ; si es mayor que f se hace un salto a nv, ya que no es valido
        jmp     vv                                                                          ; de lo contrario, el caracter es valido pues esta en el rango

    vv:                                                                                     ; vv solo se utiliza para hacer un salto que indique que es correcto, este no realiza ninguna operacion

    ret                                                                                     ; se retorna
    rangos endp                                                                             ; fin del procedimiento
    
    bloque proc near                                                                        ; procedimiento para evaluar cada bloque ingresado con su longitud correspondiente
    valBloque:
        xor     ax,ax                                                                       ; se limpia ax
        call    rangos                                                                      ; se hace una llamada al procedimiento fangos
        dec     contador                                                                    ; se decrementa el contador
        jnz     valBloque                                                                   ; el contador no es cero se salta a valBloque
    ret
    bloque endp

    generateRandom PROC near                                                                ; procedimiento para generar un numero aleatorio

        XOR     AX, AX                                                                      ; se limpia ax
        MOV     AH, 00h                                                                     ; interrupcion para obtener el tiempo del sistema         
        INT     1AH                                                                         ; DX contiene el numero de ticks desde la media noche      
        add     ticks, dx                                                                   ; se añade el numero de tiks en dx a la variable correspondiente
        xor     dx, dx                                                                      ; se limpia dx
        
        mov     ax, ticks                                                                   ; se mueve la variable ticks a AX
        mov     cx, 10h                                                                     ; se almacena 10h en cx para realizar la division y asi obtener un numero entre 0 y F
        div     cx                                                                          ; se realiza la division  
        
        cmp     dl, 10                                                                      ; se raliza una comparacion del reciduo (random generado) de la operacion y 10 para determinar si se imprime un digito o la letra      
        jl      numero                                                                      ; si es menor que 10 un salto a numero
        Jmp     letra                                                                       ; de lo contario, se hace un salto a letra

    letra:
        add     dl, 39                                                                      ; si se obtiene una letra, se suma 39 para imprimir la letra entre a y f correspondiente

    numero:
        add     dl, 48                                                                      ; se adiciona 48 para obtener el valor real del numero
        mov     ah, 02h                                                                     ; se imprime el caracter correspondiente
        int     21h
    RET                                                                                     ; se retorna
    generateRandom ENDP                                                                     ; fin del procedimiento

    delay proc                                                                              ; procedmiento para realizar pausas (esto evita que todos los elementos del uuid generado sean iguales)
        mov     bp, 1080                                                                    ; se mueve 1080 al base pointer
        mov     si, 1080                                                                    ; se mueve 1080 a si
    delaycmp:
        dec     bp                                                                          ; se decrementa bp
        nop
        jnz     delaycmp                                                                    ; si no es cero se salta a delaycmp
        dec     si                                                                          ; se decrementa si
        cmp     si, 0                                                                       ; se compara si con 0    
        jnz     delaycmp                                                                    ; si no es cero se salta a delaycmp
        ret                                                                                 ; se retorna
    delay endp                                                                              ; fin del procedimiento

    genUUID proc near                                                                       ; procedimiento para generar un UUID
    mov contador, 8                                                                         ; se fija el contador en 8, ya que es la longitud del primer bloque
    b1:
        call    generateRandom                                                              ; se llama al procedimiento para generar un numero aleatorio
        call    delay                                                                       ; se llama al procedimiento delay para producir una pausa
        dec     contador                                                                    ; se decrementa el contador
        jnz     b1                                                                          ; si el contador no es cero se hace un salto a b1
        mov     dl, '-'                                                                     ; se imprime un guion en pantalla
        mov     ah, 02h
        int     21h   
        xor     dx,dx                                                                       ; se limpia dx
    mov contador, 4                                                                         ; se fija el contador en 4, ya que es la longitud del segundo bloque
    b2:
        call    generateRandom                                                              ; se llama al procedimiento para generar un numero aleatorio
        call    delay                                                                       ; se llama al procedimiento delay para producir una pausa
        dec     contador                                                                    ; se decrementa el contador
        jnz     b2                                                                          ; si el contador no es cero se hace un salto a b2
        mov     dl, '-'                                                                     ; se imprime un guion en pantalla
        mov     ah, 02h
        int     21h 
        xor     dx,dx                                                                       ; se limpia dx
    mov contador, 3                                                                         ; se fija el contador en 3, ya que el primer bloque debe iniciar con 1
        mov     dl, '1'                                                                     ; se imprime un 1
        mov     ah, 02h
        int     21h  
    b3:
        call    generateRandom                                                              ; se llama al procedimiento para generar un numero aleatorio
        call    delay                                                                       ; se llama al procedimiento delay para producir una pauta
        dec     contador                                                                    ; se decrementa el contador
        jnz     b3                                                                          ; si el contador no es cero se hace un salto a b3
        mov     dl, '-'                                                                     ; se imprime un guion en pantalla
        mov     ah, 02h
        int     21h 
        xor     dx,dx                                                                       ; se limpia dx
    mov contador, 3                                                                         ; se fija el contador en 3, ya que el primer bloque debe iniciar con 8,9,a,b
        mov     dl, 'a'                                                                     ; se imprime una a
        mov     ah, 02h
        int     21h   
    b4:
        call    generateRandom                                                              ; se llama al procedimiento para generar un numero aleatorio
        call    delay                                                                       ; se llama el procedimiento delay para producir una pausa
        dec     contador                                                                    ; se decrementa el contador
        jnz     b4                                                                          ; si el contador no es cero se hace un salto a b4
        mov     dl, '-'                                                                     ; se imprime un guion en pantala
        mov     ah, 02h
        int     21h   
        xor     dx,dx                                                                       ; se limpia dx
    mov contador, 12                                                                        ; se fija el contador en 12, ya que es la longitud del quinto bloque
    b5:
        call generateRandom                                                                 ; se llama al procedimiento para generar un numero aleatorio
        call delay                                                                          ; se llama el procedimiento delay para producir una pausa
        dec contador                                                                        ; se decrementa el contador
        jnz b5                                                                              ; si el contador no es cero se salta a b5
    ret                                                                                     ; se retorna
    genUUID endp                                                                            ; fin del procedimiento
END MAIN                                                                                    ; fin del programa
