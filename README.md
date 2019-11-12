# Card Game

### Alumno: Contrera Cristian.

## Desarrollo

Este proyecto se realizo dividiendo el programa TAD's que representan los elementos del juego: Cartas, Jugador y Juego (este ultimo es la ejecucion de juego), estos son llamados desde el main, el cual solo inicia el programa y imprime las posiciones al final.

## Estructura

#### Cartas

Este módulo realiza las funciones de manejo de cartas, como mezclar mazo, sacar carta, tirar carta, etc..., aqui tambien se crean dos tipos de datos:

* type card = {palo: string; numero: int; posicion: int}
* type deck = card list

En card se guardan los elementos referidos a la carta como el palo (espada, oro, basto, copa), numero (del 1 al 12) y la posicion de la carta en el maso.

#### Jugador

Este módulo realiza las acciones que puede realizar un jugador, para esto implementa funciones del TAD Cartas, se define un tipo de datos:

* type player = {nombre: string; puntos: int; cartas: deck}

El cual juarda el nombre del jugador, los puntos que lleva en el juego y las cartas que posee.

#### Juego

Aqui estan las funciones que llevan adelante la ejecucion del juego y la interaccion con el usuario, se crean los jugadores y el mazo. Se define un tipo de datos:

* type before = {jugador: player; carta: card}
 
que va guardando la carta que le jugador tiro en la ronda.

## Decisiones de diseño

* Las cartas especiales son consideradas de menor valor que las "comunes" y del mismo valor entre ellas.
* Al jugar cartas especiales como SWAP, TOP, PARES y MAX con un mazo vacio, estas se pierden, o sea se eliminan del mazo del jugador pero no producen efecto.
* Al jugar la carta ID todo queda como esta.
* En caso de que se intente ingresar al juego con menos de 2 jugadores, el programa lo impide, y se queda esperando el siguiente jugador.
* Si un jugador intenta jugar una carta que no posee, el juego lo avisa y se queda esperando que tire una carta que posea.
* Al jugar cualquier carta especial, se debe jugar una comun luego para seguir con la ejecucion del programa.
* La carta especial PAR retorna las cartas en las posiciones pares.
