open List
open Pervasives
open String
open Cartas


type player = {nombre: string; puntos: int; cartas: deck}


let  iniciar_jugador (nombre: string) =
  {nombre = nombre ; puntos = 0 ; cartas = []}
;;


let actualizar_jugador (jugador: player) (jugadores_nuevos: player list) =
  let lista = List.filter (fun x -> x.nombre = jugador.nombre)
              jugadores_nuevos in
  if List.length lista = 0 then jugador
  else
    begin
      let nuevo = List.hd lista in
      {jugador with puntos = nuevo.puntos; cartas = nuevo.cartas}
    end
;;


let agregar_cartas (jugador: player) (cartas: deck ) =
  {jugador with cartas = (cartas @ jugador.cartas)}
;;


let nombre_jugador (jugador: player) =
  jugador.nombre
;;


let puntos_jugador (jugador: player) =
  jugador.puntos
;;


let cartas_jugador (jugador: player) =
  jugador.cartas
;;


let swap_jugador (jugador: player) (mazo: deck) =
  {jugador with cartas = mazo}
;;


let tirar_carta (jugador: player) (carta: card ) =
  {jugador with cartas = (eliminar_carta jugador.cartas carta)}
;;


let sumar_punto (jugador: player) (jugadores: player list) =
  List.map (fun x -> if x.nombre = jugador.nombre then
                       {x with puntos = (x.puntos + 1)}
                     else x) jugadores
;;


let dar_cartas (mazo: deck) (n: int) (jugador: player) =
  let cartas = filter (fun x -> posicion_carta x < n) mazo in
  let mazo = indexar_cartas (List.filter (fun x -> posicion_carta x >= n) mazo) 
    in
  (mazo, agregar_cartas jugador cartas)
;;