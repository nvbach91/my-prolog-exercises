% cesta vrcholy
cesta2(X,Y,C) :- cesta2_(X,Y,[X],C1),reverse(C1,C).
cesta2_(X,Y,C,[Y|C]) :- h(X,Y).
cesta2_(X,Y,C1,C) :- h(X,Z),cesta2_(Z,Y,[Z|C1],C).
