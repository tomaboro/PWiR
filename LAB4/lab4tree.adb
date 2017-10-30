with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;

procedure lab4tree is

type Element is
	record
		Data: Integer := 0;
		Left: access Element := Null;
		Right: access Element := Null;
	end record;

type Elem_Ptr is access all Element;

procedure Print(Tree: access Element) is
	procedure Helper(Tree: access Element) is
		currElem: access Element := Tree;
	begin
		if currElem = Null then
			Put("EMPTY");
		else
			Ada.Integer_Text_IO.Put(currElem.Data,4);
			Put(" Left{ ");
			Helper(currElem.Left);
			Put(" } Right { ");
			Helper(currElem.Right);
			Put(" }"); 		
		end if;
	end Helper;
begin
	Helper(Tree);
	Put_Line("");
end Print;

procedure Insert(Elem:in Integer; Tree: in out Elem_Ptr) is
begin
	if Tree = Null then
		Tree := new Element'(Elem,Null,Null);
	elsif Elem < Tree.Data then
		Insert(Elem,Tree.Left);
	else
		Insert(Elem,Tree.Right);
	end if;
end Insert;

function Search(Elem: in Integer; Tree: in out Elem_Ptr) return Boolean is
begin
	if Tree = Null then
		return false;
	elsif Tree.Data = Elem then
		return true;
	elsif Elem < Tree.Data then
		return Search(Elem,Tree.Left);
	else
		return Search(Elem,Tree.Right);
	end if;
end Search;

procedure Delete_Elem(Elem: in Integer; Tree: in out Elem_Ptr) is
	tmp: Elem_Ptr := Null;
	procedure Delete_Elem_Inn(Elem: in Integer; Tree: in out Elem_Ptr; Parent: in out Elem_Ptr) is
		function Minimum(Tree: in out Elem_Ptr) return Integer is
		ret: Integer;
		begin
			if Tree.Left.Left /= Null then
				return Minimum(Tree.Left);
			elsif Tree.Left.Left = Null then
				ret := Tree.Left.Data;
				if Tree.Left.Right /= Null then
					--Free(Tree.Left);
					Tree.Left := Tree.Left.Right;
				else
					--Free(Tree.Left);
					Tree.Left := Null;
				end if;
				return ret;
			end if;
		return -9999;
		end Minimum;

	begin
		if Tree /= Null then
			if Elem = Tree.Data then
				if Parent = Null then
					if Tree.Right = Null then
						--Free(Tree);
						Tree := Tree.Left;
					else
						if Tree.Right.Left = Null and Tree.Right.Right = Null then
							Tree.Data := Tree.Right.Data;
							--Free(Tree.Right.Data);
							Tree.Right := Null;
						elsif Tree.Right.Left = Null and Tree.Right.Right /= Null then
							Tree.Data := Tree.Right.Data;
							--Free(Tree.Right);
							Tree.Right := Tree.Right.Right;
						else
							Tree.Data := Minimum(Tree.Right);
						end if;
					end if;
				elsif Tree.Left = Null and Tree.Right = Null then 
					if Elem < Parent.Data then 
						Parent.Left := Null;
					else
						Parent.Right := Null;
					end if;
				elsif Tree.Left = Null and Tree.Right /= Null then
					--Free(Tree);
					Tree := Tree.Right;
				elsif Tree.Right = Null and Tree.Left /= Null then
					--Free(Tree);
					Tree := Tree.Left;
				elsif Tree.Right /= Null and Tree.Left /= Null then
					if Tree.Right.Left = Null and Tree.Right.Right = Null then
						Tree.Data := Tree.Right.Data;
						--Free(Tree.Right);
						Tree.Right := Null;
					elsif Tree.Right.Left = Null and Tree.Right.Right /= Null then
						Tree.Data := Tree.Right.Data;
						--Free(Tree.Right);
						Tree.Right := Tree.Right.Right;
					else
						Tree.Data := Minimum(Tree.Right);
					end if;
				end if;
			elsif Elem <  Tree.Data then
				Delete_Elem_Inn(Elem,Tree.Left,Tree);
			else
				Delete_Elem_Inn(Elem,Tree.Right,Tree);
			end if;
		end if;
	end Delete_Elem_Inn;

	StartRoot: Elem_Ptr := Null;
begin
	Delete_Elem_Inn(Elem,Tree,StartRoot);
end Delete_Elem; 

BST: Elem_Ptr := Null;
Root: Elem_Ptr := Null;
begin
	Print(BST);
	Insert(50,BST);
	Print(BST);
	Insert(75,BST);
	Print(BST);
	Insert(25,BST);
	Print(BST);
	Insert(10,BST);
	Insert(45,BST);
	Insert(30,BST);
	Print(BST);
	Delete_Elem(50,BST);
	Print(BST);
end lab4tree;
