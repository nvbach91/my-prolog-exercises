name('Matrix Calculator').
title('Simple matrix calculator in Prolog').
version('1.0').
author('Nguyen Viet Bach', 'nvbach91@outlook.com').

% Zadání
% 1) Sčítání,
% 2) Odečítání,
% 3) Násobení konstantou, 
% 4) Násobení 2 matic
% 5) Transpozice,
% 6) Výpočet determinantu max 3x3 matice.
% 7) Nalezení stopy.
% 8) Nalezení hlaví diagonály.

% Usage: 
% ?- [[1,2,3],[1,2,3],[1,2,3]] plus       [[1,2,3],[1,2,3],[1,2,3]].
% ?- [[1,2,3],[1,2,3],[1,2,3]] minus      [[1,2,3],[1,2,3],[1,2,3]].
% ?- [[4,6,8],[2,4,6],[4,6,8]] multiply_c 2.
% ?- [[4,6,8],[2,4,6],[4,6,8]] divide_c   2.
% ?- [[1,2,3],[1,2,3],[1,2,3]] multiply   [[1,2,3],[1,2,3],[1,2,3]].
% ?- transpose [[1,2,3],[1,2,3],[1,2,3]].
% ?- determinant [[1,2],[-2,3]].
% ?- trace [[4,6,8],[2,4,6],[4,6,8]].
% ?- A=[[1,2,3],[2,3,4],[3,4,5]],
%    B=[[2,3,4],[3,4,5],[4,5,6]],
%    C=[[3,4,5],[4,5,6],[5,6,7]],
%    Const=5, 
% 	 
%    A plus  	 B,
%    A minus 	 B,
%    A multiply_c Const,
%    A divide_c   Const,
%    A multiply   B,
%    transpose A,
%    determinant A,
%    trace A,
%    diagonal A,
%    
% 	 calc(A*B          ,RA),
%    calc(A+B          ,RB),
%    calc(A-B          ,RC),
%    calc(A*B          ,RD),
%    calc(A/Const      ,RE),
%    calc(A*Const      ,RF),
%    calc(Const*A      ,RG),
%                       
%    calc(A+B+C        ,RH),
%    calc(A+B-C        ,RI),
%    calc(A+B*C        ,RJ),
%    calc(A+B*Const    ,RK),
%    calc(A+Const*B    ,RL),
%    calc(A+B/Const    ,RM),
%                       
%    calc(A-B+C        ,RN),
%    calc(A-B-C        ,RO),
%    calc(A-B*C        ,RP),
%    calc(A-B*Const    ,RQ),
%    calc(A-Const*B    ,RR),
%    calc(A-B/Const    ,RS),
%                       
%    calc(A*B+C        ,RT),
%    calc(A*B-C        ,RU),
%    calc(A*B*C        ,RV),
%    calc(A*B*Const    ,RW),
%    calc(A*Const*B    ,RX),
%    calc(A*B/Const    ,RY),
%                       
%    calc(A/Const+B    ,RZ),
%    calc(A/Const-B    ,R1),
%    calc(A/Const*B    ,R2),
%    calc(A/Const/Const,R3).


% include constraint logic programming over finite domains
% used transpose/2
:- use_module(library(clpfd)).

% check if a list contains only numeric matrices
% isNumericMatrices(+Term)
isNumericMatrices([]) :- !, fail.
isNumericMatrices([H]) :- isNumericMatrix(H).
isNumericMatrices([H|T]) :-
    isNumericMatrix(H),
    isNumericMatrices(T).

% check if the matrix (list of lists) contains only numbers
% isNumericMatrix(+Term)
isNumericMatrix(LL) :- var(LL), !, fail.
isNumericMatrix([]) :- !, fail.
isNumericMatrix([[H]]) :- number(H).
isNumericMatrix([[H|T]]) :- number(H), isNumericList(T).
isNumericMatrix([H|T]) :- isNumericList(H), isNumericMatrix(T).

% check if the list contains only numbers
% isNumericList(+Term)
isNumericList(L) :- var(L), !, fail.
isNumericList([]) :- !, fail.
isNumericList([H]) :- number(H).
isNumericList([H|T]) :- number(H), isNumericList(T).

% count the number of rows in the matrix
% nMatrixRows(+Matrix, -NumberOfRows)
nMatrixRows(A, R) :-
    length(A, R).

