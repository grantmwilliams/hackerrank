-module(solution).
-export([main/0]).

readLines() ->
    readLines(next, []).

readLines(next, InputList) ->
    case io:fread("", "~d") of
        {ok, [N]} ->
            readLines(next, [N|InputList]);
        eof ->
            {ok, lists:reverse(InputList)}
    end.

main() ->
    {ok, [F]} = io:fread("", "~d"),
    {ok, ListOfNumbers} = readLines(),
    [io:format("~b~n", [X]) || X <- ListOfNumbers, X < F].
