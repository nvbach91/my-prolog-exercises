%
% @author: Nguyen Viet Bach
% @description: Calculates n-th Fibonacci Number
% @usage: to calculate 8th Fibonacci number
% ?- fib(8,F)
%
/*
fib(N,FIB) :-
    N>2,
    N1 is N-1,
    N2 is N-2,
    fib(N1,F1),
    fib(N2,F2),
    FIB is F1 + F2.
    
fib(0,0).
fib(1,1).
fib(2,1).
*/

fibonacci(N,F) :-
	N>1,N1 is N-1,fibonacci(N1,F1),N2 is N-2,fibonacci(N2,F2),F is F1+F2.
fibonacci(0,0).
fibonacci(1,1).

fib(N,F) :- N>=0, fib(N,F,0,0,1).
fib(N,F,M,F1,F2) :-
    M < N,
    M1 is M+1,
    F3 is F1+F2,
    fib(N,F,M1,F2,F3).
fib(N,F,N,F,_).