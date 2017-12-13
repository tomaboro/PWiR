%%%-------------------------------------------------------------------
%%% @author motek
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. Dec 2017 13:02
%%%-------------------------------------------------------------------
-module(zad2).
-author("motek").

%% API
-export([startWithObserver/2,stopWithObserver/2,start/1,stop/1,loop/1,handle/3,test/0,printer/0,observatorReceived/3,observatorWaiting/3,startObserver/2,stopObserver/1]).

start(State) ->
  PID = spawn(zad2,loop,[State]),
  {PID,ok}.

stop(PID) ->
  PID ! {stop}.

startWithObserver(Printer,State) ->
  PID = spawn(zad2,loop,[State]),
  Observer = spawn(zad2,observatorReceived,[PID,Printer,[]]),
  {PID,Observer,ok}.

stopWithObserver(PID,Observer) ->
  PID ! {stop},
  Observer ! {stop}.

loop(State) ->
  receive
    {stop} -> {stopped,ok};
    {save,Observer} -> Observer ! {ok,State}, loop(State);
    {handle,Request} -> handle(Request,State,self());
    {asyncHandle,Request} -> asyncHandle(Request,State), loop(State);
    _ -> loop(State)
  end.

asyncHandle({get,Key,PID},Args) ->
  PID ! {ok,maps:get(Key,Args)}.

handle({add,Key,Value},Args,Parent) ->
  loop(maps:put(Key,Value,Args)).

startObserver(PID,Printer) ->
  Observer = spawn(zad2,observatorReceived,[PID,Printer,[]]),
  {Observer,ok}.

stopObserver(PID) ->
  PID ! {stop}.

observatorWaiting(Child,Supervisor,SavedState) ->
  receive
    {stop} -> {stopped,ok};
    {ok,State} -> Supervisor ! {stateSaved,State}, observatorReceived(Child,Supervisor,State);
    _ -> observatorWaiting(Child,Supervisor,SavedState)
    after
      30000 -> start(SavedState)
  end.

observatorReceived(Child,Supervisor,SavedState) ->
  receive
    {stop} -> {stopped,ok};
    _ -> observatorReceived(Child,Supervisor,SavedState)
    after
        10000 -> Child ! {save,self()}, observatorWaiting(Child,Supervisor,SavedState)
  end.

printer() ->
  receive
    {ok,Val} -> io:format("return ~w~n",[Val]), printer();
    {stateSaved,State} -> io:format("state ~w~n",[State]), printer()
  end.

test() ->
  Printer = spawn(zad2,printer,[]),
  {PID,Observer,ok} = startWithObserver(Printer,maps:from_list([{"izaaa",22}])),
  PID ! {handle,{add,"tomek",15}},
  PID ! {handle,{add,"iza",17}},
  PID ! {asyncHandle,{get,"iza",Printer}},
  timer:sleep(50000),
  PID ! {handle,{add,"tomek2",25}},
  PID ! {handle,{add,"iza2",12}},
  PID ! {asyncHandle,{get,"iza2",Printer}},
  timer:sleep(50000),
  stopWithObserver(PID,Observer).