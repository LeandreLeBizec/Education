let rec split v l = 
  match l with
  | [] -> ([],[])
  | e::l0-> 
    let (left , right) = split v l0 in
    if e>v 
      then (left , e::right)
  else (e::left , right)

(* TEST *)
(* doit retourner [-12; 1; 3], [12; 27; 7; 8; 6; 12; 42] *)
let res1,res2 = split 4 [12; 27; -12; 7; 8; 1; 3; 6; 12; 42]
(* END TEST *)

let rec qs l = 
  match l with
  | [] -> []
  | e::l0 ->
    let (l1,l2) = split e l0 in 
    (qs l1)@(e::(qs l2))




(* TEST *)
(* doit retourner [-12; 1; 3; 4; 6; 7; 8; 12; 12; 27; 42] *)
let res = qs [4; 12; 27; -12; 7; 8; 1; 3; 6; 12; 42]
(* END TEST *)

let rec kieme k l = 
  match l with
  |[] -> failwith "jsp"
  |e::l0 -> 
    let (l1,l2) = split e l0 in
    if (List.length l1 = (k-1))
      then e
    else
      if (k-1 < List.length l1)
        then kieme k l1
      else kieme (k- 1 -(List.length l1)) l2
  
let rec kieme2 k l = 
  match l with
  | e::l0 ->
    let (l1,l2) = split e l0 in
    if ( List.length l1 = k-1 )
      then e
    else
      if ( List.length l1 > k-1)
      then kieme2 k l1
      else kieme2 (k -1- List.length l1) l2
  | _-> assert false


(* TEST *)
(* doit retourner 8 *)
let res = kieme 7 [4; 12; 27; -12; 7; 8; 1; 3; 6; 12; 42]
let res = kieme2 7 [4; 12; 27; -12; 7; 8; 1; 3; 6; 12; 42]
(* END TEST *)

let rec jqastable x f = 
  if ( (f x ) = x )
    then x
else jqastable (f x) f
(* TEST *)
(* doit retourner 1 *)
let res = jqastable 13 (fun x -> if (x = 1) then 1 else if (x mod 2 = 1) then 3 * x + 1 else x / 2)
(* END TEST *)

let rec unebulle l =
  match l with
  | [] -> []
  | e::[] -> l
  | e1::e2::l0 -> 
      if e1 < e2
        then e1::(unebulle (e2::l0)) 
    else e2::(unebulle (e1::l0))

(* TEST *)
(* doit retourner [4; 12; -12; 7; 8; 1; 3; 6; 27; 12; 42] *)
let res = unebulle [4; 12; 27; -12; 7; 8; 1; 3; 6; 42; 12]
(* END TEST *)

let tribulle l = jqastable l (unebulle) 

(* TEST *)
(* doit retourner [-12; 1; 3; 4; 6; 7; 8; 12; 12; 27; 42] *)
let res = tribulle [4; 12; 27; -12; 7; 8; 1; 3; 6; 12; 42]
(* END TEST *)


let rec merge l = 
  match l with
  | [] -> []
  | l1::l2 -> l1@(merge l2)
    
(* TEST *)
(* doit retourner [1;2;3;5] *)
let res = merge [[1];[2;3];[5]]
(* END TEST *)

let rec create f k = 
  if(k < 1 )
  then []
  else (f k)::(create f (k-1))

(* TEST *)
(* doit retourner [2; 3; 4; 5] *)
let res = create (fun x -> x+1) 4
(* END TEST *)

let rec insert j ll = 
  match ll with 
  |[]->[]
  |l1::l2 -> (j::l1)::(insert j l2)

(* TEST *)
(* doit retourner [[1;3;5];[1;7;3;9];[1];[1;6]]*)
let res = insert 1 [[3;5];[7;3;9];[];[6]]
(* END TEST *)

let partition n = 
  let rec partition2 m k =
    match (m,k) with
    | (0,0) -> [[]]
    | (_,0) -> []
    | (a,b) -> 
      if (b>a)
      then partition2 a a
      else merge (create (fun x -> insert x (partition2 (a-x) x)) b)
  in partition2 n n



(* TEST *)
(* doit retourner une liste contenant [5], [4;1], [3;2], [3;1;1], [2;2;1],
   [2;1;1;1], [1;1;1;1;1] dans un ordre arbitraire *)
let res = partition 5
(* END TEST *)
