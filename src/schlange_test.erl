%% @author aby414
%% @doc @todo Add description to schlange_test.


-module(schlange_test).
-include_lib("eunit/include/eunit.hrl").

create_test() ->
	{In,Out} = schlange:createQ(),
	?assert(stack:isEmptyS(In)),
	?assert(stack:isEmptyS(Out)).

enqueue_test() ->
	Q1 = schlange:createQ(),
	Q2 = {{1,{2,{3,{}}}},{}},
	Q3 = {{1,{2,{3,{}}}},{1,{}}},
	
	?assert(schlange:enqueue(Q1,1) == {{1,{}},{}}),
	?assert(schlange:enqueue(Q2,4) == {{4,{1,{2,{3,{}}}}},{}}),
	?assert(schlange:enqueue(Q3,4) == {{4,{1,{2,{3,{}}}}},{1,{}}}).

dequeue_test() ->
	Q1 = schlange:createQ(),
	Q2 = {{1,{2,{3,{}}}},{}},
	Q3 = {{1,{2,{3,{}}}},{1,{}}},
	
	?assert(schlange:dequeue(Q1) == {{},{}}),
	?assert(schlange:dequeue(Q2) == {{},{2,{1,{}}}}),
	?assert(schlange:dequeue(Q3) == {{1,{2,{3,{}}}},{}}).

front_test() ->
 	Q1 = {{1,{2,{3,{}}}},{4,{5,{}}}},
 	Q2 = {{1,{2,{3,{}}}},{}},
 	Q3 = {{},{}},
 	Q4 = {{},{1,{2,{3,{}}}}},
	
	?assert(schlange:front(Q1) == 4),
	?assert(schlange:front(Q2) == 3),
 	?assert(schlange:front(Q3) == Q3),
 	?assert(schlange:front(Q4) == 1). 

isEmptyQ_test() ->
	Q1 = {{},{}},
	Q2 = {{1,{}},{}},
	Q3 = {{1,{2,{3,{}}}},{4,{5,{}}}},

	?assert(schlange:isEmptyQ(Q1) == true),
	?assert(schlange:isEmptyQ(Q2) == false),
	?assert(schlange:isEmptyQ(Q3) == false).

equalQ_test() ->
	Q1 = {{1,{}},{}},
	Q2 = {{1,{}},{}},
	Q3 = {{},{1,{}}},

	?assert(schlange:equalQ(Q1, Q2) == true),
	?assert(schlange:equalQ(Q1, Q3) == false).
				  



