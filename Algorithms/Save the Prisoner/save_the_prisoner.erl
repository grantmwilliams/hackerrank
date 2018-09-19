-module(solution).
-export([main/0]).
-import(os, [getenv/1]).

saveThePrisoner(N, M, S) ->
    ((S + M - 2) rem N)+1.

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    {T, _} = string:to_integer(string:chomp(io:get_line(""))),

    lists:foreach(fun(TItr) ->
        Nms = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),

        {N, _} = string:to_integer(lists:nth(1, Nms)),

        {M, _} = string:to_integer(lists:nth(2, Nms)),

        {S, _} = string:to_integer(lists:nth(3, Nms)),

        Result = saveThePrisoner(N, M, S),

        io:fwrite(Fptr, "~w~n", [Result]) end,
    lists:seq(1, T)),

    file:close(Fptr),

    ok.
