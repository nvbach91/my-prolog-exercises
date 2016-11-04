loop_(stop, _).
loop_(S, N) :-
    write(S),nl,
    S1 is S + 1,
    S1 < N -> 
      loop_(S1, N) ; 
      loop_(stop, N).

loop(N) :-
    loop_(0, N).