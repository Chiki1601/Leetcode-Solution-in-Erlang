-spec ways_to_split_array(Nums :: [integer()]) -> integer().
ways_to_split_array(Nums) ->
    Sum = lists:sum(Nums),
    solve(Sum, Nums, 0).

-spec solve(Acc :: integer(), Nums :: [integer()], Ans :: integer()) -> integer().
solve(_, [Last], Ans) ->
    Ans;
solve(Acc, [X | Tail], Ans) when Acc - X * 2 =< 0 ->
    solve(Acc - X * 2, Tail, Ans + 1);
solve(Acc, [X | Tail], Ans) ->
    solve(Acc - X * 2, Tail, Ans).
