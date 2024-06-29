let rec split v l = 
  match l with
  |[]-> ([],[])
  |t::q->let (l1, l2) = split v q in
    if t>v then (l1, t::l2) else (t::l1, l2)


(* TEST *)
(* doit retourner [-12; 1; 3], [12; 27; 7; 8; 6; 12; 42] *)
let res1,res2 = split 4 [12; 27; -12; 7; 8; 1; 3; 6; 12; 42]
(* END TEST *)

let rec qs l = 
  match l with
  |[]->[]
  |t::q->
    let (l1,l2) = split t q in
    (qs l1)@(t::qs l2)

(* TEST *)
(* doit retourner [-12; 1; 3; 4; 6; 7; 8; 12; 12; 27; 42] *)
let res = qs [4; 12; 27; -12; 7; 8; 1; 3; 6; 12; 42]
(* END TEST *)

let rec kieme k l = failwith "à faire"

(* TEST *)
(* doit retourner 8 *)
let res = kieme 7 [4; 12; 27; -12; 7; 8; 1; 3; 6; 12; 42]
(* END TEST *)

let rec jqastable x f = 
  if (f x = x) then x else jqastable (f x) f 

(* TEST *)
(* doit retourner 1 *)
let res = jqastable 13 (fun x -> if (x = 1) then 1 else if (x mod 2 = 1) then 3 * x + 1 else x / 2)

(* END TEST *)

let rec unebulle l = 
  match l with
  |[]->l
  |[_]->l
  |t1::t2::q->
    if (t1<t2) then t1::(unebulle(t2::q)) else t2::(unebulle(t1::q)) 

(* TEST *)
(* doit retourner [4; 12; -12; 7; 8; 1; 3; 6; 27; 12; 42] *)
let res = unebulle [4; 12; 27; -12; 7; 8; 1; 3; 6; 42; 12]
(* END TEST *)

let tribulle l = jqastable l unebulle


(* TEST *)
(* doit retourner [-12; 1; 3; 4; 6; 7; 8; 12; 12; 27; 42] *)
let res = tribulle [4; 12; 27; -12; 7; 8; 1; 3; 6; 12; 42]
(* END TEST *)

let rec merge ll = 
  match ll with 
  |[]->[]
  |t::q->t@(merge q)

(* TEST *)
(* doit retourner [1;2;3;5] *)
let res = merge [[1];[2;3];[5]]
(* END TEST *)

let rec create f k = 
  if(k < 1) then [] else tribulle((f k)::(create f (k-1)))

(* TEST *)
(* doit retourner [2; 3; 4; 5] *)
let res = create (fun x -> x+1) 4
(* END TEST *)

let rec insert j ll =
  match ll with
  |[]->[]
  |t::q-> (j::t)::(insert j q)

(* TEST *)
(* doit retourner [[1;3;5];[1;7;3;9];[1];[1;6]]*)
let res = insert 1 [[3;5];[7;3;9];[];[6]]
(* END TEST *)

let partition n = failwith "� faire"

(* TEST *)
(* doit retourner une liste contenant [5], [4;1], [3;2], [3;1;1], [2;2;1],
   [2;1;1;1], [1;1;1;1;1] dans un ordre arbitraire *)
let res = partition 5
(* END TEST *)
