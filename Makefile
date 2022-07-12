# true/false
DEBUG=false

JSOC=js_of_ocaml src/demo.byte
JSOC_DEBUG=js_of_ocaml --pretty src/demo.byte

MINESWEEPER_EXE=minesweeper_game

my_js_of_ocaml:
	if [ "$(DEBUG)" = "true" ]; then $(JSOC_DEBUG); else $(JSOC); fi

graphics_ex1_:
	ocamlfind ocamlc -package js_of_ocaml -package js_of_ocaml-ppx -package js_of_ocaml-lwt.graphics -linkpkg -o src/demo.byte src/graphics_ex/graphics_ex1.ml
graphics_ex1: graphics_ex1_ my_js_of_ocaml

graphics_ex2_:
	ocamlfind ocamlc -package js_of_ocaml -package js_of_ocaml-ppx -package js_of_ocaml-lwt.graphics -linkpkg -o src/demo.byte src/graphics_ex/graphics_ex2.ml
graphics_ex2: graphics_ex2_ my_js_of_ocaml

graphics_ex3_:
	ocamlfind ocamlc -thread -package threads -package js_of_ocaml -package js_of_ocaml-ppx -package js_of_ocaml-lwt.graphics -linkpkg -o src/demo.byte src/graphics_ex/graphics_ex3.ml
graphics_ex3: graphics_ex3_ my_js_of_ocaml

my_demo:
	gcc -o src/examples/js_stub.o -c src/examples/js_stub.c
	ocamlfind ocamlc -package js_of_ocaml -package js_of_ocaml-ppx -package js_of_ocaml-lwt.graphics -custom src/examples/js_stub.o -linkpkg -o src/demo.byte src/examples/my_demo.ml
	js_of_ocaml src/examples/lib.js src/demo.byte

event_studies_:
	ocamlfind ocamlc -package js_of_ocaml -package js_of_ocaml-ppx -package js_of_ocaml-lwt.graphics -linkpkg -o src/demo.byte src/examples/event_studies.ml
event_studies: event_studies_ my_js_of_ocaml

event_:
	ocamlfind ocamlc -I src/ -o src/demo.byte -package js_of_ocaml -package js_of_ocaml-ppx -package js_of_ocaml-lwt.graphics -linkpkg src/graphics_js_ext.ml src/event.ml
event: event_ my_js_of_ocaml

minesweeper_compile:
	ocamlfind ocamlopt -o $(MINESWEEPER_EXE) -package graphics -linkpkg src/minesweeper/mw_game.ml

minesweeper_run:
	./$(MINESWEEPER_EXE)

minesweeper_web_:
	ocamlfind ocamlc -I src/ -o src/demo.byte -package js_of_ocaml -package js_of_ocaml-ppx -package js_of_ocaml-lwt.graphics -linkpkg src/graphics_js_ext.ml src/minesweeper/mw_game_web.ml
minesweeper_web: minesweeper_web_ my_js_of_ocaml

clean:
	rm -rf src/demo.byte src/demo.js $(MINESWEEPER_EXE)
	rm -rf */*.o */*.cmo */*.cmi
	rm -rf */*/*.o */*/*.cmo */*/*.cmi
