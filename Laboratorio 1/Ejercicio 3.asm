.model small 
.stack 
.code                                               
guiones:                    ; etiqueta para el proceso
    mov dl, 4Ah             ; imprimiendo 'J'
    mov ah, 02h
    int 21h
    mov dl, 2Dh             ; imprimiendo '-'
    mov ah, 02h
    int 21h
    mov dl, 6Fh             ; imprimiendo 'o'
    mov ah, 02h
    int 21h
    mov dl, 2Dh             ; imprimiendo '-'
    mov ah, 02h
    int 21h
    mov dl, 73h             ; imprimiendo 's'
    mov ah, 02h
    int 21h
    mov dl, 2Dh             ; imprimiendo '-'
    mov ah, 02h
    int 21h
    mov dl, 65h             ; imprimiendo 'e'
    mov ah, 02h
    int 21h
    mov dl, 20h             ; imprimiendo espacio
    mov ah, 02h
    int 21h
    mov dl, 4Fh             ; imprimiendo 'O'
    mov ah, 02h
    int 21h
    mov dl, 2Dh             ; imprimiendo '-'
    mov ah, 02h
    int 21h
    mov dl, 6Ch             ; imprimiendo 'l'
    mov ah, 02h
    int 21h
    mov dl, 2Dh             ; imprimiendo '-'
    mov ah, 02h
    int 21h
    mov dl, 69h             ; imprimiendo 'i'
    mov ah, 02h
    int 21h
    mov dl, 2Dh             ; imprimiendo '-'
    mov ah, 02h
    int 21h
    mov dl, 76h             ; imprimiendo 'v'
    mov ah, 02h
    int 21h
    mov dl, 2Dh             ; imprimiendo '-'
    mov ah, 02h
    int 21h
    mov dl, 61h             ; imprimiendo 'a'
    mov ah, 02h
    int 21h

    mov ah, 4Ch             ; finalizacion del proceso
    int 21h                 ; ejecucion de interrupcion
end guiones