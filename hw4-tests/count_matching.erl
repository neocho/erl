-module(count_matching).
-export([count_matching/2, helper/3]).
-compile(compile_all).

-spec count_matching (fun((T) -> boolean()), list(T)) -> non_neg_integer().
count_matching(Pred, List) -> 
    helper(Pred, List, 0).
     

-spec helper(fun((T)->boolean()), list(T), non_neg_integer()) -> integer(). 
helper(_Pred, [], X) -> X;
helper(Pred, [H|T], X) -> 
    helper(Pred, T, X + (case Pred(H) of 
                            true -> 1; 
                            false -> 0 end)).

