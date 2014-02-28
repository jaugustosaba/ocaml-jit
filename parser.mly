%{
%}

%token ADD MUL LPAREN RPAREN EOF
%token<int> NUM
%left ADD
%left MUL

%type<Ast.expr> root
%type<Ast.expr> expr

%start root

%%

root : expr EOF { $1 };

expr :
  NUM { Ast.Num $1 }
| expr ADD expr { Ast.Add ($1, $3) }
| expr MUL expr { Ast.Mul ($1, $3) }
| LPAREN expr RPAREN { $2 }
;

%%
