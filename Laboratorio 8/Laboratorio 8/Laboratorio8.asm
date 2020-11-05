cls macro
	pusha
	mov ah, 0x00
	mov al, 0x03  
	int 0x10
	popa
endm
Area macro base, altura
	xor ax, ax 
	mov al, base
	mul altura
	print str$(al),13,10
	
endm	
Perimetro macro base, altura
	xor ax, ax
	mov al, base
	add al, base
	add al, altura
	add al, altura
	print str$(al),13,10
endm	
Multiplica macro val1, val2
	xor ax,ax
	xor bx,bx
	MOV AL, val1
	mov bl, val2
	mul bl
endm	
Divide macro val1, val2
	xor ax,ax
	xor bx,bx
	MOV AL, val1
	mov bl, val2
	div al
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
	cadena1			db "CONTADOR EN CADENAS",13,10,"Por favor, ingrese la cadena a buscar",13,10,0
	cadena2			db "Por favor, ingrese la cadena en donde se buscara",13,10,0
	ingresoBase		db "Ingresa la longitud del base",13,10,0
	ingresoAltura	db "Ingrese la longitud del altura",13,10,0
	ingresoLado		db "Ingrese la longitud del lado",13,10,0
	opcionnoValida	db "Por favor, ingrese una opcion valida",13,10,0
	resArea			db "El area obtenida es de: ",0
	resPerimetro	db "El perimetro obtenido es dec: ",0
	pedirA			db "Ingrese el valor de a",13,10,0
	pedirB			db "Ingrese el valor de b",13,10,0
	pedirC			db "Ingrese el valor de c",13,10,0
	opUno			db "El resultado de 2 * b + 3 * (a-c) es: ",0
	opDos			db "El resultado de  a/b es: ",0
	opTres			db "El resultado de a * b /c  es: ",0
	opCuatro		db "El resultado de a * (b/c) es: ",0
	opcionMenu		db 0
	base db 0
	altura db 0
	valA db 0
	valB db 0
	valC db 0
	valtemp db 0
	valtemp2 db 0
	result db 0
.code

start:
PRINCIPAL PROC
	Menu:   
		INVOKE StdOut, ADDR menuPrincipal
		INVOKE StdIn, ADDR opcionMenu,10; menu principal
        cmp     opcionMenu, '1'                                              
        jl      OptNoValida                                                                
        cmp     opcionMenu, '4'                                                             
        jg      OptNoValida                                                        
        cmp     opcionMenu, '1'
        je      Ejercicio1                                                              
        cmp     opcionMenu, '2'
        je      Ejercicio2    
		cmp     opcionMenu, '3'
        je      Ejercicio3  
        cmp     opcionMenu, '4'                                                                     
        jmp     Salir 
		
	
	Ejercicio1:
		INVOKE StdOut, ADDR subMenu1
		INVOKE StdIn, ADDR opcionMenu,10 ; se lee la opcion
		cmp     opcionMenu, '1'                                              
        jl      OptNoValida                                                                
        cmp     opcionMenu, '3'                                                             
        jg      OptNoValida                                                        
        cmp     opcionMenu, '1'
        je      Cuadrado                                                              
        cmp     opcionMenu, '2'
        je      Rectangulo
		cmp     opcionMenu, '3'
        je      Triangulo  
		xor ax,ax
		jmp Ejercicio1
	Cuadrado:
		INVOKE StdOut, ADDR	ingresoLado
		INVOKE StdIn, addr base,10
		SUB base, 30H
		INVOKE StdOut, ADDR	resArea
		Area base,base
		INVOKE StdOut, ADDR	resPerimetro
		Perimetro base,base
		jmp Menu	
	Rectangulo:
		INVOKE StdOut, ADDR	ingresoBase
		INVOKE StdIn, addr base,10
		INVOKE StdOut, ADDR	ingresoAltura
		INVOKE StdIn, addr altura,10
		SUB base, 30H
		SUB altura, 30H
		INVOKE StdOut, ADDR	resArea
		Area base,altura
		INVOKE StdOut, ADDR	resPerimetro
		Perimetro base,altura
		jmp Menu
	Triangulo:
		INVOKE StdOut, ADDR	ingresoBase
		INVOKE StdIn, addr base,10
		INVOKE StdOut, ADDR	ingresoAltura
		INVOKE StdIn, addr altura,10
		SUB base, 30H
		SUB altura, 30H
		MOV AL, base
		mov bl, 2
		div bl
		mov base,al
		INVOKE StdOut, ADDR	resArea
		Area base,altura
		INVOKE StdOut, ADDR	resPerimetro
		Perimetro base,altura
		jmp Menu
	Ejercicio2:
		INVOKE StdOut, ADDR subMenu2
		INVOKE StdOut, ADDR	pedirA
		INVOKE StdIn, addr valA,10
		INVOKE StdOut, ADDR	pedirB
		INVOKE StdIn, addr valB,10
		INVOKE StdOut, ADDR	pedirC
		INVOKE StdIn, addr valC,10
		SUB valA, 30H
		SUB valB, 30H
		SUB valC, 30H
		;expresion 1
		INVOKE StdOut, ADDR	opUno
		xor ax,ax
		xor bx,bx
		MOV valtemp,2
		Multiplica  valB, valtemp
		mov result,al
		mov bl, valA
		sub bl, valC
		mov valtemp2, bl
		mov valtemp,3
		Multiplica  valtemp2, valtemp
		add result, al
		print str$(result),13,10
		;expresion 2
		INVOKE StdOut, ADDR	opDos
		Divide valA,valB
		mov result,al
		print str$(result),13,10
		;expresion 3
		INVOKE StdOut, ADDR	opTres
		Multiplica  valA, valB
		MOV valtemp, al
		Divide valtemp,valC
		mov result,al
		print str$(result),13,10
		;expresion 4
		INVOKE StdOut, ADDR	opCuatro
		Divide valB,valC
		MOV valtemp, al
		Multiplica  valA, valtemp
		mov result,al
		print str$(result),13,10
		jmp Menu
	Ejercicio3:
		INVOKE StdOut, ADDR cadena1
		INVOKE StdOut, ADDR cadena2
		xor ax,ax
		jmp Menu

	OptNoValida:
		INVOKE StdOut, ADDR opcionnoValida
		jmp Menu

	Salir:
		INVOKE ExitProcess,0									; se termina la ejecución

PRINCIPAL ENDP
end start