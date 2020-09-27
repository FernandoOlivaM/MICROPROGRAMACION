.model small
.stack 100h
.data
menuTxt      db  13,10,'INGRESE EL NUMERO DE OPCION A REALIZAR',13,10                       ; texto para solicitar una opcion en el menu
             db  '1. Generar UUID',13,10,'2. Validar UUID',13,10,'3. Salir',13,10,'> $'       
validarUUID  db  13,10,'Validar UUID',13,10,'$'                                             ; texto para opcion de validar
generarUUID  db  13,10,'Generar UUID',13,10,'$'                                             ; texto para opcion de generar
opcionNV     db  13,10,'Opcion no valida',13,10,'$'                                         ; texto para opcion de generar    
random       db  0  
r            db  0
.code
    MAIN proc 
        mov   ax,@data
        mov   ds,ax

    Menu:       
        lea     dx, menuTxt                                                                 ; se muestra el texto del menu principal
        mov     ah, 09h 
        int     21h     
            
    leerOpcion:                     
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
        lea     dx, generarUUID  
        mov     ah, 09h 
        int     21h    
        call RND                                                                            ; se llama al procedimiento para generar un numero aleatorio
        jmp     Menu                                                                        ; se retorna al menu principal
        
    Validar:       
        lea     dx, validarUUID  
        mov     ah, 09h 
        int     21h    
        jmp     Menu                                                                        ; se retorna al menu principal
        
    OptNoValida:       
        lea     dx, opcionNV                                                                ; se muestra que la opcion ingresada no es valida
        mov     ah, 09h 
        int     21h    
        jmp     Menu                                                                        ; se retorna al menu principal

    Salir: 
        mov   ah,4ch                                                                        ; se termina la ejecucion del programa
        int   21h   
        
    MAIN endp
    
    ;generar Random a partir de fecha
    RND PROC
    ; PARA LA OBTENCION DEL NUMERO ALEATORIO SE HACE UNA SUMA CON 
    ; TODOS LOS ELEMENTOS DE LA FECHA Y HORA DEL SISTEMA
    ; OBTENIENDOLOS Y ALMACENANDOLOS EN UNA VARIABLE
    ; TAMBIEN SE DIVIDE EL NUMERO OBTENIDO ENTRE 16 PARA OBTENER
    ; EL RESIDUO Y DEJARLO EN BASE HEXADECIMAL

    Mov random, 0                                                                           ; limpieza en random para no sobre escribir datos
    MOV AH,2AH                                                                              ; Se obtiene la fecha del sistema
    INT 21H
    MOV AL,DL                                                                               ; Se obtiene el dia del sistema, esta en DL
    ADD AL,DH                                                                               ; Se obtiene el mes del sistema, esta en DH
    ;ADD AL,CH                                                                              ; Se obtiene el anio del sistema
    
    MOV AH,2CH                                                                              ; Se obtiene el tiempo del sistema
    INT 21H
    ADD AL,CH                                                                               ; Se obtiene la hora del sistema
    ADD AL,CL                                                                               ; Se obtiene el minuto del sistema
    ADD AL,DH                                                                               ; Se otiene el segundo de sistema
    MOV RANDOM, AL
    XOR AX, AX
    
    MOV AL, RANDOM                                                                          ; se realiza una division de random entre 10h, para representar el numero en sistema hexadecimal
    MOV BL, 10h
    DIV BL  
    mov RANDOM, 0                                                                           ; se limpia Random
    mov RANDOM, ah                                                                          ; se almacena el residuo de la division en random
    xor AX, AX  
    ;Para imprimir el random se evalua que este sea mayor o menor a 9 (para mostrar la letra correspondiente si es mayor)
    ;mov al, RANDOM
    ;cmp al, 9h
    ;jg sumar                                                                           ; si es mayor que 9 se suma 30H
    ;
    ;sumar:
    ;    add RANDOM, 11h
        
    mov dl, RANDOM    
    cmp dl, 9h
    JG letra
    cmp dl, 9h
    jle numero
    letra:
        sub dl, 10
        add dl, 'A'
        
        mov ah, 02h
        int 21h
    
    numero:
        add dl, 30h
        mov ah, 02h
        int 21h
    


    RET                                                                                     ; retorno

    RND ENDP
    
END MAIN
