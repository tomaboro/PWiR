with Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar, Ada.Sequential_IO, pak3;
use Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar, pak3;
 
procedure lab3 is

begin
	T1 := Clock;
	Init_Random_Wektor(W1);		
	T2 := Clock;
	D := T2 - T1;
	Put_Line("Czas inicjalizacji wektora 100 elementowego = " & D'Img & "[s]");

	T1 := Clock;
	Quick_Sort(W1);		
	T2 := Clock;
	D := T2 - T1;
	Put_Line("Czas sortowania wektora 100 elementowego = " & D'Img & "[s]");


	T1 := Clock;
	Save_Wektor(W1,"W1_SAVE");		
	T2 := Clock;
	D := T2 - T1;
	Put_Line("Czas zapisu do pliku wektora 100 elementowego = " & D'Img & "[s]");


end lab3;
