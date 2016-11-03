
otoceni(S,R) :- otoceni(S,[],R).

otoceni([H|T],S,R) :- otoceni(T,[H|S],R).

otoceni([],R,R).

palindrom(L) :- otoceni(L,L).