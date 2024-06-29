:- lib(ic).
:- lib(ic_symbolic).

:- local domain(machine(m1, m2)).

taches(
  [](tache(3, [], m1, _),
    tache(8, [], m1, _),
    tache(8, [4,5], m1, _),
    tache(6, [], m2, _),
    tache(3, [1], m2, _),
    tache(4, [1,7], m1, _),
    tache(8, [3,5], m1, _),
    tache(6, [4], m2, _),
    tache(6, [6,7], m2, _),
    tache(6, [9,12], m2, _),
    tache(3, [1], m2, _),
    tache(6, [7,8], m2, _))
).

tachesSimple(
  [](tache(3, [], m1, _),
    tache(8, [], m1, _),
    tache(8, [], m1, _),
    tache(6, [], m2, _))
).

solve(Taches, Fin):-
  taches(Taches),
  domaine(Taches,Fin),
  precedence(Taches),
  conflits(Taches),
  getVarList(Taches, Liste),
  labeling(Liste),
  labeling([Fin]),
  afficherTaches(Taches).

afficherTaches(Taches):-
  (
    foreachelem(tache(Duree, Noms, Machine, Debut), Taches) do
      write(Duree), write(" "), write(Noms), write(" "), write(Machine), write(" "), writeln(Debut)
  ).

domaine(Taches, Fin):-
  (
    foreachelem(tache(Duree, _Noms, Machine, Debut), Taches), param(Fin) do
      Debut #>= 0,
      Debut #=< Fin,
      Debut + Duree #=< Fin,
      Machine &:: machine
  ).

getVarList(Taches, Liste):-
  (
    fromto([],In,Out,Liste), foreachelem(tache(_Duree, _Noms, _Machine, Debut), Taches) do
      Out = [Debut|In]
  ).

precedence(Taches):-
  (
    foreachelem(tache(_Duree, Noms, _Machine, DebutT), Taches), param(Taches) do
      (
        foreach(TP, Noms), param(Taches, DebutT) do
          tache(Duree, _Noms, _Machine, DebutTP) is Taches[TP],
          DebutT #>= DebutTP + Duree 
      )
  ).


conflits(Taches):-
  dim(Taches, [N]),
  (
    for(I,1,N), param(Taches, N) do
      (
        for(J,1,N), param(Taches, I) do
          tache(Duree1, _Noms1, Machine1, Debut1) is Taches[I],
          tache(Duree2, _Noms2, Machine2, Debut2) is Taches[J],
          ((Machine1 &= Machine2) and (I#\=J)) => ((Debut2 #>= (Debut1 + Duree1)) or (Debut1 #>= (Debut2 + Duree2)))
      )
  ).
  