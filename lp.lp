/* [Part 1]
   Parameter(s): <list> <number>
   Returns: True if number is the sume of the numbers not in nested lists in
   	        the given list.
*/
sum-up-numbers-simple([],0).
sum-up-numbers-simple([Head], 0) :-
	\+ number(Head).
sum-up-numbers-simple([Head | Tail], Total) :-
	sum-up-numbers-simple(Tail, Sub_total),
	Total is Head + Sub_total.

