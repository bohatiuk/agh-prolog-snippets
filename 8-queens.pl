% 8-queens
solution(C1,C2,C3,C4,C5,C6,C7,C8) :-
    col(C1),
    col(C2), \+ cap(2,C2,1,C1),
    col(C3), \+ cap(3,C3,1,C1), \+ cap(3,C3,2,C2),
    col(C4), \+ cap(4,C4,1,C1), \+ cap(4,C4,2,C2), \+ cap(4,C4,3,C3),
    col(C5), \+ cap(5,C5,1,C1), \+ cap(5,C5,2,C2), \+ cap(5,C5,3,C3),
    \+ cap(5,C5,4,C4),
    col(C6), \+ cap(6,C6,1,C1), \+ cap(6,C6,2,C2), \+ cap(6,C6,3,C3),
    \+ cap(6,C6,4,C4), \+ cap(6,C6,5,C5),
    col(C7), \+ cap(7,C7,1,C1), \+ cap(7,C7,2,C2), \+ cap(7,C7,3,C3),
    \+ cap(7,C7,4,C4), \+ cap(7,C7,5,C5), \+ cap(7,C7,6,C6),
    col(C8), \+ cap(8,C8,1,C1), \+ cap(8,C8,2,C2), \+ cap(8,C8,3,C3),
    \+ cap(8,C8,4,C4), \+ cap(8,C8,5,C5), \+ cap(8,C8,6,C6),
    \+ cap(8,C8,7,C7).

    % columns
    col(1). col(2). col(3). col(4). col(5). col(6). col(7). col(8).

    % cap(R1,C1,R2,C2): a queen on (R1,C1) can capture one on (R2,C2).
    cap(R,_,R,_). 
    cap(_,C,_,C). 
    cap(R1,C1,R2,C2) :- R1-C1 =:= R2-C2. % left diag
    cap(R1,C1,R2,C2) :- R1+C1 =:= R2+C2. % right diag
	