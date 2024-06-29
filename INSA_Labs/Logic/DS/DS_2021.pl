%---------------------PARTIE I---------------------
% (+ -> defini), (- -> non defini) , (? -> def ou pas def)


valeur(a,1).
valeur(b,2).
valeur(c,3).
valeur(d,4).
valeur(e,5).
valeur(f,6).
valeur(g,7).
valeur(h,8).
valeur(i,9).
valeur(j,10).
valeur(k,11).
valeur(l,12).
valeur(m,13).
valeur(n,14).
valeur(o,15).
valeur(p,16).
valeur(q,17).
valeur(r,18).
valeur(s,19).
valeur(t,20).
valeur(u,21).
valeur(v,22).
valeur(w,23).
valeur(x,24).
valeur(y,25).
valeur(z,26).


%transcoder(+ListeLettres, -ListeNombres)
transcoder([],[]).
transcoder([X|L1],[Y|L2]):-
    valeur(X,Y),
    transcoder(L1,L2).

%racourcir(+ListeN1, -ListeN2).
racourcir([_],[]).
racourcir([X,Y|L],[Z|R]):-
    Z is (X+Y) mod 100,
    racourcir([Y|L],R).

%true_love(+Prénom1, +Prénom2, -Love)
calcul([R],R).
calcul(L,R):-
    racourcir(L,LR),
    calcul(LR,R).

true_love(Prenom1, Prenom2, Love):-
    transcoder(Prenom1,L1),
    transcoder(Prenom2,L2),
    append(L1,L2,L),
    calcul(L,Love).
    
%q4
%true_love([a,d,a,m],[A,B,C],L), L=>95.

%---------------------PARTIE II---------------------
%arb(+, arb(*, 3, arb(-, 12, 9)), 2)

%find(+Tree, +X)
find(X,X):-
    integer(X).
find(arb(V,G,_),X):-
    V \== X,
    find(G,X).
find(arb(V,_,D),X):-
    V \== X,
    find(D,X).


%evaluate(+Tree, -Res)
evaluate(X,X):-
    integer(X).
evaluate(arb(V,G,D),R):-
    evaluate(G,R1),
    evaluate(D,R2),
    eval_op(V,R1,R2,R).
eval_op(+,G,D,R):-
    R is G+D.
eval_op(-,G,D,R):-
    R is G-D.
eval_op(*,G,D,R):-
    R is G*D.
eval_op(/,G,D,R):-
    D \== 0,
    R is G//D.

%rpn(+A, -L)
rpn(X,[X]):-
    integer(X).
rpn(arb(V,G,D), L):-
    rpn(G,L1),
    rpn(D,L2),
    append(L1,L2,L3),
    append(L3,[V],L).

%assoc(+Id, +List, -Value)
assoc(Id,[[Id|Y]|L],Y).
assoc(Id,[[X|Y]|L],Value):-
    assoc(Id,L,Value).

%evaluate_id(+Tree, +Assoc, -Res)
evaluate_id(X,_,X):-
    integer(X).
evaluate_id(X,L,R):-
    atom(X),
    assoc(X,L,R).
evaluate_id(arb(V,G,D),L,R):-
    evaluate_id(G,L,X),
    evaluate_id(D,L,Y),
    eval_op(V,G,D,Res).

%---------------------PARTIE III---------------------

kes([], [], []).
kes([A|B], C, [A|D]) :-
    bof(B, C, D).
bof([], [X], []).
bof([X], [Y,Z], [Z]) :-
    !.
bof([X,Y|Z], [T,U|V], [U,Y|R]) :-
    bof(Z, V, R).

/*
renvoie L=[1,w,3,r]
le role de kex/3 est d'appeler bof(B,C,D) dans le cas ou on a 3 liste non vide en paramètre
sinon de renvoyé la lsite vide.
Lors de l'appel de bof(B,C,D), le premier elem de la premiere liste est recopié comme preier eleme de la liste resultat
*/
