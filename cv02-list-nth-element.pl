%
% @author: Nguyen Viet Bach
% @description: returns the n-th element in the list
% @usage: ?- nth([a,b,c], 2, F)
% returns F = c
%
/*
nth([],0,false).
nth([_|T],F) :- 
    F is T,
    nth(T,N1).
*/
    
print(0, _) :- !.
print(_, []).
print(N, [H|T]) :- 
    write(H), nl, 
    N1 is N - 1, 
    print(N1, T).
