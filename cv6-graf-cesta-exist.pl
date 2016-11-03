
h(a,b).
h(b,c).
h(a,d).
h(c,d).
h(b,e).
h(a,e).
h(e,f).
h(d,f).
h(g,f).


cesta(A,B) :-
    h(A,B)
    ;
    /*h(A,X), cesta(X,B).*/
    h(X,B), cesta(A,X).