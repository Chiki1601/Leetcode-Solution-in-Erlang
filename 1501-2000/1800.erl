-spec max_ascending_sum(Nums :: [integer()]) -> integer().
max_ascending_sum(Nums) ->
    max_ascending_sum(Nums, hd(Nums), hd(Nums)).

max_ascending_sum([], MaxSum, _) -> 
    MaxSum;

max_ascending_sum([_], MaxSum, _) -> 
    MaxSum;

max_ascending_sum([Current, Next | Rest], MaxSum, CurSum) ->
    NewCurSum = if
                    Current < Next -> CurSum + Next;
                    true -> Next
                end,
    NewMaxSum = max(MaxSum, NewCurSum),
    max_ascending_sum([Next | Rest], NewMaxSum, NewCurSum).
