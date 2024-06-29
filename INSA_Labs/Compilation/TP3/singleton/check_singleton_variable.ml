open Type

let rec get_variable_from_term (term : term) : (string * int * int) list = 
  match term with 
    | Integer _-> []
    | EmptyList -> []
    | BuiltinFunctor(_,ta,tb) -> get_variable_from_term ta @ get_variable_from_term tb 
    | Variable(s,i,l) -> [(s,i,l)]
    | Functor(_,tl) -> get_variable_from_term_list tl 
    | Cons(ta,tb) -> get_variable_from_term ta @ get_variable_from_term tb 
and get_variable_from_term_list tl = 
  match tl with
    | [] -> []
    | t::q -> get_variable_from_term t @ get_variable_from_term_list q


let get_variables_from_predicate (predicate : predicate) : (string * int * int) list = 
  match predicate with 
    | Predicate(_, tl) -> get_variable_from_term_list tl
    | BuiltinPredicate b -> 
      match b with
        | Is (ta,tb)
        | ArithmeticEquality (ta,tb)
        | ArithmeticInequality (ta,tb)
        | ArithmeticLess (ta,tb)
        | ArithmeticGreater (ta,tb)
        | ArithmeticLeq (ta,tb)
        | ArithmeticGeq (ta,tb)
        | TermEquality (ta,tb)
        | TermInequality (ta,tb)
        | TermUnify (ta,tb)
        | TermNotUnify (ta,tb) -> get_variable_from_term ta @ get_variable_from_term tb
        | TermVar t
        | TermNotVar t
        | TermInteger t
        | TermNotInteger t -> get_variable_from_term t


let check_clause = function
  | Clause(predicate, predicate_list) ->
    let variables =
      predicate :: predicate_list
      |> List.map get_variables_from_predicate
      |> List.concat
      |> List.sort Stdlib.compare
    in
    let print_error (pos, x) =
      Printf.printf "singleton variable %s at line %d\n" x pos
    in
    let rec singleton_variable prev = function
      | [] -> []
      | (x, _, _) :: r when String.get x 0 = '_' -> singleton_variable None r
      | (x1, id1, pos1) :: (x2, id2, pos2) :: r when id1 = id2 -> singleton_variable (Some id1) r
      | (x, id, pos) :: r when prev = Some id -> singleton_variable prev r
      | (x, id, pos) :: r -> (pos, x) :: singleton_variable (Some id) r
    in
    singleton_variable None variables
    |> List.sort Stdlib.compare
    |> List.iter print_error

let check_program prog = List.iter check_clause prog
