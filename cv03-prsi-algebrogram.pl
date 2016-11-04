/*
 PRSI
 PRSI
  JEN
   SE
------
 LEJE
*/

c(0).
c(1).
c(2).
c(3).
c(4).
c(5).
c(6).
c(7).
c(8).
c(9).

prsi :- prsi(P,R,S,I,J,E,N,L),
    write(P:R:S:I),nl,
    write(P:R:S:I),nl,
    write('  '),write(J:E:N),nl,
    write('    '),write(S:E),nl,
    write('-------'),nl,
    write(L:E:J:E),nl.

prsi(P,R,S,I,J,E,N,L) :-
c(I),
c(N),N\==I,
c(E),E\==N,E\==I,
c(S),S\==0,S\==E,S\==N,S\==I,
c(J),J\==0,J\==S,J\==E,J\==N,J\==I,
c(R),R\==J,R\==S,R\==E,R\==N,R\==I,
c(P),P\==0,P\==R,P\==J,P\==S,P\==E,P\==N,P\==I,
c(L),L\==0,L\==P,L\==R,L\==J,L\==S,L\==E,L\==N,L\==I,

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