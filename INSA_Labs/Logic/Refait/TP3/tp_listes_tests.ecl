/*
TP Listes Prolog

@author Prenom1 NOM1
@author Prenom2 NOM2
@version Annee scolaire 20__/20__
*/

% Tests

tests :-
    test( test_membre ),
    test( test_compte ),
    test( test_renverser ),
    test( test_palind ),
    test( test_enieme ),
    test( test_hors_de ),    
    test( test_tous_diff ),
    test( test_conc3 ),
    test( test_debute_par ),
    test( test_sous_liste ),
    test( test_elim ),
    test( test_tri ),
    test( test_enieme2 ),
    test( test_eniemefinal ),
    test( test_conc3final ),
    test( test_comptefinal ),
    true.

test_membre :-
    assert_true( membre(a, [a,b,c]) ),                                  % membre(+A,+X) : vérification présence
    assert_true( not(membre(0, [1,2,3])) ),                             % membre(+A,+X) : vérification absence
    assert_true( sortall(A, membre(A,[2,1,3,1]), [1,1,2,3]) ).          % membre(-A,+X) : production des solutions X

test_compte :-
    assert_true( compte(a, [a,c,a,b,a,c,b], 3) ),                       % compte(+A,+X,+N) : vérification compte
    assert_true( findall(N, compte(b, [a,c,a,b,a,c,b], N), [2]) ).      % compte(+A,+X,-N) : production de la solution N

test_comptefinal :-
    assert_true( comptefinal(a, [a,c,a,b,a,c,b], 3) ),                       % compte(+A,+X,+N) : vérification compte
    assert_true( sortall(A, comptefinal(A, [a,c,a,b,a,c,b], 2), [b,c]) ),    % compte(-A,+X,+N) : production des solutions A
    assert_true( sortall([A,N], comptefinal(A,[b,c,a,b,a,a],N), [[a,3],[b,2],[c,1]]) ). % compte(-A,+X,-N) production A et N

test_renverser :-
    assert_true( renverser([a,b,c], [c,b,a]) ),                         % renverser(+,+)
    assert_true( findall(Y, renverser([1,2,2,4], Y), [[4,2,2,1]]) ).    % renverser(+,-)

test_palind :-
    assert_true( palind([a,b,b,a]) ),
    assert_true( not(palind([b,a,b,a])) ).

test_enieme :-
    assert_true( enieme(1,[a,b,a],a) ),
    assert_true( enieme(3,[a,b,a],a) ),
    assert_true( findall(A, enieme(2,[a,b,c],A), [b]) ).
    
test_enieme2 :-
    assert_true( enieme2(1,[a,b,a],a) ),
    assert_true( enieme2(3,[a,b,a],a) ),
    assert_true( sortall(N, enieme2(N,[p,a,p,a],a), [2,4]) ).

test_eniemefinal :- % Cumule les tests des 2 versions précédentes
    assert_true( eniemefinal(1,[a,b,a],a) ),
    assert_true( eniemefinal(3,[a,b,a],a) ),
    assert_true( findall(A, eniemefinal(2,[a,b,c],A), [b]) ),
    assert_true( eniemefinal(1,[a,b,a],a) ),
    assert_true( eniemefinal(3,[a,b,a],a) ),
    assert_true( sortall(N, eniemefinal(N,[p,a,p,a],a), [2,4]) ).

test_hors_de :-
    assert_true( hors_de(z, [a,b,c]) ),
    assert_true( not(hors_de(b, [a,b,c])) ).

test_tous_diff :-
    assert_true( tous_diff([1,2,3,4,5,9,7]) ),
    assert_true( not(tous_diff([1,3,4,5,3])) ).

test_conc3 :-
    assert_true( conc3([1,2,3,4],[5,6],[7,8,9,10], [1,2,3,4,5,6,7,8,9,10]) ),
    assert_true( findall(T, conc3([1,2,3,4],[5,6],[7,8,9,10],T), [[1,2,3,4,5,6,7,8,9,10]]) ).

test_conc3final :- % Cumule les tests de la version précédente et en ajoute
    assert_true( conc3final([1,2,3,4],[5,6],[7,8,9,10], [1,2,3,4,5,6,7,8,9,10]) ),
    assert_true( findall(T, conc3final([1,2,3,4],[5,6],[7,8,9,10],T), [[1,2,3,4,5,6,7,8,9,10]]) ),
    assert_true( sortall([L1,L2,L3], conc3final(L1,L2,L3,[1,2]), 
        [[[],[],[1, 2]], [[],[1],[2]], [[],[1,2],[]], [[1],[],[2]], [[1],[2],[]], [[1,2],[],[]]]) ).

test_debute_par :-
    assert_true( debute_par([1,2,3,4,5,6], [1,2,3]) ),
    assert_true( not(debute_par([1,2,3], [1,2,3,4,5,6])) ),
    assert_true( sortall(X, debute_par([1,2,3,4],X), [[], [1], [1,2], [1,2,3], [1,2,3,4]]) ).
    
