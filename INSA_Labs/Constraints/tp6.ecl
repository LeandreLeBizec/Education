:-lib(ic).
:-lib(branch_and_bound).

solve(T):-
  getData(NbPersonnes, Positions, NbPlacesBalancoire, Poids, Noms),
  defineVars(T, NbPersonnes),
  contraintes(T, NbPersonnes, Poids, Noms, Moment),
  getVarList(T, Liste),
  C #= Moment,
  %minimize(labeling(Liste),C),
  minimize(customSearch(Liste),C),
  write("Moment : "), writeln(Moment).

getData(NbPersonnes, Positions, NbPlacesBalancoire, Poids, Noms):-
  NbPersonnes = 10,
  Positions = [-8,-7,-6,-5,-4,-3,-2,-1,1,2,3,4,5,6,7,8],
  length(Positions, NbPlacesBalancoire),
  Poids = [24,39,85,60,165,6,32,123,7,14],
  Noms = [ron, zoe, jim, lou, luc, dan, ted, tom, max, kim].

defineVars(T, NbPersonnes):-
  dim(T, [NbPersonnes]),
  T #:: [(-8)..(-1),1..8].

getVarList(T, Liste):-
  (
    fromto([],In,Out,Liste), 
    foreacharg(X, T) do
      Out = [X|In]
  ).

unePlace(T):-
  ic:alldifferent(T).

balancoireEquilibre(T, NbPersonnes, Poids, Moment):-
  (
    fromto(0,In,Out,Res),
    fromto(0,InM,OutM,Moment),
    for(I,1,NbPersonnes), param(T, Poids) do 
      Distance is T[I],
      element(I, Poids, P),
      Out #= In + Distance*P,
      OutM #= InM + abs(Distance)*P
  ),
  Res #= 0.

moitmoit(T, NbPersonnes):-
  Moit is NbPersonnes div 2,
  (
    fromto(0,In,Out,Res),
    foreacharg(Personne, T) do
      Out #= In + (Personne #< 0)
  ),
  Res #= Moit.

positionParentsPlusJeunes(T, Noms):-
  ic:min(T,Min),
  ic:max(T,Max),
  (
    foreacharg(Personne, T), foreach(N, Noms), param(Min, Max) do
      N=lou -> (Personne#=Min /*or Personne#=Max*/);
      N=tom -> (/*Personne#=Min or*/ Personne#=Max);
      N=dan -> (Personne#=Min+1 or Personne#=Max-1);
      N=max -> (Personne#=Min+1 or Personne#=Max-1);
      true
  ).


contraintes(T, NbPersonnes, Poids, Noms, Moment):-
  unePlace(T),
  balancoireEquilibre(T, NbPersonnes, Poids, Moment),
  moitmoit(T, NbPersonnes),
  positionParentsPlusJeunes(T, Noms).

customSearch(Liste):-
  version1(Liste).
	%version2(Liste).
	%version3(Liste).

version1(Liste):-
	search(Liste, 0, occurrence, indomain, complete, []).

version2(Liste):-
	search(Liste, 0, input_order, indomain_middle, complete, []).

version3(Liste):-
	search(Liste, 0, occurrence, indomain_middle, complete, []).

/*
V0 - avec symétrie
Moment : 1604

T = [](3, -1, 2, 6, 1, -4, -3, -5, 5, -2)
Yes (0.44s cpu)
*/

/*
6.3) Pour une solution donnée, si on prends l'opposé de chaque valeur on obtient la solution symétrique
Pour l'eliminer on peut fixer la position des parents à Max et à Min
*/

/*
Le labeling parcourt l'ensemble des solutions possibles jusqu'à trouver une solution valide ou jusqu'à ce qu'il n'y ait plus de solutions possibles.

Cependant, cette technique de labeling original n'est pas toujours efficace car elle peut nécessiter beaucoup de temps pour trouver une solution valide, 
surtout si l'espace de recherche est grand. De plus, la stratégie de recherche n'est pas toujours optimale, ce qui peut entraîner une recherche inefficace.
*/

/*
V0 - sans symétrie
Moment : 1604

T = [](-3, 1, -2, -6, -1, 4, 3, 5, -5, 2)
Yes (0.27s cpu)
*/

/*
V1
Moment : 1604

T = [](-3, 1, -2, -6, -1, 4, 3, 5, -5, 2)
Yes (0.22s cpu)
*/

/*
V2
Moment : 1604

T = [](-3, 1, -2, -6, -1, 4, 3, 5, -5, 2)
Yes (0.20s cpu)
*/

/*
V3
Moment : 1604

T = [](-3, 1, -2, -6, -1, 4, 3, 5, -5, 2)
Yes (0.14s cpu)
*/