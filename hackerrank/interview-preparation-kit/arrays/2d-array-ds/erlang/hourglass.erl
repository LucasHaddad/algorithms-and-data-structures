-module(hourglass).

-export([test/0]).

create_sum_list({RowsLength, ColumnsLength}, Arr) ->
    %% Since the hourglass is a 3x3 matrix, we can not use a pivot that starts
    %% in the last two columns and rows
    PivotPositionList = [{X, Y}
                         || X <- lists:seq(1, RowsLength - 2),
                            Y <- lists:seq(1, ColumnsLength - 2)],
    HourglassPattern = [{0, 0},
                        {0, 1},
                        {0, 2},
                        {1, 1},
                        {2, 0},
                        {2, 1},
                        {2, 2}],
    lists:map(fun ({RowPosition, ColumnPosition}) ->
                      lists:foldl(fun ({RowShift, ColumnShift}, Acc) ->
                                          Row = lists:nth(RowPosition +
                                                              RowShift,
                                                          Arr),
                                          Element = lists:nth(ColumnPosition +
                                                                  ColumnShift,
                                                              Row),
                                          Acc + Element
                                  end,
                                  0,
                                  HourglassPattern)
              end,
              PivotPositionList).

hourglass_sum([FirstRow | _] = Rows) ->
    RowsLength = length(Rows),
    ColumnsLength = length(FirstRow),
    SumList = create_sum_list({RowsLength, ColumnsLength},
                              Rows),
    lists:max(SumList).

test_hourglass_sum() ->
    Input = [[1, 1, 1, 0, 0, 0],
             [0, 1, 0, 0, 0, 0],
             [1, 1, 1, 0, 0, 0],
             [0, 0, 2, 4, 4, 0],
             [0, 0, 0, 2, 0, 0],
             [0, 0, 1, 2, 4, 0]],
    Result = 19,
    Result = hourglass_sum(Input),
    pass.

test_create_sum_list() ->
    Input = [[-9, -9, -9, 1, 1, 1],
             [0, -9, 0, 4, 3, 2],
             [-9, -9, -9, 1, 2, 3],
             [0, 0, 8, 6, 6, 0],
             [0, 0, 0, -2, 0, 0],
             [0, 0, 1, 2, 4, 0]],
    Result = [-63,
              -34,
              -9,
              12,
              -10,
              0,
              28,
              23,
              -27,
              -11,
              -2,
              10,
              9,
              17,
              25,
              18],
    Result = create_sum_list({6, 6}, Input),
    pass.

test() ->
    pass = test_hourglass_sum(),
    pass = test_create_sum_list().
