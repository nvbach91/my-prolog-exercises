
% write,nl symbolizuje operaci nad aktualnim prvkem

% jednoduchy pruchod
% bez dalsich argumentu jen postranni efekt (vypis,...)
pruchod([]).
pruchod([H|T]) :- write(H),nl,pruchod(T).

% akumulator
mezivysledek(S1,S2) :- mezivysledek(S1,[],S),reverse(S,S2).
% pomocny predikat s vyssi aritou
mezivysledek([H1|T1],A,S2) :- write(H1),nl,mezivysledek(T1,[H1|A],S2).
mezivysledek([],A,A).