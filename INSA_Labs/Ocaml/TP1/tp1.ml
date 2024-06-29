(* TP1. Le Bizec Léandre. *)

(* Compléter, en enlevant le "failwith" et tout ce qui suit et en mettant votre code.
   Évaluer en sélectionnant puis shift-enter *)
let mul2 n = 2*n  

(* Tester, en tapant shift-enter et en sélectionnant la phrase suivante *)
(* La valeur attendue est indiquée en commentaire *)
(* TEST *)
let _ = mul2 21 (* 42 *)
(* END TEST *)

(* Compléter *)
let vabs n = if (n>0) then n else -n

(* TEST *)
let _ = vabs (-5) (* 5 *)
let _ = vabs 12 (* 12 *)
(* END TEST *)

(* Compléter *)
let test1 n = if (n>= 12 && n<=29) then true else false

(* TEST *)
let _ = test1 25 (* true *)
let _ = test1 (-8) (* false *)
(* END TEST *)

(* Compléter *)
let test2 n = if ( n=2 || n=5 || n=9 || n=53) then true else false

(* TEST *)
let _ = test2 5 (* true *)
let _ = test2 6 (* false *)
(* END TEST *)

(* Compléter *)
let test3 p = match p with
   |(12,_) -> true
   |_ -> false

(* TEST *)
let _ = test3 (12,"foo") (* true *)
let _ = test3 (12,42) (* true *)
let _ = test3 (13,true) (* false *)
(* END TEST *)

(* Compléter *)
let bissext y = if (y mod 400 = 0 ) then true else if ( y mod 100 = 0) then false else if ( y mod 4 = 0) then true else false

(* TEST *)
let _ = bissext 2000 (* true *)
let _ = bissext 1900 (* false *)
let _ = bissext 2016 (* true *)
let _ = bissext 2017 (* false *)
(* END TEST *)

(* Compléter *)
let proj1 t = match t with
   | (x,_,_) -> x
let proj23 t = match t with
   | (_,y,z) -> y,z

(* TEST *)
let _ = proj1 (1,"foo",true) (* 1 *)
let _ = proj23 (1,"foo",true) (* ("foo",true) *)
(* END TEST *)

(* Compléter *)
let inv2 arg = match arg with
   | (_,_),(x,y)->(y,x)

(* TEST *)
let _ = inv2 ((true,'a'),(1,"un")) (* ("un",1) *)
(* END TEST *)

(* Compléter *)
let incrpaire p = match p with
   | (g,d) -> (g+1, d+1)

(* TEST *)
let _ = incrpaire (12,42) (* (13,43) *)
(* END TEST *)

(* Compléter *)
let appliquepaire f p = match p with
   | (a,b) -> (f a, f b )

(* TEST *)
let _ = appliquepaire (fun x -> not x) (false,true) (* (true,false) *)
(* END TEST *)

(* Compléter *)
let incrpaire2 = fun p -> failwith "à faire"

(* TEST *)
let _ = incrpaire2 (4,18) (* (5,19) *)
(* END TEST *)

(* Compléter *)
let rapport (f,g) x = failwith "à faire"

(* TEST *)
let _ = rapport ((fun x -> x +. 1.), (fun x -> x -. 1.)) 2. (* 3. *)
(* END TEST *)

(* Compléter *)
let mytan x = failwith "à faire"

(* TEST *)
let _ = mytan 0. (* 0. *)
(* END TEST *)

(* Compléter *)
let premier n = failwith "optionnel"

(* TEST *)
let _ = premier 1 (* false *)
let _ = premier 2 (* true *)
let _ = premier 6 (* false *)
let _ = premier 13 (* true *)
(* END TEST *)

(* Compléter *)
let n_premier n = failwith "optionnel"

(* TEST *)
let _ = n_premier 10 (* 29 *)
(* END TEST *)
