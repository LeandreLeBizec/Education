% Tests

count(P, N) :-
    findall(_, P, R),
    length(R, N).

tests :-
    test( test_add1_1 ),
    test( test_add1_2 ),
    test( test_add1_3 ),
    test( test_add1_4 ),
    test( test_add1_5 ),
    test( test_add1_6 ),

    test( test_sub1_1 ),
    test( test_sub1_2 ),
    test( test_sub1_3 ),

    test( test_prod1_1 ),
    test( test_prod1_2 ),
    test( test_prod1_3 ),
    test( test_prod1_4 ),
    test( test_prod1_5 ),

    test( test_factorial1_1 ),
    test( test_factorial1_2 ),
    test( test_factorial1_3 ),

    test( test_add2_1 ),
    test( test_add2_2 ),
    test( test_add2_3 ),
    test( test_add2_4 ),
    test( test_add2_5 ),

    test( test_sub2_1 ),
    test( test_sub2_2 ),
    test( test_sub2_3 ),

    test( test_prod2_1 ),
    test( test_prod2_2 ),
    test( test_prod2_3 ),
    test( test_prod2_4 ),

    test( test_factorial2_1 ),
    test( test_factorial2_2 ),
    test( test_factorial2_3 ),
    test( test_factorial2_4 ),

    test( test_factorial3_1 ),
    test( test_factorial3_2 ),
    test( test_factorial3_3 ),
    test( test_factorial3_4 ).

test_add1_1 :-
    assert_true( add1(zero, s(s(zero)), s(s(zero))) ).

test_add1_2 :-
    assert_true( add1(s(s(s(zero))), s(s(s(s(zero)))), s(s(s(s(s(s(s(zero)))))))) ).

test_add1_3 :-
    assert_true( count(test_add1_3_aux, 8) ).
test_add1_3_aux :-
    (X = zero; X = s(zero); X = s(s(zero)); X = s(s(s(zero))); X = s(s(s(s(zero))));
     X = s(s(s(s(s(zero))))); X = s(s(s(s(s(zero))))); X = s(s(s(s(s(s(zero))))))),
    add1(X, s(zero), s(X)).

test_add1_4 :-
    assert_true( count(test_add1_4_aux, 8) ).
test_add1_4_aux :-
    (X = zero; X = s(zero); X = s(s(zero)); X = s(s(s(zero))); X = s(s(s(s(zero))));
     X = s(s(s(s(s(zero))))); X = s(s(s(s(s(zero))))); X = s(s(s(s(s(s(zero))))))),
    add1(s(X), s(s(zero)), s(s(s(X)))).

test_add1_5 :-
    assert_true( count(test_add1_5_aux, 64) ).
test_add1_5_aux :-
    (X = zero; X = s(zero); X = s(s(zero)); X = s(s(s(zero))); X = s(s(s(s(zero))));
     X = s(s(s(s(s(zero))))); X = s(s(s(s(s(zero))))); X = s(s(s(s(s(s(zero))))))),
    (Y = zero; Y = s(zero); Y = s(s(zero)); Y = s(s(s(zero))); Y = s(s(s(s(zero))));
     Y = s(s(s(s(s(zero))))); Y = s(s(s(s(s(zero))))); Y = s(s(s(s(s(s(zero))))))),
    add1(X, Y, Z),
    add1(Y, X, Z).

test_add1_6 :-
    assert_true( sortall((X, Y), add1(X, Y, s(s(s(zero)))),
                         [(zero, s(s(s(zero)))), (s(zero), s(s(zero))), (s(s(zero)), s(zero)), (s(s(s(zero))), zero)]) ).

test_sub1_1 :-
    assert_true( count(test_sub1_1_aux, 8) ).
test_sub1_1_aux :-
    (X = zero; X = s(zero); X = s(s(zero)); X = s(s(s(zero))); X = s(s(s(s(zero))));
     X = s(s(s(s(s(zero))))); X = s(s(s(s(s(zero))))); X = s(s(s(s(s(s(zero))))))),
    sub1(X, X, zero).

