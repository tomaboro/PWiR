with Ada.Text_IO, Ada.Numerics.Discrete_Random, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;

procedure lab6 is

task type Totalizator is
	entry Start;
	entry Losuj(Num: out Float);
	entry Koniec;
end Totalizator;

task body Totalizator is
G: Generator;
Rand: Float;
begin
	accept Start;
	loop 
		Reset(G);
		Rand := Random(G)*5.0 ;
		select 
			accept Koniec;
				exit;
		or
			accept Losuj(Num: out Float) do
				Num := Rand;
			end Losuj;
		end select;
	end loop;
end Totalizator;

type Kolory is (Czerowny,Niebieski,Zielony, Zolty, Magenta, Bialy, Czarny);
type DniTygodnia is (Poniedzialek, Wtorek, Sroda, Czwartek, Piatek, Sobota, Niedziela);
type Tablica6Elem is array (Integer range 1..6) of Float;

task type Totalizator2 is
	entry Start;
	entry Koniec;
	entry Losuj(Num: out Float);
	entry LosujKolor(Kolor: out Kolory);
	entry LosujDzien(Dzien: out DniTygodnia);
	entry Losuj6Elem(Tab: out Tablica6Elem);
end Totalizator2;

package Rand_Kolor is new Ada.Numerics.Discrete_Random(Kolory);
package Rand_Dzien is new Ada.Numerics.Discrete_Random(DniTygodnia);

task body Totalizator2 is
R1: Float;
R2: Kolory;
R3: DniTygodnia;
R4: Tablica6Elem;

G: Generator;
G2: Rand_Kolor.Generator;
G3: Rand_Dzien.Generator;
begin
	accept Start;
	R1 := Random(G)*5.0;
	R2 := Rand_Kolor.Random(G2);
	R3 := Rand_Dzien.Random(G3);
	For_Loop:
		for I in Integer range 1..6 loop
			R4(I) := Random(G)*50.0 - 1.0;
	end loop For_Loop;
	loop
		select
			accept Koniec;
			exit;
		or
			accept Losuj(Num: out Float) do
				Num:= R1;
			end Losuj;
			Reset(G);
			R1 := Random(G);
		or
			accept LosujKolor(Kolor: out Kolory) do
				Kolor := R2;
			end LosujKolor;
			Rand_Kolor.Reset(G2);
			R2 := Rand_Kolor.Random(G2);
		or
			accept LosujDzien(Dzien: out DniTygodnia) do
				Dzien := R3;
			end LosujDzien;
			Rand_Dzien.Reset(G3);
			R3 := Rand_Dzien.Random(G3);
		or
			accept Losuj6Elem(Tab: out Tablica6Elem) do
				For_Loop3:
				for I in Integer range 1..6 loop
					Tab(I) := R4(I);
				end loop For_Loop3;
			end Losuj6Elem;
			For_Loop2:
			for I in Integer range 1..6 loop
				Reset(G);
				R4(I) := Random(G)*50.0 - 1.0;
			end loop For_Loop2;
			Reset(G);
		end select;
	end loop;
end Totalizator2;

task type SemaforBinarny is
	entry Czekaj;
	entry Sygnal;
end SemaforBinarny;

task body SemaforBinarny is
locked: Boolean := false;
begin
	loop
		select
			when not locked =>
				accept Czekaj do
					locked := true;
				end Czekaj;
		or
			accept Sygnal;
			locked := false;
		end select;
	end loop;
end SemaforBinarny;

task type SortowanieScalanie is
	entry Start(StartWsk: in Integer; StopWsk: in Integer);
	entry Sortuj;
end SortowanieScalanie;

type Ptr is access SortowanieScalanie;

task body SortowanieScalanie is
Startt: Integer;
Stop: Integer;
Middle: Integer;
Z1 : Ptr;
Z2 : Ptr;
begin
	accept Start(StartWsk: in Integer; StopWsk: in Integer) do
		Startt := StartWsk;
		Stop := StopWsk;
	end Start;
	
	accept Sortuj;
		if Startt < Stop then
			Z1 := new SortowanieScalanie;
			Z2 := new SortowanieScalanie;
			Middle := Startt + (Stop-Startt)/2;
			Z1.Start(Startt,Middle);
			Z2.Start(Middle+1,Stop);
			Z1.Sortuj;
			Z2.Sortuj;
		end if;
end SortowanieScalanie;

begin
	Put_Line("1234");
end lab6;
