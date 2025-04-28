-spec count_subarrays(Nums :: [integer()], K :: integer()) -> integer().
count_subarrays(Nums, K) ->
    Arr = array:from_list(Nums),
    count_subarrays(Arr, array:size(Arr), K, 0, 0, 0, 0).

count_subarrays(_Arr, Size, _K, Left, _Sum, Right, Answer) when Right == Size ->
    Answer;
count_subarrays(Arr, Size, K, Left, Sum, Right, Answer) ->
    H = array:get(Right, Arr),
    NewSum = Sum + H,
    NewRight = Right + 1,
    {NewLeft, NewSum2} = adjust(Arr, NewSum, Left, NewRight, K),
    NewAnswer = Answer + (NewRight - NewLeft),
    count_subarrays(Arr, Size, K, NewLeft, NewSum2, NewRight, NewAnswer).

adjust(Arr, Sum, Left, Right, K) ->
    Length = Right - Left,
    case Sum * Length < K of
        true ->
            {Left, Sum};
        false ->
            H = array:get(Left, Arr),
            adjust(Arr, Sum - H, Left + 1, Right, K)
    end.
