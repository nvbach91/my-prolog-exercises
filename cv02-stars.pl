%
% @author: Nguyen Viet Bach
% @description: Prints n-stars
% @usage: to print 8 stars
% ?- stars(8)
%

stars(0) :-
    nl.
    
stars(N) :-
    N > 0,
    write('*'),
    N1 is N - 1,
    stars(N1).
    