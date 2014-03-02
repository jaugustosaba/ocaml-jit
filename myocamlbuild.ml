open Ocamlbuild_plugin;;

dispatch begin function
| After_rules ->
    flag ["c"; "compile"; "debug"] (S[A"-ccopt"; A"-g"]);
    dep ["ocaml"; "jit_native"] ["jit-x86_64.o"];
| _ -> ()
end
