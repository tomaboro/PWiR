-module(lab5).
-compile([export_all]).

add_to_tree(Value,Tree) -> 
	case Tree of
		{node,V,L,R} ->
			if Value < V ->
				{node,V,add_to_tree(Value,L),R};
			true ->
				{node,V,L,add_to_tree(Value,R)}
			end;
		{null} ->
			{node,Value,{null},{null}}
	end.

generate_random_tree(0,Tree) -> Tree;
generate_random_tree(Size,Tree) -> generate_random_tree(Size-1,add_to_tree(rand:uniform(1000),Tree)).
generate_random_tree(Size) -> generate_random_tree(Size,{null}).

tree_from_list(List) -> lists:foldl(fun(Value,Tree) -> add_to_tree(Value,Tree) end, {null}, List).

tree_to_list(Tree) ->
	case Tree of
		{node,V,L,R} ->
			lists:append([tree_to_list(L),[V],tree_to_list(R)]);
		{null} ->
			[]
	end.

	
tree_to_list2(Tree) ->
	case Tree of
		{node,V,L,R} ->
			lists:append([[V],tree_to_list2(L),tree_to_list2(R)]);
		{null} ->
			[]
	end.

	
tree_to_list3(Tree) ->
	case Tree of
		{node,V,L,R} ->
			lists:append([tree_to_list3(L),tree_to_list3(R),[V]]);
		{null} ->
			[]
	end.

search_tree({null},_Value) -> false;
search_tree({node,V,L,R},Value) ->
	if 
		Value == V -> true;
		Value < V -> search_tree(L,Value);
		true -> search_tree(R,Value)
	end.
	
search_tree2(Tree,Value) -> catch search_tree2_(Tree,Value).
search_tree2_({null},_Value) -> throw(false);
search_tree2_({node,V,L,R},Value) ->
	if 
		Value == V -> throw(true);
		Value < V -> search_tree(L,Value);
		true -> search_tree(R,Value)
	end.
