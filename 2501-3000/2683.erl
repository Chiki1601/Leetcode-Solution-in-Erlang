-spec does_valid_array_exist(Derived :: [integer()]) -> boolean().
does_valid_array_exist(Derived) ->
lists:foldl(fun(X, Sum) -> X bxor Sum end, 0, Derived) == 0
  .
