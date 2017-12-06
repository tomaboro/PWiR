%%%-------------------------------------------------------------------
%%% @author motek
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 06. Dec 2017 11:15
%%%-------------------------------------------------------------------
-module(zad1).
-author("motek").

%% API
-export([start/0,posrednik/0,producent/0,konsument/0]).

producent() ->
  receive
    {create,Posr} ->
      io:format("Zaczynam produkcje ~n"),Posr ! {random, self(), rand:uniform(100)},producent();
    {ok} ->
      io:format("Konsument odebral produkt ~n");
    {stop} ->
      io:format("Producent konczy prace ~n");
    _ ->
      io:format("Nieznany komunikat ~n")
  end.

posrednik() ->
  receive
    {random,Od,Num} ->
      Konsument = spawn(zad1,konsument,[]),
      io:format("Odbieram produkt od producentai ~n"),
      Od ! {ok},
      io:format("Przekazuje produkt konsumentowi ~n"),
      Konsument ! {random,self(),Num},
      posrednik();
    {ok} ->
      io:format("Konsument otrzymal produkt ~n"),
      posrednik();
    {stop} ->
      io:format("Pośrednik kończy prace ~n");
    _ ->
      io:format("Nieznany komunikat ~n")
  end.

konsument() ->
  receive
    {random,Od,Num} ->
      io:format("Konsumuje produkt ~n"),
      Od ! {ok}
  end.

start() ->
  PID1 = spawn(zad1,producent,[]),
  PID2 = spawn(zad1,posrednik,[]),
  PID1 ! {create,PID2},
  PID1 ! {create,PID2},
  PID1 ! {create,PID2},
  PID1 ! {create,PID2}.