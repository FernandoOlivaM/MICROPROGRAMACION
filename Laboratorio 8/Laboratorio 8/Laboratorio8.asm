Area macro base, altura		; esta macro solamente multiplica la base por altura
	xor ax, ax 
	mov al, base		 
	mul altura
	print str$(al),13,10	;se imprime el resultado del area en pantalla
	
endm	
Perimetro macro base, altura ;esta macro suma dos veces la base y dos veces el area
	xor ax, ax
	mov al, base
	add al, base
	add al, altura
	add al, altura
	print str$(al),13,10	; se imprime el resultado del perimetro en pantalla
endm	
Multiplica macro val1, val2	; esta macro multiplica dos valores
	xor ax,ax
	xor bx,bx
	MOV AL, val1
	mov bl, val2
	mul bl					; se alamacena el resultado en bl, ya que se utiliza en otros calculos
endm	
Divide macro val1, val2		; esta macro divide dos valres
	xor ax,ax
	xor bx,bx
	MOV AL, val1
	mov bl, val2
	div al				; se almacen el resultado en al, ya que se utiliza en otros calculos
endm


include \masm32\include\masm32rt.inc
include \masm32\include\masm32.inc
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
.386
.MODEL flat, stdcall
OPTION casemap:none ; convenion sobre mayusculas y minusculas al pasar parametros al api

.DATA
	menuPrincipal	db 13,10,13,10,"Por favor, ingrese el numero de ejercicio a elaborar:",13,10,"1. Ejercicio 1",13,10,"2. Ejercicio 2",13,10,"3. Ejercicio 3",13,10,"4. Salir",13,10,0
	subMenu1		db "CALCULO DE PERIMETRO Y AREA",13,10,"Por favor, ingrese el numero de figura a calcular:",13,10,"1. Cuadrado",13,10,"2. Rectangulo",13,10,"3. Triangulo",13,10,0
	subMenu2		db "CALCULO DE EXPRESIONES",13,10,0
	cadena1			db "contadorCadena EN CADENAS",13,10,"Por favor, ingrese la cadena a buscar",13,10,0
	cadena2			db "Por favor, ingrese la cadena en donde se buscara",13,10,0
	cadenaresult	db "La cadena 2 contiene a la cadena 1: ",0
	ingresoBase		db "Ingresa la longitud del base",13,10,0
	ingresoAltura	db "Ingrese la longitud del altura",13,10,0
	ingresoLado		db "Ingrese la longitud del lado",13,10,0
	opcionnoValida	db "Por favor, ingrese una opcion valida",13,10,0
	resArea			db "El area obtenida es de: ",0
	resPerimetro	db "El perimetro obtenido es de: ",0
	pedirA			db "Ingrese el valor de a",13,10,0
	pedirB			db "Ingrese el valor de b",13,10,0
	pedirC			db "Ingrese el valor de c",13,10,0
	opUno			db "El resultado de 2 * b + 3 * (a-c) es: ",0
	opDos			db "El resultado de  a/b es: ",0
	opTres			db "El resultado de a * b /c  es: ",0
	opCuatro		db "El resultado de a * (b/c) es: ",0
	opcionMenu		db 0,0
	base			db 0,0
	altura			db 0,0
	valA			db 0,0
	valB			db 0,0
	valC			db 0,0
	valtemp			db 0,0
	valtemp2		db 0,0
	result			db 0,0
	contadorCadena	db 0,0
	valCadena1		db 128 DUP (0),0
	valCadena2		db 128 DUP (0),0
.code

