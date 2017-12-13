%%%-------------------------------------------------------------------
%%% @author motek
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. Dec 2017 12:36
%%%-------------------------------------------------------------------
-module(zad1).
-author("motek").

%% API
-export([parallelMap/2,apply/3,merge/1,start/0]).


parallelMap(List,Fun) ->
  lists:map(fun(X) -> spawn(zad1,apply,[X,Fun,self()]) end,List),
  L = merge(List),
  io:format("~p~n",[L]).

apply(Elem,Fun,Mother) ->
  Mother ! {data, Elem, Fun(Elem)}.

merge([]) -> [];
merge([H|T]) ->
  receive
    {data,H,ReturnValue} ->
      [ReturnValue|merge(T)]
  end.

start() ->
  L = [9,3,2,7,1,0,4,7,2,8,2],
  zad1:parallelMap(L,fun(X)-> X*10 end).