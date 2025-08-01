-spec generate(NumRows :: integer()) -> [[integer()]].

gen_impl_add_element([], _, List) -> List;
gen_impl_add_element([H | T], Prev, List) -> 
    gen_impl_add_element(T, H, List ++ [Prev + H]).

gen_impl(Current) when Current =:= 1 -> [1];
gen_impl(Current) ->
    Prev = gen_impl(Current - 1),
    gen_impl_add_element(tl(Prev), hd(Prev), [1]) ++ [1].

generate(NumRows) ->
    generate(NumRows, 1).

generate(NumRows, Current) when NumRows < Current ->
    [];
generate(NumRows, Current) ->
    [gen_impl(Current)] ++ generate(NumRows, Current + 1).
