:- lib(ic).
:- lib(ic_symbolic).
:- lib(branch_and_bound).
%:- lib(eplex_cplex).

/*
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::-'    `-::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::-'  IL FAUT  ::::::::::::::::
:::::::::::::::::::::::::::::::::::::::-  '  UTILISER   `::::::::::::::
:::::::::::::::::::::::::::::::::::-'      minimize_quiet :::::::::::::
::::::::::::::::::::::::::::::::-         .  AU LIEU DE  ::::::::::::::
::::::::::::::::::::::::::::-'             .  minimize  :::::::::::::::
:::::::::::::::::::::::::-'                 `-.        ::::::::::::::::
:::::::::::::::::::::-'                  _,,-::::::::::::::::::::::::::
::::::::::::::::::-'                _,--:::::::::::::::::::::::::::::::
::::::::::::::-'               _.--::::::::::::::::::::::#####:::::::::
:::::::::::-'             _.--:::::::::::::::::::::::::::#####:::::####
::::::::'    ##     ###.-::::::###:::::::::::::::::::::::#####:::::####
::::-'       ###_.::######:::::###::::::::::::::#####:##########:::####
:'         .:###::########:::::###::::::::::::::#####:##########:::####
     ...--:::###::########:::::###:::::######:::#####:##########:::####
 _.--:::##:::###:#########:::::###:::::######:::#####:#################
'#########:::###:#########::#########::######:::#####:#################
:#########:::#############::#########::######:::#######################
##########:::########################::################################
##########:::##########################################################
##########:::##########################################################
#######################################################################
#######################################################################
################################################################# dp ##
#######################################################################
*/
minimize_quiet(P, Cost) :-
    branch_and_bound:bb_min(P, Cost, bb_options{report_success:true/0, report_failure:true/0}).

symbolic_labeling(Vars) :-
	collection_to_list(Vars, List),
	( foreach(Var, List) do
	  ic_symbolic:indomain(Var)
	).

main :-
    (read(stdin, Problem),
     problem(Problem)) -> exit(0); exit(1).

/*
  Problème 1.
  Énoncé: On vous donne une liste d'entiers. On veut savoir si les éléments de la liste sont tous différents.
  Entrée: Une liste d'entiers non vide.
  Sortie: 1 si tous les entiers sont différents 0 sinon.

  Exemple:
  Entrée: [1, 1, 2, 3]
  Sortie: 0
*/
problem(problem1) :-
  read(stdin, L),
  ic:alldifferent(L) -> writeln(stdout, 1); writeln(stdout, 0).

/*
  Problème 2.
  Énoncé: On vous donne une grille comme la suivante :
    
    G = []([](0, _, 10), 
           [](_, _, _), 
           [](10, _, 20))

  On voudrait compléter cette grille afin que pour toutes cases (I, J), on ait G[I, J] + G[I + 1, J + 1] = G[I, J + 1] + G[I + 1, J] lorsqu'on ne sort pas de la matrice. 
  Par exemple, on peut résoudre G ainsi :

        []([](0,  0,  10), 
           [](0,  0,  10), 
           [](10, 10, 20))

  Entrée: La grille G.
  Sortie: 1 si on peut compléter la grille et 0 sinon.

  Exemple:
  Entrée: []([](0, _, 10), 
             [](_, _, _), 
             [](10, _, 20)).
  Sortie: 1
*/
problem(problem2) :-
  read(stdin, T),
  dim(T, [Lignes, Cols]),
  T #:: 0..100,
  (
    for(I,1,Lignes-1), param(T, Cols) do
      (
        for(J,1,Cols-1), param(T, I) do
          Valij is T[I,J],
          Vali1j1 is T[I+1,J+1],
          Vali1j is T[I+1,J],
          Valij1 is T[I,J+1],
          Valij + Vali1j1 #= Valij1 + Vali1j
      )
  ),
  labeling(T) -> writeln(stdout, 1); writeln(stdout, 0).


/*
  Problème 3.
  Énoncé: On vous donne un tableau d'entiers positifs. On voudrait scinder ce tableau en deux parties tel que la somme de la première partie soit égale au produit
  de la seconde et de plus on voudrait que ce nombre soit le plus grand possible.
  Entrée: Le tableau de nombres.
  Sortie: La valeur recherchée la plus grande ou 0 si on ne peut scinder en deux le tableau en vérifiant la condition recherchée.

  Exemple:
  Entrée: [](2, 2, 3, 5, 5, 7, 11).
  Sortie: 25
*/
problem(problem3) :-
  fail.

