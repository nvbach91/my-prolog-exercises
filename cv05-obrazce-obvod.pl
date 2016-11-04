/* vypocet obvodu a obsahu utvaru a seznamu stejnych utvaru*/


obvod(kruh(R),O) :- O is 2*pi*R.
% obvod(ctverec(A),O) :- O is 4*A.
obvod(ctverec(A),O) :- obvod(obdelnik(A,A),O).
obvod(obdelnik(A,B),O) :- O is 2*(A+B).
obvod(trojuhelnik(A,B,C),O) :- O is A+B+C.

obvod(L,O) :- seznam(L),obvod(L,0,O).
obvod([H|T],O1,O) :- obvod(H,Ot),O2 is O1+Ot,obvod(T,O2,O).
obvod([],O,O).





obsah(kruh(R),O) :- O is pi*R**2.
% obsah(ctverec(A),O) :- O is 4*A.
obsah(ctverec(A),O) :- obsah(obdelnik(A,A),O).
obsah(obdelnik(A,B),O) :- O is A*B.
obsah(trojuhelnik(A,B,C),O) :- O is (A+B+C)/2.

obsah(L,O) :- seznam(L),obsah(L,0,O).
obsah([H|T],O1,O) :- obsah(H,Ot),O2 is O1+Ot,obsah(T,O2,O).
obsah([],O,O).

seznam([]).
%seznam([_|[]]).
seznam([_|_]).