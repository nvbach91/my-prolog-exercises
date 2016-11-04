join_str(Str1, Str2, Str3) :-
 
  % Convert strings into lists
  name(Str1, StrList1),
  name(Str2, StrList2),
 
  % Combine string lists into new string list
  append(StrList1, StrList2, StrList3),
 
  % Convert list into a string
  name(Str3, StrList3).
  
h(a,b).
h(b,c).
h(a,d).
h(c,d).
h(b,e).
h(a,e).
h(e,f).
h(d,f).
h(g,f).


cesta(A,B,S) :-
    (
        h(A,B),
        Cesta is 1,
        join_str(S, Cesta, S)
    )
    ;
    /*h(A,X), cesta(X,B).*/
    h(X,B), cesta(A,X,"").