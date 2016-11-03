%/*
%    vytvorte predikat histogram(S)
%    ktery vytiskne vodorovne orientovany histogram
%    k vypisu radku nebudete potrebovat seznamy
%*/


histogram(S) :-
    N > 0,
    N1 is N - 1,
    %write(N1),
    %S is append(['*']),
    hvezdicky(N1,T).



histogram(0,[]).

%/* DOMACI UKOL
%    vytvorte predikat svisly_histogram(S)
%    ktery vytiskne histogram v obvykle podobe
%    k vypisu radku nebudete potrebovat seznamy
%*/