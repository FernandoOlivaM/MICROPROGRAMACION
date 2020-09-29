.model small
.stack 
.data
menuTxt      db  13,10,'INGRESE EL NUMERO DE OPCION A REALIZAR',13,10                       ; texto para solicitar una opcion en el menu
             db  '1. Generar UUID',13,10,'2. Validar UUID',13,10,'3. Salir',13,10,'> $'       
validarUUID  db  13,10,'Validar UUID',13,10,'$'                                             ; texto para opcion de validar
generarUUID  db  13,10,'Generar UUID',13,10,'$'                                             ; texto para opcion de generar
opcionNV     db  13,10,'Opcion no valida',13,10,'$'                                         ; texto para opcion de generar    
random       db  0  
.code
    MAIN proc near
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
    RND PROC near
    ; PARA LA OBTENCION DEL NUMERO ALEATORIO SE HACE UNA SUMA CON 
    ; TODOS LOS ELEMENTOS DE LA FECHA Y HORA DEL SISTEMA
    ; OBTENIENDOLOS Y ALMACENANDOLOS EN UNA VARIABLE
    ; TAMBIEN SE DIVIDE EL NUMERO OBTENIDO ENTRE 16 PARA OBTENER
    ; EL RESIDUO Y DEJARLO EN BASE HEXADECIMAL

    Mov random, 0                                                                           ; limpieza en random para no sobre escribir datos
    XOR AX, AX

    MOV AH, 00h                                                                             ; interrupción para obtener el tiempo del sistema         
    INT 1AH                                                                                 ; CX:DX contiene el numero de ticks desde la media noche      

    mov  ax, dx
    xor  dx, dx
    mov  cx, 10h                                                                            ; se almacena 10h en cx para realizar la división y así obtener un numero entre 0 y F
    div  cx                                                                                 ; se realiza la división
    mov random, dl                                                                          ; se almacena el residuo de la division en random
    xor AX, AX                                                                              ; se limpia AX
    ;Para imprimir el random se evalua que este sea mayor o menor a 9 (para mostrar la letra correspondiente si es mayor)  
    cmp RANDOM, 9h                                                                          ; se raliza una comparación del numero random y 9 para determinar si se imprime un digito o la letra      
    jle numero                                                                              ; si es menor o igual a 9 se hace un salto a numero
    cmp RANDOM, 9h                                                                          ; se compara nuevamente
    JG letra                                                                                ; si es mayor a 9 se hace un salto a letra
    letra:
        sub dl, 10                                                                          ; si se obtiene una letra, se resta 10 para tener solo los valores que no son digitos
        add dl, 'A'                                                                         ; se adiciona el valor de A
        
        mov ah, 02h                                                                         ; se imprime el caracter correspondiente
        int 21h
    
    numero:
        add dl, '0'                                                                         ; se adiciona el valor de 0
        mov ah, 02h                                                                         ; se imprime el caracter correspondiente
        int 21h
    RET                                                                                     ; retorno

    RND ENDP
    
END MAIN
