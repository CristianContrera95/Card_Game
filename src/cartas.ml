open Printf
open List
open Pervasives
open Random
open String


type card = {palo: string; numero: int; posicion: int}
type deck = card list


let indice (i: int) (carta: card) = 
  {carta with posicion = i}
;;


let indexar_cartas (mazo: deck) =
  List.mapi indice mazo
;;


let palo_carta (carta: card) =
  carta.palo
;;


let numero_carta (carta: card) =
  carta.numero
;;


let posicion_carta (carta: card) = 
  carta.posicion
;;


let mazo_base () =
  let palos = ["E";"B";"O";"C"] in
  let numeros = [12;11;10;9;8;7;6;5;4;3;2;1] in
  let especiales = {palo = "SID"; numero = 0; posicion = 0} :: 
                   {palo = "SSWAP"; numero = 0; posicion = 0} ::
                   {palo = "SMAX"; numero = 0; posicion = 0} ::
                   {palo = "SMIN"; numero = 0; posicion = 0} ::
                   {palo = "STOP"; numero = 0; posicion = 0} :: 
                   {palo = "SPAR"; numero = 0; posicion = 0} :: [] in
  indexar_cartas ((List.concat (List.map (fun x -> List.map (fun y -> 
          {palo = y; numero = x; posicion = 0}) palos) numeros)) @ especiales)
;;


let imprimir (carta: card) =
  if(carta.numero = 0) then
    Printf.printf "%s " carta.palo
  else
    Printf.printf "%s%d " carta.palo carta.numero
;;


let rec mostrar_mazo (mazo: deck) =
  List.iter (imprimir) mazo
;;


let sacar_carta (mazo : deck) =
  let carta = List.hd mazo in
  let mazo = List.tl mazo in
    (indexar_cartas mazo, carta)
;;


let carta_a_string (carta: card) =
  carta.palo ^ (string_of_int carta.numero)
;;


let obtener_carta (carta: string) =
  let mazo = mazo_base() in
  if carta.[0] = 'S' then
    List.hd (List.filter (fun x -> (carta_a_string x) = (carta ^ "0")) mazo)
  else
    List.hd (List.filter (fun x -> (carta_a_string x) = carta) mazo)
;;


let comparar_cartas (carta1: card) (carta2: card) =
  (carta1.palo = carta2.palo) && carta1.numero = carta2.numero
;;


let eliminar_carta (mazo: deck) (carta: card) =
  indexar_cartas (List.filter (fun x -> not (comparar_cartas x carta)) mazo)
;;


let barajar_mazo (mazo: deck) =
  let largo = List.length mazo in
  Random.self_init();
  let mazo = List.map (fun x -> {x with posicion = Random.int largo}) 
             mazo in
  let mazo = List.sort (fun x y -> Pervasives.compare x.posicion y.posicion)
             mazo in
  indexar_cartas mazo
;;


let esta_en_mazo (mazo : deck) (carta : string) =
  if String.length carta > 0 && carta.[0] = 'S' then
    List.exists(fun x -> (carta_a_string x) = (carta ^ "0")) mazo
  else
    List.exists(fun x -> (carta_a_string x) = carta) mazo
;;


let comparar (orden: int) (carta1: card) (carta2: card) =
  if(carta1.numero = carta2.numero) then
    begin
      if carta1.palo = "E" && orden = 1 then
        carta1
      else if carta2.palo = "E" then
        carta2
      else if carta1.palo = "B" && orden = 1 then
        carta1
      else if carta2.palo = "B" then
        carta2
      else if carta1.palo = "O" && orden = 1 then
        carta1
      else if carta2.palo = "O" then
        carta2
      else if carta1.palo = "C" then
        carta1
      else
        carta2
    end
  else if orden = 1 then
    begin
      if(carta1.numero > carta2.numero) then
        carta1
      else
        carta2
    end
  else
    begin
      if(carta1.numero > carta2.numero) then
        carta2
      else
        carta1
    end
;;


let carta_maxima (mazo: deck) =
  let carta = {palo = "A"; numero = 0; posicion = -1} in
  match mazo with
  | [] -> (mazo, carta)
  | m -> let max = List.fold_left (comparar 1) carta mazo in
         let mazo = eliminar_carta mazo max in
          (indexar_cartas mazo, max)
;;
 

let carta_minima (mazo: deck) =
  let carta = {palo = "Z"; numero = 13; posicion = -1} in
  match mazo with
  | [] -> (mazo, carta)
  | m -> let min = List.fold_left (comparar 0) carta mazo in
         let mazo = eliminar_carta mazo min in
         (indexar_cartas mazo, min)
;;


let cartas_pares (mazo: deck) =
  let pares = List.filter (fun x -> (x.posicion mod 2) = 0) mazo in 
  let mazo = List.filter (fun x -> (x.posicion mod 2) != 0) mazo in 
  (indexar_cartas mazo, pares)
;;