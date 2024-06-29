(* Examen Ocaml 2020 *)
(* Nom:              *)
(* Prénom:           *)

(** {Nombre en représentation binaire} **)

(* Q1 *)

type bit =
  | B0
  | B1

type bint = bit list

(* Q2  *)

let int_of_bit b = 
  match b with
  | B0 -> 0
  | B1 -> 1

(* TEST *)
let _ = int_of_bit B0 = 0 && int_of_bit B1 = 1;;
(* END *)

(* Q3 *)
let f b acc = int_of_bit b + 2*acc
let int_of_bint l =
  List.fold_right f l 0

let _ = int_of_bint [B1] = 1 && int_of_bint [B1;B0;B1] = 5;;

(* Q4 *)

let rec count_zeros l =
  match l with
  |[]->0
  |t::q -> if (t=B0) then 1 + count_zeros q else 0

let _ = count_zeros [B0;B0;B0;B1;B0;B1] = 3;;

(* Q5 *)

let rec count_and_remove l =
  match l with
  |[]->([], 0)
  |B1::q -> (B1::q,0)
  |B0::q -> 
    let(l,n)=count_and_remove q in 
    (l,1+n)


let _ = count_and_remove [B0;B0;B0;B1;B0;B1] = ([B1;B0;B1], 3);;

(* Q6 *)
let rec remove l =
  match l with
  |[]->[]
  |B1::q -> l
  |B0::q -> remove q

let rec normalise l = List.rev ( remove (List.rev l))
  


let n = remove [B0;B1;B1;B0]

let _ =
  let n1 = normalise [B0;B1;B1] in
  let n2 = normalise [B0;B1;B1;B0] in
  let n3 = normalise [B0;B1;B1;B0;B0] in
  n1 = n2 && n2 = n3 && n3 = [B0;B1;B1];;