% count the number of columns in the matrix
% nMatrixCols(+Matrix, -NumberOfRows)
nMatrixCols([[]], 0).
nMatrixCols([[_]], 1).
nMatrixCols([H|T], C) :-
    length(H, C),
    nMatrixCols1(T, C).
nMatrixCols1([], _).
nMatrixCols1([H|T], L) :-
    length(H, C),
    L =:= C,
    nMatrixCols1(T, C).

% true if the matrix is square
% isSquareMatrix(+Matrix)
isSquareMatrix(A) :-
    nMatrixRows(A, NRows),
    nMatrixCols(A, NCols),
    NRows =:= NCols -> !;
    	writeln('Matrix is not square!'),fail.

% numericMultiply(+Number1, +Number2, -Product)
numericMultiply(X, Y, Z) :- Z is X * Y.
%%numericMultiply(X, Y, X*Y).

% numericDivide(+Number1, +Number2, -Quotient)
numericDivide(X, Y, Z) :- Z is X / Y.
%%numericDivide(X, Y, X/Y).

% sum all the numbers in this list
% sumList(+List, -Sum)
sumList([], 0).
sumList([S], S).
sumList([H1,H2|T], S) :-
    HS is H1 + H2,
    %%sumList([H1 + H2|T], S).
    sumList([HS|T], S).

% "pretty" print the matrix
% printMatrix(+Matrix)
printMatrix(A) :-
    writeln('Result ='),
    writeln('['),
    printMatrix1(A),
    writeln(']').
printMatrix1([]).
printMatrix1([H|T]) :- printList(H), printMatrix1(T).

% add indent to matrix rows
printList(A) :- write('  '), writeln(A).

