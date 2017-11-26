package lab7tests is

	task type Producent is
		entry Start;
		entry Stop;
	end Producent;

	task type Konsument is
		entry Start;
		entry Stop;
	end Konsument;

	task type UzytkownikSemafora is
		entry UzyjSemafora;
	end UzytkownikSemafora;

	task type UzytkownikSemafora2 is
		entry UzyjSemafora;
	end UzytkownikSemafora2;

	procedure Producent_Konsument_Test;
	procedure Semafor_Test;
	procedure Semafor_Test2;
end lab7tests;
