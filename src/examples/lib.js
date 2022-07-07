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

// wait_next_event : Failed experiments! Function flow never stops in js (see event_studies.ml)
/*
function caml_gr_wait_next_event (elist) {
    var elist = caml_list_to_js_array(elist);
    var cont = true;

    // EventListener V1
    document.getElementById('canvas').onmousedown = function (e) {
        console.log(e);
        cont = false;
        return "my status";
    };

    // EventListener V2: in a promise
    new Promise(function (resolve, reject) {
        document.getElementById('canvas').addEventListener("mousedown", function(e) {
            console.log(e);
            resolve("return promise status");
        }, {once: true});
    });

    // To force flow stop : add active wait, never good for CPU!
    while (cont) {
        setTimeout(function(){
        }, 2000);
    }

    return "my default status";  // Needed for the flow when called over OCaml, but not desired!
}
*/

// via async await keywords, it becomes possible to have a synchronous flow execution including promises
// but js_of_ocaml compiler failed when javascript contains async await!
/*
async function getNum() {
    var promise = new Promise(function (resolve) {
        resolve(42)
    });
    var num = await promise;
    console.log(num);  
    return num;
}
*/