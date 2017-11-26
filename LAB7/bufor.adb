with Ada.Text_IO;
use Ada.Text_IO;

package body bufor is

protected body NBuf is
	entry Wstaw(Ch: in Typ_Elementu)
		when (CurrWst mod 10) /= (CurrPob mod 10)  is
	begin
		Bufo(CurrWst mod 10) := Ch;
		CurrWst := CurrWst+1;
	end Wstaw;
	
	entry Pobierz(Ch: out Typ_Elementu)
		when CurrPob+1 < CurrWst is
	begin
		Ch := Bufo(CurrPob+1 mod 10);
		CurrPob := CurrPob + 1;
	end Pobierz;
end NBuf;

end bufor;

