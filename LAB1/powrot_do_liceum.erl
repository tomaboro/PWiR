-module(powrot_do_liceum).
-export([pole/1]).

pole({kwadrat,X,Y}) ->  X*Y;

pole({kolo,X}) -> 3.14*X*X;

pole({trojkat,Podstawa,Wysokosc}) ->
	(Podstawa*Wysokosc)/2;

pole({trapez,A,B,H}) -> 
	((A+B)*H)/2.
