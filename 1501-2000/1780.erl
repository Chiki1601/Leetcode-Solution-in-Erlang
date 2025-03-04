-spec check_powers_of_three(N :: integer()) -> boolean().
check_powers_of_three(N) -> check_powers_of_three_helper(N).

check_powers_of_three_helper(0) -> true;
check_powers_of_three_helper(N) when N rem 3 =:= 2 -> false;
check_powers_of_three_helper(N) -> check_powers_of_three_helper(N div 3).
