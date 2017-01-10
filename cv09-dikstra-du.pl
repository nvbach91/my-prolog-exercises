
h(a,b,3).
h(b,c,5).
h(a,d,2).
h(c,d,2).
h(b,e,1).
h(a,e,7).
h(e,f,9).
h(d,f,4).
h(g,f,1).

% given an array of structures like a/0/b, 
% make a new array with only the first a
% example: [a/0/b, c/1/d] --> [a, c]
% (+L, -R)
custom_copy(A,R) :- cc(A,R).
cc([],[]).
cc([H|T1],[To|T2]) :- H = To/_/_, cc(T1,T2).


% nejkratsi_cesta(+Start,-Vzdalenosti)
nejkratsi_cesta(Start,Vzdalenosti) :- dijkstra([],[Start/0/Start],Vzdalenosti).

% dijkstra(+Navstivene,+Nenavstivene,-Vzdalenosti)
dijkstra(Vzdalenosti,[],Vzdalenosti).
dijkstra(Navstivene,Nenavstivene,Vzdalenosti) :-
	vyber_uzlu(Nenavstivene,U,NenavstiveneV),
	U=V/Delka/From,
	sousedni_uzly(V,Sousedi),
    custom_copy(Navstivene, NavstiveneX),
    /*writeln(NavstiveneX),writeln(Sousedi),writeln(""),*/
	nenavstivene_uzly(Sousedi,NavstiveneX,NenavstiveniSousedi),
    /*writeln(""),*/
	% pouzijeme NenavstiveneV, protoze V uz byl drive zpracovan (viz vyber z Nenavstivene vyse)
	zarad_uzly(NenavstiveniSousedi,NenavstiveneV,Delka,Nenavstivene3),
	dijkstra([V/Delka/From|Navstivene],Nenavstivene3,Vzdalenosti).

% otazka: proc ne setof/bagof?
sousedni_uzly(U,NB) :- findall(V/D/U,h(U,V,D),NB).

% vlna
% (+Nenavstivene,-UzelKNavstiveni,-OstatniNenavstivene)
vyber_uzlu([H|T],U,NenavstiveneU) :- vyber_nejblizsiho_uzlu(T,H,U,NenavstiveneU).
vyber_nejblizsiho_uzlu([],V,V,[]).
vyber_nejblizsiho_uzlu([H|T],M,Macc,[H2|Nenavstivene]) :-
	H = _/D/_,
	M = _/Dm/_,
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
    H = To/_/_,/*write(H),write(" ** "),write(To),write(" "),*/
	(
	 member(To,Navstivene) -> Nenavstivene=Nenavstivene2/*,write("is member of "),writeln(Navstivene)*/
	;
	 Nenavstivene=[H|Nenavstivene2]/*,write("not member of "),write(Navstivene),write(" added "),writeln(H)*/
	),
	nenavstivene_uzly(T,Navstivene,Nenavstivene2).
   
% (+Uzly,+DosudNenavstivene,+DosavadniVzdalenost,-Nenavstivene)
% vystupni seznam obsahuje uzly s prepocitanymi vzdalenostmi
zarad_uzly([],Nenavstivene,_,Nenavstivene).
zarad_uzly([V/D/From|T],Nenavstivene,Delka,Nenavstivene2) :-
	(
	 odstranen(Nenavstivene,V/DelkaStara,NenavstiveneV) -> DelkaNova is min(Delka+D,DelkaStara)
	;
	 DelkaNova is Delka+D, NenavstiveneV = Nenavstivene
	),
	Nenavstivene2 = [V/DelkaNova/From|Nenavstivene3],
	zarad_uzly(T,NenavstiveneV,Delka,Nenavstivene3).

% delete() uspeje vzdy, chceme neuspech pri nepritomnosti prvku v seznamu
odstranen([H|T],H,T).
odstranen([H|T1],X,[H|T2]) :- H \= X, odstranen(T1,X,T2).

cesta :- nejkratsi_cesta(a,M),write(M).
/*,M==[c/8,f/6,e/4,b/3,d/2,a/0].*/
%:- cesta.