test_sub1_2 :-
    assert_true( count(test_sub1_2_aux, 15) ).
test_sub1_2_aux :-
    (X = zero; X = s(zero); X = s(s(zero))),
    (Y = s(s(s(zero))); Y = s(s(s(s(zero))));
     Y = s(s(s(s(s(zero))))); Y = s(s(s(s(s(zero))))); Y = s(s(s(s(s(s(zero))))))),
    add1(X, Y, Z),
    sub1(Z, Y, X).

test_sub1_3 :-
    assert_true( count(test_sub1_3_aux, 64) ).
test_sub1_3_aux :-
    (X = zero; X = s(zero); X = s(s(zero)); X = s(s(s(zero))); X = s(s(s(s(zero))));
     X = s(s(s(s(s(zero))))); X = s(s(s(s(s(zero))))); X = s(s(s(s(s(s(zero))))))),
    (Y = zero; Y = s(zero); Y = s(s(zero)); Y = s(s(s(zero))); Y = s(s(s(s(zero))));
     Y = s(s(s(s(s(zero))))); Y = s(s(s(s(s(zero))))); Y = s(s(s(s(s(s(zero))))))),
    add1(X, Y, Z),
    sub1(Z, Y, X).

test_prod1_1 :-
    assert_true( prod1(s(s(s(zero))), s(s(s(s(s(zero))))), s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(zero)))))))))))))))) ).

test_prod1_2 :-
    assert_true( count(test_prod1_2_aux, 8) ).
test_prod1_2_aux :-
    (X = zero; X = s(zero); X = s(s(zero)); X = s(s(s(zero))); X = s(s(s(s(zero))));
     X = s(s(s(s(s(zero))))); X = s(s(s(s(s(zero))))); X = s(s(s(s(s(s(zero))))))),
    prod1(zero, X, zero).

test_prod1_3 :-
    assert_true( count(test_prod1_3_aux, 8) ).
test_prod1_3_aux :-
    (X = zero; X = s(zero); X = s(s(zero)); X = s(s(s(zero))); X = s(s(s(s(zero))));
     X = s(s(s(s(s(zero))))); X = s(s(s(s(s(zero))))); X = s(s(s(s(s(s(zero))))))),
    prod1(X, s(s(zero)), Res),
    add1(X, X, Res).

test_prod1_4 :-
    assert_true( count(test_prod1_4_aux, 8) ).
test_prod1_4_aux :-
    (X = zero; X = s(zero); X = s(s(zero)); X = s(s(s(zero))); X = s(s(s(s(zero))));
     X = s(s(s(s(s(zero))))); X = s(s(s(s(s(zero))))); X = s(s(s(s(s(s(zero))))))),
    prod1(X, s(zero), X).

test_prod1_5 :-
    assert_true( count(test_prod1_5_aux, 64) ).
test_prod1_5_aux :-
    (X = zero; X = s(zero); X = s(s(zero)); X = s(s(s(zero))); X = s(s(s(s(zero))));
     X = s(s(s(s(s(zero))))); X = s(s(s(s(s(zero))))); X = s(s(s(s(s(s(zero))))))),
    (Y = zero; Y = s(zero); Y = s(s(zero)); Y = s(s(s(zero))); Y = s(s(s(s(zero))));
     Y = s(s(s(s(s(zero))))); Y = s(s(s(s(s(zero))))); Y = s(s(s(s(s(s(zero))))))),
    prod1(X, Y, Z),
    prod1(Y, X, Z).

test_factorial1_1 :-
    assert_true( factorial1(zero, s(zero)) ).

test_factorial1_2 :-
    assert_true( factorial1(s(s(s(zero))), s(s(s(s(s(s(zero))))))) ).

