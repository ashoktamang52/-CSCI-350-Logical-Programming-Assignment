/* [Part 1]
   Parameter(s): <list> <number>
   Returns: True if number is the sume of the numbers not in nested lists in
   	        the given list.
*/

head-value-simple(Element, 0):-
    \+ number(Element);
    is_list(Element).
head-value-simple(Element, Element) :- number(Element).

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

head-value-general(Element, 0) :- \+ number(Element).
head-value-general(Element, Element) :- number(Element).
head-value-general(Element, Total):-
	is_list(Element),
	sum-up-numbers-simple(Element, Total).

sum-up-numbers-general([], 0).
sum-up-numbers-general([Head | Tail], Total) :-
	sum-up-numbers-general(Tail, Sub_total),
	head-value-general(Head, Head_total),
	Total is Head_total + Sub_total.
