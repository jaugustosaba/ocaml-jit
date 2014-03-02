let lexbuf = Lexing.from_channel stdin in
  try
    let ast = Parser.root Lexer.lex lexbuf in
    let postfix = Ast.to_string ast in
    let ir = Interp.compile ast in
    let res = Interp.eval ir in
      begin
        Printf.printf "Postfix: %s\n" postfix;
        Printf.printf "Result: %d\n" res;
        Printf.printf "IR:\n";
        Interp.dump ir;
        Printf.printf "JIT: %d\n" (Jit.eval ir);
        flush stdout
      end
  with
    Lexer.Lex_error lexeme -> Printf.printf "Bad word \"%s\"\n" lexeme
  | Parsing.Parse_error -> Printf.printf "Syntax error\n"
    
