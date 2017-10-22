package body pak3 is
	
	procedure Print_Wektor(W: Wektor) is
	begin
		Put_Line("####");	
		for I in 1..W'Length loop
  			Put_Line(W(I)'Img); 
		end loop;
		Put_Line("####");
	end Print_Wektor;

	procedure Init_Random_Wektor(W: in out Wektor) is
	G: Generator;
	begin
		for I in 1..W'Length loop
	  		W(I) := Random(G);
		end loop;
	end Init_Random_Wektor;

	function Check_Sort(W: Wektor) return Boolean is 
		(for all I in W'First..(W'Last-1) => W(I) >= W(I+1)); 


	procedure Quick_Sort(W: in out Wektor) is	

		procedure Swap(Index: Integer; Dest: Integer) is
		Tmp: Float := W(Index);
		begin
			W(Index) := W(Dest);
			W(Dest) := Tmp;
		end Swap;
		
		function Split_Wektor(L: Integer; R: Integer) return Integer is 
		splitIndex: Integer := 	((R-L)/2)+L;
		splitValue: Float := W(splitIndex);
		currPos: Integer := L; 
		begin
			Swap(splitIndex,R);
			for I in L..R-1 loop
				if W(I) < splitValue then
					Swap(I,currPos);
					currPos := currPos + 1;
				end if;
			end loop;
			Swap(currPos,R);
			return currPos;
		end Split_Wektor;	

		procedure Quick(L: Integer; R: Integer) is
		I: Integer;
		begin
			if L < R then
				I := Split_Wektor(L,R);
				Quick(L,I-1);
				Quick(I+1,R);
			end if;	
		end Quick;			
	
	
	begin
	
		Quick(1,W'Length);	
	end Quick_Sort;

	procedure Save_Wektor(W: Wektor; File_Name: String) is 
	Log: FSIO.FILE_TYPE;
	begin
		FSIO.Create(Log, FSIO.Out_File, File_Name);
		for I in 1..W'Length loop
			FSIO.Write(Log,W(I));
		end loop;
		FSIO.Close(Log);
	end Save_Wektor;

end pak3;
