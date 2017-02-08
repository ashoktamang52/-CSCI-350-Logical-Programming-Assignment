/* [Part 1]
   Parameter(s): <list> <number>
   Returns: True if number is the sume of the numbers not in nested lists in
   	        the given list.
*/

% Helper goal that determines whether an element is a number or not.

head-value-simple(Element, 0):-
    \+ number(Element);
    is_list(Element).

head-value-simple(Element, Element) :- number(Element).

% Main goal.

sum-up-numbers-simple([],0).

sum-up-numbers-simple([Head], 0) :-
	\+ number(Head).

sum-up-numbers-simple([Head | Tail], Total) :-
	sum-up-numbers-simple(Tail, Sub_total),
	head-value-simple(Head, Head_total),
	Total is Head_total + Sub_total.


/* [Part 2]
	Parameter: <list> <number>
	Returns: True if <number> is the sum of all the numbers (including those in
			nested lists) in <list>.
*/

% Helper goal that determines whether an element is a number or not.
head-value-general(Element, 0) :- 
	\+ number(Element).
head-value-general(Element, Element) :- 
	number(Element).

% Main goal.

sum-up-numbers-general([], 0).

sum-up-numbers-general([Head | Tail], Total) :-
	\+ is_list(Head),
	head-value-general(Head, Head_value),
	sum-up-numbers-general(Tail, Tail_total),
	Total is Head_value + Tail_total.

sum-up-numbers-general([Head | Tail], Total) :-
	sum-up-numbers-general(Tail, Tail_total),
    is_list(Head),
	sum-up-numbers-general(Head, Head_total),
	Total is Head_total + Tail_total.


/* [Part 3]
	Parameter: <list1> <list2> <number>
	Returns: True if <number> is the minimum of the numbers in <list1> that are 
	larger than the smallest number in <list2>.
*/

% Helper goal that returns the minimum value from only-numeric simple list.

min-from-list([Element], Element) :- number(Element).
min-from-list([Head | Tail], Min) :- 
	\+ number(Head),
	min-from-list(Tail, Min).
min-from-list([Head | Tail], Final_min) :-
	min-from-list(Tail, Tail_min),
	Final_min is min(Head, Tail_min).

% Helper goal that returns a new only-numeric list from a given list.

filter-num([], []).
filter-num([Head | Tail], [Head|Y]) :- 
	filter-num(Tail, Y),
	number(Head).
filter-num([Head | Tail], Final) :-
	filter-num(Tail, Final),
	\+ number(Head).

% Helper goal that returns a new list of numbers in a list, that are greater
% than the given minium value.

greater-than([], Min, []) :-
    number(Min).
greater-than([H|T], Min, [H|X]) :-
    H > Min,
    greater-than(T, Min, X).

greater-than([H|T], Min, X) :-
    H =< Min,
    greater-than(T, Min, X).

% Main goal.

min-above-min(L1, L2, N):-
    filter-num(L2, Filtered),
    min-from-list(Filtered, Min),
    filter-num(L1, Filtered1),
    greater-than(Filtered1, Min, Greater_than),
    min-from-list(Greater_than, N).


/* [Part 4]
	Parameter: <list1> <list2> <new_list>
	Returns: True if <new_list> is a simple list of
    the items that are common in <list1> and <list2>.
    The elements in the result list are unique.
*/

% Helper function that finds common elements from both lists.

common-getter([], L2, []) :-
    is_list(L2).

common-getter([H|T], L2, [H|X]) :-
    member(H, L2),
    unique-getter(T, L2, X).

common-getter([H|T], L2, X) :-
    \+ member(H, L2),
    unique-getter(T, L2, X).

% Helper function returns a simple list given a list of nested lists.

make-simple-list([], []).

make-simple-list([H|T], Z) :-
    is_list(H),
    make-simple-list(H, X),
    make-simple-list(T, Y),
    append(X, Y, Z).

make-simple-list([H|T], [H|Z]) :-
    make-simple-list(T, Z).


% Helper function returns a list with no duplicates.

make-unique-list([], []).

make-unique-list([H|T], [H|Z]) :-
    \+ member(H, T),
    make-unique-list(T, Z).

make-unique-list([H|T], Z) :-
    member(H, T),
    make-unique-list(T, Z).

% Main goal.

common-unique-elements(L1, L2, N) :-
    make-simple-list(L1, Simple1),
    make-simple-list(L2, Simple2),
    common-getter(Simple1, Simple2, Common),
    make-unique-list(Common, N).
