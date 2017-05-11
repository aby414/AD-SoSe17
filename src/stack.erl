%% @author Agin
%% @doc Entwurfsbeschreibung: ADP1_Entwurf2_Agin Punneliparambil_Hendrik_Seemann


-module(stack).
-export([createS/0,push/2,pop/1,top/1,isEmptyS/1,equalS/2,reverseS/1]).
-import(liste,[create/0,laenge/1,insert/3,delete/2,retrieve/2,isEmpty/1]).

%% erzeugt einen leeren Stack.
createS() -> liste:create().

%----------------------------------------------------------------------------------

%% Fuegt ein Element in einen Stack ein.
push(St,Elem) -> liste:insert(St,1, Elem).

%----------------------------------------------------------------------------------

%% Loescht das oberste element eines Stacks.
pop(St) -> liste:delete(St,1).

%----------------------------------------------------------------------------------

%% Zeigt das oberste element des Stacks.
top(St) -> liste:retrieve(St, 1).

%----------------------------------------------------------------------------------

%% Ueberprueft ob ein Stack leer ist.
isEmptyS(St) -> liste:isEmpty(St).

%----------------------------------------------------------------------------------

%% Testet zwei Stacks auf strukturelle Gleichheit.
equalS(S1,S2) -> S1 == S2.

%----------------------------------------------------------------------------------

%% Dreht einen Stack um, der Stackboden wird zum Stackanfang.
reverseS(St) -> Bool = isEmpty(St), Length = liste:laenge(St),
				if 
					Bool == true -> St;    %Falls der Stack leer ist oder die Laenge 1 hat, wird der Stack unveraendert zurueckgegeben.
					Length == 1 -> St;		
					true -> H = liste:retrieve(St, 1), % Ansonsten wird ein neuer Stack erzeugt und alle Elemente, von oben beginnend,
							T = liste:delete(St, 1),	% in den neuen Stack gepusht.
							NewSt = liste:create(),
							NewStWithH = liste:insert(NewSt, 1, H),
							reverseS(T,NewStWithH)
				end.

reverseS(Rest,NewSt) -> Bool = isEmptyS(Rest),
				if 
					Bool == true -> NewSt;    		% Es werden Elemente in den neuen Stack gepusht bis der Stackboden ereicht wurde.
					true -> H = stack:top(Rest),	% Dann wird der neue Stack zurueckgegeben.
							T = stack:pop(Rest),
							Y = push(NewSt,H),
							reverseS(T,Y)
				end.




