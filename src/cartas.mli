type card 

type deck = card list

(* Esta funcion asigna la posicion de la carta en el maso
   a su campo posicion en su tipo de datos *)
val indexar_cartas: card list -> card list

(* Retorna el palo de la carta dada en un string *)
val palo_carta: card -> string

(* Retorna el numero de la carta dada en un int *)
val numero_carta: card -> int

(* Retorna la posicion de la carta dada en un int *)
val posicion_carta: card -> int

(* Crea y retorna un mazo ordenado *)
val mazo_base: unit -> card list

(* Imprime por consola un maso dado *)
val mostrar_mazo: card list -> unit

(* De un mazo dado saca la primera carta y la retorna
   junto con el mazo sin esa carta *)
val sacar_carta: card list -> card list * card

(* Retorna el palo y nuemro de la carta concatenado 
   en un string *)
val carta_a_string: card -> string

(* Dado un string que contiene el palo y el numero de
   un carta, retorna la carta*)
val obtener_carta: string -> card

(* Retorna true si dos cartas dadas son iguales *)
val comparar_cartas: card -> card -> bool

(* Dado un mazo y una carta, retorna el mazo sin la carta *)
val eliminar_carta: card list -> card -> card list

(* Dado un mazo, retorna el mazo mezclado 
   pseudo-aleatoriamente *)
val barajar_mazo: card list -> card list

(* Retorna true si dado un mazo y un string que posee
   el palo y el numero de una carta, esta esta en el mazo *)
val esta_en_mazo: card list -> string -> bool

(* Dado un mazo, retorna la carta maxima del mismo junto
   con el mazo dado sin la carta *)
val carta_maxima: card list -> card list * card

(* Dado un mazo, retorna la carta minima del mismo junto
   con el mazo dado sin la carta *)
val carta_minima: card list -> card list * card

(* Dado un mazo retorna un nuevo mazo con la cartas en las 
  posiciones paresdel mismo, junto al mazo original sin esas cartas *)
val cartas_pares: card list -> card list * card list