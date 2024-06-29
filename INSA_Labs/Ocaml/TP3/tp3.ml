type coul = Coeur | Trefle | Pique | Carreau
type haut = Sept | Huit | Neuf | Dix | Valet | Dame | Roi | As
type carte = Carte of haut*coul

let coul c = match c with
  | Carte(_,coul)->coul
let haut c = match c with
  | Carte(haut,_)->haut

let haut_of_int i = match i with
  | 7 -> Sept
  | 8 -> Huit
  | 9 -> Neuf
  | 10 -> Dix
  | 11 -> Valet
  | 12 -> Dame
  | 13 -> Roi
  | 14 -> As
  | _ -> failwith "pas bonne valeur"


(* TEST *)
(* doit retourner Dame *)
let _ = haut_of_int 12
(* END TEST *)

let coul_of_string s = match s with
  | "Coeur" -> Coeur
  | "Trefle" -> Trefle
  | "Carreau"-> Carreau
  | "Pique" -> Pique
  | _ -> failwith "pas bonne couleur"

(* TEST *)
(* doit retourner Pique *)
let _ = coul_of_string "Pique"
(* END TEST *)

let carte i s = Carte(haut_of_int i,coul_of_string s)
(* TEST *)
(* ces tests doivent retourner true *)
let _ = (haut (carte 8 "Trefle")) = Huit
let _ = (coul (carte 14 "Trefle")) = Trefle
(* END TEST *)
let haut_to_string h = match h with
| Sept -> "7"
| Huit -> "8"
| Neuf -> "9"
| Dix -> "10"
| Valet -> "11"
| Dame -> "12"
| Roi -> "13"
| As -> "14"
| _ -> failwith "pas bonne valeur"

let coul_to_string s = match s with
  | Coeur -> "Coeur"
  | Trefle -> "Trefle"
  | Carreau-> "Carreau"
  | Pique -> "Pique"
  | _ -> failwith "pas bonne couleur"

let string_of_carte c = match c with
  | Carte(haut,coul)-> 
      haut_to_string haut ^ " de " ^ coul_to_string coul 

(* TEST *)
(* ceci doit retourner la cha�ne "Valet de Pique" *)
let res = string_of_carte (carte 11 "Pique")

(* ceci doit retourner la cha�ne "9 de Trefle" *)
let res = string_of_carte (carte 9 "Trefle")
(* END TEST *)

let coul_of_int s = match s with
  | 0 -> Coeur
  | 1 -> Trefle
  | 2-> Carreau
  | 3 -> Pique
  | _ -> failwith "pas bonne couleur"
let random_carte () = Carte(haut_of_int (7+Random.int 8),coul_of_int (Random.int 4))

let rec ajtcarte l = let c=random_carte() in
    if not(List.exists (fun x->x=c) l)
    then c::l
    else ajtcarte l  
      

(* TEST *)
(* ceci doit retourner true *)
let res =
  let l1 = ajtcarte [] in
  let l2 = ajtcarte l1 in
  match l1,l2 with
  | [c],[c1; c2] -> c = c2 && c1 <> c2
  | _ -> false
(* END TEST *)

let rec faitjeu n = 
  if n=0
  then []
  else
  ajtcarte (faitjeu (n-1))

let p_compare p1 p2 =
  match p1, p2 with
  |t_p1::q_p1, t_p2::q_p2 -> 
    (haut (List.hd p1) = haut (List.hd p2))||(coul (List.hd p1) = coul (List.hd p2))
  |_ -> false

(*TEST*)  
(*ceci doit retourner true*)
let p1 = [carte 14 "Trefle";  carte 10 "Coeur" ];;
let p3 = [carte 14 "Carreau"; carte 8 "Pique" ];;

let e = List.hd p1;;
let _ = haut (List.hd p1);;
let _ = p_compare p1 p3;;
(*END TEST*)  


let rec reduc l = failwith "à faire"

let p1 = [carte 14 "Trefle";  carte 10 "Coeur" ]
let p2 = [carte 7 "Pique";    carte 11 "Carreau" ]
let p3 = [carte 14 "Carreau"; carte 8 "Pique" ]
let p4 = [carte 7 "Carreau";  carte 10 "Trefle" ]

let p'1 = p2@p1

