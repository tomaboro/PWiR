with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Float_Random;

procedure lab4list is

type Element is
	record
		Data : Integer := 0;
		Next : access Element := Null;
	end record;

type Elem_Ptr is access all Element;

procedure Print(List : access Element) is
	L : access Element := List;
begin
	if List = Null then
		Put_Line("List EMPTY!");
	else
		Put_Line("List:");
  	end if;
	while L /= Null loop
 		Put(L.Data, 4); -- z pakietu Ada.Integer_Text_IO
		New_Line;
		L := L.Next;
	end loop;
end Print;

procedure Insert(List : in out Elem_Ptr; D : in Integer) is
	E : Elem_Ptr := new Element;
begin
	E.Data := D;
	E.Next := List;
	-- lub E.all := (D, List);
	List := E;
end Insert;

-- wstawianie jako funkcja - wersja krótka
function Insert(List : access Element; D : in Integer) return access Element is ( new Element'(D,List) );

-- do napisania !!
procedure Insert_Sort(List : in out Elem_Ptr; D : in Integer) is
begin
	if List.Data > D then
		Insert(List,D);
	elsif List.Next = Null then
		List.Next := new Element'(D,Null);
	else
		Insert_Sort(List.Next,D);
	end if;
null;
end Insert_Sort;

procedure Generate_Random_List(Length: in Integer;  MyRange: in Integer; Lista: in out Elem_Ptr) is
	G: Generator;	
begin
	if Length > 0 then
		Reset(G);	
		Insert_Sort(Lista,Integer(Float(MyRange)*Random(G)));
		Generate_Random_List(Length-1, MyRange, Lista);
	end if;
end Generate_Random_List;

procedure Delete_Elem(Index: in Integer; Lista: in out Elem_Ptr) is
	currElem:  Elem_Ptr := Lista;
	Tmp: Elem_Ptr := Null;
begin
	for I in 1..Index-2 loop
		if currElem /= Null then
			Tmp := currElem;
			--Free(Tmp);
			currElem := currElem.Next;
		end if;
	end loop;
	if currElem /= Null then
		if currElem.Next /= Null then
			currElem.Next := currElem.Next.Next;
		else
			currElem.Next := Null;
		end if;
	end if;
end Delete_Elem;

procedure Delete_Elem2(Elem: Integer; Lista: in out Elem_Ptr) is
begin
	if Lista /= Null then	
		if Lista.data = Elem then
			Lista := Lista.Next;
		else
			Delete_Elem2(Elem,Lista.Next);
		end if;
	end if;
end Delete_Elem2;

function Search(Elem: in Integer; List: in Elem_Ptr) return Boolean is
begin
	if List = Null then 
		return false;
	elsif List.Data = Elem then
		return true;
	else 
		return Search(Elem,List.Next);
	end if;
end Search;

function Sito(MyRange: in Integer) return Elem_Ptr is
	Lista: Elem_Ptr := Null;
	Tail: Elem_Ptr := Null;
begin
	for I in reverse 1..MyRange loop
		Insert(Lista,I);
	end loop;
	
	Tail := Lista.Next;

	while Tail /= Null loop
		for I in 1..MyRange loop
			Delete_Elem2(Tail.Data+I*Tail.Data,Lista);
		end loop;
	Tail := Tail.Next;
	end loop;
	
	return Lista;
end Sito;

Lista : Elem_Ptr := Null;

begin
	Print(Lista);
	for I in reverse 1..10 loop
	Insert(Lista, I);
 	end loop;
	Print(Lista);
	Insert_Sort(Lista,8);
	Insert_Sort(Lista,7);
	Print(Lista);
	Generate_Random_List(5,20,Lista);
	Print(Lista);
	Delete_Elem(5,Lista);
	Print(Lista);

	Print(Sito(10));
end lab4list;