test_factorial1_3 :-
    assert_true( factorial1(s(s(s(s(zero)))), s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(zero))))))))))))))))))))))))) ).


equivalent(N1, N2) :-
    reverse(N1, RN1),
    reverse(N2, RN2),
    remove_zeroes(RN1, RN11),
    remove_zeroes(RN2, RN22),
    RN11 = RN22.

remove_zeroes([], []).
remove_zeroes([1|Ns], [1|Ns]).
remove_zeroes([0|Ns], Res) :-
    remove_zeroes(Ns, Res).

test_add2_1 :-
    assert_true( (add2([0,1,1,0,1], [1,0,1,1,1,1,1,1,1], Res), equivalent(Res, [1, 1, 0, 0, 1, 0, 0, 0, 0, 1])) ).

test_add2_2 :-
    assert_true( (add2([1,1,1,1,1], [1], Res), equivalent(Res, [0, 0, 0, 0, 0, 1])) ).

test_add2_3 :-
    assert_true( (add2([1,1,0,0,1,1,0,1,0,1,0,1,1,1,1], [1,1,1,0,0,1,1,1,1,0,0,0,0,0,0,1,1,1], Res),
                  equivalent(Res, [0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1])) ).

test_add2_4 :-
    assert_true( (add2([0,0,0,0,1], Y, [0,1,1,0,1,1]),
                  equivalent(Y, YY),
                  YY = [0, 1, 1, 0, 0, 1]) ).

test_add2_5 :-
    assert_true( (add2(X, X, [0,0,1,1,0,0,1]),
                  equivalent(X, XX),
                  XX = [0, 1, 1, 0, 0, 1]) ).

test_sub2_1 :-
    assert_true( (sub2([1,1,0,0,1,1], [1,1,0,0,1,1], Res),
                  equivalent(Res, [])) ).

test_sub2_2 :-
    assert_true( (sub2([0,0,0,0,0,0,1], [1], Res),
                  equivalent(Res, [1,1,1,1,1,1])) ).

test_sub2_3 :-
    assert_true( (sub2([1,1,1,0,1,1,1,0,1], [1,0,0,1,1,1], Res),
                  equivalent(Res, [0, 1, 1, 1, 1, 1, 0, 0, 1])) ).

test_prod2_1 :-
    assert_true( (prod2([1,0,1,1,0,1], [1,1,1,1,1,0,1], Res),
                  equivalent(Res, [1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1])) ).

test_prod2_2 :-
    assert_true( (prod2([1,0,1,1,1,1,1,0,1], [0,0,0,0,0,0,1,1,1,1,1], Res),
                  equivalent( Res, [0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1])) ).

test_prod2_3 :-
    assert_true( (prod2([1,1,0,1,1,1,0,0,0,0,0,1], [1,1,1,1,1,1], Res),
                  equivalent( Res, [1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1])) ).

test_prod2_4 :-
    assert_true( (prod2([1,0,1], [1,0,0,1], Res), equivalent( Res, [1, 0, 1, 1, 0, 1])) ).

test_factorial2_1 :-
    assert_true( (factorial2([1,0,0,1,1,1], Res), reverse(Res, R1), remove_zeroes(R1, R2), length(R2, 255)) ).

test_factorial2_2 :-
    assert_true( (factorial2([1,1], Res), equivalent(Res, [0,1,1])) ).

test_factorial2_3 :-
    assert_true( (factorial2([0,0,1], Res), equivalent(Res, [0,0,0,1,1])) ).

test_factorial2_4 :-
    assert_true( (factorial2([1,0,1], Res), equivalent(Res, [0,0,0,1,1,1,1])) ).

test_factorial3_1 :-
    assert_true( factorial3(0, 1) ).

test_factorial3_2 :-
    assert_true( factorial3(3, 6) ).

test_factorial3_3 :-
    assert_true( factorial3(4, 24) ).

