
% cesta bez cyklu
% seznam navstivenych uzlu povazujeme za mnozinu (nezalezi na poradi)

% (+Od, +Do, -Cesta)
acyklicka_cesta0(X,Y,C) :- acyklicka_cesta0_(X,Y,[X],[X],C0),reverse(C0,C).
% (+Od, +Do, +Navstiveno, +PrubeznaCesta, -Cesta)
% umoznime cestu z X do X
%acyklicka_cesta0_(X,Y,Navs,C,[Y|C]) :- h(X,Y),\+ member(Y,Navs).
acyklicka_cesta0_(X,Y,_,C,[Y|C]) :- h(X,Y).
acyklicka_cesta0_(X,Y,Navs,C1,C) :- h(X,Z),\+ member(Z,Navs),acyklicka_cesta0_(Z,Y,[Z|Navs],[Z|C1],C).

% (+Od, +Do, -Cesta)
acyklicka_cesta(X,Y,C) :- acyklicka_cesta_(X,Y,[X],C0), C=[X|C0].
% (+Od, +Do, +Navstiveno, -Cesta)
% umoznime cestu z X do X
%acyklicka_cesta_(X,Y,Navs,[Y]) :- h(X,Y),\+ member(Y,Navs).
acyklicka_cesta_(X,Y,_,[Y]) :- h(X,Y).
acyklicka_cesta_(X,Y,Navs,[Z|C0]) :- h(X,Z),\+ member(Z,Navs),acyklicka_cesta_(Z,Y,[Z|Navs],C0).
