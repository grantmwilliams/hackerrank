-module(solution).
-export([main/0]).

% 1. If contains a "0" return DEAD
% 2. Use Deterministic Miller-Rabin Primality To Check Primality
% 3. If stripping from Left and Right gives primes return "CENTRAL"
% 4. Else If stripping from Left gives primes return "LEFT"
% 5. Else If stripping from Right gives primes return "RIGHT"
% 6. Else Return "DEAD"

%========= IO UTILITY =================================================
% reads input as string
read_strings(0) ->
  [];
read_strings(I) ->
  {ok,[X]} = io:fread("", "~s"),
  [X|read_strings(I-1)].
%======================================================================

%========= MILLER-RABIN ===============================================
is_prime(1) -> false;
is_prime(2) -> true;
is_prime(3) -> true;
is_prime(N) when N > 3, ((N rem 2) == 0) -> false;
is_prime(N) -> is_mr_prime(N, [2]).

is_mr_prime(N, As) when N>2, N rem 2 == 1 ->
    {D, S} = find_ds(N),
         % this is a test for compositeness; the two case patterns disprove compositeness.
    not lists:any(fun(A) ->
                          case mr_series(N, A, D, S) of
                              [1|_] -> false;                     % first elem of list = 1
                              L     -> not lists:member(N-1, L)   % some elem of list = N-1
                          end
                  end,
                  As).
 
find_ds(N) ->
    find_ds(N-1, 0). 
find_ds(D, S) ->
    case D rem 2 == 0 of
        true ->
            find_ds(D div 2, S+1);
        false ->
            {D, S}
    end.
 
mr_series(N, A, D, S) when N rem 2 == 1 ->
    Js = lists:seq(0, S),
    lists:map(fun(J) -> pow_mod(A, power(2, J)*D, N) end, Js).
 
pow_mod(B, E, M) ->
    case E of
        0 -> 1;
        _ -> case ((E rem 2) == 0) of
                 true  -> (power(pow_mod(B, (E div 2), M), 2)) rem M;
                 false -> (B*pow_mod(B, E-1, M)) rem M
             end
    end. 
 
power(B, E) ->
    power(B, E, 1).
power(_, 0, Acc) ->
    Acc;
power(B, E, Acc) ->
    power(B, E - 1, B * Acc).
%======================================================================

%========= Zero Check =================================================
% Check if string contains "0"
containsZero([]) ->
    false;
containsZero([Number|Numbers]) when Number-48 =:= 0 ->
    true;
containsZero([Number|Numbers]) ->
    containsZero(Numbers).
%======================================================================

%========= Check Left =================================================
checkLeft([]) -> true;
checkLeft(Digits) ->
    Num = erlang:list_to_integer(Digits),
    case is_prime(Num) of
        true -> 
            [_|T] = Digits,
            checkLeft(T);
        false -> false
    end.
%======================================================================

%========= Check Right ================================================    
checkRight([]) -> true;
checkRight(Digits) ->
    Num = erlang:list_to_integer(Digits),
    case is_prime(Num) of
        true -> checkRight(lists:droplast(Digits));
        false -> false
    end.
%======================================================================

%========= Primality Check ============================================
% rercursively checks primality of starting number from left and right
checkPrimality(StrId) ->
    Id = erlang:list_to_integer(StrId),
    case is_prime(Id) of
        true ->
            [_|L] = StrId,
            R = lists:droplast(StrId),
            case {Left, Right} = {checkLeft(L), checkRight(R)} of
                {true, true}   -> io:format("CENTRAL~n");
                {true, false}  -> io:format("LEFT~n");
                {false, true}  -> io:format("RIGHT~n");
                {false, false} -> io:format("DEAD~n")
            end;
        false -> io:format("DEAD~n")
    end.
%======================================================================

%========= GET POSITIONS ==============================================

getPositions([StrId|StrIdList]) ->
    case containsZero(StrId) of
        false ->
            checkPrimality(StrId),
            getPositions(StrIdList);
        true ->
            io:format("DEAD~n"),
            getPositions(StrIdList)
    end;

getPositions([]) -> ok.
%======================================================================

main() ->
    {ok, [T]} = io:fread("", "~d"),
    StrIdList = read_strings(T),
    ok = getPositions(StrIdList).