%% @author = Hendrik Seemann.


-module(liste_test).
-include_lib("eunit/include/eunit.hrl").

create_test() ->
    ?assert(liste:create() == {}).

isEmpty_test() ->
	?assert(liste:isEmpty({}) == true),
	?assert(liste:isEmpty({1,{2,{3,{}}}}) == false),
	?assert(liste:isEmpty({1}) == false).

isList_test() ->
	?assert(liste:isList({}) == true),
	?assert(liste:isList({1,{2,{}}}) == true),
	?assert(liste:isList({a,{1,{5000,{}}}}) == true),

	?assert(liste:isList({1,2,3}) == false),
	?assert(liste:isList([1,2,3]) == false),
	?assert(liste:isList({h,t}) == false),
	?assert(liste:isList({1,{2}}) == false).

equal_test() ->
	L1 = {1,{2,{3,{}}}},
	L2 = {1,{2,{3,{}}}},
	L3 = {1,{2,{3,{4,{}}}}},
	L4 = {1,{2,{3,{4,{}}}}},

	?assert(liste:equal(L1, L2) == true),
	?assert(liste:equal(L2, L1) == true),
	?assert(liste:equal(L3, L4) == true),

	?assert(liste:equal(L1, L3) == false),
	?assert(liste:equal(L2, L4) == false).

laenge_test() ->
	L1 = {1,{2,{3,{}}}},
	L2 = {1,{2,{3,{4,{}}}}},
	L3 = {1,{}},
	L4 = {a,{b,{}}},

	?assert(liste:laenge(L1) == 3),
	?assert(liste:laenge(L2) == 4),
	?assert(liste:laenge(L3) == 1),
	?assert(liste:laenge(L4) == 2),
	?assert(liste:laenge({}) == 0).

insert_test() ->
	L1 = {1,{2,{3,{}}}},
	L2 = {1,{2,{3,{4,{}}}}},
	L3 = {1,{}},
	L4 = {a,{b,{}}},
	L5 = {},

	?assert(liste:insert(L4, 3, c) == {a,{b,{c,{}}}}),
	?assert(liste:insert(L5, 1, 1) == L3),
	?assert(liste:insert(L3, 2, 2) == {1,{2,{}}}),
	?assert(liste:insert(L2, 5, a) == {1,{2,{3,{4,{a,{}}}}}}),

	?assert(liste:insert(L1, 10, ab) == L1),
	?assert(liste:insert(L5, 10, 1) == L5),
	?assert(liste:insert(L4, 50, c) == L4).

delete_test() ->
	L1 = {1,{2,{3,{}}}},
	L2 = {1,{2,{3,{4,{}}}}},
	L3 = {1,{}},
	L4 = {a,{b,{}}},
	L5 = {},

	?assert(liste:delete(L1, 2) == {1,{3,{}}}),
	?assert(liste:delete(L2, 4) == L1),
	?assert(liste:delete(L3, 1) == L5),

	?assert(liste:delete(L4, 3) == L4),
	?assert(liste:delete(L5, 1) == L5).

find_test() ->
	L1 = {3,{1,{2,{}}}},
	L2 = {2,{4,{1,{3,{}}}}},
	L3 = {5,{}},
	L5 = {},

	?assert(liste:find(L1, 2) == 3),
	?assert(liste:find(L2, 2) == 1),
	?assert(liste:find(L3, 5) == 1),

	?assert(liste:find(L1, 4) == 0),
	?assert(liste:find(L5, 1) == 0).

retrieve_test() ->
	L1 = {3,{1,{2,{}}}},
	L2 = {2,{4,{1,{3,{}}}}},
	L3 = {5,{}},
	L5 = {},

	?assert(liste:retrieve(L1, 3) == 2),
	?assert(liste:retrieve(L2, 4) == 3),
	?assert(liste:retrieve(L3, 1) == 5),

	?assert(liste:retrieve(L1, 4) == {}),
	?assert(liste:retrieve(L2, 10) == {}),
	?assert(liste:retrieve(L5, 1) == {}).

concat_test() ->
	L1 = {3,{1,{2,{}}}},
	L2 = {2,{4,{1,{3,{}}}}},
	L3 = {5,{}},
	L4 = {a,{b,{}}},
	L5 = {},

	?assert(liste:concat(L1, L2) == {3,{1,{2,{2,{4,{1,{3,{}}}}}}}}),
	?assert(liste:concat(L3, L5) == {5,{}}),
	?assert(liste:concat(L3, L4) == {5,{a,{b,{}}}}).

diffListe_test() ->
	L1 = {},
	L2 = {3,{1,{2,{}}}},
	L3 = {3,{5,{6,{}}}},

	?assert(liste:diffListe(L1, L1) == {}),
	?assert(liste:diffListe(L1, L2) == L2),
	?assert(liste:diffListe(L2, L3) == {1,{2,{5,{6,{}}}}}),
	?assert(liste:diffListe(L2, L2) == {}).

eoCount_test() ->
	L1 = {},
	L2 = {1,{}},
	L3 = {1,{2,{3,{}}}},
	L4 = liste:insert(L2, 1, L2),
	L5 = liste:insert(L4, 1, L2),

	?assert(liste:eoCount(L1) == [1,0]),
	?assert(liste:eoCount(L2) == [0,1]),
	?assert(liste:eoCount(L3) == [0,1]),
	?assert(liste:eoCount(L5) == [0,3]).







