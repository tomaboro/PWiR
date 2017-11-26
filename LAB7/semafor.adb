with Ada.Text_IO;
use Ada.Text_IO;

package body semafor is

task body SemaforLiczbowy2 is
Sema: Integer;
begin
	Sema := Rozmiar;
	loop
		select
			when Sema > 0 =>
				accept Czekaj do
					Put_Line(Sema'Img);
					Sema := Sema-1;
				end Czekaj;
		or
			accept Sygnal;
			Sema := Sema+1;
		end select; 
	end loop;
end SemaforLiczbowy2;

protected body SemaforLiczbowy is
	entry Czekaj
		when Sema > 0 is 
	begin
		Sema := Sema - 1;
	end Czekaj;

	procedure Sygnal is 
	begin
		Sema := Sema+1;
	end Sygnal;
end SemaforLiczbowy;

end semafor;
