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
## Laboratorio 3
      Dada la emergencia del COVID-19, en Guatemala existe un sistema de alertas que ayudan a saber qué actividades y servicios estarán disponibles. Estas alertas son: Roja, Naranja, Amarilla y Verde, donde:
      Alerta Roja: Cuando el porcentaje de casos positivos vs las pruebas realizadas sea mayor o igual 20%.
      Alerta Naranja: Cuando el porcentaje de casos positivos vs las pruebas realizadas sea mayor a 15% y menor a 20%
      Alerta Amarilla: Cuando los casos positivos vs las pruebas realizadas estén entre el 5 y 15%.
      Alerta verde: cuando los casos positivos estén entre el 0 y 4%
### Instrucciones:
      Deberá realizar un programa en lenguaje ensamblador haciendo uso de MUL, DIV y los diferentes tipos de saltos, que indique la alerta correspondiente para un determinado lugar en base a ingresar la cantidad de pruebas realizadas y los resultados positivos de las mismas.
      Dado lo anterior, el usuario deberá ingresar un número de máximo 3 dígitos indicando las pruebas realizadas y a continuación otro número, también como máximo 3 dígitos indicando las pruebas que han resultado positivas.
      El programa deberá mostrar como resultado el texto “Alerta: <Alerta obtenida en base al porcentaje calculado>”.
## Laboratorio 4
      Para los siguientes ejercicios deberá leer números con 2 dígitos pero imprimir su resultado con la cantidad de dígitos correcta, es decir hasta 4 dígitos.
            1. Escribir un programa en lenguaje ensamblador que lea dos números desde el teclado, haga su multiplicación haciendo sumas sucesivas, utilizando ciclos.
            2. Escribir un programa en lenguaje ensamblador que lea dos números desde el teclado y realice su división por medio de restas sucesivas, utilizando saltos.
            3. Escribir un programa en lenguaje ensamblador que ingresando un número de dos dígitos imprima todos sus factores utilizando saltos.
            4. Escribir un programa en lenguaje ensamblador que convierta un número de 2 dígitos a su equivalente en binario utilizando ciclos. 
## Laboratorio 5
      Crear un programa, utilizando procedimientos y cadenas realice el cálculo del factorial de un número, el número mayor que puede ser ingresado es 128!

## Proyecto 1 
### Enunciado:
      El identificador único universal o identificador único global es un número de 128 bits generado de forma aleatoria, su representación estándar está conformada por dígitos hexadecimales:
                        82dc1366-6b6b-496a-bae7-a84de82dda34
      En total tiene 32 caracteres separados por guiones cumpliendo algunas normas. La probabilidad que un UUID se repita es muy cercana a cero.
#### Parte 1:
      Existen diferentes técnicas para generar la aleatoriedad, una de ellas está basada en la fecha y hora actual y la mac address del equipo,
      En este caso deberá utilizar interrupciones para obtener la fecha y hora actual del equipo y generar un timespan a partir de ello y utilizarlo en la generación de un nuevo UUID.
      Como no se tiene acceso a la mac address del equipo deberá seguir las siguientes reglas:
            1. El grupo de los cuatro bits más significativos del séptimo byte deberá iniciar siempre con “1”
            2. El segundo grupo de bits más significativo deberá iniciar con un número aleatorio entre 8,9,A o B en hexadecimal.
      La aplicación deberá contar con la opción de generar uno o varios UUIDs.
#### Parte 2:      
      El generador de UUIDs también deberá contar con un área de validación, la expresión regular utilizada para validar un UUID es la siguiente:
                        ^[0-9A-F]{8}-[0-9A-F]{4}-[1][0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$
      Así que además de generar UUIDs, el usuario podrá ingresar uno y el programa deberá mostrar si es válido o no.
### Entregables:
      1. Código fuente con su documentación interna (85%)
      2. Descripción en un diagrama de flujo de su solución (10%)
      3. Manual de usuario (5%)
