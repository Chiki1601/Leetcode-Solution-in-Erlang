-spec make_the_integer_zero(Num1 :: integer(), Num2 :: integer()) -> integer().
make_the_integer_zero(Num1, Num2) ->
    make_the_integer_zero(Num1, Num2, 0, 60).

make_the_integer_zero(_Num1, _Num2, T, MaxT) when T > MaxT ->
    -1;
make_the_integer_zero(Num1, Num2, T, MaxT) ->
    S = Num1 - T * Num2,
    case S < 0 orelse S < T of
        true ->
            make_the_integer_zero(Num1, Num2, T + 1, MaxT);
        false ->
            Ones = bit_count(S),
            if Ones =< T ->
                   T;
               true ->
                   make_the_integer_zero(Num1, Num2, T + 1, MaxT)
            end
    end.

-spec bit_count(N :: integer()) -> integer().
bit_count(0) -> 0;
bit_count(N) -> bit_count(N, 0).

bit_count(0, Count) -> Count;
bit_count(N, Count) ->
    bit_count(N band (N - 1), Count + 1).
