all: install

install:
	cd src; ocamlc -c cartas.mli jugador.mli juego.mli ; ocamlopt -o Guerra_Funcional cartas.ml jugador.ml juego.ml main.ml ; mv *.cmi *.cmx *.o Guerra_Funcional ../bin/ ;

.PHONY : clean
clean :
	rm -f bin/* ;

