
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

prsi(P,R,S,I,J,E,N,L) :-
    c(P),c(R),c(S),c(I),c(J),c(E),c(N),c(L),
    P\=0, J\=0, S\=0,
    X1 is I+I+N,
    X2 is S+S+E+S-J-X1,
    X3 is R+R+J-E-X1-X2,
    P+P =:= L+X1+X2+X3.
    
    /*
    I+I+N+E    =E+X1,
    S+S+E+S         =J+X2+X1,
    R+R+J           =E+X1+X2+X3,
    P+P             =L+X1+X2+X3.*/