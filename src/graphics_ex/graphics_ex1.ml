(*
OCaml Graphics official library first example export :
https://github.com/ocaml/graphics/blob/master/examples/graph_example.ml

Warning!
This code is not mine! It has its own license specified in the link above.
Here, it's its refactoring for its export in Javascript via js_of_ocaml.

---- Refactoring notes
 * Graphics remember_mode isn't supported by graphics_js >> the final behavior is not exactly the same (Mouse_motion KO)
 * Graphics while true loop / wait_next_event >> Transformed : Graphics_js loop / handler
*)

open Js_of_ocaml
open Graphics_js

let point x y =
  let xr = (size_x () / 2) - 30
  and yr = (size_y () / 2) - 26
  and xg = (size_x () / 2) + 30
  and yg = (size_y () / 2) - 26
  and xb = size_x () / 2
  and yb = (size_y () / 2) + 26 in
  let dr = ((x - xr) * (x - xr)) + ((y - yr) * (y - yr))
  and dg = ((x - xg) * (x - xg)) + ((y - yg) * (y - yg))
  and db = ((x - xb) * (x - xb)) + ((y - yb) * (y - yb)) in
  if dr > dg && dr > db then set_color (rgb 255 (255 * dg / dr) (255 * db / dr))
  else if dg > db then set_color (rgb (255 * dr / dg) 255 (255 * db / dg))
  else set_color (rgb (255 * dr / db) (255 * dg / db) 255);
  fill_rect x y 2 2

