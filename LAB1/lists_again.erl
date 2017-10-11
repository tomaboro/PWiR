-module(lists_again).
-compile([export_all]).

%Długość listy
len_helper([],Length) -> Length;
len_helper([_|T],TmpLength) -> len_helper(T,TmpLength+1).

len([]) -> 0;
len(L) -> len_helper(L,0).

%Min max
amin_helper([],Min) -> Min;
amin_helper([H|T],TmpMin) -> 
	if 
		H < TmpMin -> amin_helper(T,H);
		true -> amin_helper(T,TmpMin)
	end.

amin([]) -> 0;
amin([H|T]) -> amin_helper(T,H).	

amax_helper([],Max) -> Max;
amax_helper([H|T],TmpMax) -> 
	if 
		H > TmpMax -> amax_helper(T,H);
		true -> amax_helper(T,TmpMax)
	end.

amax([]) -> 0;
amax([H|T]) -> amax_helper(T,H).

tmin_max(L) -> {amin(L),amax(L)}.

tmin_max_alt_helper([]) -> {0,0};
tmin_max_alt_helper([H|T],{Min,Max}) -> 
	if(H < 


tmin_max_alt([H|T]) -> tmin_max_alt_helper(T,{H,H}).

tmax_min(L) -> {amax(L),amin(L)}.

%Pola z listy elementów
compute_fields([]) -> [];
compute_fields([H|T]) -> [powrot_do_liceum:pole(H)|compute_fields(T)].

%Konwerter temperatur
convert({celcius,Temp},kelvin) -> {kelvin,Temp*10};
convert({celcius,Temp},farenheit) -> {farenheit,Temp*15};
convert({kelvin,Temp},celcius) -> {kelvin,Temp*0.1};
convert({farenheit,Temp},celcius) -> {farenheit,Temp*0.15};
convert({farenheit,Temp},kelvin) -> {kelvin,Temp*0.66};
convert({kelvin,Temp},farenheit) -> {kelvin,Temp*1.5};
convert({_,_},_) -> {cannot,convert}.

%Lista malejąca
gen_list_down(0) -> [];
gen_list_down(N) -> [N|gen_list_down(N-1)].

%Generator listy o zadanej dlugosci
gen_ones_list(0) -> [];
gen_ones_list(N) -> [1|gen_ones_list(N-1)].

gen_list(0,_) -> [];
gen_list(N,Elem) -> [Elem|gen_list(N-1,Elem)].
