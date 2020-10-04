.model small 
.stack
.data
INGRESO     db  13,10,13,10,'CALCULO DE FACTORIAL',13,10,
	    db  'INGRESESE EL NUMERO AL QUE DESEA CALCULAR EL FACTORIAL',13,10, '> $'                     ; texto para solicitar una opcion en el menu
main:
        mov   ax,@data
        mov   ds,ax

    Menu:       
        lea     dx, INGRESO     ; se muestra el texto 
        mov     ah, 09h 
        int     21h 
    Salir: 
        mov   ah,4ch                                                                        ; se termina la ejecucion del programa
        int   21h 
END MAIN