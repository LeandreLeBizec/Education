:-lib(ic).
:-lib(branch_and_bound).

solve(T):-
  getData(NbTechniciens, Techniciens, QuantiteJour, Benefice, NbTelephone),
  defineVars(T, NbTelephone),
  contraintes(T, NbTelephone, Techniciens, QuantiteJour, Benefice, TechnicienTotal, ProfitTotal),
  getVarList(T, Liste),
  %C #= -ProfitTotal,
  C #= TechnicienTotal,
	minimize(labeling(Liste),C),
  write("TechnicienTotal = "), writeln(TechnicienTotal),
  write("ProfitTotal = "), writeln(ProfitTotal).

getData(NbTechniciens, Techniciens, QuantiteJour, Benefice, NbTelephone):-
  NbTechniciens = 22,
  Techniciens = [5,7,2,6,9,3,7,5,3],
  QuantiteJour = [140,130,60,95,70,85,100,35,45],
  Benefice = [4,5,8,5,6,4,7,10,11],
  length(Benefice, NbTelephone).

defineVars(T, NbTelephone):-
  dim(T, [NbTelephone]),
  T #:: 0..1.

getVarList(T, Liste):-
  (
    fromto([],In,Out,Liste), 
    foreacharg(X, T) do
      Out = [X|In]
  ).

technicienTotal(T, NbTelephone, Techniciens, Res):-
  (
    fromto(0,In,Out,Res),
    for(I,1,NbTelephone), param(T, Techniciens) do
      Tel is T[I],
      element(I, Techniciens, R),
      Out #= In + R*Tel
  ).

beneficeParTel(NbTelephone, QuantiteJour, Benefice, BenefParTel):-
  (
    fromto([],In,Out,BenefParTel),
    for(I,1,NbTelephone), param(QuantiteJour, Benefice) do
      element(I, QuantiteJour, Q),
      element(I, Benefice, B),
      BenefTel is B*Q,
      %Out = [BenefTel|In] -> liste à l'envers
      append(In, [BenefTel], Out)
  ).


profitTotal(T, NbTelephone, QuantiteJour, Benefice, ProfitTotal):-
  beneficeParTel(NbTelephone, QuantiteJour, Benefice, BenefParTel),
  (
    fromto(0,In,Out,ProfitTotal),
    for(I,1,NbTelephone), param(T, BenefParTel) do
      Tel is T[I],
      element(I,BenefParTel,B),
      Out #= In + B*Tel
  ).


contraintes(T, NbTelephone, Techniciens, QuantiteJour, Benefice, TechnicienTotal, ProfitTotal):-
  technicienTotal(T, NbTelephone, Techniciens, TechnicienTotal),
  TechnicienTotal #=< 22,
  profitTotal(T, NbTelephone, QuantiteJour, Benefice, ProfitTotal),
  ProfitTotal #>= 1000.


/*
5.5
TechnicienTotal = 22
ProfitTotal = 2665

T = [](0, 1, 1, 0, 0, 1, 1, 0, 1)
*/

/*
5.6
TechnicienTotal = 7
ProfitTotal = 1040

T = [](1, 0, 1, 0, 0, 0, 0, 0, 0)
*/