test_factorial3_4 :-
    assert_true( factorial3(5, 120) ).

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

%%%%%%%%%%% Binary representation
add_bit(0, 0, 0, 0, 0).
add_bit(0, 0, 1, 1, 0).
add_bit(0, 1, 0, 1, 0).
add_bit(0, 1, 1, 0, 1).
add_bit(1, 0, 0, 1, 0).
add_bit(1, 0, 1, 0, 1).
add_bit(1, 1, 0, 0, 1).
add_bit(1, 1, 1, 1, 1).

add(zero,zero,0):- !.
add(zero,s(O2),X):- 
	add(zero,O2,T),
	X is T+1.
add(s(O1),zero,X):-
	add(O1,zero,T),
	X is T+1.
add(s(O1),s(O2),X):-
	add(O1,O2,T),
	X is T+2.
	
	
a1(X,X).

%1.1
add1(zero,Y,Y).
add1(s(X),Y,s(Z)):-
	add1(X,Y,Z).

%1.2
sub1(X,Y,Z):- 
	add1(Y,Z,X).

%1.3
prod1(zero,_,zero).
prod1(s(X),Y,Z):- 
	prod1(X,Y,W),
	add1(W,Y,Z).

%1.4
factorial1(zero,s(zero)).
factorial1(s(N),Fact):-
	factorial1(N,W),
	prod1(W,s(N),Fact).

%2.1
add2([],[],0,[]).
add2([],[],1,[1]).
add2(L1,[],0,L1).
add2([],L2,0,L2).
add2([B1|L1],[],1,[C|LR]):-add_bit(B1,0,1,C,CaO),add2(L1,[],CaO,LR).
add2([],[B2|L2],1,[C|LR]):-add_bit(0,B2,1,C,CaO),add2([],L2,CaO,LR).
add2([B1|L1],[B2|L2],CaI,[C|LR]):- add_bit(B1,B2,CaI,C,CaO), add2(L1,L2,CaO,LR).
add2(L1,L2,LR):-add2(L1,L2,0,LR).   %CarryIn init à 0




%2.2
sub2(L1,L2,LR):- add2(L2,LR,L1).

%2.3
prod2([1],L2,L2).
prod2(L1,L2,LR):- sub2(L1,[1],L1Pred),prod2(L1Pred,L2,LRPred),add2(LRPred,L2,LR). %Trop long 

%2.4
factorial2([],[1]).
factorial2(N,F):- add2(NPred,[1],N),factorial2(NPred,FPred),prod_bin(FPred,N,F).

%3.1
factorial3(0,1).
factorial3(A,F):- APred is A-1,factorial3(APred,FPred),F is FPred*A.


partial_product([],X,[]).
partial_product([HD|TL],0,[0|TL1]):-
    partial_product(TL,0,TL1).
partial_product([HD|TL],1,[HD|TL1]):-
    partial_product(TL,1,TL1).
    
prod_bin(_,[],[]).
prod_bin(X,[HD|TL],RES):-
    partial_product(X,HD,PP),
    prod_bin([0|X],TL,RES1),
    add_bin(PP,RES1,RES).
	
add_binary([],[],1,[1]).
add_binary([],[],0,[]).
	
add_binary([],[HD1|TL1],RESIN,[HD2|TL2]):-
	add_bit(0,HD1,RESIN,HD2,RESOUT),
	add_binary([],TL1,RESOUT,TL2).

add_binary([HD|TL],[],RESIN,[HD2|TL2]):-
	add_bit(HD,0,RESIN,HD2,RESOUT),
	add_binary(TL,[],RESOUT,TL2).
	
add_binary([HD|TL],[HD1|TL1],RESIN,[HD2|TL2]):-
	add_bit(HD,HD1,RESIN,HD2,RESOUT),
	add_binary(TL,TL1,RESOUT,TL2).
	
add_bin(X,Y,RES):-
	add_binary(X,Y,0,RES).