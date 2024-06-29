:- lib(ic).
:- lib(ic_symbolic).

:- local domain(sexe(homme, femme)).

solve(Parent1, Parent2, Enfant):-
  getData(Affirmations, NbAffirmations), 
  defineVars(Parent1, Parent2, Enfant, Affirmations),
  affirmations(Parent1, Parent2, Enfant, Affirmations, NbAffirmations),
  labeling_symbolic([Parent1, Parent2, Enfant]).

labeling_symbolic([]).
labeling_symbolic([Var|Liste]):-
  ic_symbolic:indomain(Var),
  labeling_symbolic(Liste).

getData(Affirmations, NbAffirmations):-
  Affirmations = [AffE, AddEselonP1, AffP1, Aff1P2, Aff2P2],
  length(Affirmations, NbAffirmations).

defineVars(Parent1, Parent2, Enfant, Affirmations):-
  Parent1 &:: sexe,
  Parent2 &:: sexe,
  Enfant &:: sexe,
  (
    foreacharg(A, Affirmations) do
      A #:: 0..1
  ).

/* foreacharg : chaque element du tableau */
/* foreacelem : chaque element du tableau en profondeur */

/* -> : pour comparer des constante et  obligé de else */
/* => : pour explication et sans else et #= à droite */
affirme(S, A):-
  S &= femme => A #= 1.
affirme(S, A1, A2):-
  S &= homme => ((A1 #= 1 and A2 #= 0) or (A1 #= 0 and A2 #= 1)).

affirmations(Parent1, Parent2, Enfant, Affirmations, NbAffirmations):-
  ic_symbolic:alldifferent([Parent1, Parent2]),
  Affirmations = [AffE, AddEselonP1, AffP1, Aff1P2, Aff2P2],
  affirme(Enfant, AffE),
  affirme(Parent1, AffP1),
  affirme(Parent2, Aff1P2),
  affirme(Parent2, Aff2P2),
  affirme(Parent2, Aff1P2, Aff2P2),
  AffP1 #= 1 => Enfant &= femme,
  Aff1P2 #= 1 => Enfant &= homme,
  Aff1P2 #= 0 => Enfant &= femme,
  Aff2P2 #=1 => AffE #= 0,
  Aff2P2 #=0 => AffE #= 1.