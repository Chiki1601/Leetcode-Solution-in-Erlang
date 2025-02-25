-spec num_of_subarrays(Arr :: [integer()]) -> integer().
num_of_subarrays(Arr) ->
    helper(Arr, 0, 1, 0) rem (1000000000 + 7).

-spec helper(Arr :: [integer()], Sum :: integer(), Cnt0 :: integer(), Cnt1 :: integer()) -> integer().
helper([], _, _, _) -> 0;
helper([Num | Rest], Sum, Cnt0, Cnt1) ->
    Acc = Sum + Num,
    if
        Acc rem 2 =:= 0 -> helper(Rest, Acc, Cnt0 + 1, Cnt1) + Cnt1;
        true -> helper(Rest, Acc, Cnt0, Cnt1 + 1) + Cnt0
    end.
