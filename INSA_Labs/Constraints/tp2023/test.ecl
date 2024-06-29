:- lib(ic).
:- lib(ic_symbolic).
:- lib(branch_and_bound).

/*
problem(Moment):-
  Positions = [-1, -2, 1, 2],
  length(Positions, NbPlacesBalancoire),
  Poids = [](1, 10, 20, 30),
  dim(Poids, [NbPersonnes]),
  (
    fromto(0,InM,OutM,Moment),
    for(I,1,NbPersonnes), param(Poids,Positions) do 
      ic:element(I, Poids, P),
      ic:element(I, Positions, D),
      OutM #= InM + D*P
  ).
*/


solve(T):-
  getData(NbPersonnes, Positions, NbPlacesBalancoire, Poids, Noms),
  defineVars(T, NbPersonnes, Positions),
  contraintes(T, NbPersonnes, Poids, Noms, Moment),
  getVarList(T, Liste),
  C #= Moment,
  minimize(labeling(Liste),C),
  write("Moment : "), writeln(C).

getData(NbPersonnes, Positions, NbPlacesBalancoire, Poids, Noms):-
  Positions = [-1, -2, 1, 2],
  length(Positions, NbPlacesBalancoire),
  Poids = [](1, 10, 20, 30),
  dim(Poids, [NbPersonnes]).

defineVars(T, NbPersonnes, Positions):-
  dim(T, [NbPersonnes]),
  ic:min(Positions, Min),
  ic:max(Positions, Max),
  T #:: [Min..(-1),1..Max].

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
      ic:element(I, Poids, P),
      Out #= In + Distance*P,
      OutM #= InM + abs(Distance)*P
  ).

contraintes(T, NbPersonnes, Poids, Noms, Moment):-
  unePlace(T),
  balancoireEquilibre(T, NbPersonnes, Poids, Moment).

