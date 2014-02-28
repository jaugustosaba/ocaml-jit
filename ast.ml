type expr =
  Num of int
| Add of expr * expr
| Mul of expr * expr

let to_list expr = 
  let res = ref [] in
  let rec walk expr =
    match expr with
      Num n -> res := (string_of_int n) :: !res
    | Add (l, r) ->
        begin
          walk l;
          walk r;
          res := "+" :: !res
        end
    | Mul (l, r) ->
        begin
          walk l;
          walk r;
          res := "*" :: !res
        end
  in begin
    walk expr;
    List.rev !res
  end

let to_string expr = String.concat " " (to_list expr)