start:
	Menu:   
		INVOKE StdOut, ADDR menuPrincipal	; menu principal
		INVOKE StdIn, ADDR opcionMenu,10	; se lee la opcion del menu principal
        cmp     opcionMenu, '1'				; se evalua que la opcion sea valida
        jl      OptNoValida                                                                
        cmp     opcionMenu, '4'				; la opcion debe ser un numero entre 1 y 4              
        jg      OptNoValida                                                        
        cmp     opcionMenu, '1'				; la opcion 1 ejecuta el ejercicio 1
        je      Ejercicio1                                                              
        cmp     opcionMenu, '2'				; la opcion 2 ejecuta el ejercicio 2
        je      Ejercicio2    
		cmp     opcionMenu, '3'				; la opcion 3 ejecuta el ejercicio 3
        je      Ejercicio3  
        cmp     opcionMenu, '4'             ; la opcion 1 ejecuta la opcion de salir                                                      
        jmp     Salir 
		
	
	Ejercicio1:
		INVOKE StdOut, ADDR subMenu1
		INVOKE StdIn, ADDR opcionMenu,10	; se lee la opcion
		cmp     opcionMenu, '1'             ; la opcion debe ser un numero entre 1 y 3                                 
        jl      OptNoValida                                                                
        cmp     opcionMenu, '3'                   
        jg      OptNoValida                                                        
        cmp     opcionMenu, '1'				; la opcion 1 ejecuta el calculo para un cuadrado
        je      Cuadrado                                                              
        cmp     opcionMenu, '2'				; la opcion 2 ejecuta el calculo para un rectangulo
        je      Rectangulo
		cmp     opcionMenu, '3'				; la opcion 3 ejecuta el calculo para un tirangulo
        je      Triangulo  
		xor ax,ax
		jmp Ejercicio1						; de lo contrario, se salta Ejercicio1
	Cuadrado:
		INVOKE StdOut, ADDR	ingresoLado		; se pide ingresar la longitud del lado del cuadrado
		INVOKE StdIn, addr base,100			; se alamcena el valor
		SUB base, 30H						; se obtiene el valor real
		INVOKE StdOut, ADDR	resArea			; se da a conocer el resultado del area
		Area base,base						; se llama a la macro para calcular el area
		INVOKE StdOut, ADDR	resPerimetro	; se da a conocer el resultado del perimetro
		Perimetro base,base					; se llama a la macro para calcular el perimetro
		jmp Menu							; se retorna al Menu
	Rectangulo:
		INVOKE StdOut, ADDR	ingresoBase		; se pide ingresar la longitud de la base
		INVOKE StdIn, addr base,100			; se almacena el valor
		INVOKE StdOut, ADDR	ingresoAltura	; se pide ingresar la longitud de la altura
		INVOKE StdIn, addr altura,100		; se almacena el valor
		SUB base, 30H						; se obtiene el valor real del numero
		SUB altura, 30H
		INVOKE StdOut, ADDR	resArea			; se da a conocer el resultado del area
		Area base,altura					; se llama a la macro para calcular el area
		INVOKE StdOut, ADDR	resPerimetro	; se da a conocer el resultado del perimetro
		Perimetro base,altura				; se llama a la macro para calcular el perimetro
		jmp Menu							; se retorna al Menu
	Triangulo:
		INVOKE StdOut, ADDR	ingresoBase		; se pide ingresar la longitud de la base
		INVOKE StdIn, addr base,100			; se almacena el valor
		INVOKE StdOut, ADDR	ingresoAltura	; se pide ingresar la longitud de la altura
		INVOKE StdIn, addr altura,100		; se almacena el valor
		SUB base, 30H						; se obtiene el valor real del numero
		SUB altura, 30H
		MOV AL, base						; se divide la base a la mitad para el calculo del triangulo
		mov bl, 2
		div bl
		mov base,al							; se almacena el nuevo valor de la base
		INVOKE StdOut, ADDR	resArea			; se da a conocer el resultado del area
		Area base,altura					; se llama a la macro para calcular el area
		INVOKE StdOut, ADDR	resPerimetro	; se da a conocer el resultado del perimetro
		Perimetro base,altura				; se llama a la macro para calcular el perimetro
		jmp Menu							; se retorna al Menu
	Ejercicio2:
		INVOKE StdOut, ADDR subMenu2		; se muestra el texto del ejercicio 2
		INVOKE StdOut, ADDR	pedirA			; se pide el valor a
		INVOKE StdIn, addr valA,100			; se almacena el valor
		INVOKE StdOut, ADDR	pedirB			; se pide el valor b
		INVOKE StdIn, addr valB,100			; se almacena el valor
		INVOKE StdOut, ADDR	pedirC			; se pide el valor c
		INVOKE StdIn, addr valC,100			; se almacena el valor
		SUB valA, 30H						; se obtiene el valor real de los numeros
		SUB valB, 30H
		SUB valC, 30H
		;expresion 1
		INVOKE StdOut, ADDR	opUno			; se imprime la expresion 1
		xor ax,ax							; limpieza
		xor bx,bx							
		MOV valtemp,2						; se mueve 2 a valtemp para multiplicar
		Multiplica  valB, valtemp			; se llama la macro para multiplicar
		mov result,al						; se almacena el resultado
		mov bl, valA						; se resta A y C
		sub bl, valC
		mov valtemp2, bl
		mov valtemp,3						; se multplicara por 3
		Multiplica  valtemp2, valtemp		; se llama la macro para multplicar
		add result, al						; se suma al resultado
		print str$(result),13,10			; se imprime el resultado
		;expresion 2
		INVOKE StdOut, ADDR	opDos			; se imprime la expresion 2
		Divide valA,valB					; se llama la macro para dividir
		mov result,al						; se almacena el resultado
		print str$(result),13,10			; se imprime el resultado
		;expresion 3
		INVOKE StdOut, ADDR	opTres			; se imprime la expresion 3
		Multiplica  valA, valB				; se multiplica a y b
		MOV valtemp, al						; se almacena un resultado temporal
		Divide valtemp,valC					; se divide el temporal y c
		mov result,al						; se almacena el resultado
		print str$(result),13,10			; se imprime el resultado
		;expresion 4
		INVOKE StdOut, ADDR	opCuatro		; se imprime la expresion 4
		Divide valB,valC					; se llama la macro para dividir
		MOV valtemp, al						; se almacena el valor temporal
		Multiplica  valA, valtemp			; se llama la macro para multiplicar
		mov result,al						; se almacena el resultado
		print str$(result),13,10			; se imprime el resultado
		jmp Menu
	Ejercicio3:
		INVOKE StdOut, ADDR cadena1			; se pide la cadena a buscar
		INVOKE StdIn, ADDR valCadena1,100	; se almacena el valor
		INVOKE StdOut, ADDR cadena2			; se pide la cadena donde se buscara
		INVOKE StdIn, ADDR valCadena2,100	; se almacena el valor
		call BuscarCadena					; se llama el procedimiento para buscar
		INVOKE StdOut, ADDR cadenaresult	; se imprime la cantidad en pantalla
		print str$(contadorCadena)
		print chr$(" veces")
		jmp Menu							; se retorna

	OptNoValida:
		INVOKE StdOut, ADDR opcionnoValida	; se da a conocer que la opcion no es valida
		jmp Menu							; se retorna

	Salir:
		INVOKE ExitProcess,0				; se termina la ejecución


BuscarCadena PROC NEAR
	MOV	contadorCadena, 0					; se limpia el contador
	LEA EDI, valCadena1						; se mueven las cadenas
	LEA ESI, valCadena2
	MOV AH, 0

	buscar:
		MOV AL, [ESI]
		MOV BL, [EDI]
		INC EDI
		INC ESI	
		CMP BL, AL							; se compara el indice de la cadena 1 y la cadena 2
		JE buscar							; si no hay coinidencia se vuelve a buscar
		LEA EDI, valCadena1					; se vuelve a carcar la cadena 1
		CMP AL, AH							; se compara
		JE termina							; si ya no hay mas que evaluar se termina
		CMP BL, AH							; si hay una coincidencia se incrementa el contador
		JE incrementar
		JMP buscar							; si no se busca

	incrementar:
		INC contadorCadena					; se incrementa el contador
		DEC ESI								; se decrementa la cadena
		JMP buscar							; se retorna a buscar
	termina:	
		ret									; se termina la busqueda de cadena
	
BuscarCadena ENDP
end start