(* TEST *)
(* ceci doit retourner true *)
let _ = (reduc [p1; p2; p3; p4]) = [p'1; p3; p4]
(* END TEST *)

let rec reussite l = failwith "� faire"

let p''1 = p3@p'1
(* TEST *)
(* ceci doit retourner true *)
let res = (reussite [p1; p2; p3; p4]) = [p''1; p4]
(* END TEST *)

(* Copiez la ligne suivante (avec le #) dans le toplevel (fen�tre du bas) et
   tapez Entr�e
#load "graphics.cma";;
*)
open Graphics

let b = white
let n = black
let r = red

let carr   = [| [|b;b;b;b;b;r;b;b;b;b;b|];
                [|b;b;b;b;r;r;r;b;b;b;b|];
                [|b;b;b;r;r;r;r;r;b;b;b|];
                [|b;b;r;r;r;r;r;r;r;b;b|];
                [|b;r;r;r;r;r;r;r;r;r;b|];
                [|b;b;r;r;r;r;r;r;r;b;b|];
                [|b;b;b;r;r;r;r;r;b;b;b|];
                [|b;b;b;b;r;r;r;b;b;b;b|];
                [|b;b;b;b;b;r;b;b;b;b;b|] |]

let tref   = [| [|b;b;b;b;b;n;n;b;b;b;b|];
                [|b;b;b;b;n;n;n;n;b;b;b|];
                [|b;b;b;b;n;n;n;n;b;b;b|];
                [|b;b;n;n;b;n;n;b;n;n;b|];
                [|b;n;n;n;n;n;n;n;n;n;n|];
                [|b;n;n;n;n;n;n;n;n;n;n|];
                [|b;b;n;n;b;n;n;b;n;n;b|];
                [|b;b;b;b;b;n;n;b;b;b;b|];
                [|b;b;b;b;n;n;n;n;b;b;b|] |]

let coeu   = [| [|b;b;r;r;b;b;b;r;r;b;b|];
                [|b;r;r;r;r;b;r;r;r;r;b|];
                [|b;r;r;r;r;r;r;r;r;r;b|];
                [|b;r;r;r;r;r;r;r;r;r;b|];
                [|b;b;r;r;r;r;r;r;r;b;b|];
                [|b;b;b;r;r;r;r;r;b;b;b|];
                [|b;b;b;b;r;r;r;b;b;b;b|];
                [|b;b;b;b;b;r;b;b;b;b;b|];
                [|b;b;b;b;b;r;b;b;b;b;b|] |]


let piqu   = [| [|b;b;b;b;b;n;b;b;b;b;b|];
                [|b;b;b;b;b;n;b;b;b;b;b|];
                [|b;b;b;b;n;n;n;b;b;b;b|];
                [|b;b;n;n;n;n;n;n;n;b;b|];
                [|b;n;n;n;n;n;n;n;n;n;b|];
                [|b;n;n;n;n;n;n;n;n;n;b|];
                [|b;n;n;n;b;n;b;n;n;n;b|];
                [|b;b;b;b;b;n;b;b;b;b;b|];
                [|b;b;b;b;n;n;n;b;b;b;b|] |]

let draw_haut h = match h with
  | Sept -> draw_string " 7"
  | Huit -> draw_string " 8"
  | Neuf -> draw_string " 9"
  | Dix -> draw_string "10"
  | Valet -> draw_string " V"
  | Dame -> draw_string " D"
  | Roi -> draw_string " R"
  | As -> draw_string " A"

let draw_coul c l coul = match coul with
  | Carreau -> draw_image (make_image carr) c (l+2)
  | Trefle -> draw_image (make_image tref) c (l+2)
  | Coeur -> draw_image (make_image coeu) c (l+2)
  | Pique -> draw_image (make_image piqu) c (l+2)

let draw_carte ca =
  let (c,l) = current_point() in
  draw_haut (haut ca); draw_coul (c+12) l (coul ca); moveto c (l+14)

let draw_pile l = failwith "� faire"
(* TEST *)
let () = Graphics.open_graph ""
let _ = draw_pile p''1
let () = Graphics.close_graph ()
(* END TEST *)

let draw_jeu j = failwith "� faire"

let draw_reussite () = failwith "� faire"
(* TEST *)
let res = draw_reussite ()
(* END TEST *)
