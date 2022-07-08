(*
Here is the event studies example with my wait_next_event function rewrite in a "LWT style".
More details about work steps, see: src/examples/event_studies.ml

The loop function below is recursive (> out the while loop),
the binding structure is the same that the original,
and with operator redefinition, there is almost no difference! ;)
*)

open Js_of_ocaml
open Graphics_js
open Graphics_js_ext

(* OCaml graphics classic version *)
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

(* V1 *)
(* let rec loop () =
  Lwt.bind (wait_next_event [Button_down;Key_pressed]) (
    fun st1 ->
      if st1.keypressed then close_graph ();
      Lwt.bind (wait_next_event [Button_up]) (
        fun st2 -> 
          moveto st1.mouse_x st1.mouse_y;
          lineto st2.mouse_x st2.mouse_y;
          loop ()
    )
  ) *)

(* V2 : with monadic bind operator *)
(* let rec loop () =
  (wait_next_event [Button_down;Key_pressed]) >>=
    fun st1 ->
      if st1.keypressed then close_graph ();
      (wait_next_event [Button_up]) >>=
        fun st2 -> 
          moveto st1.mouse_x st1.mouse_y;
          lineto st2.mouse_x st2.mouse_y;
          loop () *)

(* V3 : with monadic bind operator redefinition *)
let rec loop () =
  let* st1 = wait_next_event [Button_down;Key_pressed] in
    if st1.keypressed then close_graph ();
    let* st2 = wait_next_event [Button_up] in
      moveto st1.mouse_x st1.mouse_y;
      lineto st2.mouse_x st2.mouse_y;
      loop ()

let init canvas =
  print_endline "initializing";
  Graphics_js.open_canvas canvas;
  loop ()

let () = Js.export "init" init
