
% TP2 TERMES CONSTRUITS - A compl�ter et faire tourner sous Eclipse Prolog
% ==============================================================================
% ============================================================================== 
%	FAITS
% ============================================================================== 

% Teste la propriete P et affiche ensuite "OK : P" ou "echec : P" 
test(P) :- P, !, printf("OK : %w \n", [P]).
test(P) :- printf("echec : %w \n", [P]), fail.

% Teste la propriete P et affiche ensuite "echec : P", ou rien si succ�s
assert_true(P) :- P, !.
assert_true(P) :- printf("echec : %w \n", [P]), fail.


/* 
	main_test(NumeroTest, Main) 
	mains pour tester le pr�dicat EST_MAIN 
*/

main_test(main_triee_une_paire, main(carte(sept,trefle), carte(valet,coeur), carte(dame,carreau), carte(dame,pique), carte(roi,pique))).
% attention ici m2 repr�sente un ensemble de mains	 
main_test(m2, main(carte(valet,_), carte(valet,coeur), carte(dame,carreau), carte(roi,coeur), carte(as,pique))).
main_test(main_triee_deux_paires, main(carte(valet,trefle), carte(valet,coeur), carte(dame,carreau), carte(roi,coeur), carte(roi,pique))).
main_test(main_triee_brelan, main(carte(sept,trefle), carte(dame,carreau), carte(dame,coeur), carte(dame,pique), carte(roi,pique))).	
main_test(main_triee_suite,main(carte(sept,trefle),carte(huit,pique),carte(neuf,coeur),carte(dix,carreau),carte(valet,carreau))).
main_test(main_triee_full,main(carte(deux,coeur),carte(deux,pique),carte(quatre,trefle),carte(quatre,coeur),carte(quatre,pique))).

main_test(merreur1, main(carte(sep,trefle), carte(sept,coeur), carte(dame,pique), carte(as,trefle), carte(as,pique))).
main_test(merreur2, main(carte(sep,trefle), carte(sept,coeur), carte(dame,pique), carte(as,trefle))).

  
tests :-
    test(test_est_carte),
    test(test_est_main),
    test(test_inf_carte),
    test(test_est_main_triee),
    test(test_une_paire),
    test(test_deux_paires),
    test(test_brelan),
    test(test_suite),
    test(test_full).

test_tmp_carte(Y) :-
    carte_test(_,Y),
    est_carte(Y).

test_est_carte :-
     findall(Y,test_tmp_carte(Y),LY),assert_true(length(LY,2)). 

  % Pr�dicat permettant de r�cup�rer toutes les mains d�finies dans la base de faits
test_tmp_est_main(Y):-
  main_test(_,Y),est_main(Y).
  
  % Pr�dicat v�rifiant que 8 mains ont bien �t� r�cup�r�es
test_est_main :-
  findall(X,test_tmp_est_main(X),LX),assert_true(length(LX,8)).

test_inf_carte :-
    assert_true(inf_carte(carte(quatre, pique),carte(cinq,coeur))),
    assert_true(inf_carte(carte(quatre, coeur),carte(cinq,coeur))),
    assert_true(inf_carte(carte(quatre, carreau),carte(cinq,coeur))),
    assert_true(inf_carte(carte(quatre, trefle),carte(cinq,coeur))),
    assert_true(inf_carte(carte(cinq,trefle),carte(cinq,coeur))),
    findall(Y,inf_carte(carte(cinq,Y),carte(cinq,coeur)),LY),
    assert_true(length(LY,2)). 
  
test_tmp_m2_triee(X):-
    main_test(m2,X),
    est_main_triee(X).

test_est_main_triee :-
	main_test(main_triee_une_paire,Y),assert_true(est_main_triee(Y)),
    main_test(main_triee_deux_paires,Z),assert_true(est_main_triee(Z)),
	findall(X,test_tmp_m2_triee(X),LX),assert_true(length(LX,2)). 
  
test_tmp_deux_paires(Main):-
    main_test(_,Main),deux_paires(Main).

test_deux_paires:-
    findall(Y,test_tmp_deux_paires(Y),LY),assert_true(length(LY,3)). 

test_tmp_une_paire(Main):-
    main_test(_,Main),une_paire(Main).

test_une_paire:-
    findall(Y,test_tmp_une_paire(Y),LY),assert_true(length(LY,10)).

test_tmp_brelan(Main):-
    main_test(_,Main),brelan(Main).

test_brelan:-
    findall(Y,test_tmp_brelan(Y),LY),assert_true(length(LY,2)).

test_tmp_suite(Main):-
    main_test(_,Main),suite(Main).

test_suite:-
    findall(Y,test_tmp_suite(Y),LY),assert_true(length(LY,1)).

test_tmp_full(Main):-
    main_test(_,Main),full(Main).

test_full:-
  findall(Y,test_tmp_full(Y),LY),assert_true(length(LY,1)).




  /*
	hauteur(Valeur)
*/
hauteur(deux).
hauteur(trois).
hauteur(quatre).
hauteur(cinq).
hauteur(six).
hauteur(sept).
hauteur(huit).
hauteur(neuf).
hauteur(dix).
hauteur(valet).
hauteur(dame).
hauteur(roi).
hauteur(as).

/*
	couleur(Valeur)
*/
couleur(trefle).
couleur(carreau).
couleur(coeur).
couleur(pique).

