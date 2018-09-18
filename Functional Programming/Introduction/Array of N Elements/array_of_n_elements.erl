-module(solution).
-export([main/0]).
    
main() ->
    {ok, [N]} = io:fread("", "~d"),
    % Fill in the blank with your code creating a list of N integers  
    List = lists:seq(1,N),
    % Do not change any of the other lines of code.