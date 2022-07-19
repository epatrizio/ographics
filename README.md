# ographics - OCaml Graphics to the web

This project is a study whose objective is to bring the OCaml Graphics library to the web via js_of_ocaml.\
This will allow multiple examples written in OCaml Graphics to be exported to the
[Learn-OCaml](https://github.com/ocaml-sf/learn-ocaml) learning web platform.

*This study, done at [IRILL - Research and Innovation on Free Software](https://www.irill.org)
is part of my professional training.*

## Technical environment

* [OCaml Graphics](https://github.com/ocaml/graphics) is the standard OCaml library for drawing, manipulating bitmaps and simply interacting with the end user (keyboard, mouse).
* [Js_of_ocaml](https://ocsigen.org/js_of_ocaml/) is an open source component of web development tools suite written in OCaml by [Ocsigen](https://ocsigen.org). Js_of_ocaml is a compiler whose target is Javascript.

## Challenge and execution

This study real challenge consists in bringing together the event system OCaml and Javascript,
which are completely different. To do this, after a lot of experimentations,
I had to go through [LWT - Light Weight cooperative Threads](https://ocsigen.org/lwt/),
the asynchronous programming component written in monadic style.

The Makefile contains all the example compilation tasks.
Then, to see the result, just open the src/demo.html file in your favorite browser.

*For information, most of the source files contain in comments all the progressive experiments.*
