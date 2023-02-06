-spec two_sum(Nums :: [integer()], Target :: integer()) -> [integer()].
two_sum(Nums, Target) ->
    try
        lists:foldl(
            fun(Value, {Index, Dict}) -> 
                case dict:find(Target - Value, Dict) of
                    error ->
                        {Index + 1, dict:append(Value, Index, Dict)};
                    {ok, ComplementIndex} ->
                        throw([Index, hd(ComplementIndex)])
                end
            end, {0, dict:new()}, Nums)
    catch
        _:Solution:_ ->
            Solution
    end.
