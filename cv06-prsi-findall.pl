/* PRSI
   PRSI
    JEN
     SE
--------
   LEJE  */

cifry([0,1,2,3,4,5,6,7,8,9]).

prsi :- prsi(S),write('Pocet reseni: '),length(S,N),write(N),nl,  prsi_(S).
prsi_([P|T]) :- vypis_prsi(P),nl,prsi_(T).
prsi_([]).
	
vypis_prsi([P,R,S,I,J,E,N,L]) :- prsi(P,R,S,I,J,E,N,L),
    write(P:R:S:I),nl,
    write(P:R:S:I),nl,
    write('  '),write(J:E:N),nl,
    write('    '),write(S:E),nl,
    write('-------'),nl,
    write(L:E:J:E),nl.

prsi(S) :- findall([P,R,S,I,J,E,N,L],prsi(P,R,S,I,J,E,N,L),S).

prsi(P,R,S,I,J,E,N,L) :-
	cifry(C),
	select(I,C,Ci),
	select(N,Ci,Cn),
	select(E,Cn,Ce),
	select(S,Ce,Cs),S\==0,
	select(J,Cs,Cj),J\==0,
	select(R,Cj,Cr),
	select(P,Cr,Cp),P\==0,
	select(L,Cp,_),L\==0,

	S1 is 2*I + N +E,
	X1 is S1 div 10,
	E =:= S1 mod 10,

	S2 is X1+3*S+E,
	X2 is S2 div 10,
	J =:= S2 mod 10,

	S3 is X2 + 2*R + J,
	X3 is S3 div 10,
	E =:= S3 mod 10,

	L =:= 2*P + X3.
