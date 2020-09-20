.model small
.stack
.data
 numA db 32h                        ; numA es igual a 2 en sistema decimal
 numB db 33h                        ; numB es igual a 3 en sistema decimal
 numC db 31h                        ; numC es igual a 1 en sistema decimal
 Ej_A db 'Ejercicio A: $'
 Ej_B db 'Ejercicio B: $'
 Ej_C db 'Ejercicio C: $'
 Ej_D db 'Ejercicio D: $'

.code
main:
    mov ax, @data
    mov ds, ax
    XOR AX, AX    
    jmp EjercicioA
    
    EjercicioA:                     ; EJERCICIO A: A + B
        mov dx, offset Ej_A         ; Se imprime el numero de ejercicio y que es lo que este realiza
        mov ah, 09h        
        int 21h

        mov dl, numA                ; imprime numA
        mov ah, 02h  
        int 21h 
        
        mov dl, 2Bh                 ; imprime +
        mov ah, 02h
        int 21h  

        mov dl, numB                ; imprime numbB
        mov ah, 02h   
        int 21h

        mov dl, 3DH                 ; imprime =
        mov ah, 02h   
        int 21h
 
        MOV AL, numA                ; se carga el valor de numA en AL
        ADD AL, numB                ; se adiciona numB a AL
        sub AL, 30h                 ; se resta 30h para visualizar el resultado real de la suma
                
        MOV DL, AL                  ; se imprime el resultado
        MOV AH, 02 
        INT 21H 
        
        MOV DL, 10                  ; se imprime un salto de linea
        MOV AH, 02
        INT 21h
        MOV DL, 13
        INT 21H
        
        XOR AX, AX
        jmp EjercicioB              ; se realiza un salto para ejecutar el ejercicio b
        
        MOV AH, 4CH                 ; finalizacion del proceso
        INT 21H                     ; ejecucion de interrupcion
        
     EjercicioB:                    ; EJERCICIO B: A - C
        mov dx, offset Ej_B         ; Se imprime el numero de ejercicio y que es lo que este realiza
        mov ah, 09h        
        int 21h
        
        mov dl, numA                ; se imprime numA
        mov ah, 02h  
        int 21h 

        mov dl, 2Dh                 ; se imprime -
        mov ah, 02h
        int 21h  

        mov dl, numC                ; se imprime numB
        mov ah, 02h   
        int 21h

        mov dl, 3DH                 ; se imprime =
        mov ah, 02h   
        int 21h

        MOV AL, numA                ; se carga el valor de numA en AL
        SUB AL, numC                ; se resta el valor de numB en AL
        ADD AL, 30h                 ; se adiciona 30h para visualizar el resultado real de la resta
        
        MOV DL, AL                  ; se imprime el resultado
        MOV AH, 02 
        INT 21H 

        MOV DL, 10                  ; se imprime un salto de linea
        MOV AH, 02
        INT 21h
        MOV DL, 13
        INT 21H
        
        XOR AX, AX
        jmp EjercicioC              ; se realiza un salto para ejecutar el ejercicio c
        
        MOV AH, 4CH                 ; finalizacion del proceso
        INT 21H                     ; ejecucion de interrupcion
        
    EjercicioC:                     ; EJERCICIO C: A + 2B + C
        mov dx, offset Ej_C         ; Se imprime el numero de ejercicio y que es lo que este realiza
        mov ah, 09h        
        int 21h
        
        mov dl, numA                ; se imprime numA
        mov ah, 02h  
        int 21h 

        mov dl, 2Bh                 ; se imprime +
        mov ah, 02h
        int 21h 

        mov dl, 28h                 ; se imprime (
        mov ah, 02h  
        int 21h 

        mov dl, 32h                 ; se imprime 2
        mov ah, 02h  
        int 21h 

        mov dl, 29h                 ; se imprime )
        mov ah, 02h  
        int 21h 
        
        mov dl, numB                ; se imprime numB
        mov ah, 02h   
        int 21h
        
        mov dl, 2Bh                 ; se +
        mov ah, 02h  
        int 21h 
        
        mov dl, numC                ; se imprime numC
        mov ah, 02h   
        int 21h
        
        mov dl, 3DH                 ; se imprime =
        mov ah, 02h   
        int 21h

                                    ; por jerarquia primero se realiza la multiplicacion
        
        MOV AL, numB                ; se carga el valor de numB en AL
        SUB AL, 30H                 ; se resta 30 en AL para trabajar con el valor real del numero
        MOV BL, 2                   ; se carga 2 en BL para realizar la multiplicacion
        MUL BL                      ; se realiza la multiplicacion de AL y BL
        MOV DL, AL                  ; se carga el valor de AL en DL
        ADD DL, numA                ; se suma numA a DL, no se resta ya que la multiplicacion aun se encuentra en un caracter no numerico
        add dl, numC                ; se suma NumC a DL
        sub dl, 30h                 ; se resta 30 a DL para tener el valor real de la operación
              
        MOV AH, 02                  ; se imprime el resultado  
        INT 21H 
        
        MOV DL, 10                  ; se imprime un salto de linea
        MOV AH, 02
        INT 21h
        MOV DL, 13
        INT 21H
        
        XOR AX, AX
        jmp EjercicioD              ; se realiza un salto para ejecutar el ejercicio c
        
        MOV AH, 4CH                 ; finalizacion del proceso
        INT 21H                     ; ejecucion de interrupcion
    
     EjercicioD:                    ; EJERCICIO B: A + B - C
        mov dx, offset Ej_D         ; Se imprime el numero de ejercicio y que es lo que este realiza
        mov ah, 09h        
        int 21h

        mov dl, numA                ; se imprime numA
        mov ah, 02h  
        int 21h 

        mov dl, 2Bh                 ; se imprime +
        mov ah, 02h
        int 21h  

        mov dl, numB                ; se imprime numB
        mov ah, 02h   
        int 21h

        mov dl, 2Dh                 ; se imprime -
        mov ah, 02h
        int 21h  

        mov dl, numC                ; se imprime numC
        mov ah, 02h   
        int 21h

        mov dl, 3DH                 ; se imprime =
        mov ah, 02h   
        int 21h

        MOV AL, numA                ; se carga el valor de numA en AL
        ADD AL, numB                ; se adiciona numB a AL
        sub AL, 30h                 ; se resta 30h para obtener el resultado real de la suma

        sub al, numC                ; se resta a AL el valor de Numc
        add al, 30h                 ; se adiciona 30 para obtener el valor real de la operación
        
        MOV DL, AL                  ; se imprime el resultado
        MOV AH, 02 
        INT 21H 
        
        MOV DL, 10                  ; se imprime un salto de linea
        MOV AH, 02
        INT 21h
        MOV DL, 13
        INT 21H
        
        XOR AX, AX        
        MOV AH, 4CH                 ; finalizacion del proceso
        INT 21H                     ; ejecucion de interrupcion
     
     
        
     MOV AH, 02H
     INT 21H
        
end main
