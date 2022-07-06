(*
---- Topic: My specific demo
 * external javascript function calls (declaration / lib.js / js_stub.c for ocaml compilation / interoperability)
 * direct javascript function calls (Dom_html.window##alert)
 * event model
 * draw_image

---- Notes

Make images (bitmap) from color array seems to be ok!
But make images from files seems not implemented by Graphics_js.

Add -package camlimages.png
js_of_ocaml compilation message:
Missing primitives
  read_png_file
  write_png_file_index
  write_png_file_rgb
*)

open Js_of_ocaml
open Graphics_js

external add : int -> int -> int = "caml_add"
external hello : string -> Js.js_string Js.t = "caml_hello"

let draw_text s x y =
  set_text_size 12 ;
  moveto x y ;
  draw_string s

let draw_img () =
  let color_array = Array.make_matrix 100 100 (rgb 99 255 99) in
  let color_img = make_image color_array in
    draw_image color_img 0 0

let loop_handler st =
  try
    draw_img ();
    if st.keypressed then (
      if st.key='q' || st.key='Q' then raise Exit;
      clear_graph ();
      draw_text "Hello World! keypressed" 10 450;
      draw_text (String.make 1 (st.key)) 10 440;
      draw_text (Js.to_bytestring (hello "world")) 10 430;
    )
    else if st.button then (
      clear_graph () ;
      draw_text "Hello World! button" 10 450 ;
      draw_text (string_of_int st.mouse_x) 10 440 ;
      draw_text (string_of_int st.mouse_y) 10 430 ;
      draw_text (string_of_int (add 10 32)) 10 420 ;
      Dom_html.window##alert(Js.string "hello world")
    )
  with Exit -> close_graph ()

let init canvas =
  print_endline "initializing";
  let () = Graphics_js.open_canvas canvas in
  let () =
    loop [Key_pressed;Button_down] loop_handler
  in
  ()

let () = Js.export "init" init
