open Cartas

type player

(* Dado un string que contendra el nombre del jugador
   retorna un jugador, o sea si tipo de datos *)
val iniciar_jugador: string -> player

(* Dado un jugador y una lista de jugadores, se busca al 
   jugador en la lista y se reemplazan los datos del que esta
   en la lista por el que que fue dado, y se retorna la lista *)
val actualizar_jugador: player -> player list -> player

(* Dado un jugador y un mazo de cartas, se retorna el 
   jugador con las cartas en su mazo *)
val agregar_cartas: player -> deck -> player

(* Dado un jugador retorna el nombre de jugador *)
val nombre_jugador: player -> string

(* Dado un jugador retorna los puntos que posee el jugador *)
val puntos_jugador: player -> int

(* Dado un jugador retorna su mazo de cartas *)
val cartas_jugador: player -> deck

(* Dado un jugador y un mazo, cambia el mazo del jugador por
   por el dado y retorna el jugador *)
val swap_jugador: player -> deck -> player

(* Dado un jugador y una carta retorna el jugador sin la carta *)
val tirar_carta: player -> card -> player

(* Dado un jugador y una lista de jugadores suma un punto al
   jugador dado en la lista, y retorna la lista *)
val sumar_punto: player -> player list -> player list

(* Dado un mazo, un numero y un jugador, le agrega ese numero de
   cartas al jugador y retorna el jugador y el mazo sin las cartas *)
val dar_cartas: deck -> int -> player -> deck * player
