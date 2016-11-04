
faktorial(N,F) :- N>0,N1 is N-1,faktorial(N1,F1),F is F1*N.
faktorial(0,1).