let caml () =
  let n = 0x000000
  and w = 0xFFFFFF
  and b = 0xFFCC99
  and y = 0xFFFF00
  and o = 0xCC9966
  and v = 0x00BB00
  and g = 0x888888
  and c = 0xDDDDDD
  and t = transp in
    make_image
    [|
      [|
        t; t; t; t; t; t; t; t; t; t; t; n; n; n; n; n; n; t; t; t; t; t; t; t;
        t; t; t; t; t; t; t; t;
      |];
      [|
        t; t; t; t; t; t; t; t; t; t; n; n; n; n; n; n; n; n; n; t; t; t; t; t;
        t; t; t; t; t; t; t; t;
      |];
      [|
        t; t; t; t; t; t; t; t; n; n; n; n; n; n; n; n; n; n; n; n; t; t; t; t;
        t; t; t; t; t; t; t; t;
      |];
      [|
        n; n; n; n; n; n; t; n; n; n; n; n; b; b; b; b; b; b; b; n; n; t; t; t;
        t; t; n; n; n; n; n; t;
      |];
      [|
        n; o; o; o; o; o; n; n; n; n; b; b; b; b; b; b; b; b; b; b; b; n; n; n;
        n; n; n; n; n; n; n; t;
      |];
      [|
        n; o; o; o; o; o; o; n; n; n; n; n; n; n; n; n; n; n; n; n; n; n; n; n;
        n; n; n; n; n; n; n; t;
      |];
      [|
        n; o; o; o; o; o; o; o; n; n; n; g; g; g; n; n; n; n; n; n; n; n; n; n;
        n; n; n; n; n; n; t; t;
      |];
      [|
        n; n; o; o; o; o; o; o; o; n; n; n; c; c; n; n; n; n; n; n; n; n; n; n;
        n; n; n; n; n; n; t; t;
      |];
      [|
        t; n; n; o; o; o; o; o; o; o; n; n; n; c; n; n; n; n; n; n; n; b; b; n;
        n; n; n; n; n; t; t; t;
      |];
      [|
        t; t; n; n; n; o; o; o; o; o; o; n; n; n; n; n; n; n; n; n; b; b; b; b;
        n; n; n; n; t; t; t; t;
      |];
      [|
        t; t; t; t; n; n; o; o; o; o; o; o; n; n; n; n; n; n; n; n; b; b; b; b;
        b; b; n; n; t; t; t; t;
      |];
      [|
        t; t; t; t; t; n; n; o; o; o; o; o; o; n; n; n; n; n; n; o; o; b; b; b;
        b; b; b; n; n; t; t; t;
      |];
      [|
        t; t; t; t; t; n; n; o; o; o; o; o; o; b; b; b; b; b; n; n; o; o; b; b;
        b; b; b; b; n; n; t; t;
      |];
      [|
        t; t; t; t; n; n; n; o; o; o; o; o; b; b; b; b; b; b; b; n; n; o; o; b;
        b; b; b; b; b; n; n; t;
      |];
      [|
        t; t; t; t; n; n; n; o; o; o; o; b; b; b; b; b; b; b; b; b; n; n; o; o;
        b; b; b; b; b; b; n; n;
      |];
      [|
        t; t; t; t; n; n; n; o; o; o; o; b; b; b; b; b; n; n; b; b; b; n; n; o;
        o; b; b; b; b; b; n; n;
      |];
      [|
        t; t; t; t; n; n; n; o; o; o; o; b; b; b; b; b; n; n; b; b; b; b; n; n;
        o; o; b; o; b; b; n; n;
      |];
      [|
        t; t; t; t; n; n; n; o; o; o; o; b; b; b; b; b; n; n; b; b; b; b; b; n;
        n; o; o; o; o; o; n; n;
      |];
      [|
        t; t; t; t; n; n; n; o; o; o; o; b; b; b; b; b; n; n; b; b; b; b; b; b;
        n; n; o; o; o; o; n; n;
      |];
      [|
        t; t; t; t; n; n; n; o; o; o; o; o; b; b; b; b; n; n; b; b; b; b; b; b;
        b; n; n; o; o; n; n; n;
      |];
      [|
        t; t; t; t; n; n; n; n; o; o; o; o; o; b; b; b; n; n; n; b; b; b; b; b;
        b; b; n; n; o; n; b; n;
      |];
      [|
        t; t; t; t; t; n; n; n; o; o; o; o; o; o; b; b; n; n; n; b; b; b; b; b;
        b; b; b; n; n; n; b; n;
      |];
      [|
        t; t; t; t; t; t; n; n; o; o; o; o; o; o; o; y; v; y; n; b; b; b; b; b;
        b; b; b; n; n; b; b; n;
      |];
      [|
        t; t; t; t; t; t; t; n; o; o; o; o; o; v; y; o; o; n; n; n; b; b; b; b;
        b; b; b; n; n; b; b; n;
      |];
      [|
        t; t; t; t; t; t; t; n; o; o; o; y; v; o; o; o; o; n; n; n; n; b; b; b;
        b; b; b; n; n; b; b; n;
      |];
      [|
        t; t; t; t; t; t; n; n; o; v; y; o; y; o; o; o; o; o; o; n; n; n; b; b;
        b; b; b; n; n; b; b; n;
      |];
      [|
        t; t; t; t; t; t; n; o; y; y; o; o; v; o; o; o; o; o; o; o; n; n; n; b;
        b; b; n; n; n; b; n; t;
      |];
      [|
        t; t; t; t; t; n; n; v; o; v; o; o; o; o; o; o; o; o; o; o; o; n; n; n;
        b; n; n; n; n; b; n; t;
      |];
      [|
        t; t; t; t; t; n; v; o; o; v; o; o; o; o; o; o; o; o; o; o; o; o; n; n;
        n; n; n; n; n; n; t; t;
      |];
      [|
        t; t; t; t; n; n; o; o; o; o; o; o; o; o; o; o; o; o; o; o; o; n; n; n;
        n; n; n; t; t; t; t; t;
      |];
      [|
        t; t; t; t; n; o; o; o; o; o; o; o; o; o; o; o; o; o; o; o; n; n; t; t;
        t; t; t; t; t; t; t; t;
      |];
      [|
        t; t; t; t; n; n; n; n; n; n; n; n; n; n; n; n; n; n; n; n; n; t; t; t;
        t; t; t; t; t; t; t; t;
      |];
    |]

let loop_handler st =
  try
    if st.keypressed then raise Exit;
    if st.button then (
      (* remember_mode true; *)
      draw_image (caml ()) st.mouse_x st.mouse_y;
      (* remember_mode false; *)
    );
    let x = st.mouse_x + 16 and y = st.mouse_y + 16 in
      moveto 0 y;
      lineto (x - 25) y;
      moveto 10000 y;
      lineto (x + 25) y;
      moveto x 0;
      lineto x (y - 25);
      moveto x 10000;
      lineto x (y + 25);
      draw_image (caml ()) st.mouse_x st.mouse_y
  with Exit -> close_graph ()

let init canvas =
  print_endline "initializing";
  let () = Graphics_js.open_canvas canvas in
  let () =
    for y = (size_y () - 1) / 2 downto 0 do
      for x = 0 to (size_x () - 1) / 2 do
        point (2 * x) (2 * y)
      done
    done;
    set_color (rgb 0 0 0);
    loop [(*Mouse_motion;*)Key_pressed;Button_down] loop_handler
  in
  ()

let () = Js.export "init" init
