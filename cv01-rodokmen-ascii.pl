/*
Prvni priklad logickeho programu.

Cast rodokmenu rodiny, zalozene ceskym kralem Janem Lucemburskym,
a jeho manzelkou Eliskou Premyslovnou.
*/

% muzi

muz(jan_lucembursky).
muz(karel_IV).
muz(jan_jindrich).
muz(vaclav_lucembursky).
muz(vaclav_IV).
muz(zikmund).
muz(jindrich_bavorsky).
muz(jan_II_francouzsky).
muz(rudolf_IV_rakousky).
muz(ota_braniborsky).
muz(jan_sobeslav).
muz(jost).
muz(prokop).
muz(ladislav_pohrobek).
muz(jan_zhorelecky).
muz(richard_II_anglicky).
muz(jan_hohenzollern).
muz(albrecht_II_habsbursky).

% zeny

zena(eliska_premyslovna).
zena(blanka_z_valois).
zena(anna_falcka).
zena(anna_svidnicka).
zena(eliska_pomoranska).
zena(marketa).
zena(judita).
zena(marketa_tyrolska).
zena(marketa_opavska).
zena(katerina).
zena(johana_bavorska).
zena(zofie_bavorska).
zena(marie_uherska).
zena(barbara_celjska).
zena(anna).
zena(marketa_2).
zena(alzbeta).
zena(alzbeta_lucemburska).

% vztah manzelstvi

manzelka(eliska_premyslovna,jan_lucembursky).
manzelka(blanka_z_valois,karel_IV).
manzelka(anna_falcka,karel_IV).
manzelka(anna_svidnicka,karel_IV).
manzelka(eliska_pomoranska,karel_IV).
manzelka(anna,richard_II_anglicky).
manzelka(johana_bavorska,vaclav_IV).
manzelka(zofie_bavorska,vaclav_IV).
manzelka(marie_uherska,zikmund).
manzelka(barbara_celjska,zikmund).
manzelka(marketa_2,jan_hohenzollern).
manzelka(katerina,rudolf_IV_rakousky).
manzelka(katerina,ota_braniborsky).
manzelka(marketa_tyrolska,jan_jindrich).
manzelka(marketa_opavska,jan_jindrich).
manzelka(judita,jan_II_francouzsky).
manzelka(alzbeta,albrecht_II_habsbursky).

% vztah otcovstvi

otec(karel_IV,vaclav_IV).
otec(karel_IV,zikmund).
otec(karel_IV,marketa_2).
otec(karel_IV,anna).
otec(karel_IV,jan_zhorelecky).
otec(karel_IV,katerina).
otec(jan_lucembursky,karel_IV).
otec(jan_lucembursky,jan_jindrich).
otec(jan_lucembursky,marketa).
otec(jan_lucembursky,judita).
otec(jan_lucembursky,vaclav_lucembursky).
otec(jan_jindrich,jost).
otec(jan_jindrich,jan_sobeslav).
otec(jan_jindrich,prokop).
otec(zikmund,alzbeta).
otec(albrecht_II_habsbursky,ladislav_pohrobek).
otec(jan_zhorelecky,alzbeta_lucemburska).

% vztah materstvi

matka(eliska_premyslovna,marketa).
matka(eliska_premyslovna,judita).
matka(eliska_premyslovna,karel_IV).
matka(eliska_premyslovna,jan_jindrich).
matka(eliska_premyslovna,vaclav_lucembursky).
matka(blanka_z_valois,marketa_2).
matka(blanka_z_valois,katerina).
matka(anna_svidnicka,vaclav_IV).
matka(eliska_pomoranska,zikmund).
matka(eliska_pomoranska,jan_zhorelecky).
matka(alzbeta,ladislav_pohrobek).

% vztahy definovane na zaklade predchozich pomoci pravidel

bratr(X,Y) :-
   muz(X),otec(O,X),matka(M,X),otec(O,Y),matka(M,Y).

sestra(X,Y) :-
   zena(X),otec(O,X),matka(M,X),otec(O,Y),matka(M,Y).

deda(X,Y) :-
   muz(X),otec(X,Z),(otec(Z,Y);matka(Z,Y)).

baba(X,Y) :-
   zena(X),matka(X,Z),(otec(Z,Y);matka(Z,Y)).

vnuk(X,Y) :-
   muz(X),(deda(Y,X);baba(Y,X)).

vnucka(X,Y) :-
   zena(X),(deda(Y,X);baba(Y,X)).

rodic(X,Y) :- otec(X,Y);matka(X,Y).

praded(X,Y) :- otec(X,Z),(deda(Z,Y);baba(Z,Y)).

prababa(X,Y) :- matka(X,Z),(deda(Z,Y);baba(Z,Y)).
