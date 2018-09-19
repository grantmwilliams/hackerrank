-module(solution).
-export([main/0]).

fact(N) -> fact(N, 1).
fact(0, T) -> T;
fact(N, T) when N > 0 -> fact(N-1, N*T).

printRow(N) ->
    A = [trunc(fact(N-1)/(fact(R-1)*fact(N-R))) || R <- lists:seq(1,N)],
    lists:foreach(fun(E) -> io:format("~w ", [E]) end, A), 
    io:format("~n", []).

main() ->
    {ok, [T]} = io:fread("","~d"),
    [printRow(N) || N <- lists:seq(1, T)].
