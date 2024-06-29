

% Tests

tests :-
    test(test_plat),
    test(test_repas),
    test(test_plat200_400),
    test(test_plat_bar),
    test(test_val_cal),
    test(test_repas_eq).


% Teste la propriete P et affiche ensuite "OK : P" ou "echec : P" 
test(P) :- P, !, printf("OK : %w \n", [P]).
test(P) :- printf("echec : %w \n", [P]), fail.

% Teste la propriete P et affiche ensuite "echec : P", ou rien si succès
assert_true(P) :- P, !.
assert_true(P) :- printf("echec : %w \n", [P]), fail.

test_plat :-
    assert_true( plat(grillade_de_boeuf) ),
    assert_true( plat(saumon_oseille) ),
    assert_true( not plat(artichauts_Melanie) ),
    assert_true( not plat(sorbet_aux_poires) ).

test_repas :-
    assert_true( repas(cresson_oeuf_poche, poulet_au_tilleul, fraises_chantilly) ),
    assert_true( not repas(melon_en_surprise, poulet_au_tilleul, fraises_chantilly) ).

test_plat200_400 :-
    assert_true( sortedof(P, plat200_400(P), [bar_aux_algues, poulet_au_tilleul, saumon_oseille]) ).

test_plat_bar :-
    assert_true( sortedof(P, plat_bar(P), [grillade_de_boeuf, poulet_au_tilleul]) ).

test_val_cal :-
    assert_true( val_cal(cresson_oeuf_poche, poulet_au_tilleul, fraises_chantilly, 901) ),
    assert_true( not val_cal(truffes_sous_le_sel, grillade_de_boeuf, sorbet_aux_poires, 901) ).

test_repas_eq :-
    assert_true( repas_eq(artichauts_Melanie, saumon_oseille, fraises_chantilly) ),
    assert_true( not repas_eq(truffes_sous_le_sel, grillade_de_boeuf, sorbet_aux_poires) ).

sortedof(Term, Goal, SortedList) :-
    findall(Term, Goal, List),
    msort(List, SortedList).


% Fin des tests.

hors_d_oeuvre(artichauts_Melanie).
hors_d_oeuvre(truffes_sous_le_sel).
hors_d_oeuvre(cresson_oeuf_poche).

viande(grillade_de_boeuf).
viande(poulet_au_tilleul).

poisson(bar_aux_algues).
poisson(saumon_oseille).

dessert(sorbet_aux_poires).
dessert(fraises_chantilly).
dessert(melon_en_surprise).

calories(artichauts_Melanie, 150).
calories(truffes_sous_le_sel, 202).
calories(cresson_oeuf_poche, 212).
calories(grillade_de_boeuf, 532).
calories(poulet_au_tilleul, 400).
calories(bar_aux_algues, 292).
calories(saumon_oseille, 254).
calories(sorbet_aux_poires, 223).
calories(fraises_chantilly, 289).
calories(melon_en_surprise, 122).

%plat
plat(X):-
    poisson(X).
plat(X):-
    viande(X).

%repas
repas(X,Y,Z):-
    hors_d_oeuvre(X),
    plat(Y),
    dessert(Z).

%plat200_400
plat200_400(X):-
    plat(X),
    calories(X,Y),
    Y >=200,
    Y =< 400.

%plat_bar
plat_bar(X):-
    plat(X),
    calories(X,Y),
    calories(bar_aux_algues,Z),
    Y > Z.

%val_cal
val_cal(E,P,D,T):-
    repas(E,P,D),
    calories(E,CE),
    calories(P,CP),
    calories(D,CD),
    T is CE+CP+CD.

%repas_eq
repas_eq(E,P,D):-
    val_cal(E,P,D,T),
    T =< 800.