-module(solution).
-export([main/0]).
-import(os, [getenv/1]).

appendAndDelete(S, T, K) ->
        
    N = getCommonPrefix(S, T, 0),
    Slen = string:length(S),
    Tlen = string:length(T),
    
    if
        Slen + Tlen < K ->
            "Yes";
        (Slen + Tlen - 2*N =< K) and ( abs(Slen + Tlen - 2*N) rem 2 =:= K rem 2) ->
            "Yes";
        true ->
            "No"
   end.
    
getCommonPrefix([SH | ST], [TH | TT], N) ->
    case SH =:= TH of
        true -> getCommonPrefix(ST, TT, N+1);
        false -> N
    end;
getCommonPrefix([], T, N) ->
    N;
getCommonPrefix(S, [], N) ->
    N.
    
main() ->
    {ok, Fptr} = file:open(getenv("OUTPUT_PATH"), [write]),

    S = case io:get_line("") of eof -> ""; SData -> string:chomp(SData) end,

    T = case io:get_line("") of eof -> ""; TData -> string:chomp(TData) end,

    {K, _} = string:to_integer(string:chomp(io:get_line(""))),

    Result = appendAndDelete(S, T, K),

    io:fwrite(Fptr, "~s~n", [Result]),

    file:close(Fptr),

    ok.