type instr =
  Push of int
| Add
| Mul

let compile expr =
  let instr_list = ref [] in
  let rec compile expr =
    match expr with
    | Ast.Num n ->
      instr_list := (Push n) :: !instr_list
    | Ast.Add (l, r) ->
      begin
        compile l;
        compile r;
        instr_list := Add :: !instr_list
      end
    | Ast.Mul (l, r) ->
      begin
        compile l;
        compile r;
        instr_list := Mul :: !instr_list
      end
  in begin
    compile expr;
    Array.of_list (List.rev !instr_list)
  end


let to_string instr =
  match instr with
    Push n -> Printf.sprintf "push %d" n
  | Add    -> "add"
  | Mul    -> "mul"


let dump code =
  let print_instr pc instr =
    let instr_str = to_string instr in
      Printf.printf "%5d: %s\n" pc  instr_str
  in
    Array.iteri print_instr code


let eval code =
  let stack = Stack.create () in
  let do_bin_op op =
    let right = Stack.pop stack in
    let left = Stack.pop stack in
      Stack.push (op left right) stack
  in
  let eval_instr instr =
    match instr with
      Push n -> Stack.push n stack
    | Add -> do_bin_op ( + )
    | Mul -> do_bin_op ( * )
  in begin
    Array.iter eval_instr code;
    Stack.top stack
  end