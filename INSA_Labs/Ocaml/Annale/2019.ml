(*Examen 2019*)
(*Exo 1*)

type linexpr = {cst:int;coeffs:(int*string) list}

(* ex : 2 + 7x + 9y *)
let e = { cst=2; coeffs=[(7,"x");(9,"y")]}

(*Q1*)


let eval_lin f le = 
  let rec eval_coeffs f l=
    match l with 
    |[]->0
    |t::q-> match t with
      |(entier,variable)->entier*f variable + eval_coeffs f q
  in le.cst + eval_coeffs f le.coeffs

(*Solution plus courtes et plus claire :*)
let eval_lin f le = 
  let rec eval_coeffs f l=
    match l with 
    |[]->0
    |(entier, variable)::q-> entier*f variable + eval_coeffs f q
  in le.cst + eval_coeffs f le.coeffs


(* TEST *)
let _ = eval_lin ( fun v -> if v = "x" then 1 else 2) e;;


(*Q2*)
  let checkC1 le = 
    let rec checkCoeffs l = match l with
      |[] -> true
      (*|t::q -> if (fst t)=0 then false else checkCoeffs q*)
      |t::q -> match t with
        |(entier, variable)-> if entier=0 then false else checkCoeffs q
    in checkCoeffs le.coeffs

(* TEST *)
let bad1 = {cst =2; coeffs = [(7,"x");(9,"y");(0,"z")]};;
let _ = checkC1 bad1
let _ = checkC1 e

(*Q3*)
let checkC2 le = 
  let rec checkCoeffs l = match l with
    |[] -> true
    |t::[]->true
    |t1::t2::q -> if (snd t1) > (snd t2) then false else checkCoeffs (t2::q)
  in checkCoeffs le.coeffs

(* TEST *)
let bad2 = {cst =2; coeffs = [(9,"y");(7,"x")]};;
let _ = checkC2 bad2
let _ = checkC2 e


let rec exist l x=
  match l with
  |[]->false 
  |t::q-> if (snd t)=x then true else exist q x

(* TEST *)
let bad3 = {cst =2; coeffs = [(4,"y");(7,"x");(5,"y")]};;
let _ = exist bad3.coeffs "y"


(*Q4*)
let checkC3 le = 
  let rec checkCoeffs l = match l with
    |[]-> true
    |t::q -> if (exist q (snd t)) then false else checkCoeffs q
  in checkCoeffs le.coeffs

(* TEST *)
let _ = checkC3 bad3
let _ = checkC3 e

(* Q5 *)
let checklin le=
  if (checkC1 le=true && checkC2 le=true && checkC3 le=true) then true else false

  (* TEST *)
let _ = checklin e
let _ = checklin bad1
let _ = checklin bad2
let _ = checklin bad3


(* Q6 *)
let constante c = { cst=c; coeffs=[]}
(* TEST *)
let _ = constante 2

(* Q6 *)
let constante c = { cst=c; coeffs=[]}
(* TEST *)
let _ = constante 2

(* Q7 *)
let variable ci xi = { cst=0; coeffs=[ci,xi]}
(* TEST *)
let _ = variable 2 "x"

(* Q8 *)

let mul i le = 
  let rec mulcoeffs i l = 
    match l with
    |[] ->  []
    |t::q -> match t with 
      |(entier,variable) -> (entier*i,variable)::(mulcoeffs i q)
  in {cst=i*le.cst; coeffs=(mulcoeffs i le.coeffs)}

(*Solution plus courtes et plus claire :*)
let mul i le = 
  let rec mulcoeffs i l = 
    match l with
    |[] ->  []
    |(entier,variable)::q -> (entier*i,variable)::(mulcoeffs i q)
  in {cst=i*le.cst; coeffs=(mulcoeffs i le.coeffs)}

(*en utilisant fst*)
let mul i le = 
  let rec mulcoeffs i l = 
    match l with
    |[] ->  []
    |t::q -> ((fst t)*i,snd t)::(mulcoeffs i q)
  in {cst=i*le.cst; coeffs=(mulcoeffs i le.coeffs)}


(* TEST *)
let e2 = mul 2 e;;
checklin e2;;

(* Q9*)

let rec addcoeffs (i,v) l = match l with
  |[] -> [(i,v)]
  |t::q -> if ((v) < (snd t)) then (i,v)::t::q else t::(addcoeffs (i,v) q)   

let rec addceoffsexi (i,v) l = match l with
  |[] -> [(i,v)]
  |t::q -> if (v = snd t) then (fst t+i,snd t)::q else addceoffsexi (i,v) q

let add (i,v) le = 
  if (exist le.coeffs v) 
    then addceoffsexi (i,v) le.coeffs
  else addcoeffs (i,v) le.coeffs

 
(* TEST *)
let e = { cst=2; coeffs=[(7,"x");(9,"y")]}
let _ = add (5,"z") e

(*Q10*)

let rec coeff0 l = match l with
  |[]->[]
  |t::q -> if (fst t)=0 then coeff0 q else t::(coeff0 q)


let rec coeffexist l = match l with
  |[]->[]
  |t::q -> if (exist q (snd t)) then coeffexist q else t::coeffexist q


let rec coefftrie l = match l with
  |[]->[]
  |t::[] -> [t] 
  |t1::t2::q -> if (snd t1)>(snd t2) then t2::coefftrie(t1::q) else t1::coefftrie(t2::q)

