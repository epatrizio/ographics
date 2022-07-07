(*
---- Topic: event studies
Event management is the graphics to js export real challenge!

Here is a simple example with a typical context : conditional events*
In Graphics_js, no wait_next_event function. So what possibilities ... ?

---- failed experiments
 * declare wait_next_event as external function and implement it in javascript
    external wait_next_event : event list -> 
      < mouse_x : int Js.prop ;
        mouse_y : int Js.prop ;
        button : bool Js.prop ;
        keypressed : char Js.prop ;
        key : string Js.prop > Js.t = "caml_gr_wait_next_event"
  KO : flow and event models are so different between js and ocaml (see lib.js)
*)

open Js_of_ocaml
open Graphics_js

(* OCaml graphics classic version - *Button_up is considered only after a button_down *)
(* let loop () =
  try
    while true do 
      let st1 = wait_next_event [Button_down;Key_pressed] in
        if st1.keypressed then raise Exit;
        let st2 = wait_next_event [Button_up] in
          moveto st1.mouse_x st1.mouse_y;
          lineto st2.mouse_x st2.mouse_y
    done
  with 
  | Exit -> exit 0 *)

(* First idea: exception. KO, it's impossible to exit of the Graphics.loop even with an exception *)
(* let loop () =
  let loop_handler_1 st1 =
    try
      if st1.keypressed then raise Exit;
      let loop_handler_2 st2 =
          moveto st1.mouse_x st1.mouse_y;
          lineto st2.mouse_x st2.mouse_y;
      in
      Graphics_js.loop [Button_up] loop_handler_2
    with
    | Exit -> print_endline "stop!" ; close_graph ()
  in
  Graphics_js.loop [Key_pressed;Button_down] loop_handler_1 *)

(* Second idea, no choice : listen all events at the same level and make a state management (Here: c_status var) *)
let loop () =
  let c_status : status option ref = ref None in
  let loop_handler st =
    try
      if st.button then c_status := Some st
      else (
        match !c_status with
        | Some s ->
          moveto s.mouse_x s.mouse_y;
          lineto st.mouse_x st.mouse_y;
          c_status := None ;
        | None -> print_endline "NONE!" ; 
      );
      if st.keypressed then
        match !c_status with
        | Some s -> ()
        | None -> raise Exit
    with
    | Exit -> print_endline "exit!" ; close_graph ()
  in
  Graphics_js.loop [Key_pressed;Button_down;Button_up] loop_handler

let init canvas =
  print_endline "initializing";
  Graphics_js.open_canvas canvas;
  loop ()

let () = Js.export "init" init
