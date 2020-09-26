.model small
.stack 100h
.data
menuTxt      db  13,10,'INGRESE EL NUMERO DE EJERCICIO A REALIZAR',13,10                       ; texto para solicitar una opcion en el menu
             db  '1. Multiplicar Dos Numeros',13,10,'2. Dividir Dos Numeros',13,10
             db  '3. Obtener Factores de un Numero',13,10,'4. Convertir un Numero a Binario'
             db  13,10,'5. Salir',13,10,'> $'       
optNV        db  13,10,'Opcion no valida',13,10,'$'                                         ; texto para opcion no valida    
optMul       db  13,10,'MULTIPLICACION DE DOS NUMEROS',13,10,'$'                                            
optDiv       db  13,10,'DIVISION DE DOS NUMEROS',13,10,'$'                                            
optFac       db  13,10,'OBTENER FACTORES DE UN NUMERO',13,10,'$'                                            
optBin       db  13,10,'CONVERTIR NUMERO A BINARIO',13,10,'$'                                            
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
        cmp     al, '5'                                                                     ; se compara la opcion ingresada con tres
        jg      OptNoValida                                                                 ; si es mayor a 3 se vuelve a mostrar el menu, ya que no es valida
            
        cmp     al, '1'
        je      Multiplicar                                                                     ; Opcion para multiplicar
        cmp     al, '2'
        je      Dividir                                                               	    ; Opcion para dividir
        cmp     al, '3'
        je      Factores
        cmp     al, '4'
        je      Conversion
        cmp     al, '5'                                                                	     
        jmp     Salir                                                                       ; si la opcion ingresada es cinco se saldra del programa
      
    Multiplicar:       
        lea     dx, optMul                                                                
        mov     ah, 09h 
        int     21h    
        jmp     Menu                                                                        ; se retorna al menu principal
        
    Dividir:       
        lea     dx, opDiv                                                                
        mov     ah, 09h 
        int     21h    
        jmp     Menu                                                                        ; se retorna al menu principal
        
    Factores:       
        lea     dx, optFac                                                                
        mov     ah, 09h 
        int     21h    
        jmp     Menu                                                                        ; se retorna al menu principal
    Conversion:       
        lea     dx, optBin                                                                
        mov     ah, 09h 
        int     21h    
        jmp     Menu                                                                        ; se retorna al menu principal      
    OptNoValida:       
        lea     dx, optNv                                                                ; se muestra que la opcion ingresada no es valida
        mov     ah, 09h 
        int     21h    
        jmp     Menu                                                                        ; se retorna al menu principal
        
    Salir: 
        mov   ah,4ch                                                                        ; se termina la ejecucion del programa
        int   21h  
END MAIN
