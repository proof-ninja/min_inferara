%token <string> ID
%token AT
%token FN
%token FORALL EXISTS
%token EXTERNAL LET ASSERT
%token ARROW
%token LPAREN RPAREN
%token LBRACKET RBRACKET
%token COMMA COLON SEMICOLON DEF_EQUAL
%token PLUS MINUS DIV MULT
%token EQUALS GT LT GTE LTE
%token EOF
%type <Ast.decl list> program
%start program

%%

program:
  | decl* EOF { $1 }

decl:
| EXTERNAL FN ID params_ty ARROW ID SEMICOLON { Ast.External($3, $4, $6) }
| FN ID params quantifier? LBRACKET statements RBRACKET { Ast.FunDecl($2, $3, $6) }

statements:
| statement* { $1 }

quantifier:
| FORALL { $1 }
| EXISTS { $1 }

id_with_type:
| ID COLON ID { $1 }

id:
| ID { $1 } | id_with_type { $1 }

params:
| LPAREN separated_list(COMMA, id)  RPAREN { $2 }
params_ty:
| LPAREN separated_list(COMMA, ID) RPAREN { $2 }

expr_with_name:
| ID COLON expr { $3 }
| expr { $1 }
expr:
| ID { Ast.Id($1) }
| AT { Ast.At }
| expr LPAREN separated_list(COMMA, expr_with_name) RPAREN { Ast.Apply($1, $3) }
(*| expr SEMICOLON expr? { Ast.Sequence($1, Option.value ~default:Ast.tt $3) }*)
| expr PLUS   expr { Ast.Op(Plus,   $1, $3) }
| expr MINUS  expr { Ast.Op(Minus,  $1, $3) }
| expr MULT   expr { Ast.Op(Mult,   $1, $3) }
| expr DIV    expr { Ast.Op(Div,    $1, $3) }
| expr EQUALS expr { Ast.Op(Equals, $1, $3) }
| expr LTE    expr { Ast.Op(Lte,    $1, $3) }
| expr GTE    expr { Ast.Op(Gte,    $1, $3) }
| expr LT     expr { Ast.Op(Lt,     $1, $3) }
| expr GT     expr { Ast.Op(Gt,     $1, $3) }

statement:
| LET id DEF_EQUAL expr SEMICOLON { Ast.Let($2, $4) }
| ASSERT expr SEMICOLON { Ast.Assert $2 }
| expr SEMICOLON { Ast.Expr $1 }
