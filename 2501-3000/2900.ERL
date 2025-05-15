-spec get_longest_subsequence(Words :: [unicode:unicode_binary()], Groups :: [integer()]) -> [unicode:unicode_binary()].
get_longest_subsequence([FirstWord | RestWords], [FirstGroup | RestGroups]) ->
    get_longest_subsequence(RestWords, RestGroups, FirstGroup, [FirstWord]).

%% Helper function with accumulator
get_longest_subsequence([], [], _PrevGroup, Acc) ->
    lists:reverse(Acc);
get_longest_subsequence([Word | Words], [Group | Groups], PrevGroup, Acc) ->
    case Group =:= PrevGroup of
        true -> get_longest_subsequence(Words, Groups, PrevGroup, Acc);
        false -> get_longest_subsequence(Words, Groups, Group, [Word | Acc])
    end.
