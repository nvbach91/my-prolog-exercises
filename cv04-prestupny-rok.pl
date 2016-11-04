/*
    vytvorte predukat prestupny_rok(R) ktery uspeje pokud je rok R
    prestupny dle gregorianskeho kalendare
    
    rok je prestupny pokud je delitelny ctyrmi
    staleti ejsou prestupna
    roky delit 400 jsou prestupne

*/



prestupny_rok(R) :-
    R > 1582, 
    (
        (R div 400 > 0, R mod 400 =:= 0)
        ;
        (R div 100 > 0, R mod 100 =\= 0, R mod 4 =:= 0)
    ).
