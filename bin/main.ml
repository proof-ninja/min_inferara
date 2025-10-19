open Min_inferara
open Common

let parse_file filename =
  let ic = open_in filename in
  let lex = Lexing.from_channel ic in
  Lexing.set_filename lex filename;
  try
    let result = Parser.program Lexer.token lex in
    close_in ic;
    Ok result
  with e ->
    let pos = Lexing.lexeme_start_p lex in
    let col = pos.pos_cnum - pos.pos_bol in
    Printf.sprintf
      "%s:%d:%d: syntax error. (%s)\n"
      pos.pos_fname pos.pos_lnum (col + 1)
      (Printexc.to_string e)
    |> Result.error

let () =
  print_endline "Hello, Min Inferara Language!";
  let filename = Sys.argv.(1) in
  match parse_file filename with
  | Ok prog ->
     print_endline (!%"Parse: %s" (Ast.show_program prog))
  | Error err -> print_endline err
