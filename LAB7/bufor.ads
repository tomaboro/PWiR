generic 
    Rozmiar: Natural;
    type Typ_Elementu is digits <>;
package bufor is
	type TBuf is array(Integer range 1..Rozmiar) of Typ_Elementu;

protected NBuf is
	entry Wstaw(Ch: in Typ_Elementu);
	entry Pobierz(Ch: out Typ_Elementu);
	private 
		Bufo: TBuf;
		CurrWst: Integer := 1;
		CurrPob: Integer := 0;
end NBuf;
end bufor;
