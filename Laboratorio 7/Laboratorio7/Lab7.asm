include \masm32\include\masm32rt.inc
include \masm32\include\masm32.inc
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
.386
.MODEL flat, stdcall
OPTION casemap:none ; convenion sobre mayusculas y minusculas al pasar parametros al api

.DATA
		nombre DB 128 DUP (0)							;variable para almacenar el nombre
		carne DB 128 DUP (0)							;variable para almacenar el carne
		carrera DB 128 DUP (0)							;variable para almacenar la carrera
.code

start:
	printf("Por Favor, Ingrese su nombre: ")			; se pide ingresar el nombre
	INVOKE StdIn, ADDR nombre,20						; se almacena el nombre
	printf("Por Favor, Ingrese su carné: ")				; se pide ingresar el carne
	INVOKE StdIn, ADDR carne,10							; se almacena el carne
	printf("Por Favor, Ingrese su carrera: ")			; se pide ingresar la carrera
	INVOKE StdIn, ADDR carrera,20


	printf("Hola ")										; se imprime el mensaje en pantalla
	INVOKE StdOut, ADDR nombre							; se imprime el nombre almacenado en pantalla
	printf(", su carne es:  ")							; se imprime el mensaje en pantalla
	INVOKE StdOut, ADDR carne							; se imprime el carne almacenado en pantalla
	printf("\nBienvenido a la carrera de ingenieria: ")	; se imprime el mensaje en pantalla
	INVOKE StdOut, ADDR carrera							; se imprime la carrera almacenda en pantalla

   INVOKE ExitProcess,0									; se termina la ejecución

end start