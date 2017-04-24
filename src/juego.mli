open Cartas
open Jugador

type before

(* Pide al usuario los nombres de los jugadores, los inicializa
   y crea el mazo base para retornarlo junto con una lista de 
 los jugadores *)
val cargar_jugadores: unit -> deck * player list

(* Recibe un mazo, una lista de las cartas jugadas en una ronda,
   una lista de todos los jugadores, una lista de los jugadores
   activos y un int que representa el turno siguiente. Con estos
   datos va efectuando el juego jugada por jugada, hasta que solo 
   un jugador posea cartas, y retorna la lista de jugadores junto
   con lo que queda del mazo *)
val juego:  deck -> before list -> player list ->  player list -> int -> deck * player list
