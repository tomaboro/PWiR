-module(lab81).
-compile([export_all]).

-vsn(1.0).

producent() ->
	receive
		{create,Posr} -> 
			io:format("Zaczynam produkcje ~n"),Posr ! {random, self(), rand:uniform(100)},producent();
		{ok} ->
			 io:format("Konsument odebrał produkt ~n");
		{stop} ->
			io:format("Producent konczy prace ~n");
		_ ->
			 io:format("Nieznany komunikat ~n")
	end.

posrednik() ->
	receive 
		{random,Od,Num} ->
			Konsument = spawn(lab81,konsument,[]), 
			io:format("Odbieram produkt od producentai ~n"),
			Od ! {ok},
			io:format("Przekazuje produkt konsumentowi ~n"),
			Konsument ! {random,self(),Num},
			posrednik();
		{ok} ->
			io:format("Konsument otrzymał produkt ~n"),
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

producent2([Panel]) ->
	receive
		{create,Posr} -> 
			Panel ! {"producent","Zaczynam produkcje ~n"},Posr ! {random, self(), rand:uniform(100)},producent2([Panel]);
		{ok} ->
			 Panel ! {"producent", "Konsument odebrał produkt ~n"};
		{stop} ->
			Panel ! {"producent","Producent konczy prace ~n"};
		_ ->
			 producent2([Panel])
	end.

posrednik2([Panel]) ->
	receive 
		{random,Od,Num} ->
			Konsument = spawn(lab81,konsument2,[Panel]), 
			Panel ! {"posrednik","Odbieram produkt od producentai ~n"},
			Od ! {ok},
			Panel ! {"posrednik","Przekazuje produkt konsumentowi"},
			Konsument ! {random,self(),Num},
			posrednik2([Panel]);
		{ok} ->
			Panel ! {"posrednik","Konsument otrzymał produkt ~n"},
			posrednik2([Panel]);
		{stop} ->
			Panel ! {"posrednik","Pośrednik kończy prace ~n"};
		_ ->
			posrednik2([Panel])
	end.

konsument2([Panel]) ->
	receive
		{random,Od,Num} ->
			Panel ! {"konsument","Konsumuje produkt ~n"},
			Od ! {ok}
	end.

print({printxy,X,Y,Msg}) ->
   io:format("\e[~p;~pH~p",[Y,X,Msg]);
print({clear}) ->
   io:format("\e[2J",[]);
print({tlo}) ->
  print({printxy,2,4,1.2343}),
  io:format("",[])  .

printxy({X,Y,Msg}) ->
   io:format("\e[~p;~pH~p~n",[Y,X,Msg]).
printTest()->
  print({clear}),
  print({printxy,1,20, "Ada"}),
  print({printxy,10,20, 2012}),

  print({tlo}),
  print({gotoxy,1,25}).

panel(Offset) ->
	receive
		{producent,Msg} ->
			printxy ! (1,Offset,Msg),
			panel(Offset+1);
		{posrednik,Msg} ->
			printxy(10,Offset,Msg),
			panel(Offset+1);
		{konsument,Msg} ->
			printxy(20,Offset,Msg),
			panel(Offset+1);
		_ ->
			panel(Offset)
	end.
start() ->
	PID0 = spawn(lab81,panel,[0]),
	PID1 = spawn(lab81,producent2,[PID0]),
	PID2 = spawn(lab81,posrednik2,[PID0]),
	PID1 ! {create,PID2},
	PID1 ! {create,PID2},
	PID1 ! {create,PID2},
	PID1 ! {create,PID2},
	register(producent,PID1),
	register(posrednik,PID2).
