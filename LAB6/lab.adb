with Ada.Text_IO;
use Ada.Text_IO;

procedure lab is

task Zadanie_1A is
	entry Start(Num: in out Integer);
	entry Koniec;
end Zadanie_1A;

task body Zadanie_1A is
begin
	loop
		select
			accept Koniec;
				exit;
		or
			accept Start(Num: in out Integer) do
				Num := 5;
				Put_Line("Losuje");
				Zadanie_1A.Start(Num);
			end Start;
		end select;
	end loop;
end Zadanie_1A;

Something: Integer;
begin
	Zadanie_1A.Start(Something);
	delay 5.0;
	Zadanie_1A.Koniec;
end lab;
