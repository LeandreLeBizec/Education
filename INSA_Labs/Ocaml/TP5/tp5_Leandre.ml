let rec longueur l = 
  match l with 
  |[]->0
  |t::q->1+longueur q


(* TEST *)
(* Ceci doit retourner 3 *)
let res = longueur [1;2;3]
(* END TEST *)

let rec appartient e l = 
  match l with
  |[]->false
  |t::q->if (t=e) then true else (appartient e q)


(* TEST *)
(* Ceci doit retourner false *)
let res = appartient 4 [1;2;3]
(* END TEST *)

let rec rang e l = 
  match l with
  |[]->0
  |t::q->if (t=e) then 1 else 
    if (rang e q = 0 ) then 0 else (rang e q) +1



(* TEST *)
(* Ceci doit retourner 2 *)
let res = rang 2 [3;2;1]
(* END TEST *)

type 'a option = None | Some of 'a
let rec rang_opt e l = 
  match l with
  |[]-> None
  |t::q->if (t=e) then Some 1 else 
    match rang_opt e q with
    |Some i-> Some(i+1)
    |None->None


(* TEST *)
(* Ceci doit retourner Some 2 *)
let res = rang_opt 2 [3;2;1]
(* Ceci doit retourner None *)
let res = rang_opt 0 [3;2;1]
(* END TEST *)

let rec concatl l1 l2 = 
  match l1,l2 with
  |[],_->l2
  |t1::q1,_->t1::(concatl q1 l2)

(*
let rec concatl l1 l2 = match l1 with
  |t::q->t::concatl q l2
  |[]->l2
*)

(* TEST *)
(* Ceci doit retourner [1;2;3;4;5;6] *)
let res = concatl [1;2;3] [4;5;6]
(* END TEST *)

let rec debliste l n = 
  match l,n with
  |[],_->[]
  |t::q,1->t::[]
  |t::q,_->t::debliste q (n-1)


(* TEST *)
(* Ceci doit retourner [1; 2; 3] *)
let res = debliste [1;2;3;4;5;6;7] 3
(* END TEST *)

let rec finliste l n = 
  match l with
  |[]->[]
  |t::q->if (n >= longueur l) then l else finliste q n

(* TEST *)
(* Ceci doit retourner [5; 6; 7] *)
let res = finliste [1;2;3;4;5;6;7] 10
(* END TEST *)

let rec remplace x y l = 
  match l with 
  |[]->[]
  |t::q->if(t=x) then y::remplace x y q else t::remplace x y q

(* TEST *)
(* Ceci doit retourner [1; 42; 3; 42; 5] *)
let res = remplace 2 42 [1;2;3;2;5]
(* END TEST *)

let rec entete l l1 = 
    match l,l1 with
    |_,[]->false
    |[],_->true
    |tl::ql,tl1::ql1->if (tl=tl1) then entete ql ql1 else false


(* TEST *)
(* Ceci doit retourner true *)
let res = entete [1;2;3;] [1;2;3;2;5]
(* END TEST *)

let rec sousliste l l1 = 
  if (longueur l)>(longueur l1) then false else 
    match l1 with
    |[]->false
    |t::q->if entete l l1 then true else sousliste l q

(* TEST *)
(* Ceci doit retourner true *)
let res = sousliste [2;3;2] [1;2;3;2;5]
(* END TEST *)

let oter l l1 = 
  if not(entete l l1) then l1 else finliste l1 (longueur l1 - longueur l)


(* TEST *)
 (* Ceci doit retourner [2; 5] *)
 let res = oter [1;2;3] [1;2;3;2;5]
(* END TEST *)

let rec remplacel l1 l2 l =
  if not(sousliste l1 l) then l else
    match l with 
    |[]->[]
    |t::q->
      if entete l1 l 
        then concatl l2 (remplacel l1 l2 (finliste l (longueur l - longueur l1)))
      else t::(remplacel l1 l2 q)


(* TEST *)
(* Ceci doit retourner [4; 5; 6; 2; 5; 6; 2; 1; 3; 8] *)
let res = remplacel [1;2;1] [5;6] [4;1;2;1;2;1;2;1;2;1;3;8]
(* END TEST *)

let rec supprimel l1 l = 
  if l1 = [] then l else
      match l with
      | [] -> []
      | t::q -> 
        if entete l1 l
          then (supprimel l1 (finliste l (longueur l - longueur l1)))
        else t::(supprimel l1 q)

(* TEST *)
(* Ceci doit retourner [4; 2; 1; 3; 8] *)
let res = supprimel [1;2;1] [4;1;2;1;2;1;3;8]

(* Ceci doit retourner [1; 2; 3] *)
let res = supprimel [] [1;2;3]
(* END TEST *)
