-module(lab2).
-compile([export_all]).

map_append(Key, Value, Map) ->
    Map#{ Key => Value }.

map_update(Key, Value, Map) ->
    Map#{ Key := Value}.

map_elem_display(Key,Value) -> io:fwrite("~s ===> ~w~n",[Key,Value]).

map_display(Map) -> maps:map(fun map_elem_display/2,Map),ok.

m_update({Key,Value},Acc) ->
	case maps:is_key(Key,Acc) of
	true -> List = maps:get(Key,Acc),maps:update(Key,[Value|List],Acc);
	_ -> maps:put(Key,[Value],Acc) end.

list_group(List) -> 
	maps:to_list(lists:foldl(fun(Elem,Acc) -> m_update(Elem,Acc) end,#{},List)).  	
	 
m2_update(Key,Acc) ->
	case maps:is_key(Key,Acc) of
	true -> Length = maps:get(Key,Acc),maps:update(Key,Length + 1,Acc);
	_ -> maps:put(Key,1,Acc) end.

list_group2(List) -> 
	lists:foldl(fun(Elem,Acc) -> m2_update(Elem,Acc) end,#{},List).  	

%display_helper(K,V,Acc) -> lists:concat(Acc, K, " => ", V, "\n").
%map_display(Map) -> maps:fold(display_helper,"",Map).

func(Path) -> 
	{ok,BinFile} = file:read_file(Path),
	BinText = binary:split(BinFile,[<<" ">>,<<"\n">>,<<".">>], [global]),
	Text = lists:filter(fun(X) -> X /= "" end,lists:map(fun(X) -> binary:bin_to_list(X) end,BinText)),	
	list_group2(Text).

func_alt(Path) -> 	
	{ok,BinFile} = file:read_file(Path),
	BinText = binary:split(BinFile,[<<" ">>,<<"\n">>,<<".">>], [global]),
	Text = lists:filter(fun(X) -> X /= "" end,lists:map(fun(X) -> binary:bin_to_list(X) end,BinText)),	
	TextGrouped = list_group(lists:map(fun(X) -> {X,1} end,Text)),
	ReadyToBeMap = lists:map(fun({Key,List}) -> {Key,lists:foldl(fun(X,Acc) -> X+Acc end,0,List)}end,TextGrouped),
	maps:from_list(ReadyToBeMap).
