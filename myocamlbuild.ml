open Ocamlbuild_plugin;;

dispatch begin function
| After_rules ->
    flag ["c"; "compile"; "jit_native"; "debug"] (S[A"-ccopt"; A"-g"]);
    dep ["link"; "ocaml"; "jit_native"] ["jit-x86_64.o"];
| _ -> ()
end
