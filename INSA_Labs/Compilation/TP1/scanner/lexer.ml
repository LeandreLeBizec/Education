type token =
| INT of int
| VARIABLE of string
| NAME of string
| LEFT_PAREN | RIGHT_PAREN
| LEFT_BRACKET | RIGHT_BRACKET
| PIPE | DOT | COMMA | COLON_HYPHEN
| PLUS | MINUS | MULT | DIV
| TERM_EQ | TERM_INEQ | IS | TERM_UNIFY | TERM_NOT_UNIFY
| TERM_VAR | TERM_NOT_VAR | TERM_INTEGER | TERM_NOT_INTEGER
| ARITH_EQ | ARITH_INEQ | ARITH_LESS | ARITH_GREATER | ARITH_GEQ | ARITH_LEQ
| EOF

let print = function
  | INT i -> Printf.printf "INT %d\n" i
  | VARIABLE var -> Printf.printf "VARIABLE %s\n" var
  | NAME name -> Printf.printf "NAME %s\n" name
  | LEFT_PAREN -> Printf.printf "LEFT_PAREN\n"
  | RIGHT_PAREN -> Printf.printf "RIGHT_PAREN\n"
  | LEFT_BRACKET -> Printf.printf "LEFT_BRACKET\n"
  | RIGHT_BRACKET -> Printf.printf "RIGHT_BRACKET\n"
  | PIPE -> Printf.printf "PIPE\n"
  | DOT -> Printf.printf "DOT\n"
  | COMMA -> Printf.printf "COMMA\n"
  | COLON_HYPHEN -> Printf.printf "COLON_HYPHEN\n"
  | PLUS -> Printf.printf "PLUS\n"
  | MINUS -> Printf.printf "MINUS\n"
  | MULT -> Printf.printf "MULT\n"
  | DIV -> Printf.printf "DIV\n"
  | TERM_EQ -> Printf.printf "TERM_EQ\n"
  | TERM_INEQ -> Printf.printf "TERM_INEQ\n"
  | IS -> Printf.printf "IS\n"
  | TERM_UNIFY -> Printf.printf "TERM_UNIFY\n"
  | TERM_NOT_UNIFY -> Printf.printf "TERM_NOT_UNIFY\n"
  | TERM_VAR -> Printf.printf "TERM_VAR\n"
  | TERM_NOT_VAR -> Printf.printf "TERM_NOT_VAR\n"
  | TERM_INTEGER -> Printf.printf "TERM_INTEGER\n"
  | TERM_NOT_INTEGER -> Printf.printf "TERM_NOT_INTEGER\n"
  | ARITH_EQ -> Printf.printf "ARITH_EQ\n"
  | ARITH_INEQ -> Printf.printf "ARITH_INEQ\n"
  | ARITH_LESS -> Printf.printf "ARITH_LESS\n"
  | ARITH_GREATER -> Printf.printf "ARITH_GREATER\n"
  | ARITH_GEQ -> Printf.printf "ARITH_GEQ\n"
  | ARITH_LEQ -> Printf.printf "ARITH_LEQ\n"
  | EOF -> Printf.printf "EOF\n"

exception Lexical_error of string

let line_number = ref 0

let newline () = incr line_number

let error msg = raise (Lexical_error (msg ^ " at line " ^ string_of_int !line_number))

let rec get_token stream =
  let next () = Stream.next stream in (* retourne le premier caractère du flot et supprime ce caractère. Si le flot est vide, une exception de type Stream.Failure est lancée *)
  let peek () = Stream.peek stream in (* retourne le premier caractère du flot sans le supprimer. L'élément renvoyé est Some('a'), par exemple, si le flot n'est pas vide, et None sinon *)
  let junk () = Stream.junk stream |> ignore in (* supprime le premier caractère du flot et renvoie une exception de type Stream.Failure si le flot est vide *)
  let char_to_string c = String.make 1 c in
  let rec consume_comment () = 
    try
      if peek () = Some('*') then 
        begin
          junk ();
          if peek () <> Some('/') then consume_comment ()
          else junk () 
        end
      else
        begin 
          if next () = '\n' then newline ();
          consume_comment ()
        end
    with Stream.Failure -> error "EOF in comment"
  in
  try
    match next() with
    |'(' -> LEFT_PAREN
    |')' -> RIGHT_PAREN
    |'[' -> LEFT_BRACKET
    |']' -> RIGHT_BRACKET
    |'|' -> PIPE
    |'.' -> DOT
    |',' -> COMMA
    |'+' -> PLUS
    |'-' -> MINUS
    |'*' -> MULT
    |'/' -> begin
      if peek () = Some('*') 
        then ( junk (); consume_comment (); get_token stream) 
      else DIV
    end
    |' ' | '\t' | '\r' -> get_token stream
    | '\n' -> newline (); get_token stream
  with Stream.Failure -> EOF

