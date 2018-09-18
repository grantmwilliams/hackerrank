-module(solution).

-export([main/0]).

% returns string representation of line without line break
read_line() ->
    string:strip(io:get_line(""), both, $\n).

% converts string to list of tokens
tokenize_line(Str, Func) ->
    lists:map(Func, string:tokens(Str, " ") ).

% equivalent to seq(start, stop, inc) but works with floats
f_seq(Start, Stop, Inc) ->
    f_seq(Start, Stop, Inc, [Start]).

f_seq(Current, Stop, Inc, Range) ->
    case Current < Stop of
        true ->
            f_seq(Current+Inc, Stop, Inc, [Current|Range]);
        false ->
            lists:reverse(Range)
    end.

% evaluate f(x)
expr(A, B, X) ->
    expr(A, B, X, 0).

expr([A|At], [B|Bt], X, Sum) ->
   N = A * math:pow(X, B),
   expr(At, Bt, X, Sum+N);

expr([], _, _, Sum) ->
    Sum.

main() ->
    Delta = 0.0001,
    A = tokenize_line(read_line(), fun erlang:list_to_integer/1),
    B = tokenize_line(read_line(), fun erlang:list_to_integer/1),
    {ok, [L, R]} = io:fread("", "~d ~d"),
    
    Range = f_seq(L, R, Delta),
    Area = lists:sum([Delta/2 * (expr(A, B, X)+expr(A,B,X+Delta)) || X <- Range]),
    Volume = lists:sum([math:pi() * math:pow(expr(A, B, X),2) * Delta || X <- Range]),
    
    io:format("~w~n", [Area]),
    io:format("~w~n", [Volume]).