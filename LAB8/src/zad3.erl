%%%-------------------------------------------------------------------
%%% @author motek
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 06. Dec 2017 11:19
%%%-------------------------------------------------------------------
-module(zad3).
-author("motek").

%% API
-export([generator/0,dataProcessor/1,receiveBufor/0,start/0]).

computations(0) -> 0;
computations(Num) ->
  math:log(Num),
  computations(Num-1).

generator() ->
  receive
    {generate,Destination} ->
      Destination ! {data,rand:uniform(100)},
      generator();
    _ ->
      generator()
  end.

dataProcessor(ReceiveBufor) ->
  receive
    {data,Num} ->
      N = computations(Num+10000000),
      ReceiveBufor ! {computed,Num,Num/5},
      dataProcessor(ReceiveBufor);
    _ ->
      dataProcessor(ReceiveBufor)
  end.

receiveBufor() ->
  receive
    {computed,StartValue,EndValue} ->
      io:format("Value ~f~n",[EndValue]),
      receiveBufor();
    _ ->
      receiveBufor()
  end.

start() ->
  PID1 = erlang:spawn(zad3, generator, []),
  PID3 = erlang:spawn(zad3,receiveBufor,[]),
  L = [erlang:spawn(zad3, dataProcessor, [PID3]), erlang:spawn(zad3, dataProcessor, [PID3]), erlang:spawn(zad3, dataProcessor, [PID3]), erlang:spawn(zad3, dataProcessor, [PID3])],
  lists:foreach(fun(X) -> PID1 ! {generate,X} end,L),
  lists:foreach(fun(X) -> PID1 ! {generate,X} end,L),
  lists:foreach(fun(X) -> PID1 ! {generate,X} end,L),
  lists:foreach(fun(X) -> PID1 ! {generate,X} end,L),
  lists:foreach(fun(X) -> PID1 ! {generate,X} end,L).

