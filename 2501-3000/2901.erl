-spec get_words_in_longest_subsequence(Words :: [unicode:unicode_binary()], Groups :: [integer()]) -> [unicode:unicode_binary()].
get_words_in_longest_subsequence(Words, Groups) -> 
    erlang:erase(), 
    {_, R} = best([], -1, [binary_to_list(W) || W <- Words], Groups, 0), 
    R.

solve([], [], I) -> {0, []};
solve([W|Words], [G|Groups], I) -> 
    case erlang:get({'solve', I}) of
        R when is_tuple(R) -> R;
        _ -> 
            {L, Ans} = best(W, G, Words, Groups, I+1),
            R = {L + 1, [list_to_binary(W)|Ans]},
            erlang:put({'solve', I}, R),
            R
    end.

best(W, G, [Word|Words], [Group|Groups], I) -> 
    case check(W, Word, G, Group) of
        true -> max(solve([Word|Words], [Group|Groups], I), best(W, G, Words, Groups, I+1));
        false -> best(W, G, Words, Groups, I+1)
    end;
best(W, G, [], [], I) -> {0, []}.

check([], _, -1, _) -> true;
check(W, Word, G, Group) when G == Group -> false;
check([], [H2|T2], _, _) -> false;
check([H1|T1], [], _, _) -> false;
check([H1|T1], [H2|T2], G, Group) when H1 == H2 -> check(T1, T2, G, Group);
check([H1|T1], [H2|T2], _, _) -> T1 == T2.
