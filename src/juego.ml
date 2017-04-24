open Printf
open List
open String
open Cartas
open Jugador


type before = {jugador: player; carta: card}


let pedir_nombre () =
  printf "Ingrese el nombre del jugador o EXIT para comenzar el juego: \n";
  read_line()
;;


(* Crear jugadores hasta que sean 2 o mas *)
let rec iniciar_jugadores (mazo: deck) (n: int) = 
  if(n = 0) then
    []
  else
    begin
      match pedir_nombre() with
      | "EXIT" -> if n >= 4 then
                    begin
                      printf "Se requieren 2 o mas jugadores\n";
                      iniciar_jugadores mazo n
                    end
                  else
                    []
      | "" -> printf "Nombre invalido\n"; iniciar_jugadores mazo n
      | x -> let jugador = iniciar_jugador x in
             let mazo, jugador = dar_cartas mazo 7 jugador in
             jugador :: iniciar_jugadores mazo (n-1)
    end
;;


let cargar_jugadores () =
  let mazo = barajar_mazo (mazo_base()) in
  let lista = iniciar_jugadores mazo 5 in
  let mazo = List.filter (fun x -> posicion_carta x >= (List.length lista) * 7)
             mazo in
  (mazo, lista)
;;


(* Operaciones de las cartas especiales *)
let cartas_especiales (mazo: deck) (jugador: player) (carta: card) =
  if numero_carta carta = 0 then
    begin
      let palo = palo_carta carta in
      if palo = "SMAX" && List.length mazo > 0 then
        begin
          let mazo, carta_max = carta_maxima mazo in
          let jugador = tirar_carta jugador carta in
          let jugador = agregar_cartas jugador [carta_max] in
          (mazo, jugador, true)
        end
      else if palo = "SMIN" && List.length (cartas_jugador jugador) > 0 then
        begin
          let jugador = tirar_carta jugador carta in
          let cartas_aux, carta_min = carta_minima (cartas_jugador jugador) in
          let jugador = tirar_carta jugador carta_min in
          let mazo = indexar_cartas (mazo @ [carta_min]) in
          (mazo, jugador, true)
        end
      else if palo = "SSWAP" && List.length mazo > 0 then
        begin
          let mazo_aux = cartas_jugador jugador in
          let jugador = swap_jugador jugador mazo in
          let mazo = indexar_cartas mazo_aux in
          (mazo, jugador, true)
        end
      else if palo = "STOP" && List.length mazo > 0 then
        begin
          let mazo, alzar = sacar_carta mazo in
          let jugador = tirar_carta jugador carta in
          let jugador = agregar_cartas jugador [alzar] in
          (mazo, jugador, true)
        end
      else if palo = "SPAR" && List.length mazo > 0 then
        begin
          let mazo, pares = cartas_pares mazo in
          let jugador = agregar_cartas jugador pares in
          let jugador = tirar_carta jugador carta in
          (mazo, jugador, true)
        end
      else
        begin
          let jugador = tirar_carta jugador carta in
          (mazo, jugador, true)
        end
    end
  else (mazo, jugador, false)
;;


(* Imprime el jugador y la carta tirada en la ronda actual *)
let mostrar_jugada (mano: before) =
  let jugador = nombre_jugador mano.jugador in
  let carta = carta_a_string mano.carta in
  Printf.printf "%s %s\n" jugador carta
;;


(* Imprime la informacion de la ronda *)
let ronda (mazo_largo: int) (lista: before list) (jugador: player) =
  Printf.printf "\nMazo: %d cartas\nRonda:\n"  mazo_largo;
  List.iter (mostrar_jugada) lista;
  Printf.printf "%s(%d): " (nombre_jugador jugador) (puntos_jugador jugador);
  mostrar_mazo (cartas_jugador jugador);
  Printf.printf "\nQue carta vas a jugar %s?\n" (nombre_jugador jugador);
;; 


