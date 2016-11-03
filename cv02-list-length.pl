%
% @author: Nguyen Viet Bach
% @description: Calculates a list's size
% @usage: to show a list's size
% ?- sizeof([a,b,c], N)
% returns N = 3
%

sizeof([],0).
sizeof([_|T],N) :- 
    sizeof(T,N1),
    N is N1+1.
