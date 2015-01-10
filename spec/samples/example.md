{::options syntax_highlighter="rouge" /}

# Ruby

## Introducción

### Un poco de historia

En 1993, __Yukihiro Matsumoto ("Matz")__, habló con sus colegas de universidad sobre el poder y las
posibilidades que ofrecían los lenguajes para hacer
[scripts](http://en.wikipedia.org/wiki/Scripting_language). Probó algunos lenguajes como
[Perl](http://en.wikipedia.org/wiki/Perl) y
[Python](http://en.wikipedia.org/wiki/Python_(programming_language)), pero ninguno le convencía, así
que empezó a desarrollar el suyo.

El desarrollo de Ruby comienza el 24 de febrero de 1993 y la primera alpha sale en diciembre de
1994. Un año más tarde se publica la primera versión pública de Ruby.

### El lenguaje

Ruby es un lenguaje de programación de __alto nivel__, __orientado a objetos__, __reflexivo__ e
__interpretado__, que busca la productividad y la felicidad de los desarrolladores:

* Alto nivel: lo que quiere decir que es fácil de leer y escribir.
* Orientado a objetos: les permite a los usuarios manipular estructuras de datos llamadas objetos,
para construir y ejecutar programas.
* Reflexivo: Permite a los usuarios alterarlo libremente. Las partes esenciales de Ruby pueden ser
quitadas o redefinidas a placer.
* Interpretado: Está diseñado para ser ejecutado por medio de un intérprete.

### ¡Hola, Mundo!

#### El primer programa

La tradición dicta que el primer programa que se escribe cuando se aprende un nuevo lenguaje es el
[¡Hola, Mundo!](http://en.wikipedia.org/wiki/%22Hello,_world!%22_program), y nosotros no vamos a ser
menos.

Lo que tenemos que hacer es escribir un programa que muestre por pantalla _Hello, world!_. Para ello
vamos a crear el fichero `hello_world.rb` y escribimos:

~~~ ruby
puts 'Hello, World!'
~~~

Y para ejecutar el programa:

~~~ shell
ruby hello_world.rb
~~~

Ahora sí, podemos continuar.
