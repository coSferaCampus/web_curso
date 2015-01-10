{::options syntax_highlighter="rouge" /}

# Ruby

## Tipos de datos

Los programas existen para analizar y manipular datos rápidamente. Por eso es importante que
entendamos los diferentes tipos de datos que podemos usar.

### Números

En la mayoría de lenguajes de programación se usan dos tipos de números, los __enteros (integers)__
y los __decimales (floats)__.

Aquí tenemos representados _integers_:

~~~ ruby
5
-134
9999999999999999
9_999_999_999_999_999 # Usamos '_' para que sea más legible
0
~~~

Y aquí algunos _floats_:

~~~ ruby
5.12
-134.5465
0.0001
0.0
~~~

Usamos el _punto_ para separar la parte entera de la decimal.

#### Aritmética simple

Con los números tenemos todas las herramientas de una calculadora simple. Podemos sumar y restar con
"+" y "-", multiplicar con "\*" y dividir con "/":

~~~ ruby
1.0 + 4.0 # 5.0
7.2 - 4.5 # 2.7
5.0 * 3.0 # 15.0
9.0 / 2.0 # 4.5
~~~

Veamos un ejemplo con _integers_:

~~~ ruby
1 + 4 # 5
7 - 4 # 3
5 * 3 # 15
9 / 2 # 4
~~~

Todo normal, aunque puede que os resulte extraña la última operación, pero es lo que tiene la
aritmética con _integers_, se obtienen _integers_ como respuesta.

Si queremos usar expresiones más complejas, podemos usar los paréntesis:

~~~ ruby
5 * (12-8) + -15 # 5
98 + (59872 / (13*8)) * -52 # -29802
~~~

### Caracteres

Ya hemos aprendido sobre números, pasemos a las letras.

En programación, a los grupos de letras se les llama __strings (cadenas de caracteres)__:

~~~ ruby
'Hola.'
"Ruby mola."
'5 es mi número favorito.'
'#%^?&*@!'
'      '
''
~~~

Como podemos ver, las cadenas pueden estar formadas por cualquier carácter (letras, signos de
puntuación, dígitos, símbolos, espacios en blanco...) delimitadas por ' o ". La última cadena no
está compuesta por ningún carácter; a esta la llamamos __empty string (cadena vacía)__.

#### Aritmética de strings

De la misma forma en la que podemos usar la aritmética con los números, la podemos usar con las
cadenas. Vamos _concatenar_ dos cadenas:

~~~ ruby
'Me gustan' + 'las manzanas.' # "Me gustanlas manzanas."
~~~

Ups, he olvidado pone el espacio. Los espacios no importan normalmente, pero en las cadenas son un
carácter más.

~~~ ruby
'Me gustan ' + 'las manzanas.' # "Me gustan las manzanas."
'Me gustan' + ' las manzanas.' # "Me gustan las manzanas."
~~~

¿Qué pasa si queremos concatenar la misma cadena varias veces?:

~~~ ruby
'tic tac ' + 'tic tac ' + 'tic tac ' + 'tic tac ' # "tic tac tic tac tic tac tic tac "
~~~

Estoy cansado de escribir... Por suerte podemos "multiplicar" cadenas.

~~~ ruby
'tic tac ' * 4 # "tic tac tic tac tic tac tic tac "
~~~

Si lo pensamos tiene sentido, después de todo, 7*3 es 7+7+7.

#### A tener en cuenta

Hay algunas cosas que tenemos que tener en cuenta cuando trabajamos con cadenas de caracteres, por
ejemplo:

~~~ ruby
'12' + 12 # TypeError: no implicit conversion of Fixnum into String
'2' * '5' # TypeError: no implicit conversion of String into Integer
~~~

El problema es que no podemos sumar una cadena y un número, o multiplicar dos cadenas. Si lo
pensamos tiene bastante sentido, porque en realidad estamos haciendo algo como esto:

~~~ ruby
'Juan' + 12
'Juan' * 'Antonio'
~~~

Otro ejemplo con el operador \*:

~~~ ruby
'cerdito' * 5 # "cerditocerditocerditocerditocerdito"
5 * 'cerdito' # TypeError: String can't be coerced into Fixnum
~~~

Podemos tener 5 conjuntos de la cadena 'cerdito', pero no podemos tener 'cerdito' conjuntos del
número 5.

Para terminar, qué pasa si queremos escribir `Aquí hay algo que huele "raro".`:

~~~ ruby
'Hay algo que huele "raro".' # "Hay algo que huele \"raro\"."
"Hay algo que huele "raro"." # SyntaxError: unexpected tIDENTIFIER, expecting end-of-input
~~~

El intérprete ha ententido que hemos terminado de escribir la cadena después de las segundas
comillas, por eso no sabe qué hacer con el resto de la ĺínea. Para evitar esto (ya tenemos una pista
en la salida de la primera línea) tenemos que _escapar_ los caracteres que se usan para crear
cadenas:

~~~ ruby
'Hay algo que huele \'raro\'.' # "Hay algo que huele 'raro'."
"Hay algo que huele \"raro\"." # "Hay algo que huele \"raro\"."
~~~

#### Diferencia entre ' y "

Dentro de una cadena podemos incluir sentencias con la expresión `#{}`:

~~~ ruby
puts "El resultado de sumar 7 y 4 es 7 + 4"
puts "El resultado de sumar 7 y 4 es #{7 + 4}"
~~~

En la primera línea se imprime por pantalla la cadena `El resultado de sumar 7 y 4 es 7 + 4` y en la
segunda `El resultado de sumar 7 y 4 es 11`. Esto es así porque Ruby lo que hace al encontrarse con
la expresión `#{}` dentro de una cadena es evaluar el contenido de lo que tiene dentro.

¿Y cuál es la diferencia entre comillas simples (') y dobles (")? Lo que hace el intérprete cuando
se encuentra una cadena formada por " es buscar las apariciones de la expresión `#{}` y sustituirlas
por el resultado; esto no se hace si la cadena está formada por ':

~~~ ruby
puts 'El resultado de sumar 7 y 4 es #{7 + 4}' # "El resultado de sumar 7 y 4 es \#{7 + 4}"
puts "El resultado de sumar 7 y 4 es #{7 + 4}" # "El resultado de sumar 7 y 4 es 11"
~~~

### Símbolos

Los símbolos son parecidos a las candenas. Los definimos con un nombre precedido de ":". Pueden
contener letras, números y guiones bajos (\_), pero no pueden empezar por un número:

~~~ ruby
:pending
:not_connected

:9days # SyntaxError
~~~

Más tarde veremos para qué son útiles.

### Ejercicios

1. Calcular el perímetro de un círculo de 4 cm de radio.
2. Calcular el área de un círculo de 7 cm de diámetro.
3. Cuántas horas tiene un año.
4. Cuántos minutos hay en una década.
5. Tú edad en segundos.
6. Si mi edad es 1204 millones de segundos, ¿cuántos años tengo?