(*let rec normalise le = coefftrie(coeffexist(coefftrie le.coeffs))*)
(*let rec normalise le = {cst=le.cst; coeffs=coefftrie(coeffexist(coeff0 le.coeffs))}*)

let rec normalise le = {cst=le.cst; coeffs = coefftrie(coeffexist (coeff0 le.coeffs)) }

(* TEST *)
let bad = { cst=1; coeffs=[(0,"x");(9,"y");(5,"x")]};;
let e = { cst=2; coeffs=[(7,"x");(9,"y")]}
let _ = normalise e;;
let _ = normalise bad;;

(*-------------------------------------------------------------------------------------------------*)
(*Exo 2*)

type 'a expr =
  | Cst of 'a
  | Var of string
  | Add of 'a expr * 'a expr
  | Mul of 'a expr * 'a expr

let e = Add(Add(Cst 2,Mul(Cst 7, Var "x")),Mul(Cst 9, Var "y"))
(* e=(2+7x)+9y *)

type 'a anneau = 
  {
    addition : 'a -> 'a -> 'a;
    multiplication : 'a -> 'a -> 'a;
    zero : 'a;
    one : 'a;
    equal : 'a -> 'a -> bool
  }

  (*Q11*)
let int_anneau = 
  {
    addition = ( + ) ;
    multiplication = ( * );
    zero = 0;
    one = 1;
    equal = ( = );
  }

  (*Q12*)
let rec eval_expr an f e = match e with
  |Cst(c) -> c
  |Var(v) -> f v 
  |Add(e1,e2) -> an.addition (eval_expr an f e1) (eval_expr an f e2)
  |Mul(e1,e2) -> an.multiplication (eval_expr an f e1) (eval_expr an f e2)

(* TEST *)

let _ = eval_expr int_anneau ( fun v -> if v = "x" then 1 else 2) e;;


(*Q13*)
let rec equal_expr e1 e2 = match (e1,e2) with
  |Cst(c1),Cst(c2) -> c1 = c2
  |Var(v1),Var(v2) -> v1 = v2
  |Add(e11,e12),Add(e21,e22) -> (equal_expr e11 e21) && (equal_expr e12 e22)
  |Mul(e11,e12),Mul(e21,e22) -> (equal_expr e11 e21) && (equal_expr e12 e22)
  |(_,_) -> false

(* TEST *)
let _ = equal_expr e e

(* Q14 *)

let rec simpl_expr e =
  match e with
  | Cst(c) -> Cst(c)
  | Var(v) -> Var(v) 
  (* Add *)
  |Add(Cst(0),a)->a
  |Add(a, Cst(0))->a
  |Add(Var(x),Var(y))->if x=y then Mul(Cst(2),Var(x)) else Add(Var(x),Var(y))
  |Add(e1,e2)-> Add(simpl_expr e1, simpl_expr e2)
  (* Mul *)
  |Mul(Cst(0),_)-> Cst(0)
  |Mul(_,Cst(0))-> Cst(0)
  |Mul (Cst(1), Var(x))-> Var(x)
  |Mul (Var(x),Cst(1))-> Var(x)
  |Mul(e1,e2)-> Mul(simpl_expr e1, simpl_expr e2) 

(* TEST *)
let s0x = Add(Cst(0),Var("x"))
let _ = simpl_expr s0x
let sx0 = Add(Var("x"),Cst(0))
let _ = simpl_expr sx0
let sxx = Add(Var("x"),Var("x"))
let _ = simpl_expr sxx
let m1x = Mul(Cst(1),Var("x"))
let _ = simpl_expr m1x
let mx1 = Mul(Var("x"),Cst(1))
let _ = simpl_expr mx1
let m0x = Mul(Cst(0),Var("x"))
let _ = simpl_expr m0x
let mx0 = Mul(Var("x"),Cst(0))
let _ = simpl_expr mx0

let bastien = Mul(Mul(Var("x"),Cst(0)), Add(Var("x"),Cst(0)))
let _ = simpl_expr bastien

(* Q15 *)
let expr_of_linexpr le =
  let rec exp_coeff l = match l with
    | [] -> Cst(0)
    | e :: l1 -> Add(Mul(Cst(fst e),Var(snd e)), exp_coeff l1)
  in simpl_expr(Add(Cst(le.cst),exp_coeff le.coeffs))
(* TEST *)
let linexp = {cst = 34 ; coeffs = [(2,"x");(3,"y")]}
let expexp = expr_of_linexpr linexp

let rec linexpr_of_expr e = match e with 
| Cst(c) -> {cst = c ; coeffs = []}
| Var(v) -> {cst = 0 ; coeffs = [(1,v)]}
| Add(e1,e2) -> let a = linexpr_of_expr e1 in let b = linexpr_of_expr e2
                in normalise {cst = a.cst + b.cst ; coeffs = a.coeffs @ b.coeffs}
| Mul(e1,e2) ->
  begin
    match (e1,e2) with
    | (Cst(c),Var(v)) | (Var(v),Cst(c)) -> {cst = 0 ; coeffs = [(c,v)]}
    | (_,_) -> failwith "Erreur : l'expression n'est pas linéaire"
  end
(* TEST *)
let _ = linexpr_of_expr expexp