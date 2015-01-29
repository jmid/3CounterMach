compile:
	ocamlbuild src/main.byte

top: compile
	ocamlbuild src/main.top

clean:
	ocamlbuild -clean
