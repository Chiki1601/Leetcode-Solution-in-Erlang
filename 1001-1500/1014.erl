-spec max_score_sightseeing_pair(Values :: [integer()]) -> integer().
  max_score_loop([], Max, _, _) -> Max;
  max_score_loop([Value | Rest], Max, Score, I) ->
    NewScore = Score - 1,
    NewMax = max(Max, NewScore + Value),
    NextScore = max(NewScore, Value),
    max_score_loop(Rest, NewMax, NextScore, I + 1).
  max_score_sightseeing_pair(Values) -> [First | Rest] = Values, max_score_loop(Rest, 0, First, 1).
