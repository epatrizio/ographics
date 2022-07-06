//Provides: caml_add const
function caml_add(n1, n2) {
    return n1 + n2;
}

//Provides: caml_hello const
//Requires: caml_jsstring_of_string
function caml_hello(world) {
    var world = caml_jsstring_of_string(world);
    var h = "hello, " + world + "! ;)";
    return h;
}
