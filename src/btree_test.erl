%% @author aby414
%% @doc @todo Add description to btree_test.


-module(btree_test).
-include_lib("eunit/include/eunit.hrl").

initBT_test() -> 
	BT = {},
	
	?assert(btree:initBT() == BT).

isBT_test() -> 
	Y = btree:insertBT({}, 10),
	X = btree:insertBT(Y, 8),
	C = btree:insertBT(X, 5),
	V = btree:insertBT(C, 4),
	B = btree:insertBT(V, 9),
	N = btree:insertBT(B, 15),
	M = btree:insertBT(N, 13),
	A = btree:insertBT(M, 16),
	
	B1 = {10,10,{8,3,{5,2,{4,1,{},{}},{}},{9,1,{},{}}},{15,1,{},{}}},
	B2 = {a,4,{8,3,{5,2,{6,1,{},{}},{}},{9,1,{},{}}},{15,1,{},{}}},
	B3 = {10,4,{8,3,{10,2,{4,1,{},{}},{}},{9,1,{},{}}},{15,2,{},{}}},
	B4 = {10,3,{8,2,{},{11,1,{},{}}},{}},

	?assert(btree:isBT(A) == true),
	?assert(btree:isBT(B1) == false),
	?assert(btree:isBT(B2) == false),
	?assert(btree:isBT(B3) == false),
	?assert(btree:isBT({}) == true),
	?assert(btree:isBT(Y) == true),
	?assert(btree:isBT(B4) == false),
	?assert(btree:isBT(5) == false).
	
insertBT_test() ->
	Y = {10,1,{},{}},
	X = {10,2,{8,1,{},{}},{}},
	V = {10,3,{8,2,{4,1,{},{}},{}},{}},
	C = {10,3,{8,2,{4,1,{},{}},{}},{13,1,{},{}}},
	
	?assert(btree:insertBT({},10) == Y),
	?assert(btree:insertBT(Y,8) == X),
	?assert(btree:insertBT(X,8) == X),
	?assert(btree:insertBT(X,a) == X),
	?assert(btree:insertBT(X,4) == V),
	?assert(btree:insertBT(V,13) == C).

isEmptyBT_test() -> 
	B1 = btree:initBT(),
	B2 = {10,1,{},{}},
	?assert(btree:isEmptyBT(B1) == true),
	?assert(btree:isEmptyBT(B2) == false).
	

equalBT_test() ->
	B1 = {10,3,{8,2,{4,1,{},{}},{}},{13,1,{},{}}},
	B2 = {10,3,{8,2,{4,1,{},{}},{}},{13,1,{},{}}},
	B3 = {},
	B4 = {10,2,{8,1,{},{}},{}},
	
	?assert(btree:equalBT(B1, B2) == true),
	?assert(btree:equalBT(B3,{}) == true),
	?assert(btree:equalBT(B1, B4) == false).

%{10,4,{8,3,{5,2,{4,1,{},{}},{}},{9,1,{},{}}},{15,1,{},{}}}