/*
  Problème 4.
  Énoncé: On nous donne un nombre N en base 10 et on voudrait trouver le prochain multiple de ce nombre, 
  toujours en base 10, qui ne s'écrive qu'avec les digits 0, 1, 2 et 3. On supposera que le nombre recherché ne dépasse pas 100 digits.
  Entrée: Le nombre N.
  Sortie: Le nombre recherché.

  Exemple:
  Entrée: 12.
  Sortie: 120
*/
problem(problem4) :-
  fail.

/*
  Problème 5.
  Énoncé: On dispose d'une balançoire et de plusieurs personnes. Les personnes ne peuvent s'assoir qu'à certains emplacements sur cette balançoire. 
  On voudrait calculer la différence minimale entre les moments des deux côtés de la balançoire (si la balançoire est équilibrée, cette valeur vaut 0).

  Entrée: Une liste L de places disponibles, le côté gauche est indiqué par des nombres négatifs et le côté droit par des nombres positifs. 
  Par exemple la liste : [-1, -3, -5, -8, 2, 4, 5, 6, 8] indique qu'il y a 4 emplacements à gauche et 5 à droite. 
  Ensuite un tableau représentant le poids de chacun des individus, par exemples : [](55, 75, 82, 110).
  Sortie: La différence minimale entre les moments (positifs) des deux côtés de la balançoire.

  Exemple:
  Entrée: [-1, -2, 1, 2].
          [](1, 10, 20, 30).
  Sortie: 8
*/
problem(problem5) :-  
  fail.
/*
solve(T):-
  read(stdin,L)
  getData(NbPersonnes, Positions, NbPlacesBalancoire, Poids, Noms),
  defineVars(T, NbPersonnes, Positions),
  contraintes(T, NbPersonnes, Poids, Noms, Moment),
  getVarList(T, Liste),
  C #= Moment,
  minimize(labeling(Liste),C),
  write("Moment : "), writeln(stdout, C).

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
*/




/*
  Problème 6.
  Énoncé: On nous donne un graphe non orienté et on voudrait déterminer le nombre minimum de sommets qui permet de couvrir toutes les arrêtes. 
  Par exemple, soit la liste d'arrêtes suivantes :
    [(1,3), (3,2)]
  Le sommet 3 permet de couvrir les 2 arrêtes. Il nous faut donc un sommet pour couvrir toutes les arrêtes de ce graphe.

  Entrée: La nombre de sommet N. Les sommets vont de 1 à N. Ensuite la liste des arrêtes. 
  Aucune arrête n'est dupliquée. Par exemple on ne pourrait pas avoir dans la liste les arrêtes (1,3) et (3,1).
  Sortie: Le nombre minimum de sommets pour couvrir toutes les arrêtes.

  Exemple:
  Entrée: 3.
          [(1,3), (3,2)].
  Sortie: 1
*/
problem(problem6) :-
  fail.

/*
  Problème 7.
  Énoncé: Ce problème s'inspire du jeu sumplete. On vous donne une grille comme la suivante :
    
    Grille : 
      []([](7, 2, 3, 6, 1),
         [](1, 5, 1, 6, 3),
         [](5, 4, 8, 7, 3),
         [](1, 2, 5, 4, 3),
         [](5, 7, 8, 9, 8))

  et deux tableaux :
    1) SommeDesLignes   : [](11, 1, 18, 3, 7)
    2) SommeDesColonnes : [](7, 7, 12, 7, 7)

  Vous pouvez ignorer des éléments dans la Grille afin que la somme de la ligne I soit égale à SommeDesLignes[I] et que la somme de la colonne J soit égale à SommeDesColonnes[J]. Par exemple, on peut résoudre le problème actuel en ignorant les nombres suivants :

      []([](7, x, 3, x, 1),
         [](x, x, 1, x, x),
         [](x, x, 8, 7, 3),
         [](x, x, x, x, 3),
         [](x, 7, x, x, x))

  Entrée: La grille, les deux tableaux.
  Sortie: 1 si on peut résoudre le problème et 0 sinon.

  Exemple:
  Entrée: []([](7, 2, 3, 6, 1),
             [](1, 5, 1, 6, 3),
             [](5, 4, 8, 7, 3),
             [](1, 2, 5, 4, 3),
             [](5, 7, 8, 9, 8)).
          [](11, 1, 18, 3, 7).
          [](7, 7, 12, 7, 7).
  Sortie: 1
*/
problem(problem7) :-
  fail.
