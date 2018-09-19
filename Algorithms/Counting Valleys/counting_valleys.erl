-module(solution).
-export([main/0]).
-import(os, [getenv/1]).

countingValleys(N, S) ->
    countingValleys(0, 0, S).

countingValleys(0, V, [68|T]) ->
    countingValleys(-1, V+1, T);

countingValleys(E, V, [68|T]) ->
        countingValleys(E-1, V, T);

countingValleys(E, V, [_|T]) ->
    countingValleys(E+1, V, T);
    
countingValleys(_, V, []) -> V.

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    {N, _} = string:to_integer(string:chomp(io:get_line(""))),

    S = case io:get_line("") of eof -> ""; SData -> string:chomp(SData) end,

    Result = countingValleys(N, S),

    io:fwrite(Fptr, "~w~n", [Result]),

    file:close(Fptr),

    ok.
