printHistogramRow([]).
printHistogramRow([H|T]) :- (H >  0, write('*');H =< 0, write(' ')), printHistogramRow(T).
  
printHistogram([]).
printHistogram([H|T]) :- printHistogramRow(H),nl,printHistogram(T).

generate_sub_list(_, _, _, 0, []).
generate_sub_list([H|T], GlobalNRows, CurrentNRows, NCols, [SubListMember|SubList]) :-
    NCols > 0,
    L_NCols is NCols - 1,
    nth0(L_NCols, [H|T], HTMember),
    TMP is GlobalNRows - CurrentNRows,
    (HTMember >= TMP,SubListMember is 1;HTMember < TMP,SubListMember is 0),
    generate_sub_list([H|T], GlobalNRows, CurrentNRows, L_NCols, SubList).
    
generate_main_list(_, _, 0, _, []).
generate_main_list([H|T], GlobalNRows, NRows, NCols, [SubList|MainList]) :-
    NRows > 0,
    L_NRows is NRows - 1,
    generate_sub_list([H|T], GlobalNRows, L_NRows, NCols, ReversedSublist),
    reverse(ReversedSublist,SubList),
    generate_main_list([H|T], GlobalNRows, L_NRows, NCols, MainList).
    
histogram([]).
histogram([H|T]) :- max_list([H|T], NRows),length([H|T], NCols),generate_main_list([H|T], NRows, NRows, NCols, ML),reverse(ML, TL),printHistogram(TL).
