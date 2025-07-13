-spec match_players_and_trainers(Players :: [integer()], Trainers :: [integer()]) -> integer().
match_players_and_trainers(Players, Trainers) ->
    SortedPlayers = lists:sort(Players),
    SortedTrainers = lists:sort(Trainers),
    match(SortedPlayers, SortedTrainers, 0).

%% Helper function to recursively find matches
match([], _, Matches) ->
    Matches;
match(_, [], Matches) ->
    Matches;
match([P | RestPlayers], [T | RestTrainers], Matches) ->
    case P =< T of
        true -> 
            match(RestPlayers, RestTrainers, Matches + 1);  %% found a match, move both pointers
        false -> 
            match([P | RestPlayers], RestTrainers, Matches)  %% current trainer too weak, move trainer pointer
    end.