(** {Bibliothèque d'ensembles} *)
type comparison = EQUAL| LESSTHAN| GREATERTHAN

let cmp_int = fun i j -> if i = j then EQUAL else if i < j then LESSTHAN else GREATERTHAN;;
let cmp_int i j = if i = j then EQUAL else if i < j then LESSTHAN else GREATERTHAN;;

(* Q7 *)

let rec is_sorted cmp l = 
  match l with
  |[]->true
  |[_]->true
  |t1::t2::q -> if (cmp t1 t2 <> GREATERTHAN) then is_sorted cmp (t2::q) else false

let _ = (is_sorted cmp_int [1;5;7]) && not (is_sorted cmp_int [1;7;5]);;

(** Q8 *)

let rec add_elt cmp e l =
  match l with
  |[]-> [e]
  |t::q -> if (cmp e t <> GREATERTHAN) then e::l else t::(add_elt cmp e q)


let _ = add_elt cmp_int 6 [1;5;7] = [1;5;6;7];;

(* Q9 *)

let rec union cmp l1 l2 =
  match (l1,l2) with
  |([],[])->[]
  |(t::q, [])->t::q
  |([], t::q)->t::q
  |(t1::q1, t2::q2)-> 
    if (cmp t1 t2 = LESSTHAN)
      then t1::t2::(union cmp q1 q2) 
    else 
      if (cmp t1 t2 = EQUAL)
        then t1::(union cmp q1 q2) 
      else t2::(union cmp (t1::q1) q2)



let _ = union cmp_int [1;5;7] [2;5;6] = [1;2;5;6;7];;


(* ------------{Représentation d'ensembles d'entiers}---------------- *)

type intset = Empty | Node of intset * bool * intset;;

(* Soit la liste d'entiers binaires l qui représente l'ensemble {0;2;3;4;7}. *)
let l = [ [] ; [B0;B1] ; [B1;B1] ; [B0;B0;B1] ; [B1;B1;B1] ];;
(* L'arbre a reprśente la liste l sous forme de intset *)
let a = Node
          (Node (Node (Empty, false, Node (Empty, true, Empty)), false,
                 Node (Empty, true, Empty)),
           true, Node (Empty, false, Node (Empty, true, Node (Empty, true, Empty))))

(* Q10 *)

let rec cardinal s = match s with
  |Empty -> 0
  |Node(sg,boo,sd)-> if boo=true then 1 + cardinal sg + cardinal sd else cardinal sg + cardinal sd

let _ = cardinal Empty = 0 && cardinal a = 5

(* Q11 *)

let rec mem s x = match s with
  |Empty -> false
  |Node(sg,boo,sd)->
    begin
      match x with
      |[]->boo
      |t::q -> if t = B0 then mem sg q else mem sd q
    end

let _ = mem a [] && mem a [B0;B0;B1] && not (mem a [B1]);;

(* Q12 *)

let rec singleton l = match l with  
  |[]-> Node(Empty,true,Empty)
  |t::q->if t=B0 then Node(singleton q,false,Empty) else Node(Empty,false,singleton q)

let _ = singleton [B0;B1] = Node (Node (Empty, false, Node (Empty, true, Empty)), false, Empty);;

(* Q13 *)

let rec add_elt i s = failwith "TODO"


let a1 = Node
 (Node (Node (Empty, false, Node (Empty, true, Empty)), false,
   Node (Empty, true, Node (Empty, true, Empty))),
 true, Node (Empty, false, Node (Empty, true, Node (Empty, true, Empty))));;

let _ = add_elt [B1;B1] a = a &&  add_elt [B0;B1; B1] a = a1;;


(* Q14 *)

let rec remove_elt i s = if mem s i = false then s else
  match s with
  | Empty -> Empty
  | Node(sg,boo,sd) ->
    begin 
      match i with 
      | [] -> Node(sg,false,sd)
      | e :: i1 -> if e = B0 then Node(remove_elt i1 sg,boo,sd) else Node(sg,boo,remove_elt i1 sd)
    end

let _ = remove_elt [] Empty = Empty &&
          remove_elt [B1;B1;B1] Empty = Empty &&
            remove_elt [] a  = Node
          (Node (Node (Empty, false, Node (Empty, true, Empty)), false,
                 Node (Empty, true, Empty)),
           false, Node (Empty, false, Node (Empty, true, Node (Empty, true, Empty)))) &&
              remove_elt [B1;B1;B1] a = 
                Node
                  (Node (Node (Empty, false, Node (Empty, true, Empty)), false,
                         Node (Empty, true, Empty)),
                   true, Node (Empty, false, Node (Empty, true, Node (Empty, false, Empty))));;

(* Q15 *)

let rec is_empty s = cardinal s = 0

let _ = is_empty Empty = true  &&
        is_empty (Node(Empty, false, Empty)) = true &&
          is_empty (Node(Empty, true, Empty)) = false &&
            is_empty a = false;;

(* Q16 *)


let rec minimise s = match s with
| Empty -> Empty
| Node(sg,boo,sd) ->
  begin
    match (cardinal sg,cardinal sd) with
    | (0,0) -> if boo then Node(Empty,boo,Empty) else Empty
    | (0,_) -> Node(Empty,boo,minimise sd)
    | (_,0) -> Node(minimise sg,boo,Empty)
    | (_,_) -> Node(minimise sg,boo,minimise sd)
  end


let _ = minimise Empty = Empty &&
          minimise (Node(Empty,false,Empty)) = Empty &&
            minimise
              (Node
                 (Node (Node (Empty, false, Node (Empty, false, Empty)), false,
                     Node (Empty, false, Empty)),
                  false, Node (Empty, false, Node (Empty, true, Node (Empty, false, Empty))))) =
              Node (Empty, false, Node (Empty, false, Node (Empty, true, Empty)));;

(* Q17 *)

let rec union s1 s2 = match (s1,s2) with
| (Empty,Empty) -> Empty
| (_,Empty) -> s1
| (Empty,_) -> s2
| (Node(sg1,boo1,sd1),Node(sg2,boo2,sd2)) -> if boo2 
                                            then Node((union sg1 sg2), boo2, (union sd1 sd2))
                                            else Node((union sg1 sg2), boo1, (union sd1 sd2))

let u1 =
  (* [ [] ; [B0;B1] ; [B1;B1;B1] ] *)
  Node (Node (Empty, false, Node (Empty, true, Empty)), true,
               Node (Empty, false, Node (Empty, false, Node (Empty, true, Empty))));;
let u2 = 
  (*[[B1;B1];[B0;B0;B1];[B1;B1;B1]] *)
  Node (Node (Node (Empty, false, Node (Empty, true, Empty)), false, Empty),
        false, Node (Empty, false, Node (Empty, true, Node (Empty, true, Empty))));;

let _ = union u1 Empty = u1 && union Empty u2 = u2 && union u1 u2 = a;;


(* Q18 *)

let div2 s = match s with
| Empty -> Empty
| Node(sg,boo,sd) ->  union sg sd

let _ =
  div2 Empty = Empty
  && div2 (Node(Empty, true, Empty)) = Empty
  && div2 (Node(Node(Empty, true, Empty),false,Empty)) = Node(Empty, true, Empty)
  && div2 (Node(Empty,false,Node(Empty, true, Empty))) = Node(Empty, true, Empty)
  && div2 a = Node (Node (Empty, false, Node (Empty, true, Empty)), false,
   Node (Empty, true, Node (Empty, true, Empty)));;

(* Q19 *)
(* FONCTIONNE PAS *)

let rec elements a = match a with
|Empty -> []
|Node(g,true,d)-> let (i:bint) = [] in i::( (List.map (fun i-> B0::i) (elements g))@(List.map (fun i-> B1::i) (elements d)) )
|Node(g,false,d) -> (List.map (fun i-> B0::i) (elements g))@(List.map (fun i-> B1::i) (elements d))

let _ = 
  elements Empty = [] &&
  elements (Node(Empty, true, Empty)) = [[]]  &&
    elements (Node (Node(Empty,true, Empty), false, Empty)) = [[B0]]  &&
      elements (Node(Empty, false, (Node(Empty, true, Empty)))) = [[B1]]  &&
        List.sort compare (elements a) = List.sort compare l;;



