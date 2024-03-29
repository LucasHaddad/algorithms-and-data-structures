% John works at a clothing store. He has a large pile of socks that he must pair
% by color for sale. Given an array of integers representing the color of each
% sock, determine how many pairs of socks with matching colors there are.

% For example, there are `n = 7` socks with colors `ar = [1,2,1,2,1,3,2]`. There
% is one pair of color 1 and one of color 2. There are three odd socks left, one
% of each color. The number of pairs is 2.

-module(sock_merchant).

-export([count_number_of_pair_of_sockets/2,
         filter_socks/2,
         separate_socks/2,
         sock_merchant/2,
         test/0,
         test_sock_merchant/0]).

%% Next: number
%% Acc: map
separate_socks(Next, Acc) ->
    KeyExists = maps:is_key(Next, Acc),

    case KeyExists of
        true ->
            CurrentKeyList = maps:get(Next, Acc),
            maps:update(Next, [Next | CurrentKeyList], Acc);
        false -> maps:put(Next, [Next], Acc)
    end.

%% Value: number
filter_socks(_, Value) ->
    if length(Value) div 2 >= 1 -> true;
       true -> false
    end.

%% Next: {key, [number]}
%% Acc: number
count_number_of_pair_of_sockets({_, Arr}, Acc) ->
    Acc + length(Arr) div 2.

%% N: number
%% Ar: [number]
sock_merchant(_, Ar) ->
    % SocksSeparatedList = #{1: [1,1], 2: [2], ...}
    SocksSeparatedList = lists:foldl(fun separate_socks/2,
                                     #{},
                                     Ar),
    SocksWithPairs = maps:filter(fun filter_socks/2,
                                 SocksSeparatedList),
    ListOfSocksWithPairs = maps:to_list(SocksWithPairs),
    lists:foldl(fun count_number_of_pair_of_sockets/2,
                0,
                ListOfSocksWithPairs).

test_sock_merchant() ->
    3 = sock_merchant(9,
                      [10, 20, 20, 10, 10, 30, 50, 10, 20]),
    4 = sock_merchant(10, [1, 1, 3, 1, 2, 1, 3, 3, 3, 3]),
    pass.

test() -> pass = test_sock_merchant().
