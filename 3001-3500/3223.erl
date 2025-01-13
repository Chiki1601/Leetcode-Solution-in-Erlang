-spec minimum_length(S :: unicode:unicode_binary()) -> integer().
minimum_length(S) ->
    case unicode:characters_to_list(S) of
        [] -> 0;
        [_] -> 1;
        [_, _] -> 2;
        _ -> 
            lists:foldl(fun(C, {D, R}) ->
                            Curr = dict:find(C, D, 0),
                            D1 = if Curr + 1 > 2 -> dict:store(C, 1, D);
                                  true -> dict:store(C, Curr + 1, D)
                                end,
                            R1 = R + (dict:find(C, D1, 0) - Curr),
                            {D1, R1}
                        end, {dict:new(), 0}, unicode:characters_to_list(S))
            |> elem(1)
    end.
