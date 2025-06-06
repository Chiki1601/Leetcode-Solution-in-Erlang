-spec length_of_lis(Nums :: [integer()]) -> integer().
length_of_lis(Nums) ->
    Pred = fun(V, Index) -> {{Index, V}, Index + 1} end,
    {IVals, _} = lists:mapfoldl(Pred, 0, Nums),
    [H|T] = IVals,
    Tid = ets:new(lis, []),
    length_of_lis([], T, H, Tid, 0).

length_of_lis(Before, [], {_, Val}, Tid, Max) ->
    max(lis(Before, Val, Tid) + 1, Max);
length_of_lis(Before, [Next|After], Current={Index, Val}, Tid, Max) ->
    Lis = lis(Before, Val, Tid) + 1,
    ets:insert(Tid, {Index, Lis}),
    length_of_lis([Current|Before], After, Next, Tid, max(Max, Lis)).

lis([], _, _) -> 0;
lis(L, N, Tid) ->
    Opts = lists:filter(fun({I, V}) -> V < N end, L),
    Pred = fun({I, _}) -> ets:lookup_element(Tid, I, 2) end,
    case Opts of
        [] -> 0;
        _ ->
            lists:max(lists:map(Pred, Opts))
    end.
