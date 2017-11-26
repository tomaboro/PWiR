generic 
    Rozmiar: Natural;
package semafor is

task type SemaforLiczbowy2 is
	entry Czekaj;
	entry Sygnal;
end SemaforLiczbowy2;

protected SemaforLiczbowy is
	entry Czekaj;
	procedure Sygnal;
	private
		Sema: Integer := Rozmiar;
end SemaforLiczbowy;

end semafor;
