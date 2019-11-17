factorial(1, 1). 
factorial(N, R) :-
    N > 1, 
    TN is N - 1,
    factorial(TN, TR), 
    X is N * TR.

fibonacci(1,1) :- !.
fibonacci(2,2) :- !.
fibonacci(X, R) :-
    X > 2,
    A is X - 1,
    fibonacci(A, RA),
    B is X - 2,
    fibonacci(B, RB),
    R is RA + RB.