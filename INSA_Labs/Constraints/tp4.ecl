:- lib(ic).

solve(T):-
   getData(TailleEquipes, NbEquipes, CapaBateaux, NbBateaux, NbConf),
   defineVars(T, NbEquipes, NbConf, NbBateaux),
   pasMemeBateaux(T, NbEquipes, NbConf),
   pasMemePartenaires(T, NbEquipes, NbConf),
   capaBateaux(T, TailleEquipes, NbEquipes, CapaBateaux, NbBateaux, NbConf),
   %getVarList(T, L),
   getVarListAlt(T, L),
   writeln(L),
   labeling(L).

getData(TailleEquipes, NbEquipes, CapaBateaux, NbBateaux, NbConf):-
   %TailleEquipes = [5,5,2,1],
   TailleEquipes = [7,6,5,5,5,4,4,4,4,4,4,4,4,3,3,2,2,2,2,2,2,2,2,2,2,2,2,2,2],
   length(TailleEquipes, NbEquipes),
   %CapaBateaux = [7,6,5],
   CapaBateaux = [10,10,9,8,8,8,8,8,8,7,6,4,4],
   length(CapaBateaux, NbBateaux),
   NbConf = 3.

defineVars(T, NbEquipes, NbConf, NbBateaux):-
   dim(T, [NbEquipes, NbConf]),
   T #:: 1..NbBateaux.


getVarList(T, Liste):-
   dim(T, [Row, Column]),
   (
    fromto([],In,Out,Liste), 
    for(I,1,Column), param(T,Row) do
      X is T[1..Row,I],
      collection_to_list(X,Y),
      Out = [Y|In]
   ). 
   
getVarListAlt(T, L):-
    dim(T, [NbEquipes, NbConf]),
    (multifor([ConfI, EqI], [1, 1], [NbConf, NbEquipes//2 + 1]),
        param(T,NbEquipes),
        fromto([],In, Out,L)
      do
        X is T[EqI,ConfI],
        OppositeIndex is NbEquipes - EqI + 1,
        Y is T[OppositeIndex,ConfI],
        append(In, [X,Y], Out)
).
   
pasMemeBateaux(T, NbEquipes, NbConf):-
   (
    for(I,1,NbEquipes), param(T, NbConf) do
      X is T[I, 1..NbConf],
      collection_to_list(X,Y),
      ic:alldifferent(Y)
   ). 


pasMemePartenaires(T, NbEquipes, NbConf) :-
	(multifor([Ei, Ej, Ci, Cj], [1, 1, 1, 1], [NbEquipes, NbEquipes, NbConf, NbConf]),
	   param([T])
	   do
		(
	    	LigneEq1 is T[Ei],
	    	LigneEq2 is T[Ej],
	        ((Ei #\= Ej) and (Ci #\= Cj) and (LigneEq1[Ci] #= LigneEq2[Ci])) => (LigneEq1[Cj] #\= LigneEq2[Cj])
		)
	).

%accéder au nième element de la liste
nth_list(Liste, N, Elt):-
	nth_list_aux(Liste, N, 1, Elt),
	!.
nth_list_aux([X|_Reste], N, N, X).
nth_list_aux([_X|Reste], N, I, Elt):-
	I < N,
	I1 is I+1,
	nth_list_aux(Reste, N, I1, Elt).

capaBateaux(T, TailleEquipes, NbEquipes, CapaBateaux, NbBateaux, NbConf):-
   (
      for(I,1,NbConf), param(T, NbEquipes, TailleEquipes, CapaBateaux) do
         Conf is T[1..NbEquipes, I],
         (
            for(K,1,NbEquipes), param(NbEquipes, TailleEquipes, CapaBateaux, Conf) do
               Eq1 is Conf[K],
               nth_list(TailleEquipes, K, EqTaille1),
               (
                  for(L,1,NbEquipes), param(CapaBateaux, TailleEquipes, Conf, K, Eq1, EqTaille1) do
                     Eq2 is Conf[L],
                     nth_list(TailleEquipes, L, EqTaille2),
                     element(Eq2, CapaBateaux, CapaBat),
                     ((K #\= L) and (Eq1 #= Eq2)) => (EqTaille1 + EqTaille2 #=< CapaBat)
               )  
         )
   ).