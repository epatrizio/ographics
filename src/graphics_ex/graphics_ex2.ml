(*
OCaml Graphics official library second example export :
https://github.com/ocaml/graphics/blob/master/examples/graph_test.ml

Warning!
This code is not mine! It has its own license specified in the link above.
Here, it's its refactoring for its export in Javascript via js_of_ocaml.

---- Topic
 * Standard drawing primitives
*)

open Js_of_ocaml
open Graphics_js

let dashes y =
  for i = 1 to 100 do
    plot y (2 * i);
    plot y (3 * i);
    plot y (4 * i)
  done

let carre c =
  rlineto 0 c;
  rlineto c 0;
  rlineto 0 (-c);
  rlineto (-c) 0

let draw_green_string s =
  set_color green ;
  draw_string s

let draw_red_string s =
  set_color red ;
  draw_string s

let draw_poly v =
  let l = Array.length v in
  if l > 0 then (
    let x0, y0 = current_point () in
    let p0 = v.(0) in
    let x, y = p0 in
    moveto x y;
    for i = 1 to l - 1 do
      let x, y = v.(i) in
      lineto x y
    done;
    lineto x y;
    moveto x0 y0)

let equi x y l =
  [|
    (x - (l / 2), y);
    (x, y + int_of_float (float_of_int l *. (sqrt 3.0 /. 2.0))); (x + (l / 2), y);
  |]

let draw_arc_ellipse x y r1 r2 =
  set_color green;
  draw_arc x y r1 r2 60 120;
  set_color black;
  draw_arc x y r1 r2 120 420

let draw_arc_ellipses x y r1 r2 =
  let step = 5 in
  for i = 0 to (r1 - step) / (2 * step) do
    for j = 0 to (r2 - step) / (2 * step) do
      draw_arc_ellipse x y (3 * i * step) (3 * j * step)
    done
  done

let fill_arc_ellipse x y r1 r2 c1 c2 =
  set_color c1;
  fill_arc x y r1 r2 60 120;
  set_color c2;
  fill_arc x y r1 r2 120 420

let fill_arc_ellipses x y r1 r2 =
  let step = 3 in
  let c1 = ref black and c2 = ref yellow in
  let exchange r1 r2 =
    let tmp = !r1 in
    r1 := !r2;
    r2 := tmp
  in
  for i = r1 / (2 * step) downto 10 do
    for j = r2 / (2 * step) downto 30 do
      exchange c1 c2;
      fill_arc_ellipse x y (3 * i) (3 * j) !c1 !c2
    done
  done

let init canvas =
  print_endline "initializing";
  let () = Graphics_js.open_canvas canvas in
  let () =
    let sz = 450 and lw = 15 in
    let go_caption l = moveto 210 (130 - lw + l) in
    let go_legend () = go_caption (-3 * lw) in
      set_color foreground ;
      dashes 3 ;
      set_line_width 20 ;
      dashes (sz - 20) ;
      draw_char 'C' ;
      draw_char 'a' ;
      draw_char 'm' ;
      draw_char 'l' ;
      moveto 10 10 ;
      set_line_width 5 ;
      for i = 1 to 10 do
        moveto (10 * i) (10 * i);
        set_color (rgb (155 + (10 * i)) 0 0);
        carre (10 * i)
      done ;
      moveto 10 210 ;
      set_color blue ;
      set_line_width 1 ;
      for i = 1 to 10 do
        carre (10 * i)
      done ;
      rmoveto 0 120 ;
      fill_circle 20 190 10 ;
      set_color green ;
      rlineto 0 10 ;
      rmoveto 50 10;
      let x, y = current_point () in
        draw_circle x y 20 ;
      set_color black ;
      rlineto 0 20 ;
      set_color cyan ;
      go_caption 0 ;
      fill_rect 210 130 5 10 ;
      fill_rect 220 130 10 20 ;
      fill_rect 235 130 15 40 ;
      fill_rect 255 130 20 80 ;
      fill_rect 280 130 25 160 ;
      set_color green ;
      rlineto 50 0 ;
      set_color black ;
      set_line_width (lw / 4) ;
      draw_rect 210 130 5 10 ;
      draw_rect 220 130 10 20 ;
      draw_rect 235 130 15 40 ;
      draw_rect 255 130 20 80 ;
      draw_rect 280 130 25 160 ;
      set_line_width lw ;
      rlineto 50 0 ;
      go_legend () ;
      set_text_size 10 ;
      set_color (rgb 150 100 250) ;
      let x, y = current_point () in
        fill_rect x (y - 5) (8 * 20) 25 ;
      set_color yellow ;
      go_legend () ;
      draw_string "Graphics (OCaml)" ;
      moveto 120 210 ;
      set_color red ;
      fill_arc 150 260 25 25 60 300;
      draw_green_string "A ";
      draw_red_string "red";
      draw_green_string " pie.";
      set_text_size 5;
      moveto 180 240;
      draw_red_string "A ";
      draw_green_string "green";
      draw_red_string " slice." ;
      set_color green;
      fill_arc 200 260 25 25 0 60;
      set_color black;
      set_line_width 2;
      draw_arc 200 260 27 27 0 60;
      set_color red;
      fill_poly [| (40, 10); (150, 70); (150, 10); (40, 10) |];
      set_color blue ;
      draw_poly [| (150, 10); (150, 70); (260, 10); (150, 10) |] ;
      set_color black ;
      fill_poly (Array.append (equi 300 20 40) (equi 300 44 (-40))) ;
      set_line_width 1 ;
      set_color cyan ;
      draw_poly (equi 300 20 40) ;
      set_color red ;
      draw_poly (equi 300 44 (-40)) ;
      let x, y = current_point () in
        rlineto 10 10;
        moveto x y;
        moveto 395 100
      ;
      let x, y = current_point () in
        fill_ellipse x y 25 15 ;
      set_color (rgb 0xFF 0x00 0xFF) ;
      rmoveto 0 (-50);
      let x, y = current_point () in
        fill_ellipse x y 15 30
      ;
      rmoveto (-45) 0 ;
      let x, y = current_point () in
        draw_ellipse x y 25 10 ;
      set_line_width 3 ;
      draw_arc_ellipses 20 128 15 50 ;
      fill_arc_ellipses 400 240 150 200 ;
      set_color transp ;
      draw_circle 400 240 50 ;
      draw_circle 400 240 40 ;
      draw_circle 400 240 30 ;
      set_color red ;
      draw_circle 400 240 20 ;
  in
  ()

let () = Js.export "init" init
