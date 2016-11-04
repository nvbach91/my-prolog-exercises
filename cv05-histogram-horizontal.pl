hvezdicky(N) :- N>0,write('*'),N1 is N-1,hvezdicky(N1).
hvezdicky(0) :- nl.

histogram([H|T]) :- hvezdicky(H),histogram(T).
histogram([]).
