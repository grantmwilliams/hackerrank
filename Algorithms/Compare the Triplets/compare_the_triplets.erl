-module(solution).
-export([main/0]).
-import(os, [getenv/1]).

% Complete the solve function below.
solve(A, B) ->
    get_scores(A, B, [0,0]).
  
get_scores([], _, Acc) ->
    Acc;
get_scores([AH|AT], [BH|BT], [AS, BS]) when AH > BH ->
    get_scores(AT, BT, [AS + 1, BS]);
get_scores([AH|AT], [BH|BT], [AS, BS]) when AH < BH ->
    get_scores(AT, BT, [AS, BS + 1]);
get_scores([AH|AT], [BH|BT], [AS, BS]) when AH =:= BH ->
    get_scores(AT, BT, [AS, BS]).


read_multiple_lines_as_list_of_strings(N) ->
    read_multiple_lines_as_list_of_strings(N, []).

read_multiple_lines_as_list_of_strings(0, Acc) ->
    lists:reverse(Acc);
read_multiple_lines_as_list_of_strings(N, Acc) when N > 0 ->
    read_multiple_lines_as_list_of_strings(N - 1, [string:chomp(io:get_line("")) | Acc]).

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    ATemp = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    A = lists:map(fun(X) -> {I, _} = string:to_integer(X), I end, ATemp),

    BTemp = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

    B = lists:map(fun(X) -> {I, _} = string:to_integer(X), I end, BTemp),

    Result = solve(A, B),

    io:fwrite(Fptr, "~s~n", [lists:join(" ", lists:map(fun(X) -> integer_to_list(X) end, Result))]),

    file:close(Fptr),

    ok.
