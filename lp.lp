/* [Part 1]
   Parameter(s): <list> <number>
   Returns: True if number is the sume of the numbers not in nested lists in
   	        the given list.
*/
sum-up-numbers-simple([],0).
sum-up-numbers-simple([Element], Element).
sum-up-numbers-simple([Element1, Element2 | Tail], Total) :-
	sum-up-numbers-simple([Element1+Element2], Total).

