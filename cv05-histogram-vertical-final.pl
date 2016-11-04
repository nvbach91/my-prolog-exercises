%
% Vertical Histogram in prolog
% Written by: Nguyen Viet Bach
% Usage  : ?- histogram(/* array non negative integers */).
% Example: ?- histogram([1,2,0,7,4,10,6,9,7,5,3,4,5,6,7,8]).
% Output : 
%
%        *          
%      * *        
%      * *       *
%    * * **     **
%    * ****    ***
%    * *****  ****
%    ******* *****
%    *************
%  * *************
% ** *************
%

/* prints each member in the list line by line */
printList([]). 
printList([X|List]) :-
    write(X),nl,
    printList(List).
    
/* reverse all list members and members in those members https://goo.gl/x2aMo2 */
reverseListMembersAndAllTheirMembers([], []).
reverseListMembersAndAllTheirMembers([H|T], X) :-
    reverseListMembersAndAllTheirMembers(H, NewH),
    reverseListMembersAndAllTheirMembers(T, NewT),
    append(NewT, [NewH], X).
reverseListMembersAndAllTheirMembers(X, X).

/* prints space or * depending on the value of the matrix row*/
printHistogramRow([]).
printHistogramRow([H|T]) :-
    (
        H >  0, write('*')
        ;
        H =< 0, write(' ') 
    ), printHistogramRow(T).

/* prints each matrix row line by line */    
printHistogram([]).
printHistogram([H|T]) :-
    printHistogramRow(H),
    nl,
    printHistogram(T).

    
    
    
/* generate the matrix row values (aka. columns, sublists) */
generate_sub_list(_, _, _, 0, []).
generate_sub_list([H|T], GlobalNRows, CurrentNRows, NCols, [SubListMember|SubList]) :-
    NCols > 0,
    L_NCols is NCols - 1,
    nth0(L_NCols, [H|T], HTMember),
    TMP is GlobalNRows - CurrentNRows,
    /*write(HTMember),write(' ? '),write(TMP),write(', '),*/
    (   
    	HTMember >= TMP,
        SubListMember is 1
    ;   
    	HTMember < TMP,
    	SubListMember is 0
    ),
    generate_sub_list([H|T], GlobalNRows, CurrentNRows, L_NCols, SubList).
    
/* generate the matrix rows (sublists) */
generate_main_list(_, _, 0, _, []).
generate_main_list([H|T], GlobalNRows, NRows, NCols, [SubList|MainList]) :-
    NRows > 0,
    L_NRows is NRows - 1,
    generate_sub_list([H|T], GlobalNRows, L_NRows, NCols, SubList),
    /* reverse the reversed sublist because we were prepending the values... 
    reverse(ReversedSublist,SubList),*/
    generate_main_list([H|T], GlobalNRows, L_NRows, NCols, MainList).
       
histogram([H|T]) :-
    /**
     * NRows is the number of sublists 
     * Assign the max value in the list to NRows
     */
    max_list([H|T], NRows),
    write('NRows '),write(NRows),write(', '),
    
    /**
     * NCols is the number of members in each sublist 
     * Assign the length of the list to NCols
     */
    length([H|T], NCols),
    write('NCols '),write(NCols),nl,
    
    generate_main_list([H|T], NRows, NRows, NCols, ML),
    reverseListMembersAndAllTheirMembers(ML, TL),
    printList(TL),
    printHistogram(TL).
    
histogram([]).
