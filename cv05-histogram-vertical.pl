/* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */
hvezdicky(N) :- 
    N>0,
    write('*'),
    N1 is N-1,
    hvezdicky(N1).
    
hvezdicky(0) :- nl.

/* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */
mt_generate_sub_list([H|T], NRows, NCols, MainList) :-
    NCols > 0,
    L_NCols is NCols - 1,
    writeln(NCols),nl,
    mt_generate_sub_list([H|T], NRows, L_NCols, MainList).

/* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */
mt_generate_main_list([H|T], NRows, ML) :-
    NRows > 0,
    L_NRows is NRows - 1,
    write(ML).
    /*mt_generate_sub_list([H|T], NRows, NCols, MainList),
    mt_generate_main_list([H|T], L_NRows, NCols, MainList).
    
    prepend([2,3], MainList, MainList).
    
    mt_generate_sub_list([H|T], L_NRows, NCols, MainList),
    
    mt_generate_main_list([H|T], L_NRows, NCols, [[1,2,3]|MainList]).*/

mt_generate_main_list(_, 0, _, _):- writeln("Created rows").
    
/* = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = */
   
histogram([H|T]) :-
    /**
     * NRows is the number of sublists 
     * Assign the max value in the list to NRows
     */
    max_list([H|T], NRows),
    write("NRows "),
    writeln(NRows),
    
    /** 
     * NCols is the number of members in each sublist 
     * Assign the length of the list to NCols
     */
    length([H|T], NCols),
    write("NCols "),
    writeln(NCols),
    
    /* javascript code solution of transformation
        function getMaxOfArray(numArray) { return Math.max.apply(null, numArray); };
        var inputList = [2,4,3,4,1];
        var NRows = getMaxOfArray(inputList);
        var NCols = inputList.length;
        var ResultList = [];
        for (var i = NRows - 1; i >= 0; i--) {
            var SubList = [];
            for (var j = NCols - 1; j >= 0; j--) {
                var inputListValue = inputList[j];
                if (inputListValue > (NRows - i - 1)) {
                    SubList.unshift(1);
                } else {
                    SubList.unshift(0);
                }
            }
            ResultList.unshift(SubList);
        }
        JSON.stringify(ResultList);
    */
    mt_generate_main_list([H|T], NRows, ML),
    write(ML),nl.
    
histogram([]).

custom_print(L) :-
  maplist(term_to_atom, L, L1),
  atomic_list_concat(L1, L2),
  write(L2).

  
prepend(X,List,R) :-
    R = [X|List].
/*
horizontal
[2,4,3,4,1]

**
****
***
****
*

vertical
[2,4,3,4,1] 
-> 
[ 
[0,1,0,1,0], 
[0,1,1,1,0], 
[1,1,1,1,0], 
[1,1,1,1,1] 
]

 * *
 ***
****
*****
*/