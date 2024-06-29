%----------------------------EXO1--------------------------------

%oter_n_prem(+N,+L,-R) créer R la liste L à laquelle on ote les N premiers éléments
oter_n_prem(0,_,[]).
oter_n_prem(N,[T|L],[T|R]):-
    M is N-1,
    oter_n_prem(M,L,R).


%pas_dans(+L1,+L2,-R) créer R la liste des éléments de L2 qui ne sont pas dans L1
pas_dans(L1,[],[]).
pas_dans(L1,[T|L2],R):-
    member(T,L1),
    pas_dans(L1,L2,R).
pas_dans(L1,[T|L2],[T|R]):-
    not member(T,L1),
    pas_dans(L1,L2,R).

    
%maxi(+L,-R) créer R le max de la liste L
maxi([M],M).
maxi([T1,T2|L], R):-
    T1>=T2,
    maxi([T1|L], R).
maxi([T1,T2|L], R):-
    T1<T2,
    maxi([T2|L], R).

%ajout_deb(+X,+L,-R) créer R la liste L avec X au début
renvListe(L,R):-
    renvListe(L,[],R).
renvListe([T|L1],L2,R):-
    renvListe(L1,[T|L2],R).
renvListe([],L2,L2).

ajout_deb(X,L,[X|RL]):-
    renvListe(L,RL).

%----------------------------EXO2--------------------------------

joueur(01,dupont,tom,10/1,fcrennes,0610).
joueur(02,foucher,martin,30/1,poitiers,0620).
joueur(03,dilaire,maxime,40/1,rennes,0710).

arbitre(a1,hubert,thomas,0810).
arbitre(a2,clorant,xavier,0910).

match(m1,lundi,20,t11,01,02,a1).
match(m2,mardi,21,t22,01,03,a1).
match(m1,lundi,22,t12,01,03,a1).

victoire(m1,01).
victoire(m2,03).
victoire(m3,03).

terrain(t11,s1,1).
terrain(t12,s1,2).
terrain(t21,s2,1).
terrain(t22,s2,2).


%arbitre_ok(-N,-P)
arbitre_ok(N,P):-
    match(Code_m,Mardi,_,C2,_,_,Code_a),
    victoire(Code_m,Num_lic),
    joueur(Num_lic,_,_,_, TCRennes,_),
    arbitre(Code_a, N, P,_).

%deux_terrains(-A)
deux_terrains(A):-
    match(_,_,_,C1,_,_,A),
    match(_,_,_,C2,_,_,A),
    C1 \== C2.

%prog_lundi(-C)
prog_lundi(prog(H,C)):-
    match(_,Lundi,H,C,_,_,_).

%tout_perdu(-N,-P)
tout_perdu(N,P):-
    joueur(L,N,P,_,_,_),
    not(victoire(_,L)).

%tous_les_jours(-A)
pas_tous_les_jours(A):-
    arbitre(A,_,_,_),
    not(match(_,J,_,_,_,_,A)).
tous_les_jours(A):-
    match(_,J,_,_,_,_,A),
    not(pas_tous_les_jours(A)).


%----------------------------EXO3--------------------------------


inconnu(X) :-
    pas_mieux(X,Y),
%2) !,
    non_plus(Y).
inconnu(X) :-
    non_plus(X).
pas_mieux(a,b).
%3) !.
pas_mieux(a,c).
non_plus(b).
%4) !.
non_plus(a).


/*
renvoie 
1) T=a T=b T=a 
2) T=a
3) T=a T=b T=a
4) T=a T=b
*/