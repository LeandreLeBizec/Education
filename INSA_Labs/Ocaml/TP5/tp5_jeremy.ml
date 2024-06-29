let rec longueur l = 
  match l with 
  | [] -> 0
  | e::[] -> 1
  | e::l1 -> 1+(longueur l1)

(* TEST *)
(* Ceci doit retourner 3 *)
let res = longueur [1;2;3]
(* END TEST *)

let rec appartient e l = 
  match l with
  | [] -> false
  | e1::l1 ->
    if e=e1
    then true
    else appartient e l1

(* TEST *)
(* Ceci doit retourner false *)
let res = appartient 4 [1;2;3]
(* retourne true *)
let res = appartient 3 [1;2;3]
(* END TEST *)

let rang e l = 
  if not(appartient e l)
  then 0
  else
  let rec rang2 e1 l1 r= 
    match l1 with
    | []-> assert false
    | e2::l2 ->
      if(e2 = e1 )
        then r
      else rang2 e1 l2 (r+1)
  in rang2 e l 1

(* TEST *)
(* Ceci doit retourner 2 *)
let res = rang 2 [3;2;1]
let res = rang 3 [3;2;1]
let res = rang 4 [3;2;1]
(* END TEST *)

let rec concatl l1 l2 = 
  match l1,l2 with
  | [],[] -> []
  | e1::l1',_ -> e1::(concatl l1' l2)
  | [],e2::l2' -> l2


(* TEST *)
(* Ceci doit retourner [1;2;3;4;5;6] *)
let res = concatl [1;2;3] [4;5;6]
(* END TEST *)

let rec debliste l n = 
  match l,n with
  | [],_ -> []
  | e::l1,1 -> e::[]
  | e::l1,_ -> e::(debliste l1 (n-1))

(* TEST *)
(* Ceci doit retourner [1; 2; 3] *)
let res = debliste [1;2;3;4;5;6;7] 3
(* END TEST *)

let rec finliste l n = 
  match l with
  | [] -> assert false
  | e::l1 ->
    if n >= (longueur l)
    then l
    else finliste l1 n


(* TEST *)
(* Ceci doit retourner [5; 6; 7] *)
let res = finliste [1;2;3;4;5;6;7] 3
(* END TEST *)

let rec remplace x y l = 
  match l with
  | [] -> []
  | e::l1 ->
    if e=x
    then y::(remplace x y l1)
    else e::(remplace x y l1)

(* TEST *)
(* Ceci doit retourner [1; 42; 3; 42; 5] *)
let res = remplace 2 42 [1;2;3;2;5]
(* END TEST *)

let rec entete l l1 = 
  if (longueur l)>(longueur l1)
  then false
  else
    match l,l1 with
    | [],_ -> true
    | e::l',e1::l1' -> 
      if e=e1
      then entete l' l1'
      else false
    | _,_ -> assert false

(* TEST *)
(* Ceci doit retourner true *)
let res = entete [1;2;3] [1;2;3;2;5]
(* END TEST *)

let rec sousliste l l1 = 
  if (longueur l)>(longueur l1)
    then false
    else
      match l1 with 
      | [] -> false
      | e::l1' ->
        if entete l l1
          then true
          else sousliste l l1'

(* TEST *)
(* Ceci doit retourner true *)
let res = sousliste [2;3;2] [1;2;3;2;5]
(* END TEST *)

let oter l l1 = 
  if not(entete l l1)
  then l1
  else finliste l1 (longueur l1 - longueur l)

(* TEST *)
 (* Ceci doit retourner [2; 5] *)
 let res = oter [1;2;3] [1;2;3;2;5]
(* END TEST *)

let rec remplacel l1 l2 l = 
  if not(sousliste l1 l)
  then l
  else 
    match l with
    | [] -> []
    | e::l' -> 
      if entete l1 l
      then concatl l2 (remplacel l1 l2 (finliste l (longueur l - longueur l1)))
      else e::(remplacel l1 l2 l')

(* TEST *)
(* Ceci doit retourner [4; 5; 6; 2; 5; 6; 2; 1; 3; 8] *)
let res = remplacel [1;2;1] [5;6] [4;1;2;1;2;1;2;1;2;1;3;8]
(* END TEST *)

let rec supprimel l1 l = 
  if l1 = []
  then l
  else
    match l with
    | [] -> []
    | e::l' -> 
      if entete l1 l
      then (supprimel l1 (finliste l (longueur l - longueur l1)))
      else e::(supprimel l1 l')

(* TEST *)
(* Ceci doit retourner [4; 2; 1; 3; 8] *)
let res = supprimel [1;2;1] [4;1;2;1;2;1;3;8]

(* Ceci doit retourner [1; 2; 3] *)
let res = supprimel [] [1;2;3]
(* END TEST *)
let rec somme l =
  match l with
  | [] -> 0
  | e::l1 -> e+(somme l1)
  
let res = somme [1;2;3]


  let maxl l =
    match l with
    | e::[] -> 0
    | e'::l'->
      let rec maxl2 l2 m2 =
        match l2 with 
        | es2::[] -> max es2 m2
        | e2::l2' ->
          let rec maxl3 l3 m3 =
            match l3 with
            | es3::[]-> max es3 m3
            | e3::l3' -> max (maxl3 (debliste l3 ((longueur l3) -1)) (max m3 (somme l3))) m3
            | _ -> assert false
          in 
          maxl2 l2' (max (somme l2) (maxl3 l2' m2))
        | _ -> assert false
        in max (somme l) (maxl2 l' (somme l))
      | _ -> assert false

      
(* TEST *)
(* retourne -1*)
let res = somme [-1; 3; -4; 2; -3; 4; -2; 3; -1]
(* Ceci doit retourner 5 *)

let res = maxl [-1; 3; -4; 2; -3; 4; -2; 3; -1]
(* END TEST *)
