-spec missing_number(Nums :: [integer()]) -> integer().
missing_number(Nums) ->
    N = length(Nums),
    TotalSum = N * (N + 1) div 2,
    Sum = lists:sum(Nums),
    TotalSum - Sum.
