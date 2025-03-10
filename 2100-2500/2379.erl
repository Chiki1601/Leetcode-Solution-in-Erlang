-spec minimum_recolors(Blocks :: unicode:unicode_binary(), K :: integer()) -> integer().
minimum_recolors(<<Blocks/binary>>, K) ->
    minimum_recolors(binary_to_list(Blocks), K);    
minimum_recolors(Blocks, K) ->
    recolor(Blocks, [], K, 0, 0).

recolor([], _, _, _, W) -> W;
recolor([H | T], [{DB, DW} | DT], K, B, W) when (B + W) == K ->
    min(
        W,
        case H of
            $B -> recolor(T, DT ++ [{1, 0}], K, B - DB + 1, W - DW);
            $W -> recolor(T, DT ++ [{0, 1}], K, B - DB, W - DW + 1)
        end
    );
recolor([H | T], Del, K, B, W) ->
    case H of
        $B -> recolor(T, Del ++ [{1, 0}], K, B + 1, W);
        $W -> recolor(T, Del ++ [{0, 1}], K, B, W + 1)
    end.