test_sous_liste :-
    assert_true( sous_liste([1,2,3,4,5,6],[3,4]) ),
    assert_true( not(sous_liste([1,2,3,4,5,6],[4,3])) ),
    assert_true( not(sous_liste([1,2,3,4,5,6],[1,6])) ),
    assert_true( setof(L, sous_liste([1,2,3],L), [[],[1],[1,2],[1,2,3],[2],[2,3],[3]]) ). % setof au lieu de findall pour ignorer les multiples [] et trier

test_elim :-
    assert_true( elim([a,b,a,b,a], [a,b]) ; elim([a,b,a,b,a], [b,a]) ),
    assert_true( elim([a,b,a,b,a], Y) ; msort(Y, [a,b]) ).

test_tri :-
    assert_true( tri([5,4,3,2,1], [1,2,3,4,5]) ),
    assert_true( findall(Tri, tri([4,1,3,2],Tri), [[1,2,3,4]]) ).

test_inclus :-
    assert_true( inclus([3,2], [1,2,3,4]) ),
    assert_true( not(inclus([3,55], [1,2,3,4])) ).

test_non_inclus :-
    assert_true( non_inclus([3,55], [1,2,3,4]) ),
    assert_true( not(non_inclus([3,2], [1,2,3,4])) ).

test_union_ens :-
    assert_true( (union_ens([1,2],[3,4], Z), msort(Z,[1,2,3,4])) ).

test_inclus2 :-
    assert_true( inclus2([3,2], [1,2,3,4]) ),                                      % mode (+,+) pour réussite
    assert_true( not(inclus2([3,55], [1,2,3,4])) ),                                % mode (+,+) pour échec
    assert_true( sortall(A, inclus2(A, [1,2]), [[], [1], [1, 2], [2], [2, 1]] ) ). % mode (-,+)
    % le mode (+,-) produit une infinité de solutions, ce qui est normal


% SortedList donne la liste triee de toutes les solutions de Term dans le but Goal 
sortall(Term, Goal, SortedList) :-
    findall(Term, Goal, List),
    msort(List, SortedList).

% Teste la propriete P et affiche ensuite "OK : P" ou "echec : P" 
test(P) :- P, !, printf("OK : %w \n", [P]).
test(P) :- printf("echec : %w \n", [P]), fail.
% Teste la propriete P et affiche ensuite "echec : P", ou rien si succès
assert_true(P) :- P, !.
assert_true(P) :- printf("echec : %w \n", [P]), fail.
% Adaptation a Swish, utiliser format => assert_true(P) :- format('echec : ~p ~n', [P]), fail.

% Fin des tests

%membre(?A, +X)
membre(X, [X|R]).
membre(X, [T|Q]):-
    membre(X, Q).

%compte(+A, +X, ?N)
compte(X, [], 0).
compte(X, [X|R], N):-
    compte(X, R, M),
    N is M+1.
compte(X, [T|Q], N):-
    X\==T,
    compte(X, Q, N).
    

%renverser(+X,?Y)
renverser(X,Y):-
    renverser(X,[],Y).
renverser([],L,L).
renverser([T|Q],L1,L2):-
    renverser(Q,[T|L1],L2).


/*
Marche en (+X, +Y) mais pas en (+X,?Y)
renverser([],_).
renverser([T|Q],Y):-
    renverser(Q, [T|Y]).
*/


%palind(+X)
palind(X):-
    renverser(X,X).



%enieme(+N,+X,-A)
enieme(1, [X|Q], X).
enieme(N,[T|Q],X):-
    M is N-1,
    enieme(M,Q,X).

%hors_de(+A,+X)
hors_de(X,[]).
hors_de(X,[T|Q]):-
    X \== T,
    hors_de(X,Q).

%tous_diff(+X)
tous_diff([]).
tous_diff([T|Q]):-
    hors_de(T,Q),
    tous_diff(Q).

%conc3(+L1,+L2,+L3,?L)
conc3([],[],L,L).
conc3([],[X|L2],L3,[X|L]):-
    conc3([],L2,L3,L).
conc3([X|L1],L2,L3,[X|L]):-
    conc3(L1,L2,L3,L).

%debute_par(+L1,L2)
debute_par(L1,[]).
debute_par([X|L1],[X|L2]):-
    debute_par(L1,L2).


%sous_liste(+L1,?L2)
sous_liste(L1,[]).
sous_liste([X|L1],[Y|L2]):-
    sous_liste(L1,[Y|L2]).
sous_liste([X|L1],[X|L2]):-
    debute_par(L1,L2).

%elim(+L1,-L2)
elim([],[]).
elim([X|L1],L2):-
    elim(L1,L2),
    membre(X,L2).
elim([X|L1],[X|L2]):-
    elim(L1,L2),
    hors_de(X,L2).

%inserer(+E,+L1,-L2)
inserer(E,[],[E]).
inserer(E,[X|L1],[X|L2]):-
    X<E,
    inserer(E,L1,L2).
inserer(E,[X|L1],[E,X|L1]):-
    X>=E.

%tri(+L1,-L2)
tri([],[]).
tri([X|L1],L2):-
    tri(L1,L3),
    inserer(X,L3,L2).
