-module(solution).
-export([main/0]).

readLines() ->
    readLines(next, []).

readLines(next, InputList) ->
    case io:fread("", "~f") of
        {ok, [N]} ->
            readLines(next, [N|InputList]);
        eof ->
            {ok, lists:reverse(InputList)}
    end.

factorial(N) ->
  factorial(1, N, 1).

factorial(Current, N, Result) when Current =< N ->
    NewResult = Result * Current,
    factorial(Current+1, N, NewResult);

factorial(_, _, Result) ->
    Result.

factorialList() ->
    [factorial(N) || N <- lists:seq(0, 9)].


evaluateNaturalExponential(X, Factorials) ->
    evaluateNaturalExponential(X, Factorials, 0, 0).


evaluateNaturalExponential(_, [], _, Accumulator) -> Accumulator;


evaluateNaturalExponential(X, [Factorial|NextFactorials], Step, Accumulator) ->

    ExpansionStep = math:pow(X, Step)/Factorial,

    evaluateNaturalExponential(X, NextFactorials, Step+1, Accumulator+ExpansionStep).

main() ->

    {ok, _} = io:fread('', "~d"),

    {ok, ListOfNumbers} = readLines(),

    Factorials = factorialList(),

    [ io:format("~.4f~n", [evaluateNaturalExponential(X, Factorials)]) || X <- ListOfNumbers ].
