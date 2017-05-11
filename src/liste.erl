%% @author abw280
%% @doc Entwurfsbeschreibung: ADP1_Entwurf2_Agin Punneliparambil_Hendrik_Seemann


-module(liste).
-export([create/0,isEmpty/1,isList/1,retrieve/2,equal/2,laenge/1,find/2,insert/3,delete/2,concat/2,gerade/1,diffListe/2,isInList/2,eoCount/1]).

%% Erzeugt eine neue Liste
create() -> {}.

%----------------------------------------------------------------------------------

%% Ueberprueft, ob die Liste leer ist
isEmpty({}) -> true;
isEmpty(_) -> false.

%----------------------------------------------------------------------------------

%% Ueberprueft, ob ein uebergebener Parameter eine ADT-Liste ist.
isList({})-> true;
isList({_,Y})-> isList(Y);
isList(_) -> false.

%----------------------------------------------------------------------------------

%% Equal testet auf Strukturgleichheit
equal(L1,L2) -> L1 == L2.

%----------------------------------------------------------------------------------

%% Berechnet die Laenge der Liste
laenge({}) -> 0;      
laenge({_X,{}}) -> 1;
laenge({_H,T}) -> 1 + laenge(T).

%----------------------------------------------------------------------------------

%% Fuegt eine Element in einer Liste ein.
insert({},1,Elem) -> {Elem,{}};        				% Gueltige Eingabe in einer leeren Liste an erster Position.
insert({},_Pos,_Elem) ->{};			  				% Ungueltige Position in leerer List.
insert(List,1,Elem) ->  {Elem,List};				% Einfuegen an erster Position mit verschieben.
insert({H,T},Pos,Elem) ->{H,insert(T,Pos-1,Elem)}.	% Einfuegen in der Mitte oder am Ende.

%----------------------------------------------------------------------------------

%% Loescht ein Element an einer bestimmten Position
delete({},_Pos) -> {};
delete({H,{}},Pos) when Pos>1 -> {H,{}};
delete({_H,{}},1) -> {};
delete({_H,T},1)-> T;
delete({H,T},Pos) -> {H,delete(T, Pos-1)}.

%----------------------------------------------------------------------------------

%% Gibt die Position eines Elements in einer Liste zurueck.
find(List,Elem) -> find(List,Elem,0).
find({},_Elem,Acc) -> Acc;
find({Elem,_T},Elem,Acc) -> Acc+1;
find({_H,{}},_Elem,Acc) -> Acc-Acc;
find({_,T},Elem,Acc) -> find(T,Elem,Acc+1).

%----------------------------------------------------------------------------------

%% Findet das Element an einer bestimmten Position.
retrieve({},_Pos) ->{};
retrieve({H,_T},1) -> H;
retrieve({_H,T},Pos) -> retrieve(T,Pos-1).

%----------------------------------------------------------------------------------

%% Verkettet zwei Listen miteinander.
concat(L1,{}) -> L1;
concat({},L2) -> L2;
concat(L1,{H,{}}) -> S1 = laenge(L1)+1, insert(L1,S1,H);
concat(L1,{H,T}) -> S1 = laenge(L1)+1,L3 = insert(L1,S1,H),concat(L3,T).

%----------------------------------------------------------------------------------

%% erzeugt eine Liste mit unique Elementen.
diffListe({},L2) -> L2;
diffListe(L1,{}) -> L1;
diffListe(L1, L2) -> L = concat(L1, L2), deleteAll(L,{},{}).  % Beide Listen werdem konkateniert die "to_set" Funktion wird aufgerufen

%% Testet, ob das Element in der lIste ist.
isInList(L,Elem) ->Num = find(L, Elem),
	if 
		Num > 0 -> true;
		true -> false
	end.

%% Loescht alle Elemente die mehrfach vorkommen.
deleteAll({},_Marked,Unique) -> stack:reverseS(Unique);  %Liste ist unique und wird returned.
deleteAll({H,T}, Marked, Unique) ->  				% In Marked speichern wir die Elemente die wir schon kennen
	case isInList(Marked,H) of	
		true -> Pos = find(Unique,H), 
				deleteAll(T,Marked,delete(Unique, Pos));	% Wenn wir das Element kennen, wird es aus Unique geloescht.
		false -> deleteAll(T,insert(Marked,1,H), insert(Unique, 1, H)) % Ansonsten markieren wir es und fuegen es in die Unique liste ein.
	end.

%----------------------------------------------------------------------------------

%% Testet, ob eine Liste eine gerade Laenge hat.
gerade({}) -> true;
gerade(List) -> X = laenge(List), Y = 2, 
   				Res = X rem Y,
				Res == 0.

%% eoCount/1 ruft eoCount/2 mit Akkumulator auf.
eoCount(List) -> eoCount(List,[0,0]).

%% Wir iterieren ueber die Liste. Wenn die Liste gerade ist, wird der Even-Zaehler inkrementiert,
%% ansonsten der Odd-Zaehler.
eoCount(List,[E,O]) -> Bool1 = gerade(List),
	if 
		Bool1 == true -> [G,U]= iterieren(List,[E,O]), [E+1+G,O+U];  
		true -> [G,U ]= iterieren(List,[E,O]), [E+G,O+U+1]
	end.

%% Mit iterieren, laufen wir ueber die aktuelle Liste
%% und rufen eoCount erneut auf dem ersten element dieser Liste auf,
%% falls dieses eine Liste ist.
%% Ansonsten iterieren wir ueber die restliche Liste.
iterieren({},Acc)-> Acc;
iterieren({H,T},[E,O]) -> Bool1 = isList(H),
	if 
		Bool1 == true -> [G,U] = eoCount(H,[E,O]),
						 [X,Y] = iterieren(T,[E,O]),
						 [E+G+X,O+U+Y];
		true -> iterieren(T,[E,O])
	end.
		
						 






