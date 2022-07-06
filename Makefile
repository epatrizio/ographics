graphics_ex1:
	ocamlfind ocamlc -package js_of_ocaml -package js_of_ocaml-ppx -package js_of_ocaml-lwt.graphics -linkpkg -o src/demo.byte src/graphics_ex/graphics_ex1.ml
	js_of_ocaml src/demo.byte

graphics_ex2:
	ocamlfind ocamlc -package js_of_ocaml -package js_of_ocaml-ppx -package js_of_ocaml-lwt.graphics -linkpkg -o src/demo.byte src/graphics_ex/graphics_ex2.ml
	js_of_ocaml src/demo.byte

graphics_ex3:
	ocamlfind ocamlc -thread -package threads -package js_of_ocaml -package js_of_ocaml-ppx -package js_of_ocaml-lwt.graphics -linkpkg -o src/demo.byte src/graphics_ex/graphics_ex3.ml
	js_of_ocaml src/demo.byte

my_demo:
	gcc -o src/examples/js_stub.o -c src/examples/js_stub.c
	ocamlfind ocamlc -package js_of_ocaml -package js_of_ocaml-ppx -package js_of_ocaml-lwt.graphics -custom src/examples/js_stub.o -linkpkg -o src/demo.byte src/examples/my_demo.ml
	js_of_ocaml src/examples/lib.js src/demo.byte

event_studies:
	ocamlfind ocamlc -package js_of_ocaml -package js_of_ocaml-ppx -package js_of_ocaml-lwt.graphics -linkpkg -o src/demo.byte src/examples/event_studies.ml
	js_of_ocaml src/demo.byte
