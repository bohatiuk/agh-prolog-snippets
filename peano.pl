% peano numbers:
% zero (0 in N)
% s(zero) (1 in N) 
% ...

encode(zero, 0).

% encode(s(zero), 1).
% encode(s(s(zero)), 1).
% ...

encode(s(X), N) :-
    encode(X, TN),
    N is TN + 1.

% in peano arithmetic
% x + zero = x
% x + s(y) = s(x+y)


add(X, zero, X).

% add(X, s(Y), R) :-
%    add(X, Y, TR),
%    R = s(TR).
  
add(X, s(Y), s(R)) :- add(X, Y, R).

addn(N1, N2, R) :-
    encode(P1, N1),
    encode(P2, N2),
    add(P1, P2, PR),
    encode(PR, R).

sub(X, zero, X).
sub(X, s(Y), R) :- sub(X, Y, s(R)).

mul(_, zero, zero).
mul(X, s(Y), R) :- mul(X, Y, RM), add(RM, X, R).

%%%%%%%%%%%%%%%%%%%%

len(zero, 0).

len(s(X), R) :-
    len(X, TR),
    R is TR + 1.

greater_than(X, Y) :- len(X, LX), len(Y, LY), LX > LY.

divacc(X, _, R, A, C) :-
    greater_than(A, X),
    s(R) = C.

divacc(X, Y, R, A, C) :- 
    add(A, Y, RA),
	divacc(X, Y, R, RA, s(C)).
    
% assume X > Y
div(X, Y, R) :-
    divacc(X, Y, R, zero, 0).
    
    
    
    