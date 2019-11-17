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

len(zero, 0).
len(s(X), R) :-
    len(X, TR),
    R is TR + 1.

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

div(X, Y, _) :- 
    less_than(X, Y), !. 
div(X, Y, s(R)) :-
    sub(X, Y, D), div(D, Y, R).
   

mod(X, Y, R) :- 
    less_than(X, Y), R = X, !.
mod(X, Y, R) :-
    sub(X, Y, D), mod(D, Y, R).

greater_than(X, Y) :- len(X, LX), len(Y, LY), LX > LY.

less_than(X, Y) :- len(X, LX), len(Y, LY), LX < LY.

eq(X, Y) :- len(X, L), len(Y, L).


    
    
    
    