/*
	succ_hauteur(H1, H2)
*/
succ_hauteur(deux, trois).
succ_hauteur(trois, quatre).
succ_hauteur(quatre, cinq).
succ_hauteur(cinq, six).
succ_hauteur(six, sept).
succ_hauteur(sept, huit).
succ_hauteur(huit, neuf).
succ_hauteur(neuf, dix).
succ_hauteur(dix, valet).
succ_hauteur(valet, dame).
succ_hauteur(dame, roi).
succ_hauteur(roi, as).

/*
	succ_couleur(C1, C2)
*/
succ_couleur(trefle, carreau).
succ_couleur(carreau, coeur).
succ_couleur(coeur, pique).
% ordre : trefle,carreau,coeur,pique

/*
  carte_test
  cartes pour tester le predicat EST_CARTE
*/

carte_test(c1,carte(sept,trefle)).
carte_test(c2,carte(neuf,carreau)).
carte_test(ce1,carte(7,trefle)).
carte_test(ce2,carte(sept,t)).


% ============================================================================= 
%        QUESTION 1 : est_carte(carte(Hauteur,Couleur))
% ==============================================================================

est_carte(carte(Hauteur,Couleur)):-
    hauteur(Hauteur),
    couleur(Couleur). 

% ==============================================================================
%	QUESTION 2 : est_main(main(C1,C2,C3,C4,C5))
%        faire les tests differents des que l on peut permet d elaguer l arbre et donc de gagner en temps d ex�cution .
%        (la phrase ci-dessus repond elle a l histoire du micro seconde dans l ennonce )
% ============================================================================== 

est_main(main(C1,C2,C3,C4,C5)):-
    est_carte(C1),
    est_carte(C2),
    est_carte(C3),
    est_carte(C4),
    est_carte(C5),
    C1 \== C2,
    C1 \== C3,
    C1 \== C4,
    C1 \== C5,
    C2 \== C3,
    C2 \== C4,
    C2 \== C5,
    C3 \== C4,
    C3 \== C5,
    C4 \== C5.



% ============================================================================= 
%       QUESTION 3  inf_carte(carte(_,_),carte(_,_))
% ============================================================================= 


inf_hauteur(H1,H2):-
    succ_hauteur(H1,H2).
inf_hauteur(H1,H2):-
    succ_hauteur(H1,Ht),
    inf_hauteur(Ht,H2).


inf_couleur(C1,C2):-
    succ_couleur(C1,C2).
inf_couleur(C1,C2):-
    succ_couleur(C1,Ct),
    inf_couleur(Ct,C2).


inf_carte(carte(H1,C1),carte(H2,C2)):-
    inf_hauteur(H1,H2).
inf_carte(carte(H,C1),carte(H,C2)):-
    inf_couleur(C1,C2).



% ============================================================================= 
%       QUESTION 4 : est_main_triee(main(C1,C2,C3,C4,C5))
% ============================================================================= 

est_main_triee(main(C1,C2,C3,C4,C5)):-
    inf_carte(C1,C2),
    inf_carte(C2,C3),
    inf_carte(C3,C4),
    inf_carte(C4,C5).



% ============================================================================= 
%       QUESTION 5 : une_paire(main(carte(_,_),carte(_,_),carte(_,_),carte(_,_),carte(_,_)))
% ============================================================================== 

une_paire(main(carte(H,_),carte(H,_),carte(_,_),carte(_,_),carte(_,_))).
une_paire(main(carte(_,_),carte(H,_),carte(H,_),carte(_,_),carte(_,_))).
une_paire(main(carte(_,_),carte(_,_),carte(H,_),carte(H,_),carte(_,_))).
une_paire(main(carte(_,_),carte(_,_),carte(_,_),carte(H,_),carte(H,_))).


% ============================================================================= 
%       QUESTION 6 : deux_paires(main(carte(_,_),carte(_,_),carte(_,_),carte(_,_),carte(_,_)))
% ============================================================================= 

deux_paires(main(carte(H1,_),carte(H1,_),carte(H2,_),carte(H2,_),carte(_,_))).
deux_paires(main(carte(_,_),carte(H1,_),carte(H1,_),carte(H2,_),carte(H2,_))).
deux_paires(main(carte(H1,_),carte(H1,_),carte(_,_),carte(H2,_),carte(H2,_))).


% ==============================================================================
%       QUESTION 7 : brelan(main(carte(_,_),carte(_,_),carte(_,_),carte(_,_),carte(_,_)))
% ==============================================================================

brelan(main(carte(H,_),carte(H,_),carte(H,_),carte(_,_),carte(_,_))).
brelan(main(carte(_,_),carte(H,_),carte(H,_),carte(H,_),carte(_,_))).
brelan(main(carte(_,_),carte(_,_),carte(H,_),carte(H,_),carte(H,_))).


% ============================================================================= 
%       QUESTION 8 : suite(main(carte(_,_),carte(_,_),carte(_,_),carte(_,_),carte(_,_)))
% ============================================================================= 


suite(main(carte(H1,_),carte(H2,_),carte(H3,_),carte(H4,_),carte(H5,_))):-
    succ_hauteur(H1,H2),
    succ_hauteur(H2,H3),
    succ_hauteur(H3,H4),
    succ_hauteur(H4,H5).
    
% ============================================================================= 
%       QUESTION 9 : full(main(carte(_,_),carte(_,_),carte(_,_),carte(_,_),carte(_,_)))
% =============================================================================



full(main(carte(H1,_),carte(H1,_),carte(H2,_),carte(H2,_),carte(H2,_))).
full(main(carte(H1,_),carte(H1,_),carte(H1,_),carte(H2,_),carte(H2,_))).