/*
printList([]).
printList([H|T]) :-
    write(H),write(', '),
    printList(T).
*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% defining operators
:- op(500, yfx, [plus, minus]).
:- op(400, yfx, [multiply, multiply_c, divide_c]).
:- op(300, fx, [determinant, transpose, trace, diagonal]).

% computes A + B and print result to console
% plus(+MatrixA, +MatrixB)
plus(A, B) :-
    isNumericMatrices([A,B]),
    matrixAddition(A, B, S),
	printMatrix(S).    
plus(A, B) :-
    B = C plus D,
    matrixAddition(A, C, AC),
    plus(AC, D).
plus(A, D) :-
    A = B plus C,
    matrixAddition(B, C, BC),
    plus(BC, D).
plus(A, E) :-
    A = B plus C plus D,
    matrixAddition(B, C, BC),
    matrixAddition(BC, D, BCD),
    plus(BCD, E).
plus(A, F) :-
    A = B plus C plus D plus E,
    matrixAddition(B, C, BC),
    matrixAddition(BC, D, BCD),
    matrixAddition(BCD, E, BCDE),
    plus(BCDE, F).

% computes A - B and print result to console
% minus(+MatrixA, +MatrixB)
minus(A, B) :-
    isNumericMatrices([A,B]),
    matrixSubtraction(A, B, R),
    printMatrix(R).

% computes A * B and print result to console
% multiply(+MatrixA, +MatrixB)
multiply(A, B) :-
    isNumericMatrices([A,B]),
    matrixMultiplication(A, B, P),
    printMatrix(P).
    
% computes A * c and print result to console
% multiply_c(+MatrixA, +ConstantC)
multiply_c(A, C) :-
    isNumericMatrix(A),
	number(C),
    matrixMultiplicationByConstant(A, C, P),
    printMatrix(P).

% computes A / c and print result to console
% multiply_c(+MatrixA, +ConstantC)
divide_c(A, C) :-
    isNumericMatrix(A),
	number(C),
    matrixDivisionByConstant(A, C, Q),
    printMatrix(Q).

% transpose the matrix A to A^T and print result to console
% transpose(+MatrixA)
transpose(A) :-
    isNumericMatrix(A),
    matrixTransposition(A, AT),
    printMatrix(AT).

% computes determinant of matrix A and print result to console
% determinant_of(+MatrixA)
determinant(A) :-
    isSquareMatrix(A),
    isNumericMatrix(A),
    calculateMatrixDeterminant(A, D),
    write('Determinant = '),writeln(D).

% computes trace of matrix A and print result to console
% trace(+MatrixA)
trace(A) :-
    isSquareMatrix(A),
    isNumericMatrix(A),
    calculateTrace(A, T),
    write('Trace = '),writeln(T).

% shows the main diagonal members in the console
% diagonal(+MatrixA)
diagonal(A) :-
    isNumericMatrix(A),
    getDiagonal(A, D),
    write('Diagonal = '),writeln(D).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% defining some combinations of operators
calc(A+B, R) :-
    isNumericMatrices([A,B]),
    matrixAddition(A, B, R).

%--------------------------------------------------------------------------
calc(A-B, R) :-
    isNumericMatrices([A,B]),
    matrixSubtraction(A, B, R).

%--------------------------------------------------------------------------
calc(A*B, R) :-
    isNumericMatrices([A,B]),
    matrixMultiplication(A, B, R).

%--------------------------------------------------------------------------
calc(A/Const, R) :-
    isNumericMatrix(A),
    number(Const),
    matrixDivisionByConstant(A, Const, R).

%--------------------------------------------------------------------------
calc(A*Const, P) :-
    isNumericMatrix(A),
    number(Const),
    matrixMultiplicationByConstant(A, Const, P).
calc(Const*A, P) :-
    isNumericMatrix(A),
    number(Const),
    matrixMultiplicationByConstant(A, Const, P).

%--------------------------------------------------------------------------
calc(A+B+C, R) :-
    isNumericMatrices([A,B,C]),
    matrixAddition(A, B, AB),
    matrixAddition(AB, C, R).
calc(A+B-C, R) :-
    isNumericMatrices([A,B,C]),
    matrixAddition(A, B, AB),
    matrixSubtraction(AB, C, R).
calc(A+B*C, R) :-
    isNumericMatrices([A,B,C]),
    matrixMultiplication(B, C, BC),
    matrixAddition(A, BC, R).
calc(A+B*Const, R) :-
    isNumericMatrices([A,B]),
    number(Const),
    matrixMultiplicationByConstant(B, Const, BC),
    matrixAddition(A, BC, R).
calc(A+Const*B, R) :-
    isNumericMatrices([A,B]),
    number(Const),
    matrixMultiplicationByConstant(B, Const, BC),
    matrixAddition(A, BC, R).
calc(A+B/Const, R) :-
    isNumericMatrices([A,B]),
    number(Const),
    matrixDivisionByConstant(B, Const, BC),
    matrixAddition(A, BC, R).

%--------------------------------------------------------------------------
calc(A-B+C, R) :-
    isNumericMatrices([A,B,C]),
    matrixSubtraction(A, B, AB),
    matrixAddition(AB, C, R).
calc(A-B-C, R) :-
    isNumericMatrices([A,B,C]),
    matrixSubtraction(A, B, AB),
    matrixSubtraction(AB, C, R).
calc(A-B*C, R) :-
    isNumericMatrices([A,B,C]),
    matrixMultiplication(B, C, BC),
    matrixSubtraction(A, BC, R).
calc(A-B*Const, R) :-
    isNumericMatrices([A,B]),
    number(Const),
    matrixMultiplicationByConstant(B, Const, BC),
    matrixSubtraction(A, BC, R).
calc(A-Const*B, R) :-
    isNumericMatrices([A,B]),
    number(Const),
    matrixMultiplicationByConstant(B, Const, BC),
    matrixSubtraction(A, BC, R).
calc(A-B/Const, R) :-
    isNumericMatrices([A,B]),
    number(Const),
    matrixDivisionByConstant(B, Const, BC),
    matrixSubtraction(A, BC, R).

%--------------------------------------------------------------------------
calc(A*B+C, R) :-
    isNumericMatrices([A,B,C]),
    matrixMultiplication(A, B, AB),
    matrixAddition(AB, C, R).
calc(A*B-C, R) :-
    isNumericMatrices([A,B,C]),
    matrixMultiplication(A, B, AB),
    matrixSubtraction(AB, C, R).
calc(A*B*C, R) :-
    isNumericMatrices([A,B,C]),
    matrixMultiplication(B, C, BC),
    matrixMultiplication(A, BC, R).
calc(A*B*Const, R) :-
    isNumericMatrices([A,B]),
    number(Const),
    matrixMultiplication(A, B, AB),
    matrixMultiplicationByConstant(AB, Const, R).
calc(A*Const*B, R) :-
    isNumericMatrices([A,B]),
    number(Const),
    matrixMultiplicationByConstant(A, Const, AC),
    matrixSubtraction(AC, B, R).
calc(A*B/Const, R) :-
    isNumericMatrices([A,B]),
    number(Const),
    matrixMultiplication(A, B, AB),
    matrixDivisionByConstant(AB, Const, R).

%--------------------------------------------------------------------------
calc(A/Const+B, R) :-
    isNumericMatrices([A,B]),
    number(Const),
    matrixDivisionByConstant(A, Const, AC),
    matrixAddition(AC, B, R).
calc(A/Const-B, R) :-
    isNumericMatrices([A,B]),
    number(Const),
    matrixDivisionByConstant(A, Const, AC),
    matrixSubtraction(AC, B, R).
calc(A/Const*B, R) :-
    isNumericMatrices([A,B]),
    number(Const),
    matrixDivisionByConstant(A, Const, AC),
    matrixMultiplication(AC, B, R).

%--------------------------------------------------------------------------
calc(A/Const/Const1, R) :-
    isNumericMatrix(A),
    number(Const),
    number(Const1),
    matrixDivisionByConstant(A, Const, AC),
    matrixDivisionByConstant(AC, Const1, R).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% matrixAddition(+MatrixA, +MatrixB, -Sum)
matrixAddition(A, B, S) :- 
    % apply add function to all elements from list A and B to S
    % A and B must be of the same length
    % S will be the result of merging two matrices by the addition function
    maplist(maplist(add), A, B, S).
% add(+Number1, +Number2, -Sum)
add(X, Y, Z) :- Z is X + Y.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% matrixSubtraction(+MatrixA, +MatrixB, -Difference)
matrixSubtraction(A, B, D) :- 
    % apply subtract function to all elements from list A and B to S
    % A and B must be of the same length
    % S will be the result of merging two matrices by the subtract function
    maplist(maplist(mSubtract), A, B, D).
% subtract(+Number1, +Number2, -Difference)
mSubtract(X, Y, Z) :- Z is X - Y.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% matrixTransposition(+Matrix, -TransposedMatrix)
matrixTransposition(A, AT) :- 
    % using SWI-Prolog clpfd transpose...
    transpose(A, AT).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% matrixMultiplication(+MatrixA, +MatrixB, -Product)
matrixMultiplication(A, B, P) :-
    % matrix nRowsA x nColsA multiply nRowsB x nColsB
    % where nColsA equals nRowsB
    % makes new matrix of dimensions nRowsA x nColsB
    % transpose matrix B and compare list dimensions
    % i.e. 
    % 	3x2 mult 2x3 makes 3x3
    % 	3x2 mult 2x4 makes 3x4
    % 	
    % transpose matrix B 
    % to get dot products of row of matrix A and column of matrix B 
    transpose(B, BT),
    % apply dot product of each row
    maplist(mapDotProduct(BT), A, P).

% compute dot product of two vectors
mapDotProduct(BT, A, P) :- maplist(dotProduct(A), BT, P).
% dot product is the sum of all multiplied pairs of nums from two lists
% dotProduct(+List1, +List2, -DotProduct)
dotProduct(L1, L2, D) :-
    % create the list of products of pairs of numbers from List1 and List2
    maplist(numericMultiply, L1, L2, SL),
    sumList(SL, D).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% matrixMultiplicationByConstant(+Number1, +Constant, -Product)
matrixMultiplicationByConstant(A, C, P) :- 
    mmbc(A, C, P).
mmbc([], _, []).
mmbc([H|T], C, [HS|TS]) :-
    scalarProduct(H, C, HS),
    mmbc(T, C, TS).

% compute scalar product
% scalarProduct(+List, +Constant, -ScalarProduct)
scalarProduct([], _, []).
scalarProduct([H], C, [HS]) :- HS is C * H.
scalarProduct([H|T], C, [HS|TS]) :-
    HS is C * H,
    scalarProduct(T, C, TS).

% a much easier solution using maplist
%mmbcc(A,C,R) :-
%    maplist(maplist(multx(C)), A, R).
%multx(C, X, Y) :-
%    Y is C * X.
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% matrixMultiplicationByConstant(+Number1, +Constant, -Quotient)
matrixDivisionByConstant(A, C, Q) :- 
    mdbc(A, C, Q).
mdbc([], _, []).
mdbc([H|T], C, [HD|TD]) :-
    scalarQuotient(H, C, HD),
    mdbc(T, C, TD).

% compute scalar division
% scalarQuotient(+List, +Constant, -ScalarQuotient)
scalarQuotient([], _, []).
scalarQuotient([H], C, [HD]) :- HD is H / C.
scalarQuotient([H|T], C, [HD|TD]) :-
    HD is H / C,
    scalarQuotient(T, C, TD).

% a much easier solution using maplist
%mdbcc(A,C,R) :-
%   maplist(maplist(divx(C)), A, R).
%divx(C, X, Y) :-
%   Y is X/C.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

det([[]], _) :- !, fail.
det([[A11]], D) :- !, D = A11.
det([[A11,A12],[A21,A22]], D) :-
    A1122 is A11*A22,
    A2112 is A21*A12,
    D is A1122 - A2112.

det([[A11,A12,A13],[A21,A22,A23],[A31,A32,A33]], D) :-
	D is A11*(A22*A33-A23*A32)-A12*(A21*A33-A23*A31)+A13*(A21*A32-A22*A31).

% TODO:
% computing 4+x4+ matrix determinant using cofactor expansion
det([_|_], _) :- fail.

% calculateMatrixDeterminant(+MatrixA, -Determinant)
calculateMatrixDeterminant(A, D) :-
    det(A, D).
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% computes trace of given matrix
% trace is the sum of diagonal entries
% trace(+MatrixA, -Trace)
calculateTrace(A, T) :-
    getDiagonal(A, D),
    sumList(D, T).

getDiagonal(A, D) :-
    nMatrixRows(A, N),
    getDiagonal(A, 0, N, D).
getDiagonal(_, N, N, []).
getDiagonal([H|T], Start, N, [DH|DT]) :- 
    S1 is Start+1,
    getNthElem(S1, H, DH),
    getDiagonal(T, S1, N, DT).
    
getNthElem(1,[E|_],E).
getNthElem(N,[_|C],E) :- 
    N > 1, 
    N1 is N - 1, 
    getNthElem(N1,C,E).

test :-
    [[1,2,3],[1,2,3],[1,2,3]] plus       [[1,2,3],[1,2,3],[1,2,3]],
    [[1,2,3],[1,2,3],[1,2,3]] minus      [[1,2,3],[1,2,3],[1,2,3]],
    [[4,6,8],[2,4,6],[4,6,8]] multiply_c 2,
    [[4,6,8],[2,4,6],[4,6,8]] divide_c   2,
    [[1,2,3],[1,2,3],[1,2,3]] multiply   [[1,2,3],[1,2,3],[1,2,3]],
    transpose [[1,2,3],[1,2,3],[1,2,3]],
    determinant [[1,2],[-2,3]],
    diagonal [[4,6,8],[2,4,6],[4,6,8]],
    trace [[4,6,8],[2,4,6],[4,6,8]],
    
    A=[[1,2,3],[2,3,4],[3,4,5]],
    B=[[2,3,4],[3,4,5],[4,5,6]],
    C=[[3,4,5],[4,5,6],[5,6,7]],
    Const=5,
    
    A plus  	 B,
    A minus 	 B,
    A multiply_c Const,
    A divide_c   Const,
    A multiply   B,
    transpose A,
    determinant A,
    diagonal A,
    trace A,
    
	calc(A*B          ,_),
    calc(A+B          ,_),
    calc(A-B          ,_),
    calc(A*B          ,_),
    calc(A/Const      ,_),
    calc(A*Const      ,_),
    calc(Const*A      ,_),

    calc(A+B+C        ,_),
    calc(A+B-C        ,_),
    calc(A+B*C        ,_),
    calc(A+B*Const    ,_),
    calc(A+Const*B    ,_),
    calc(A+B/Const    ,_),

    calc(A-B+C        ,_),
    calc(A-B-C        ,_),
    calc(A-B*C        ,_),
    calc(A-B*Const    ,_),
    calc(A-Const*B    ,_),
    calc(A-B/Const    ,_),

    calc(A*B+C        ,_),
    calc(A*B-C        ,_),
    calc(A*B*C        ,_),
    calc(A*B*Const    ,_),
    calc(A*Const*B    ,_),
    calc(A*B/Const    ,_),

    calc(A/Const+B    ,_),
    calc(A/Const-B    ,_),
    calc(A/Const*B    ,_),
    calc(A/Const/Const,_).
