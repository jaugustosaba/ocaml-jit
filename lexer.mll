{

exception Lex_error of string

}

rule lex = parse
  '+' { Parser.ADD }
| '*' { Parser.MUL }
| '(' { Parser.LPAREN }
| ')' { Parser.RPAREN }
| ['0' - '9']+ { Parser.NUM (int_of_string (Lexing.lexeme lexbuf)) }
| (' ' | '\t' | '\n' | '\r') { lex lexbuf }
| eof { Parser.EOF }
| _ { raise (Lex_error (Lexing.lexeme lexbuf)) }
