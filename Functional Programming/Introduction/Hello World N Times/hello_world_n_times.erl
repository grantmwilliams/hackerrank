-module(solution).
-export([main/0]).

print_hello(N) ->
    [io:format("Hello World~n") || _ <- lists:seq(1,N)].

main() ->
    {N, _} = string:to_integer(string:chomp(io:get_line(""))),

    print_hello(N),
    ok.
