(*
LWT (light-weight cooperative threads) seems to be the only solution of my problem
So here is my wait_next_event function implementation with a LWT approach

original signature  wait_next_event evt_list : status 
becomes             wait_next_event evt_list : status Lwt.t

Implementation is inspired by loop function
https://github.com/ocsigen/js_of_ocaml/blob/master/lib/lwt/graphics/graphics_js.ml
Nb. some elements of graphics_js.ml have been hard included here because not exposed in the .mli interface
*)

open Js_of_ocaml
open Js_of_ocaml_lwt
open Graphics_js

(* --- Hard copy some elements from graphics_js.ml --- *)
class type context_ =
  object
    method canvas : Dom_html.canvasElement Js.t Js.readonly_prop
  end

type context = context_ Js.t

let ( >>= ) = Lwt.bind

external get_context : unit -> context = "caml_gr_state_get"
external document_of_context : context -> Dom_html.document Js.t = "caml_gr_doc_of_state"

let compute_real_pos (elt : #Dom_html.element Js.t) ev =
  let r = elt##getBoundingClientRect in
  let x =
    (float_of_int ev##.clientX -. r##.left)
    /. (r##.right -. r##.left)
    *. float_of_int elt##.width
  in
  let y =
    (float_of_int ev##.clientY -. r##.top)
    /. (r##.bottom -. r##.top)
    *. float_of_int elt##.height
  in
  truncate x, elt##.height - truncate y
;;
(* ------ *)

let mouse_x, mouse_y = ref 0, ref 0
let button = ref false

let wait_next_event evt_list : status Lwt.t =
  let ctx = get_context () in
  let elt = ctx##.canvas in
  let doc = document_of_context (get_context ()) in
  let pick_list = ref [] in
  
    elt##.onmousemove :=
    Dom_html.handler (fun ev ->
        let cx, cy = compute_real_pos (elt :> #Dom_html.element Js.t) ev in
        mouse_x := cx;
        mouse_y := cy;
        Js._true);

    if List.mem Button_down evt_list then
      pick_list := (Lwt_js_events.mousedown elt >>= (fun ev ->
        button := true;
        Lwt.return { mouse_x = !mouse_x; mouse_y = !mouse_y; button = true; keypressed = false; key = '0' }))
        :: !pick_list;

    if List.mem Button_up evt_list then
      pick_list := (Lwt_js_events.mouseup elt >>= (fun ev ->
        button := false;
        Lwt.return { mouse_x = !mouse_x; mouse_y = !mouse_y; button = false; keypressed = false; key = '0' }))
        :: !pick_list;

    if List.mem Mouse_motion evt_list then
      pick_list := (Lwt_js_events.mousemove elt >>= (fun ev ->
        Lwt.return { mouse_x = !mouse_x; mouse_y = !mouse_x; button = !button; keypressed = false; key = '0' }))
        :: !pick_list;

    if List.mem Key_pressed evt_list then
      pick_list := (Lwt_js_events.keypress doc >>= (fun ev ->
        let key =
          try char_of_int (Js.Optdef.get ev##.charCode (fun _ -> 0))
          with Invalid_argument _ -> '0'
        in
        Lwt.return { mouse_x = !mouse_x; mouse_y = !mouse_y; button = !button; keypressed = true; key = key }))
        :: !pick_list;

    Lwt.pick !pick_list
;;
