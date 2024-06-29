:- lib(ic).

%Exo1
couleurBateau(vert(_)).
couleurBateau(vert(claire)).
couleurBateau(vert(fonce)).
couleurBateau(noir).
couleurBateau(blanc).

couleurVoiture(rouge(_)).
couleurVoiture(rouge(claire)).
couleurVoiture(rouge(fonce)).
couleurVoiture(vert(_)).
couleurVoiture(vert(claire)).
couleurVoiture(vert(fonce)).
couleurVoiture(gris).
couleurVoiture(blanc).

couleurExistante(CouleurBateau, CouleurVoiture) :-
  couleurBateau(CouleurBateau),
  couleurVoiture(CouleurVoiture).

choixCouleur(CouleurBateau, CouleurVoiture) :-
  couleurExistante(CouleurBateau, CouleurVoiture),
  CouleurBateau = CouleurVoiture.
%choixCouleur(vert(claire), vert(_)). -> Yes

isBetween(Min, Min, _).
isBetween(Var, Min, Max) :-
  MinPlus is Min+1,
  MinPlus =< Max,
  isBetween(Var, MinPlus, Max).

commande(NbResistance, NbCondensateur) :-
  isBetween(NbResistance, 5000, 10000),
  isBetween(NbCondensateur, 9000, 20000),
  NbCondensateur =< NbResistance.
%Si on place le =< en 1er, NbResistance et NbCondensateur ne serait pas unifier donc il y aurait une erreure

commande2(NbResistance, NbCondensateur) :-
  NbResistance #:: 5000..10000,
  NbCondensateur #:: 9000..20000,
  NbCondensateur #=< NbResistance,
  labeling([NbResistance, NbCondensateur]).
%Marche super bien


%Exo2
chapie(Chats, Pies, Pattes, Tetes) :-
  data(MaxChats, MaxPies),
  constraints_chapie(Chats, Pies, Pattes, Tetes, MaxChats, MaxPies),
  labeling([Chats, Pies, Pattes, Tetes]).

data(100, 100).

constraints_chapie(Chats, Pies, Pattes, Tetes, MaxChats, MaxPies):-
  Chats #:: 0..MaxChats,
  Pies #:: 0..MaxPies,
  Chats + Pies #= Tetes,
  4*Chats + 2*Pies #= Pattes.

/*
Q1.9
chapie(2, Pies, Pattes, 5).

Pies = 3
Pattes = 14
Yes (0.00s cpu)
*/

/*
Q1.10
3*Tetes #= Pattes, chapie(Chat, Pies, Pattes, Tetes).

Tetes = 0
Pattes = 0
Chat = 0
Pies = 0
Yes (0.00s cpu, solution 1, maybe more) ? ;

...

Tetes = 20
Pattes = 60
Chat = 10
Pies = 10
Yes (0.01s cpu, solution 11)
*/

%Exo3
vabs_prolog(Val, Val):-
  number(Val),
  Val >= 0.
vabs_prolog(Val, AbsVal) :-
  number(Val),
  Val < 0,
  AbsVal is -Val.

vabs(Val, AbsVal) :-
  AbsVal #> 0,
  AbsVal #= Val or AbsVal #= -Val,
  labeling([Val, AbsVal]). 

/*
X #:: -10..10, vabs(X,Y).

X = -10
Y = 10
Yes (0.00s cpu, solution 1, maybe more) ? ;

...

X = 10
Y = 10
Yes (0.01s cpu, solution 20) maybe more) ? ;
*/

%Q1.12) Marche pas avec vabs_prolog (number() ?), marche bien avec vabs de ic

faitListe(ListVar, Taille, Min, Max):-
  length(ListVar, Taille),
  ListVar #:: Min..Max.

suite([]).
suite([X1]).
suite([X1, X2]).
suite([X, X1, X2 | Reste]) :-
  vabs(X1, Abs),
  X2 #= Abs - X,
  suite([X1, X2 | Reste]).

%accéder au nième element de la liste
nth_list(Liste, N, Elt):-
	nth_list_aux(Liste, N, 0, Elt),
	!.
nth_list_aux([X|_Reste], N, N, X).
nth_list_aux([_X|Reste], N, I, Elt):-
	I < N,
	I1 is I+1,
	nth_list_aux(Reste, N, I1, Elt).

%vérifier la périodicté 9
periodic(List) :-
  length(List, Length),
  Length mod 9 =:= 0,
  nth_list(List, 0, Elt0), 
  nth_list(List, 9, Elt9), 
  Elt9 is Elt0, 
  nth_list(List, 1, Elt1), 
  nth_list(List, 10, Elt10), 
  Elt10 is Elt1.

/* 
periodic([1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9]).
Yes (0.00s cpu)

faitListe(Liste, 18, -10, 10), suite(Liste), periodic(Liste).

Liste = [4, -6, 2, 8, 6, -2, -4, 6, 10, 4, -6, 2, 8, 6, -2, -4, 6, 10]
Yes (0.00s cpu, solution 1, maybe more) ? ;

Liste = [3, -6, 3, 9, 6, -3, -3, 6, 9, 3, -6, 3, 9, 6, -3, -3, 6, 9]
Yes (0.00s cpu, solution 2, maybe more) ? ;

...
 */