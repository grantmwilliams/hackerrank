% Enter your code here. Read input from STDIN. Print output to STDOUT
% Your class should be named solution

-module(solution).
-export([main/0]).

gcd(A, 0) ->
    A;

gcd(A, B) when A < B ->
    gcd(B, A);

gcd(A, B) ->
    gcd(B, A rem B).

main() ->
    {ok, [A, B]} = io:fread("", "~d~d"),
    G = gcd(A, B),
    io:format("~w~n", [G]).
