% 4-queens
solution(C1,C2,C3,C4) :-
    
    col(C1),
    col(C2), \+ cap(2,C2,1,C1),
    col(C3), \+ cap(3,C3,1,C1), \+ cap(3,C3,2,C2),
    col(C4), \+ cap(4,C4,1,C1), \+ cap(4,C4,2,C2), \+ cap(4,C4,3,C3).

    % columns
    col(1). col(2). col(3). col(4).

    % cap(R1,C1,R2,C2): a queen on (R1,C1) can capture one on (R2,C2).
    cap(R,_,R,_). 
    cap(_,C,_,C). 
    cap(R1,C1,R2,C2) :- R1-C1 =:= R2-C2. % left diag
    cap(R1,C1,R2,C2) :- R1+C1 =:= R2+C2. % right diag


trace_solution(C1, C2, C3, C4) :-
    trace,
    solution(C1,C2,C3,C4).