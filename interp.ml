let rec eval expr =
  match expr with
    Ast.Num n -> n
  | Ast.Add (l, r) -> (eval l) + (eval r)
  | Ast.Mul (l, r) -> (eval l) * (eval r)