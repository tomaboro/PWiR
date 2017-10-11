%% -*- coding: utf-8 -*-
-module(example).
% nazwa modułu

-compile([export_all]).
% opcje kompilatora, w tym wypadku eksport wszystkich funkcji
% przydatne przy testowaniu
%
%-export([add/2, head/1, sum/1] ).
% lista funkcji jakie będą widoczne dla innych modułów

-vsn(1.0).
% wersja

-kto_jest_najlepszy(ja).
%dowolny atom możę być wykorzystany jako 'atrybut' modułu
%po kompilacji uruchom lab1:module_info().
%inne narzędzia mogą korzystać z tych informacji


-import(math,[pi/0]).
% lista modułów ,które są potrzebne.
% nie jest to konieczne


%funkcje

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
add(A1,A2) -> A1+A2.

%################################

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
head([H|_]) -> {glowa,H}.
%################################

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sum([]) -> 0;
sum([H|T]) -> H + sum(T).
%################################

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tsum(L) -> tsum(L, 0). %tsum/1

tsum([H|T], S) -> tsum(T, S+H); %tsum/2 
tsum([],S) -> S.
% klauzule funkcji rozdzielana są średnikiem
% po ostatniej jst kropka
%################################


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
obwod_kola(Promien) -> 
        Dwa_pi = 2 * pi(),  % wyrażenie pomocnicze
        Dwa_pi * Promien.   % ostatni element przed '.' lib ';' 
                            % to wynik funkcji
%################################


