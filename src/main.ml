open Cartas
open Jugador
open Juego
open Printf
open List
open Pervasives
open String


let imprimir_posiciones (jugadores: player list) =
  let jugadores = List.sort (fun y x -> Pervasives.compare (puntos_jugador x)
                  (puntos_jugador y)) jugadores in
  Printf.printf "\n\nGAME OVER. Posiciones:\n";
  List.iteri (fun i x -> printf "%d   %s  %d\n" (i+1) (nombre_jugador x) 
              (puntos_jugador x)) jugadores
;;


let main () =
  let mazo, jugadores = cargar_jugadores () in
  let lista = [] in
  let mazo, jugadores = juego mazo lista jugadores jugadores 0 in
  imprimir_posiciones jugadores
;;


main();;