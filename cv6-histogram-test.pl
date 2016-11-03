generateList(N, R) :-
    N > 0,
    N1 is N - 1,
    generateList(N1, [N|5]).
    
generateList(0, []).

histogram([H|T]) :-
    numlist(H, 10, R),
    write(R).