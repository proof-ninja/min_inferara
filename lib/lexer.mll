let space = ['\t' '\n' '\r' ' ']

let id_char = ['0'-'9' 'A'-'Z' '_' 'a'-'z' '.']

rule token = parse
| '\n' { Lexing.new_line lexbuf; token lexbuf }
| '\t' { token lexbuf }
| ' ' { token lexbuf }
| "/*" { block_comment lexbuf; token lexbuf }
| "//" { line_comment lexbuf; token lexbuf }
| '@' { Parser.AT }
| "fn" { Parser.FN }
| '(' { Parser.LPAREN }
| ')' { Parser.RPAREN }
| '{' { Parser.LBRACKET }
| '}' { Parser.RBRACKET }
| ',' { Parser.COMMA }
| ':' { Parser.COLON }
| ';' { Parser.SEMICOLON }
| '=' { Parser.DEF_EQUAL }
| '+' { Parser.PLUS }
| '-' { Parser.MINUS }
| '*' { Parser.MULT }
| '/' { Parser.DIV }
| "==" { Parser.EQUALS }
| '<' { Parser.LT }
| '>' { Parser.GT }
| "<=" { Parser.LTE }
| ">=" { Parser.GTE }
| "->" { Parser.ARROW }
| "forall" { Parser.FORALL }
| "exists" { Parser.EXISTS }
| "external" { Parser.EXTERNAL }
| "assert" { Parser.ASSERT }
| "let" { Parser.LET }
| id_char+ as lexeme { Parser.ID lexeme }
| eof { Parser.EOF }

and line_comment = parse
| ('\n' | eof) { Lexing.new_line lexbuf }
| _ { line_comment lexbuf }

and block_comment = parse
| "*/" { () }
| "/*" { block_comment lexbuf; block_comment lexbuf }
| '\n' { Lexing.new_line lexbuf; block_comment lexbuf }
| eof { () }
| _ { block_comment lexbuf }
