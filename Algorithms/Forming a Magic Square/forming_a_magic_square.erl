-module(solution).
-export([main/0]).
-import(os, [getenv/1]).

%% Printing Utility
%%===========================================================================================
printList(List) ->
    io:format("| "),
    [io:format("~w ", [Val]) || Val <- List],
    io:format("|~n").

printSquare(Square) ->
    io:format("---------~n"),
    [printList(List) || List <- Square],
     io:format("---------~n~n").
     
printAllSquares(Squares) ->
    [printSquare(Square) || Square <- Squares].


%% Transpose Matrix
%%===========================================================================================
transpose([[]|_]) -> [];
transpose(M) ->
    [lists:map(fun hd/1, M) | transpose(lists:map(fun tl/1, M))].


%% Rotate Matrix
%%===========================================================================================
rotate([]) -> [];
rotate(Matrix) ->
    rotate(forward, lists:reverse(Matrix), [ [] || _ <- hd(Matrix) ]).

rotate(forward, [], Acc) -> lists:reverse(Acc);
rotate(backward, [], Acc) -> Acc;
rotate(forward, [Row|Rest], Acc) ->
    rotate(backward, Rest, prepend(Row, Acc));
rotate(backward, [Row|Rest], Acc) ->
    rotate(forward, Rest, prepend(lists:reverse(Row), Acc)).

prepend(From, To) -> prepend(From, To, []).
prepend([Hf|Tf], [Ht|Tt], Acc) -> prepend(Tf, Tt, [[Hf|Ht]|Acc]);
prepend([], [], Acc)           -> Acc.

%% Generate All Valid Magic Squares
%%===========================================================================================
generateMagicSquares() ->
    Seed = [[2, 9, 4], [7, 5, 3], [6, 1, 8]],
    generateMagicSquares([Seed|[transpose(Seed)]]).
    
generateMagicSquares(L) when length(L) =:= 8 -> L;

generateMagicSquares(L) ->
    [X,H|_] = lists:reverse(L),
    R = rotate(H),
    T = transpose(R),
    generateMagicSquares(L ++ [R] ++ [T]).

%% Finds Minimum Cost to Transform Input
%%===========================================================================================
getCost(Input, Squares) ->
    lists:min(
        lists:map(fun(Square) -> 
            lists:sum(
                lists:zipwith(fun(A,B) -> 
                        max(A,B) - min(A,B) end,
                    lists:flatten(Input),
                    lists:flatten(Square))) end,
            Squares)).


%%  HackerRank Function Call
%%===========================================================================================
formingMagicSquare(S) ->
    Squares = generateMagicSquares(),
    getCost(S, Squares).

%% HackerRank IO 
%%===========================================================================================
read_multiple_lines_as_list_of_strings(N) ->
    read_multiple_lines_as_list_of_strings(N, []).

read_multiple_lines_as_list_of_strings(0, Acc) ->
    lists:reverse(Acc);
read_multiple_lines_as_list_of_strings(N, Acc) when N > 0 ->
    read_multiple_lines_as_list_of_strings(N - 1, [string:chomp(io:get_line("")) | Acc]).

main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    STemp = read_multiple_lines_as_list_of_strings(3),

    S = lists:map(fun(X) -> lists:map(fun(Y) -> {I, _} = string:to_integer(Y), I end, re:split(X, "\\s+", [{return, list}, trim])) end, STemp),

    Result = formingMagicSquare(S),

    io:fwrite(Fptr, "~w~n", [Result]),

    file:close(Fptr),

    ok.