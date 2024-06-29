:- lib(ic).
:- lib(ic_symbolic).
:- lib(branch_and_bound).

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
  Énoncé: On vous donne une liste d'entiers. On veut savoir si les éléments de la liste ne sont pas tous différents.
  Entrée: Une liste d'entiers non vide.
  Sortie: 0 si tous les entiers sont différents 1 sinon.

  Exemple:
  Entrée: [1, 1, 2, 3]
  Sortie: 1
*/
problem(problem1) :-
  read(stdin, L),
  ic:alldifferent(L) -> writeln(stdout, 0); writeln(stdout, 1).
    

/*
  Problème 2.
  Énoncé: On vous donne trois tableaux d'entiers V1, V2 et Weights de même taille N. On voudrait rendre le produit scalaire de V1 et V2 pondéré par Weights: V1[1] * V2[1] * Weights[1] + ... + V1[N] * V2[N] * Weights[N].
  Entrée: V1 puis V2 puis Weights.
  Sortie: V1[1] * V2[1] * Weights[1] + ... + V1[N] * V2[N] * Weights[N].

  Exemple:
  Entrée: [](1, 2, 3, 4)
          [](5, 5, 10, 20)
          [](0, 1, 2, 1)
  Sortie: 150
*/
problem(problem2) :-
  read(stdin, V1),
  read(stdin, V2),
  read(stdin, W),
  (
    fromto(0,In,Out,Res),
    foreacharg(X, V1), foreacharg(Y, V2), foreacharg(Z, W) do 
      Out #= In + X*Y*Z

  ),
  writeln(stdout, Res).
  


/*
  Problème 3.
  Énoncé: On vous donne une liste de listes de pairs, par exemple : [[(X, 1), (Y, 1)], [(X, 0)], [(Y, 0)]]. 
  Cette liste va représenter une forme normale conjonctive. Une variable associée à un 0 représente la négation d'une proposition, 
  une variable associée à un 1 représente une proposition. Une liste dans cette liste de listes représente une clause, 
  du coup les propositions à l'intérieur sont séparées par des OU et les clauses sont séparées par des ET. 
  La liste [[(X, 1), (Y, 1)], [(X, 0)], [(Y, 0)]] représente donc la forme normale conjonctive suivante : 
  (X OU Y) ET (not X) ET (not Y). Le but de ce problème est de rendre 1 si on peut satisfaire cette forme normale conjonctive et 0 sinon.
  Entrée: La forme normale conjonctive.
  Sortie: 1 si on peut satisfaire celle-ci et 0 sinon.

  Exemple:
  Entrée: [[(X, 1), (Y, 1)], [(X, 0)], [(Y, 0)]]
  Sortie: 0
*/
problem(problem3) :-
  fail.

/*
  Problème 4.
  Énoncé: On vous donne une liste d'entiers L positifs. On voudrait trouver la longueur de la sous-séquence croissante la plus grande. 
  Par exemple, pour la liste [3, 10, 4, 1, 5, 0, 8], la longueur de la plus grande sous-séquence croissante est 4, avec la sous-séquence [3, _, 4, _, 5, _, 8].
  Entrée: L.
  Sortie: La longueur de la sous-séquence croissante la plus grande.

  Exemple:
  Entrée: [3, 10, 4, 1, 5, 0, 8]
  Sortie: 4
*/
problem(problem4) :-
  fail.

/*
  Problème 5.
  Énoncé: On vous donne une liste de listes d'entiers, par exemple : [[1, 1, 2], [1, 2, 1, 1]] et un entier Max. 
  On va calculer une sorte de hash pour chaque liste d'entiers, et on voudrait qu'il n'y ait aucune collision (tous les hashs sont différents). 
  Voici notre façon (un peu singulière) de calculer un hash pour un nombre [X, Y, Z, T] et Max : ((((0 * P + X) * P) + Y) * P + Z) * P + T avec P dans [1..31] 
  (on va voir après comment choisir P) et avec la particularité suivante : si un des résultats intermédiaire dépasse Max, on le met à 0. 
  Ce qui veut dire que si (0 * P + X) >= Max, ce résultat devient 0 dans le calcul. De même pour ((_) * P) + Y et ainsi de suite. 
  Le but de ce problème est de trouver la plus grande puissance P qui permette de ne pas avoir de collisions avec notre façon de calculer les hashs. 
  Il existera toujours une puissance P qui permette de résoudre le problème.
  Pour [[1, 1, 2], [1, 2, 1, 1]] et Max = 5, le résultat est P = 31. En effet on obtient les deux hashs suivants : 2 et 0 qui sont bien différents.
  Entrée: Une liste de listes d'entiers.
  Sortie: La puissance la plus grande permettant de ne pas avoir de collisions.

  Exemple: 
  Entrée: [[1, 1, 2], [1, 2, 1, 1]]
          5
  Sortie: 31
*/
problem(problem5) :-
  fail.
  

/*
  Problème 6.
  Énoncé: On vous donne une grille contenant des 0 et des 1. Par exemple la grille :
              []([](0, 1, 0, 1, 1),
                 [](0, 0, 1, 1, 1), 
                 [](0, 1, 1, 0, 1),
                 [](0, 1, 1, 1, 1))
          On vous donne aussi un nombre Max qui est le nombre maximum de 0 qui peuvent se transformer en 1. Le but de ce problème est de trouver le nombre de cases dans la plus grande sous-grille qui se termine forcément dans le coin inférieur droit de la grille et qui ne contient que des 1. On peut transformer au maximum Max 0 en 1. 
          Si Max = 1, on obtient : 9. En effet, la sous-grille est :
              []([](0, 1, 0, 1, 1),
                 [](0, 0, #, #, #), 
                 [](0, 1, #, #, #),
                 [](0, 1, #, #, #))

          Il y aura toujours une solution avec un nombre de cases >= 1.

  Entrée: La grille et le nombre Max.
  Sortie: Le nombre de cases de la sous-grille (pas forcément un carré) de taille maximale qui se termine dans le coin inférieur droit.

  Exemple: 
  Entrée: []([](0, 1, 0, 1, 1),
             [](0, 0, 1, 1, 1), 
             [](0, 1, 1, 0, 1),
             [](0, 1, 1, 1, 1))
            1
          
  Sortie: 9
*/
problem(problem6) :-
  fail.
  

/*
  Problème 7.
  Énoncé: Dans un département d'enseignement il y a N cours à distribuer à N enseignants. 
  Chaque enseignant donne ses préférences sous forme d'un entier (plus l'entier est grand mieux c'est pour lui). 
  Le but est de trouver une bijection entre enseignants et cours qui maximise la somme des préférences. Par exemple pour la matrice de préférences suivante :
            [](
               [](3, 3, 1, 2),
               [](0, 4, -8, 3),
               [](0, 2, 3, 0),
               [](-1, 1, 2, -5)
            )
          On obtient 10 en choisissant :
            [](
               [](X, 3, 1, 2),
               [](0, 4, -8, X),
               [](0, X, 3, 0),
               [](-1, 1, X, -5)
            )

  Entrée: La matrice de préférences.
  Sortie: La plus grande somme de préférences que l'on puisse obtenir.

  Exemple:
  Entrée: [](
               [](3, 3, 1, 2),
               [](0, 4, -8, 3),
               [](0, 2, 3, 0),
               [](-1, 1, 2, -5)
            )
          
  Sortie: 10
*/
problem(problem7) :-
  fail.


