%%%-------------------------------------------------------------------
%%% @author motek
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 06. Dec 2017 11:17
%%%-------------------------------------------------------------------
-module(zad2).
-author("motek").

%% API
-export([panel/1,posrednik2/1,producent2/1,konsument2/1,print/1,printxy/1,start/0]).

producent2(Panel) ->
  receive
    {create,Posr} ->
      Panel ! {producent,"Zaczynam produkcje"},
      Posr ! {random, self(), rand:uniform(100)},
      producent2(Panel);
    {ok} ->
      Panel ! {producent, "Konsument odebral produkt"};
    {stop} ->
      Panel ! {producent,"Producent konczy prace"};
    _ ->
      producent2(Panel)
  end.

posrednik2(Panel) ->
  receive
    {random,Od,Num} ->
      Konsument = spawn(zad2,konsument2,[Panel]),
      Panel ! {posrednik,"Odbieram produkt od producentai"},
      Od ! {ok},
      Panel ! {posrednik,"Przekazuje produkt konsumentowi"},
      Konsument ! {random,self(),Num},
      posrednik2(Panel);
    {ok} ->
      Panel ! {posrednik,"Konsument otrzymal produkt"},
      posrednik2(Panel);
    {stop} ->
      Panel ! {posrednik,"Pośrednik kończy prace"};
    _ ->
      posrednik2(Panel)
  end.

konsument2(Panel) ->
  receive
    {random,Od,Num} ->
      Panel ! {konsument,"Konsumuje produkt"},
      Od ! {ok}
  end.

print({printxy,X,Y,Msg}) ->
  io:format("\e[~p;~pH~p",[Y,X,Msg]);
print({clear}) ->
  io:format("\e[2J",[]);
print({tlo}) ->
  print({printxy,2,4,1.2343}),
  io:format("",[]).

printxy({X,Y,Msg}) ->
  io:format("\e[~p;~pH~p~n",[Y,X,Msg]).

panel(Offset) ->
  receive
    {clear} ->
      print({clear}),
      panel(Offset);
    {tlo} ->
      print({tlo}),
      panel(Offset);
    {producent,Msg} ->
      print({printxy,1,Offset,Msg}),
      panel(Offset+1);
    {posrednik,Msg} ->
      print({printxy,40,Offset,Msg}),
      panel(Offset+1);
    {konsument,Msg} ->
      print({printxy,80,Offset,Msg}),
      panel(Offset+1);
    _ ->
      panel(Offset)
  end.

start() ->
  PID0 = spawn(zad2,panel,[1]),
  PID1 = spawn(zad2,producent2,[PID0]),
  PID2 = spawn(zad2,posrednik2,[PID0]),
  PID1 ! {create,PID2},
  PID1 ! {create,PID2},
  PID1 ! {create,PID2},
  PID1 ! {create,PID2}.