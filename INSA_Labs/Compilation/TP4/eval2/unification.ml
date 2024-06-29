open Type

exception Not_unifiable

let rec unify_terms env t1 t2 =
  match Substitution.substitution_in_term env t1, Substitution.substitution_in_term env t2 with
  | t1,t2 when t1 = t2 -> env
  | Functor(s1, tl1), Functor(s2, tl2) when s1 = s2 -> unify_lists env tl1 tl2
  | BuiltinFunctor(bf1, a, b), BuiltinFunctor(bf2, c, d) when bf1 = bf2 -> unify_terms (unify_terms env a c) b d
  | Variable(_,id,_), t -> Env.add env id t
  | t, Variable(_,id,_) -> Env.add env id t
  | Cons(a, b), Cons(c, d) -> unify_terms (unify_terms env a c) b d
  | _ -> raise Not_unifiable

and unify_lists env l1 l2 =
  try
    List.fold_left2 (fun env t1 t2 -> unify_terms env t1 t2) env l1 l2
  with Invalid_argument _ -> raise Not_unifiable

let unify_predicates env = function
  | Predicate(p1, l1), Predicate(p2, l2) when p1 = p2 -> unify_lists env l1 l2
  | _ -> raise Not_unifiable
