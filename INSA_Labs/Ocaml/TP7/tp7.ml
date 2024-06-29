type 'a narbr =
  |Noeud of 'a * 'a narbr list 

let feuille v = Noeud (v,[])
let noeud v l = Noeud (v,l)
let valeur a = 
  match a with
  | Noeud(v,_) -> v
  | _-> assert false

let rec sous_arbres a =
  match a with
  | Noeud(_,l) -> l
  | _ -> assert false

let a1 = feuille 4
let a2 = noeud 3 [a1; a1]

(* TEST *)
(* Doivent retourner true *)
let _ = valeur a1 = 4
let _ = valeur a2 = 3
let _ = sous_arbres a1 = []
let _ = sous_arbres a2 = [a1; a1]
(* END TEST *)

let rec compter a = 
  match a with 
  |Noeud(_,[]) -> 1
  |Noeud(_,l) -> let rec compterl list = 
    match list with
    |[]-> 1
    |e::[] -> compter e
    |e::l' -> compter e + compterl l' in compterl l

(* TEST *)
(* doit retourner 2 *)
let _ = compter a2
(* END TEST *)

let rec pluslongue a = 
  match a with
  |Noeud(_,[]) -> 1
  |Noeud(_,b::l) -> 1 + max (pluslongue b) (let rec vpluselevee list = 
    match list with 
    |[] -> 0
    |e::l' -> max (pluslongue e) (vpluselevee l') in vpluselevee l)

let a3 = noeud 8 [a1; a2; a1]
(* TEST *)
(* doit retourner 3 *)
let _ = pluslongue a3
(* END TEST *)

let rec listsa a = 
  match a with
  |Noeud(_,list) -> let rec sa l =
    match l with
    |[] -> [] 
    |e::l' -> (listsa e)@(sa l')
    in (sa list)@[a]
let f4 = feuille 4
let f10 = feuille 10
let f12 = feuille 12
let f13 = feuille 13
let f20 = feuille 20
let f21 = feuille 21
let n7 = noeud 7 [f10; f12; f13]
let n3 = noeud 3 [f4; n7; f20]
let n5 = noeud 5 [n3; f21]


(* TEST *)
(* Ceci doit retourner true *)
let _ =
  List.sort compare (listsa n5)
  = List.sort compare [f4; f10; f12; f13; f20; f21; n7; n3; n5]
(* END TEST *)

let rec mapconcat v l = 
  match l with 
  |[] -> []
  |e::l' -> (v::e)::(mapconcat v l')
let rec listbr a = 
  match a with
  |Noeud(v,[]) -> [[v]]
  |Noeud(v,l) -> mapconcat v (let rec affectll list =  
    match list with 
    |[] -> []
    |e::l' -> (listbr e) @ (affectll l') in affectll l)

(* TEST *)
(* doit retourner true *)
let _ =
  let res =
    [
      [5; 3; 4]; [5; 3; 7; 10]; [5; 3; 7; 12]; [5; 3; 7; 13]; [5; 3; 20]; [5; 21];
    ]
  in
  List.sort compare (listbr n5) = List.sort compare res
(* END TEST *)

let rec egal a b = 
  match (a,b) with
  |(Noeud (x,[]),Noeud (y,[])) -> x = y
  |(Noeud (x,l1),Noeud (y,l2)) -> 
    if x != y 
      then false 
    else (let rec aux lst1 lst2 = 
      match (lst1,lst2) with
      |([],[]) -> true
      |(a1::[],a2::[]) -> egal a1 a2
      |(a1::z1,a2::z2) -> 
        if egal a1 a2 
          then aux z1 z2 
        else false
      |(_,_) -> false in aux l1 l2)

(* TEST *)
(* doit retourner true *)
let _ = egal n5 n5
(* END TEST *)

let rec remplace a1 a2 a = 
  if egal a1 a 
    then a2 
  else 
    match a with 
    |Noeud(v,l)-> Noeud (v, let rec remplacefaible lst = 
      match lst with
      |[] -> []
      |b::z -> 
        if egal a1 b 
          then a2::z 
        else (remplace a1 a2 b)::(remplacefaible z) 
        in remplacefaible l)
let n42 = noeud 42 [feuille 2048]
let res = noeud 5 [noeud 3 [f4; n42; f20]; f21]

(* TEST *)
(* ceci doit retourner true *)
let _ = remplace n7 n42 n5 = res
(* END TEST *)
