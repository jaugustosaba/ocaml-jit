let lexbuf = Lexing.from_channel stdin in
  try
    let ast = Parser.root Lexer.lex lexbuf in
    let str = Ast.to_string ast in
    let res = Interp.eval ast in
    let stk = Stack.compile ast in
      begin
        Printf.printf "AST: %s\n" str;
        Printf.printf "Result: %d\n" res;
        Printf.printf "Stack code dump:\n";
        Stack.dump stk
      end
  with
    Lexer.Lex_error lexeme -> Printf.printf "Bad word \"%s\"\n" lexeme
  | Parsing.Parse_error -> Printf.printf "Syntax error\n"
    
