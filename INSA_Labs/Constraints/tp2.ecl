:- lib(ic).
:- lib(ic_symbolic).

%Q1
:- local domain(pays(angleterre, espagne, ukraine, norvege, japon)).
:- local domain(couleur(rouge, vert, blanc, jaune, bleu)).
:- local domain(boisson(cafe, the, lait, jusOrange, eau)).
:- local domain(voiture(bmw, ford, toyota, honda, datsun)).
:- local domain(animal(chien, serpent, renard, cheval, zebre)).

%Q2
domaine_maison(m(Pays, Couleur, Boisson, Voiture, Animal, Numero)):-
  Pays &::pays,
  Couleur &::couleur,
  Boisson &::boisson,
  Voiture &::voiture,
  Animal &::animal,
  Numero #:: 1..5.

%Q3
rue(Rue):-
  (for(I,1,5),
  foreach(Maison,Rue) do
    domaine_maison(Maison),
    Maison = m(_,_,_,_,_,N),
    N #= I   
  ).

%Q4
ecrit_maison(Rue):-
  (
    foreach(m(Pays, Couleur, Boisson, Voiture, Animal, Numero), Rue) do 
      writeln(" "),
      writeln(" /\\ "),
      writeln("/  \\"),
      writeln("|  |"),
      writeln("|  |"),
      writeln(" --"),
      write("n°"), writeln(Numero),
      writeln(Pays), 
      writeln(Couleur), 
      writeln(Boisson), 
      writeln(Voiture), 
      writeln(Animal)
  ).

%Q5
getVarList(Rue, Liste):-
  (
    fromto([],In,Out,Liste), foreach(Maison,Rue) do
      Maison = m(Pays,Couleur,Animal,Boisson,Voiture,_),
      Out = [Pays,Couleur,Animal,Boisson,Voiture|In]
  ).

labeling_symbolic([]).
labeling_symbolic([Var|Liste]):-
  ic_symbolic:indomain(Var),
  labeling_symbolic(Liste).

%Q6
resoudre(Rue):-
  rue(Rue),
  constrain_rue(Rue),
  getVarList(Rue, Liste),
  labeling_symbolic(Liste),
  ecrit_maison(Rue).

%Q7
alldiff([ m(P1, C1, B1, V1, A1, 1),
	  m(P2, C2, B2, V2, A2, 2),
	  m(P3, C3, B3, V3, A3, 3),
	  m(P4, C4, B4, V4, A4, 4),
	  m(P5, C5, B5, V5, A5, 5)]):-
	ic_symbolic:alldifferent([P1, P2, P3, P4, P5]),
	ic_symbolic:alldifferent([C1, C2, C3, C4, C5]),
	ic_symbolic:alldifferent([B1, B2, B3, B4, B5]),
	ic_symbolic:alldifferent([V1, V2, V3, V4, V5]),
	ic_symbolic:alldifferent([A1, A2, A3, A4, A5]).


constrain1(Rue):-
	(foreach(m(Pays, Couleur, Boisson, Voiture, Animal, Numero), Rue)
	do
		/*** a ***/
		(Pays &= angleterre) #= (Couleur &= rouge),
		/*** b ***/
		(Pays &= espagne) #= (Animal &= chien),
		/*** c ***/
		(Couleur &= vert) #= (Boisson &= cafe),
		/*** d ***/
		(Pays &= ukraine) #= (Boisson &= the),
		/*** f ***/
		(Voiture &= bmw) #= (Animal &= serpent),
		/*** g ***/
		(Couleur &= jaune) #= (Voiture &= toyota),
		/*** h ***/
		(Boisson &= lait) #= (Numero #= 3),
		/*** i ***/
		(Pays &= norvege) #= (Numero #= 1),
		/*** l ***/
		(Voiture &= honda) #= (Boisson &= jusOrange),
		/*** m ***/
		(Pays &= japon) #= (Voiture &= datsun)
	).

constrain2(Rue):-
  (
  foreach(m(_Pays2, Couleur2, _Boisson2, _Voiture2, Animal2, Numero2), Rue),
  param(Rue)
  do
      (
      foreach(m(Pays1, Couleur1, _Boisson1, Voiture1, _Animal1,  Numero1), Rue), /*on est obligé de faire une double boucle pour récupérer plusieurs maison pour les comparer entre elles*/
      param(Couleur2, Animal2, Numero2)
      do
      /*** e ***/
      (Couleur2 &= vert) and (Couleur1 &= blanc) => (Numero2 #= Numero1 + 1),
      /*** j ***/
      ((Voiture1 &= ford) and (Animal2 &= renard)) => ((Numero2 #= Numero1 + 1) or (Numero2 #= Numero1 - 1)),
      /*** k ***/
      ((Voiture1 &= toyota) and (Animal2 &= cheval)) => ((Numero2 #= Numero1 + 1) or (Numero2 #= Numero1 - 1)),
      /*** n ***/
      ((Pays1 &= norvege) and (Couleur2 &= bleu)) => ((Numero2 #= Numero1 + 1) or (Numero2 #= Numero1 - 1))
    )
  ).

constrain_rue(Rue):-
  alldiff(Rue),
  constrain1(Rue),
  constrain2(Rue).

/*
 /\ 
/  \
|  |
|  |
 --
n°1
norvege
jaune
eau
toyota
renard

 /\ 
/  \
|  |
|  |
 --
n°5
japon
vert
cafe
datsun
zebre
*/