-define(MOD, 1000000007).

-spec length_after_transformations(binary(), integer(), [integer()]) -> integer().
length_after_transformations(S, T, Nums) ->
    Freq = freq(S, lists:duplicate(26, 0)),
    M = build_matrix(0, Nums, lists:duplicate(26, lists:duplicate(26, 0))),
    MT = matrix_power(M, T),
    RowSum = [lists:sum(R) rem ?MOD || R <- MT],
    lists:sum([F * R rem ?MOD || {F, R} <- lists:zip(Freq, RowSum)]) rem ?MOD.

freq(<<>>, Acc) -> Acc;
freq(<<C, Rest/binary>>, Acc) when C >= $a, C =< $z ->
    I = C - $a,
    Val = lists:nth(I + 1, Acc),
    freq(Rest, update_at(I, Val + 1, Acc));
freq(<<_, Rest/binary>>, Acc) -> freq(Rest, Acc).

build_matrix(26, _, M) -> M;
build_matrix(I, [N | Ns], M) ->
    Row = build_row(I, N, lists:nth(I + 1, M)),
    build_matrix(I + 1, Ns, update_at(I, Row, M)).

build_row(_, 0, Row) -> Row;
build_row(I, N, Row) -> build_row_loop(1, N, I, Row).

build_row_loop(J, N, _, Row) when J > N -> Row;
build_row_loop(J, N, I, Row) ->
    K = (I + J) rem 26,
    Val = lists:nth(K + 1, Row),
    build_row_loop(J + 1, N, I, update_at(K, Val + 1, Row)).

matrix_power(_, 0) -> identity_matrix();
matrix_power(M, 1) -> M;
matrix_power(M, N) when N rem 2 == 0 ->
    H = matrix_power(M, N div 2),
    multiply(H, H);
matrix_power(M, N) ->
    H = matrix_power(M, (N - 1) div 2),
    multiply(multiply(H, H), M).

identity_matrix() ->
    [[if I == J -> 1; true -> 0 end || J <- lists:seq(0, 25)] || I <- lists:seq(0, 25)].

multiply(A, B) ->
    BT = transpose(B),
    [[lists:sum([X * Y rem ?MOD || {X, Y} <- lists:zip(RA, CB)]) rem ?MOD || CB <- BT] || RA <- A].

transpose(M) ->
    lists:foldr(fun(Row, Acc) -> lists:zipwith(fun(X, C) -> [X | C] end, Row, Acc) end,
                lists:duplicate(length(hd(M)), []), M).

update_at(0, V, [_ | T]) -> [V | T];
update_at(N, V, [H | T]) -> [H | update_at(N - 1, V, T)].
