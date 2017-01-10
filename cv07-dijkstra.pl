
% nejkratsi_cesta(+Start,-Vzdalenosti)
nejkratsi_cesta(Start,Vzdalenosti) :- dijkstra([],[Start/0],Vzdalenosti).

% dijkstra(+Navstivene,+Nenavstivene,-Vzdalenosti)
dijkstra(Vzdalenosti,[],Vzdalenosti).
dijkstra(Navstivene,Nenavstivene,Vzdalenosti) :-
	vyber_uzlu(Nenavstivene,U,NenavstiveneV),
	U=V/Delka,
	sousedni_uzly(V,Sousedi),
	nenavstivene_uzly(Sousedi,Navstivene,NenavstiveniSousedi),
				% pouzijeme NenavstiveneV, protoze V uz byl drive zpracovan (viz vyber z Nenavstivene vyse)
	zarad_uzly(NenavstiveniSousedi,NenavstiveneV,Delka,Nenavstivene3),
	dijkstra([V/Delka|Navstivene],Nenavstivene3,Vzdalenosti).

% otazka: proc ne setof/bagof?
sousedni_uzly(U,NB) :- findall(V/D,h(U,V,D),NB).

% vlna
% (+Nenavstivene,-UzelKNavstiveni,-OstatniNenavstivene)
vyber_uzlu([H|T],U,NenavstiveneU) :- vyber_nejblizsiho_uzlu(T,H,U,NenavstiveneU).
vyber_nejblizsiho_uzlu([],V,V,[]).
vyber_nejblizsiho_uzlu([H|T],M,Macc,[H2|Nenavstivene]) :-
	H = _/D,
	M = _/Dm,
	(
	 D < Dm -> M2=H,H2=M
	;
	 M2=M,H2=H
	),
	vyber_nejblizsiho_uzlu(T,M2,Macc,Nenavstivene).
   
% (+SeznamUzlu,+Navstivene,-NenavstiveneZeSeznamu)
% (+Sousedi,+Navstivene,-NenavstiveniSousedi)
% odfiltruj_navstivene_uzly
nenavstivene_uzly([],_,[]).
nenavstivene_uzly([H|T],Navstivene,Nenavstivene) :-
	(
	 member(H,Navstivene) -> Nenavstivene=Nenavstivene2
	;
	 Nenavstivene=[H|Nenavstivene2]
	),
	nenavstivene_uzly(T,Navstivene,Nenavstivene2).
   
% (+Uzly,+DosudNenavstivene,+DosavadniVzdalenost,-Nenavstivene)
% vystupni seznam obsahuje uzly s prepocitanymi vzdalenostmi
zarad_uzly([],Nenavstivene,_,Nenavstivene).
zarad_uzly([V/D|T],Nenavstivene,Delka,Nenavstivene2) :-
	(
	 odstranen(Nenavstivene,V/DelkaStara,NenavstiveneV) -> DelkaNova is min(Delka+D,DelkaStara)
	;
	 DelkaNova is Delka+D, NenavstiveneV = Nenavstivene
	),
	Nenavstivene2 = [V/DelkaNova|Nenavstivene3],
	zarad_uzly(T,NenavstiveneV,Delka,Nenavstivene3).

% delete() uspeje vzdy, chceme neuspech pri nepritomnosti prvku v seznamu
odstranen([H|T],H,T).
odstranen([H|T1],X,[H|T2]) :- H \= X, odstranen(T1,X,T2).

cesta :- consult('graf1o.pl'),nejkratsi_cesta(a,M),write(M),M==[c/8,f/6,e/4,b/3,d/2,a/0].
%:- cesta.
