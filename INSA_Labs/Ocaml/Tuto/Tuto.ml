let somme x y = x+y

let somme = fun x y -> x+y

let f = fun x y -> x mod y > y * 2 + 5;;
let f a = float_of_int a;;
let f g h x y z = (g (x,y) ) *. (h y z) ;;



let rec factorielle x =
  if x = 1 then 1
  else x * factorielle(x-1)



let facto x =
  let rec f x acc=
    if x=1 then acc
    else f (x-1)(acc*x)
  in f x 1

  (*BEGIN TEST*)

let _ = factorielle 4
let _ = facto 4

(*END TEST*)

let rec fibonnaci x = match x with
  |0->0
  |1->1
  |_->fibonnaci(x-1)+fibonnaci(x-2)

let rec fibonnaci2 x =
  if (x=0||x=1) then 
    if x=0 then 0
    else 1
  else fibonnaci2(x-1)+fibonnaci2(x-2)

let fibo x =
  let rec f x acc1 acc2 =
    if x=0 then acc2
    else f (x-1) acc2 (acc1+acc2)
  in f x 1 0

(*BEGIN TEST*)  

let _ = fibonnaci 4
let _ = fibonnaci 10
let _ = fibo 4
let _ = fibo 10
let _ = fibonnaci2 4
let _ = fibonnaci2 10

(*END TEST*)


let _ = 1::2::[3]

let p1 = [1; 2; 3];;
List.hd p1