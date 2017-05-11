%% @author Agin
%% @doc Entwurfsbeschreibung: ADP1_Entwurf2_Agin Punneliparambil_Hendrik_Seemann


-module(schlange).
-export([createQ/0,enqueue/2,dequeue/1,front/1,isEmptyQ/1,equalQ/2]).
-import(stack,[createS/0,push/2,pop/1,reverseS/1]).


%% Erzeugt eine leere Queue.
createQ() -> {stack:createS(),stack:createS()}.

%----------------------------------------------------------------------------------

%% Elemente koennen in die Schlange eingereiht werden.
enqueue({In,Out},Elem) ->  Y = stack:push(In, Elem), {Y,Out}.

%----------------------------------------------------------------------------------

%% Das vorderste Element der Schlange wird entnommen. Es wird die veraenderete Schlange zurueckgegeben.
%% dequeue({In,Out}) -> Bool1 = isEmptyQ({In,Out}), Bool2 = stack:isEmptyS(Out),
%% 	if 
%% 		Bool1 == true -> {stack:createS(),stack:createS()};  % leerer Stack: Schlange varaendert sich nicht.
%% 		Bool2 == true -> RSt = stack:reverseS(In), 			 % Out-Stack leer: In-Stack wird auf den Out-Stack umgestapelt 		
%% 						NewOut = stack:pop(RSt),				% und das oberste Element wir entnommen.
%% 						{{},NewOut};
%% 		true -> NewOut = stack:pop(Out), 					% Wenn beide Stacks belegt sind, wird vom Out_stack das oberste Element entfernt	
%% 				{In,NewOut}
%% 	end.

dequeue({In,Out}) -> Bool1 = stack:isEmptyS(In) and stack:isEmptyS(Out), Bool2 = stack:isEmptyS(Out),
	if 
		Bool1 == true -> {In,Out};  
		Bool2 == true -> {InNew,OutOld} = restack({In,Out}),
						 {InNew,stack:pop(OutOld)};
		true -> {In,stack:pop(Out)}				
				
	end.

restack({In,Out}) ->
	case stack:isEmptyS(In) of
		true -> {In,Out};
		_Else -> InTop = stack:top(In),
				 InNew = stack:pop(In),
				 restack({InNew,stack:push(Out,InTop)})
	end.

%----------------------------------------------------------------------------------

front({In,Out}) -> Bool1 = stack:isEmptyS(In) and stack:isEmptyS(Out), Bool2 = stack:isEmptyS(Out),
				if
					Bool1 == true ->  {In,Out};         						% Schlange ist leer: leere Schlange wird zurueckgegeben.
					Bool2 == true -> Rev = stack:reverseS(In), stack:top(Rev);	% Out-Stack ist leer: das aelteste Element des In-Stacks wird gefunden.
					true -> stack:top(Out)									% Beide Stacks voll: das oberste Element von Out-Stack wird ermittelt.
				end.

%----------------------------------------------------------------------------------

%% Testet, ob eine Schlange leer ist.
%% Eine Schlange ist leer, wennn beide Stacks leer sind.
isEmptyQ({In,Out}) -> stack:isEmptyS(In) and
			   stack:isEmptyS(Out).

%----------------------------------------------------------------------------------

%% Testet zwei Schlangen auf strukturelle Gleichheit.
equalQ(Q1,Q2) -> Q1 == Q2.  
