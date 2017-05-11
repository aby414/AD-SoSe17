%% @author aby414
%% @doc @todo Add description to stack_test.


-module(stack_test).
-include_lib("eunit/include/eunit.hrl").

create_test() ->
	?assert(stack:createS() == {}).
	
push_test() ->
	S1 = {},
	S2 = {1,{2,{3,{}}}},

 	?assert(stack:push(S1,4) == {4,{}}),
	?assert(stack:push(S2,4) == {4,{1,{2,{3,{}}}}}).

					
pop_test() ->
	S1 = {},
	S2 = {1,{2,{3,{}}}},
	
	?assert(stack:pop(S1) == {}),
	?assert(stack:pop(S2) == {2,{3,{}}}).

top_test() -> 
	S1 = {},
	S2 = {1,{2,{3,{}}}},
	
	?assert(stack:top(S1) == {}),
	?assert(stack:top(S2) == 1).

isEmptyS_test() -> 
	S1 = {},
	S2 = {1,{2,{3,{}}}},

	?assert(stack:isEmptyS(S1) == true),
	?assert(stack:isEmptyS(S2) == false).

					
equalS_test() ->
	S1 = {},
	S2 = {},
	S3 = {1,{2,{3,{}}}},
	S4 = {1,{2,{3,{}}}},
	S5 = {1,2,{3,{}}},

	?assert(stack:equalS(S1, S2) == true),
	?assert(stack:equalS(S3, S4) == true),
	?assert(stack:equalS(S3, S5) == false).

reverseS_test() ->
	S1 = {1,{2,{3,{}}}},
	S2 = {3,{2,{1,{}}}},
	S3 = {},
	S4 = {1,{}},

	?assert(stack:reverseS(S1) == S2),
	?assert(stack:reverseS(S2) == S1),
	?assert(stack:reverseS(S3) == S3),
	?assert(stack:reverseS(S4) == S4).








