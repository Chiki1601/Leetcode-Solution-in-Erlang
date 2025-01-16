-spec xor_all_nums(Nums1 :: [integer()], Nums2 :: [integer()]) -> integer().
xor_all_nums(Nums1, Nums2) ->
    Ans1 = xor_if_odd(Nums1, Nums2),
    Ans2 = xor_if_odd(Nums2, Nums1),
    Ans1 bxor Ans2.

xor_if_odd(List1, List2) ->
    case length(List2) rem 2 of
        1 -> lists:foldl(fun(X, Acc) -> Acc bxor X end, 0, List1);
        _ -> 0
    end.
