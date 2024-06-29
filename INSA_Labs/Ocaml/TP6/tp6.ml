(* remplacer par votre type *)
type 'a arbin = 
   |Noeud of 'a * 'a arbin * 'a arbin
   |Feuille of 'a 

let feuille v = Feuille v
let noeud v g d = Noeud (v,g,d)

let rec compter a =
   match a with
   |Feuille v -> 1
   |Noeud (v,g,d) -> compter g + compter d

(* TEST *)
(* ceci doit retourner 3 *)
let arbre_test = noeud 12 (feuille 5) (noeud 7 (feuille 6) (feuille 8))
let _ = compter arbre_test
(* END TEST *)

let rec to_list a = 
   match a with 
   |Feuille v -> [v]
   |Noeud (v,g,d) -> (to_list g)@[v]@(to_list d)

(* TEST *)
(* ceci doit retourner [5; 12; 6; 7; 8] *)
let _ = to_list arbre_test
(* END TEST *)

let rec ajt a s =
   match a with
   |Feuille _ -> Noeud (s,feuille "Nil",feuille "Nil")
   |Noeud (v,g,d) -> 
      if s = v 
         then a 
      else 
         if s < v 
            then Noeud (v, ajt g s,d) 
         else Noeud(v,g,ajt d s) 

let rec constr l = 
   match l with 
   |[]->Feuille "Nil"
   |t::[]->Noeud(t, Feuille"Nil",Feuille"Nil")
   |t::q -> ajt (constr q) t

let l = ["celeri";"orge";"mais";"ble";"tomate"; "soja"; "poisson"]
(* TEST *)
(* Ceci doit retourner true *)
let _ = List.filter (fun s -> s <> "Nil") (to_list (constr l)) = List.sort compare l
(* END TEST *)

type coord = int * int
type 'a arbinp = (coord * 'a) arbin
let d = 5
let e = 4

let rec placer a = 
   let rec placer_faible a x y = 
     match a with
     |Feuille v -> (Feuille((x, y), v), (x+e))
     |Noeud (v, g, dr)-> 
       let (a_g, newx) = placer_faible g x (y+d) 
         in let (a_d, x_foll) = placer_faible dr (newx+e) (y+d) 
           in (Noeud(((newx, y),v), a_g, a_d), x_foll) 
             in fst(placer_faible a e d)

let t =
  noeud 'a'
    (feuille 'j')
    (noeud 'b'
       (noeud 'c'
          (noeud 'd' (feuille 'w') (feuille 'k'))
          (feuille 'z'))
       (feuille 'y'))

(* Pour tester *)
let res = placer t

(* TEST *)
(* Ceci doit retourner true *)
let res = (placer t = noeud ((8, 5), 'a')
     (feuille ((4, 10), 'j'))
     (noeud ((32, 10), 'b')
        (noeud ((24, 15), 'c')
           (noeud ((16, 20), 'd') (feuille ((12, 25), 'w')) (feuille ((20, 25), 'k')))
           (feuille ((28, 20), 'z')))
        (feuille ((36, 15), 'y'))))
(* END TEST *)
