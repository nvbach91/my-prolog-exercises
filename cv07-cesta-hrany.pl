% cesta seznamem hran
cesta(X,Y,C) :- cesta_(X,Y,[],C1),reverse(C1,C).
cesta_(X,Y,C,[X-Y|C]) :- h(X,Y).
cesta_(X,Y,C1,C) :- h(X,Z),cesta_(Z,Y,[X-Z|C1],C).
