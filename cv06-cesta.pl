
cesta(X,Y) :- h(X,Y).
cesta(X,Y) :- h(X,Z),cesta(Z,Y).
