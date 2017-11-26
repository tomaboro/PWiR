with Ada.Text_IO, Ada.Numerics.Float_Random,bufor,semafor;
use Ada.Text_IO, Ada.Numerics.Float_Random;

package body lab7tests is

package packageBuf is new bufor(10,Float);
package sem is new semafor(2);

task body Producent is
G: Generator;
Tmp: Float;
begin
	accept Start;
	Put_Line("Producent rodzi się.");
	loop
		select
			accept Stop;
			Put_Line("Producent umiera");
			exit;
		else
			Reset(G);
			Tmp := Random(G);
			Put_Line("Produkuje: " & Tmp'Img);
			packageBuf.NBuf.Wstaw(Tmp);
			delay 1.0;
		end select;
	end loop;
end Producent;

task body Konsument is
Tmp: Float;
begin
	accept Start;
	Put_Line("Konsument rodzi się.");
	loop
		select
			accept Stop;
			Put_Line("Konsument umiera");
			exit;
		else
			packageBuf.NBuf.Pobierz(Tmp);
			Put_Line("Zjadam: " & Tmp'Img);
		end select;
	end loop;
end Konsument;

task body UzytkownikSemafora is
begin
	accept UzyjSemafora;
	Put_Line("Probuje dostac sie do semafora");
	sem.SemaforLiczbowy.Czekaj;
	Put_Line("Rozpoczynam operacje na semaforze");
	delay 5.0;
	Put_Line("Koncze operacje na semaforze");
	sem.SemaforLiczbowy.Sygnal;
end UzytkownikSemafora;

SemaforLiczbowyTmp: sem.SemaforLiczbowy2;

task body UzytkownikSemafora2 is
begin
	accept UzyjSemafora;
	Put_Line("Probuje dostac sie do semafora");
	sem.SemaforLiczbowy.Czekaj;
	Put_Line("Rozpoczynam operacje na semaforze");
	delay 5.0;
	Put_Line("Koncze operacje na semaforze");
	sem.SemaforLiczbowy.Sygnal;
end UzytkownikSemafora2;

procedure Producent_Konsument_Test is
Producent1: Producent;
Konsument1: Konsument;
begin
	Producent1.Start;

	delay 3.0;

	Konsument1.Start;

	delay 10.0;

	Producent1.Stop;
	Konsument1.Stop;
end Producent_Konsument_Test;

procedure Semafor_Test is 
U1 :UzytkownikSemafora;
U2 :UzytkownikSemafora;
U3 :UzytkownikSemafora;
begin
	U1.UzyjSemafora;
	U2.UzyjSemafora;
	U3.UzyjSemafora;
end Semafor_Test;

procedure Semafor_Test2 is 
U1 :UzytkownikSemafora2;
U2 :UzytkownikSemafora2;
U3 :UzytkownikSemafora2;
begin
	U1.UzyjSemafora;
	U2.UzyjSemafora;
	U3.UzyjSemafora;
end Semafor_Test2;

end lab7tests;
