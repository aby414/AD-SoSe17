%% @author aby414
%% @doc Entwurfsbeschreibung: ADP1_Entwurf2_Agin Punneliparambil_Hendrik_Seemann


-module(btree).
-export([initBT/0,isBT/1,insertBT/2,equalBT/2,isEmptyBT/1]).

%% Ein leerer Baum wird erzeugt.
initBT() -> {}.

%----------------------------------------------------------------------------------

%% Testet, ob ein uebergebener Baum ein BT ist.
isBT({}) -> true; 
isBT({W,H,L,R}) when is_number(W) and is_number(H) -> Bool = checkHeight(H,L,R),
													  {_Min,Max} = getMinMax({W,H,L,R}), 
	if 
		 Max == null -> false;
		 Bool == false -> false;
		 true -> true					
	end;
isBT(_) -> false.

getMinMax({W,H,{},{}}) when is_number(H) and is_number(W)->{W,W};
getMinMax({W,H,L,{}}) when is_number(H) and is_number(W) -> {Min,Max} = getMinMax(L),
										   Bool = checkHeight(H, L,{}),
	if 
		Bool == false -> {null,null};
		(Max /= null) and (Max < W) -> {Min,W};
		true -> {null,null}
	end;

getMinMax({W,H,{},R}) when is_number(H)  and is_number(W) -> {Min,Max} = getMinMax(R),
										   					 Bool = checkHeight(H,{},R),
	if
		Bool == false -> {null,null};
		(Min /= null) and (Min > W) -> {W,Max};
		true -> {null,null}
	end;

getMinMax({W,H,L,R})  when is_number(H) and is_number(W)-> {LMin,LMax} = getMinMax(L),
										{RMin,RMax} = getMinMax(R),
										  Bool = checkHeight(H, L,R),
	if
		Bool == false -> {null,null};
		(LMax /= null) and (RMin /= null) and (LMax < W) and (RMin > W) -> {LMin,RMax};
		true -> {null, null}
	end;

getMinMax(_) -> {null,null}.



%% Ueberprueft, ob die Hoehe der Wurzel stimmt.
checkHeight(H,L,R) -> H - maxHeight(L, R) == 1.		 


%----------------------------------------------------------------------------------

%% insert mit Typueberpruefung.
insertBT(BT,Elem) ->
	case is_number(Elem) of
		true -> insert(BT,Elem);
		_Else -> BT
	end.

%% Fuegt ein Element in den Baum ein. Die Hoehe wird mittels der maximalen Hoehe der Kinderknoten 
%% plus der eigene Hoehe(+1) ermittelt.
insert({},Elem) -> {Elem,maxHeight({},{})+1,{},{}};
insert({W,H,L,R},Elem) -> 
	if
		Elem > W -> NewR = insert(R,Elem), {W,maxHeight(L, NewR)+1,L,NewR};
		Elem < W -> NewL = insert(L,Elem), {W,maxHeight(NewL, R)+1,NewL,R};
		true -> {W,H,L,R}
	end.

%% Ermittelt die Hoehe eines Baums.
getHeight({}) -> 0;
getHeight({_W,H,_L,_R}) -> H.

%% Ermittelt die groesste Hoehe der Kinderknoten.
maxHeight(L,R) -> Bool1 = getHeight(L) > getHeight(R), 
	if 
		Bool1 == true -> getHeight(L);
		true -> getHeight(R)
	end.

%----------------------------------------------------------------------------------

%% Ueberprueft ob der Baum leer ist.
isEmptyBT({}) -> true;
isEmptyBT(_) -> false.

%----------------------------------------------------------------------------------

%% Testet auf strukturelle Gleichheit.
equalBT(BT1,BT2) -> BT1 == BT2.