(* Realiza las operaciones al tirar una carta *)
let rec jugada (mazo: deck) (lista: before list) (jugador: player) =
  ronda (List.length mazo) lista jugador;
  let carta = read_line() in
  if esta_en_mazo (cartas_jugador jugador) carta then
    begin
      let mazo, jugador, es_especial = cartas_especiales mazo 
                                       jugador (obtener_carta carta) in
      if es_especial then
        jugada mazo lista jugador
      else
        begin
          let lista = {jugador = jugador; carta = obtener_carta carta}::lista in
          let lista = List.rev lista in
          if List.length mazo != 0 then
            begin
              let mazo, alzar = sacar_carta mazo in
              let jugador = agregar_cartas jugador [alzar] in
              let jugador = tirar_carta jugador (obtener_carta carta) in
              (mazo, lista, jugador)
            end
          else
            begin
              let jugador = tirar_carta jugador (obtener_carta carta) in
              (mazo, lista, jugador)
            end
        end
    end
  else
    begin
      Printf.printf "\nCarta ingresada invalida\n";
      jugada mazo lista jugador
    end
;;


(* Retorna el ganador de una ronda *)
let ganador_ronda (lista: before list) (jugadores: player list) =
  let cartas = List.map (fun x -> x.carta) lista in
  let cartas, carta_max = carta_maxima cartas in
  let ganador = List.filter (fun x -> comparar_cartas x.carta carta_max) 
                lista in
  (List.hd ganador).jugador
;;


(* Actualiza los jugadores activos con todos los jugadores *)
let actualizar_jugadores (jugadores_nuevos: player list) 
                         (jugadores_viejos: player list) =
  List.map (fun x -> actualizar_jugador x jugadores_nuevos) jugadores_viejos
;;


let rec juego (mazo: deck) (lista: before list) (jugadores: player list) 
              (jugadores_activos: player list) (turno: int) =
  if turno = List.length jugadores_activos then
    let turno = 0 in
    let jugador_ganador = ganador_ronda lista jugadores_activos in
    Printf.printf "\nEl jugador %s gano la ronda.\n" (nombre_jugador 
      jugador_ganador);
    let jugadores_activos = sumar_punto jugador_ganador jugadores_activos in
    let jugadores_activos = List.filter (fun x -> 
                          if List.length (cartas_jugador x) > 0 then true
                          else begin Printf.printf 
                          "\nEl jugador %s ya no tiene cartas.\n" 
                          (nombre_jugador x); false end) jugadores_activos in
    let lista = [] in
    if List.length jugadores_activos > 1 then
      begin
        let proximo_jugador = List.hd jugadores_activos in
        let jugadores_activos = (List.tl jugadores_activos) @ (proximo_jugador :: [])
        in 
        let mazo, lista, proximo_jugador = jugada mazo lista proximo_jugador in
        let jugadores_activos = List.map (fun x -> 
            if (nombre_jugador x) = (nombre_jugador proximo_jugador) then
              actualizar_jugador proximo_jugador []
            else x) jugadores_activos in
        let jugadores = actualizar_jugadores jugadores_activos jugadores in
        juego mazo lista jugadores jugadores_activos (turno+1)
      end
    else
      begin
        let jugadores = actualizar_jugadores jugadores_activos jugadores in
        (mazo, jugadores)
      end
  else
    begin
      let proximo_jugador = List.hd jugadores_activos in
      let jugadores_activos = (List.tl jugadores_activos) @ (proximo_jugador :: [])
      in 
      let mazo, lista, proximo_jugador = jugada mazo lista proximo_jugador in
      let jugadores_activos = List.map (fun x -> 
            if (nombre_jugador x) = (nombre_jugador proximo_jugador) then
              actualizar_jugador proximo_jugador []
            else x) jugadores_activos in
      let jugadores = actualizar_jugadores jugadores_activos jugadores in
      juego mazo lista jugadores jugadores_activos (turno+1)
    end
;;
