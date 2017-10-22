with Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar, Ada.Sequential_IO;
use Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar;

package pak3 is
	type Wektor is array (Integer range <>) of Float;

	W1: Wektor(1..100) := (1.0,5.9,3.4,7.8,1.3, others => 11.78);
	
	T1, T2: Time;
	D: Duration;

	package  FSIO is new Ada.Sequential_IO (Float);	
	
	procedure Print_Wektor(W: Wektor);
	procedure Init_Random_Wektor(W: in out Wektor);
	function Check_Sort(W: Wektor) return Boolean;
	procedure Quick_Sort(W: in out Wektor);
	procedure Save_Wektor(W: Wektor; File_Name: String);

end pak3;
