with Ada.Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;

procedure lab6 is

task Zadanie_1A is
	entry Start;
	entry Losuj(Num: in out Float);
	entry Koniec;
end Zadanie_1A;

task body Zadanie_1A is
G: Generator;
begin
	accept Start;
	Put_Line("Zaczynam zadanie A");
	loop 
		select 
			accept Koniec;
				Put_Line("Kończę A");
				exit;
		or
			accept Losuj(Num: in out Float) do
				Reset(G);
				Num := Random(G);
			end Losuj;
			Put_Line("Wylosowano");
		end select;
	end loop;
end Zadanie_1A;

task type Zadanie_tmp is
	entry Print;
end Zadanie_tmp;

task body Zadanie_tmp is
begin
	accept Print do
		Put_Line("Zaczynam działanie");
		delay 5.0;
		Put_Line("Kończę działanie");
	end Print;
end Zadanie_tmp;

task type Zadanie_Semafor is
	entry Start;
	entry Lock;
	entry Quit;
end Zadanie_Semafor;

task body Zadanie_Semafor is 
semafor: Boolean := true;
begin
	accept Start;
	loop
		select
			accept Quit;
				exit;
 		or
			when semafor => accept Lock do
				Put_Line("Blokuję semafor");
				semafor := false;
				--Zadanie_tmp.Print;
			end Lock;
			Put_Line("Odblokowywuję semafor");
			semafor := true;
		end select;
	end loop;
end Zadanie_Semafor;

X,Y,Z: Float;
begin
--	Zadanie_Semafor.Lock;
--	Zadanie_Semafor.Lock;
--	Zadanie_Semafor.Lock;
--	Zadanie_1A.Start;
--	Zadanie_1A.Koniec;
	Put_Line("Trololo");
	Zadanie_1A.Start;
	Zadanie_1A.Koniec;
	Put_Line("Lolololo");
end lab6;
