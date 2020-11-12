Mapeo MACRO roxIndex, colIndex, Filas, Columnas, dimension
	MOV AL, roxIndex
	MOV BL, Columnas
	mul BL				
	MOV BL, dimension
	MUL BL			
	MOV CL, AL	
	MOV AL, colIndex
	MOV BL, dimension
	MUL BL
	ADD AL, CL	
ENDM
.386
.MODEL flat, stdcall										
OPTION casemap:none
INCLUDE \masm32\include\windows.inc
INCLUDE \masm32\include\kernel32.inc
INCLUDE \masm32\include\masm32.inc
INCLUDE \masm32\include\masm32rt.inc
.DATA
	textMenu DB 13,10,"POR FAVOR, INGRESE LA OPCION A REALIZAR",13,10,"1. LLENAR AUTOMATICAMENTE",13,10,"2. LLENAR MANUALMENTE",13,10,"3. SALIR",13,10,0
	ingresaCol DB "Ingrese la cantidad de columnas",13,10,0
	IngresaFil DB "Ingrese la cantidad de filas",13,10,0
	CantCeldas DB "La dimensin de la matriz es: ",0
	dimMatriz DB "La matriz obtenida es: ",13,10,0
	IngresarChar DB "Ingrese el caracter a añadir a la matriz: ",0
	dimNoValida DB "La dimension de la matriz excede el limite (1-99).",13,10,0
	colMatriz DB 0,0
	filMatriz DB 0,0
	DimensionMatriz DB 0,0
	optMenu DB 0,0
	Matriz DW 100 DUP ("$")
	auxMatriz DB 0,0
	colIndex DB 0,0
	rowIndex DB 0,0
	contadorAlv db 0,0
.CODE
Programa:
	Menu:
		INVOKE StdOut, ADDR textMenu
		INVOKE StdIn, ADDR optMenu, 10
		cmp     optMenu, '1'				; se evalua que la opcion sea valida
        jl      OptNoValida                                                                
        cmp     optMenu, '3'				; la opcion debe ser un numero entre 1 y 3             
        jg      OptNoValida                                                        
        cmp     optMenu, '1'				; la opcion 1 ejecuta el ejercicio 1
        je      Ejercicio1                                                              
        cmp     optMenu, '2'				; la opcion 2 ejecuta el ejercicio 2
        je      Ejercicio2		
		cmp		optMenu, '3'				; la opcion tres ejecuta la salida
		je		Salir	
	Ejercicio1:
		CALL leerDimensiones			;llamada a procedimiento para leer dimensiones
		INVOKE StdOut, ADDR dimMatriz
		column:
			Mapeo rowIndex, colIndex, filMatriz, colMatriz, 1		;llamada a macro para el mapeo
			MOV DimensionMatriz, AL
			CALL printMatirz		;llamada al procedimiento para imprimir la matriz
			print chr$(9)
			INC colIndex			;incremento al indice de columnas
			MOV CL, colIndex
			CMP CL, colMatriz
			JL column
			INC rowIndex			;incremento al indice de filas
			MOV CL, rowIndex
			CMP CL, filMatriz
			JL row
			JMP Menu
		row:
			MOV colIndex, 0h
			print chr$(10)
			JMP column
			
	Ejercicio2:
		CALL leerDimensiones ;llamada al procedimiento para leer dimensiones
		CALL llenarMatriz	;llamada al procedimiento para llenar la matriz manualmente
		MOV AL, colMatriz
		MOV BL, filMatriz
		MUL BL
		MOV DimensionMatriz, AL ;obtension de la dimension
		CALL sortManual
		INVOKE StdOut, ADDR dimMatriz
		CALL printManual	; llamada a procedmineot para imprimir la matriz manualmente ingresada
		JMP Menu
		
	OptNoValida:		;opcion de menu no valida
		INVOKE StdOut, ADDR dimNoValida
		JMP Salir
	Salir:
		INVOKE ExitProcess, 0		;fin de la ejecucion

	printManual PROC near	;procedimiento para imprimir la matruz manualmente ingresada
		MOV colIndex, 0h	; se limpian los indices
		MOV rowIndex, 0h
		LEA ESI, Matriz
		colManual:
			MOV AL, [ESI]
			MOV DimensionMatriz, AL
			INVOKE StdOut, ADDR DimensionMatriz	;se imprime el elemento
			print chr$(9)	;tabulador
			INC ESI		;incrementa indice
			INC colIndex
			MOV CL, colIndex
			CMP CL, colMatriz
			JL colManual
			INC rowIndex
			MOV CL, rowIndex
			CMP CL, filMatriz
			JL filManual
			JMP Salir
		filManual:
			MOV colIndex, 0h
			print chr$(10)	;se imprme el salto de linea
		JMP colManual
	ret
	printManual ENDP
	sortManual PROC near	;procedimiento para ordenar la matriz manualmente ingresada
		MOV CL, DimensionMatriz
		SUB CL, 01H
		JMP origen
		volverOrigen:
			INC rowIndex ;incremento de indice
		origen:
			LEA ESI, Matriz
			LEA EDI, Matriz
			INC EDI
			CMP CL,rowIndex
			JE ordenado
			MOV colIndex, 0h
			JMP recorrer
		volverColumna:
			INC colIndex ;incremento de indice
		recorrer:
			MOV DL, DimensionMatriz
			SUB DL, rowIndex
			SUB DL, 01h
			CMP DL, colIndex
			JE volverOrigen
			MOV AL, [ESI]
			MOV BL, [EDI]
			CMP AL, BL
			JG cambiarColumna
			INC EDI
			INC ESI
			JMP volverColumna
		cambiarColumna:		;cambio de columna
			MOV [ESI],BL
			MOV [EDI],AL
			INC EDI
			INC ESI
			JMP volverColumna
		ordenado:
	ret
	sortManual ENDP

	leerDimensiones PROC Near  ;lectua de filas y columnas
		INVOKE StdOut, ADDR ingresaCol
		INVOKE StdIn, ADDR colMatriz,100
		INVOKE StdOut, ADDR IngresaFil
		INVOKE StdIn, ADDR filMatriz,100
		SUB filMatriz, 30H ;valores reales de los numeros
		SUB colMatriz,30H 
		mov al, filMatriz		 
		mul colMatriz
		MOV DimensionMatriz,al	;obtension de la dimension
		INVOKE StdOut, ADDR CantCeldas
		print str$(DimensionMatriz),10 ; se imprime la dimension
	ret
	leerDimensiones ENDP
	llenarMatriz PROC near  ;llenar la matriz manualmente
			LEA ESI, Matriz
			XOR CX, CX
			MOV CL, DimensionMatriz
			MOV DimensionMatriz, 0h
			MOV contadorAlv, CL
			ent:
				
				INVOKE StdOut, ADDR IngresarChar
				INVOKE StdIn, ADDR auxMatriz, 100
				MOV AL, auxMatriz
				MOV [ESI], AL
				INC ESI
				XOR ECX,ECX
				dec contadorAlv
				jnz ent
		ret
		llenarMatriz ENDP
	printMatirz PROC near ;imprimir matriz llenada automaticamente
		MOV BL, DimensionMatriz
		CMP DimensionMatriz, 0Ah
		JL ajuste
		JMP imprime
		ajuste:
			MOV AL, 0h
			print str$(AL)
		imprime:
			MOV AL,BL
			print str$(AL)
	ret
	printMatirz ENDP
END Programa