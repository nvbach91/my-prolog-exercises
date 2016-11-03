%/*
%    vytvorte predikat hvezdicky(N,S)
%    ktery do promenne S ulozi N hvezdicek
%    (seznam N prvku '*')
%*/


hvezdicky(N,['*'|T]) :-
    N > 0,
    N1 is N - 1,
    %write(N1),
    %S is append(['*']),
    hvezdicky(N1,T).



hvezdicky(0,[]).