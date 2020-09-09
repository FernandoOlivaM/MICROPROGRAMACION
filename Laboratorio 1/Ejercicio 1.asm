.model small 
.stack 
.data

nombre db 'Jose Fernando Oliva Morales',13,10,'$'   ; cadenas que seran mostradas en pantalla 
carne db '1251518',13,10,'$'                        ; 13,10,$ es utilizado como salto de linea

.code                                               
main:                                               ; etiqueta para el proceso
    mov ax, @data                                   ; direccion de inicio de segmento de datos
    mov ds, ax                                      
                                                    ; imprimir cadena nombre
    mov dx, offset nombre                           ; asignando dx a la variable nombre
    mov ah, 09h                                     ; se manda a imprimir la cadena
    int 21h                                         ; ejecuta proceso

    mov dx, offset carne                        
    mov ah, 09h 
    int 21h
    
    mov ah, 4Ch                                     ; finalizacion del proceso
    int 21h                                         ; ejecucion de interrupcion
end main