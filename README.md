# MICROPROGRAMACIÓN
## Laboratorio 1
### Objetivo
      ● Mostrar la estructura básica de un programa en Lenguaje ensamblador, así como la forma de ensamblarlo y generar el código objeto, además de su enlace como programa ejecutable.
      ● Familiarizar los diversos sistemas numéricos, sus conversiones, operaciones y lógica apropiada para representar información en un programa en Lenguaje Ensamblador.
#### ● Ejercicio 1
      Declarar dos variables, que almacenen dos valores predefinidos, no ingresados por el usuario.
            ● Variable 1: nombre del alumno
            ● Variable 2: carnet del alumno
      Imprimir ambos valores en pantalla.
#### ● Ejercicio 2
      Utilizando el archivo asm para el inciso anterior, responder lo siguiente.
            1. Cuando se genera el archivo obj a partir del archivo “.asm” ¿Qué información nos muestra en consola y qué significa?
            2. ¿En qué punto se crea el archivo ejecutable?
            3. ¿Cuál es la interrupción utilizada para imprimir una cadena de caracteres?
            4. ¿Cuál es la interrupción para imprimir solamente un caracter?
            5. ¿Qué registros entran en juego al ejecutar una interrupción de la serie 21h?
#### ● Ejercicio 3            
      Tomando el ejercicio 1, imprimir su primer nombre y primer apellido carácter por carácter con guión que separe letra por letra.

## Laboratorio 2
#### ● Ejercicio 1
      Utilizando los archivos “Ejemplo1.asm” y “Ejemplo2.asm” genere el código objeto y el programa ejecutable utilizando el Ensamblador “TASM” y el Enlazador “TLINK”. Conteste las siguientes preguntas:
      1. Cuando se genera el ejecutable del archivo “Ejemplo2.asm”, ¿cuál es la advertencia que se muestra en pantalla? ¿Por qué muestra esa advertencia?
      2. Modificado el programa para que no muestre la advertencia, ¿cuál es el resultado del programa, es decir, por qué se imprime ese carácter y no un 30?
      3. Modifique el código del archivo “Ejemplo2.asm” y utilizando la tabla de códigos ASCII, imprima en pantalla una letra “Z”.
#### ● Ejercicio 2
      1. Deberá declarar 3 variables numéricas con un valor fijo de un dígito
      2. Realice las siguientes operaciones:
            a. A + B
            b. A - C
            c. A + 2B + C
            d. A + B - C
#### ● Ejercicio 3            
      Comandos del Modo “DEBUG”:
            ● N Nombrar un programa.
            ● L Se encarga de cargar el programa.
            ● U "Desensamblar" código máquina y pasarlo a código simbólico.
            ● A Ensamblar instrucciones simbólicas y pasarlas a código máquina.
            ● D Mostrar el contenido de un área de memoria.
            ● E Introducir datos en memoria, iniciando en una localidad específica.
            ● G Correr el programa ejecutable que se encuentra en memoria.
            ● P Proceder o ejecutar un conjunto de instrucciones relacionadas.
            ● Q Salir de la sesión con DEBUG.
            ● R Mostrar el contenido de uno o más registros.
            ● T Rastrear la ejecución de una instrucción.
            ● W Escribir o grabar un programa en disco.
      Utilizando el Modo “DEBUG” de DOS cargue el programa “Ejemplo2.exe” y responda las siguientes preguntas:
            1. ¿En qué dirección de memoria inicia el código del programa?
            2. ¿En qué dirección de memoria termina el código del programa?
            3. Aparecen los comentarios en pantalla ¿Sí? ¿No? ¿Por qué?
            4. Para cada una de las instrucciones del programa, escriba la dirección de memoria que tiene asignada:
                  Dirección de memoria |  Instrucción
                  -------------------- | --------------- 
                                       |  Mov AX,@DATA
                                       |  Mov DS,AX
                                       |  Mov AX,0000h
                                       |  Mov BX,0000h
                                       |  Mov AL,15h
                                       |  Mov BL,15h
                                       |  Add AL,BL
                                       |  Mov DL,AL
                                       |  Mov AH,02
                                       |  Int 21h
                                       |  Mov AH,4CH
                                       |  int 21h    
            5. ¿Cuál es la dirección del segmento de código?
            6. Antes de iniciar la ejecución por pasos del programa, ¿cuáles son los valores de los registros de propósito general?
            7. El valor del IP, ¿coincide con la dirección de inicio del programa?
            8. Utilice el comando para el rastreo instrucción por instrucción y, por cada línea del código, escriba el contenido de los registros internos del CPU.
      