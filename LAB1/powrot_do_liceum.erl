-module(powrot_do_liceum).
-export([pole/1]).

pole({kwadrat,X,Y}) ->  X*Y;

pole({kolo,X}) -> 3.14*X*X;

pole({trojkat,Podstawa,Wysokosc}) ->
	(Podstawa*Wysokosc)/2;

pole({trapez,A,B,H}) -> 
	((A+B)*H)/2;
	
pole({szescian,A}) ->
	(A*A*A);
	
pole({kula,R}) -> 
	4*3.14*R*R;

pole({stozek,R,L}) ->
	3.14*R*(R+L).
	
objetosc({stozek,R,H}) ->
	(1/3)*3.14*R*R*H;

objetosc({kula,R}) ->
	(4/3)*3.14*R*R*R;
	
objetosc({szescian,A}) ->
	A*A*A.
