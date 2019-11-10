% list operations

% length

len([], 0).

% each recursion call new intemediate "X" variables created
% and when recursion stops, program will backtrack to them
len([_|T], R) :-
    len(T, X),
    R is X + 1.

% here recursion stops,
% result is computated here, at the "tail"
lenacc([], A, A).

lenacc([_|T], R, A) :-
    NewA is A + 1,
    lenacc(T, R, NewA).

alen([], 0).

alen([_|T], R) :-
    lenacc(T, R, 1).

% append

append([], [H|T], [H|T]).

% in each recursion call result is list with head H and
% result of appending T1 to L2
append([H|T1], [H2|T2], [H|T3]) :-
    append(T1, [H2|T2], T3)/*, trace*/.

% append traverses first list, second list is appended once to result
% always pass shortest list as first argument
% this way we swap order in resulting list
append_optimized(L1, L2, R) :-
    alen(L1, R1),
    alen(L2, R2),
    (R1 < R2,
    append(L1, L2, R) ;
    append(L2, L1, R)).

split(L, R1, R2) :-
    append(R1, R2, L).

% prefix
% list L1 is a prefix of L2 if there is some list 
% such that L1 appended with this list gives L2
prefix(L1, L2) :-
    append(L1, _, L2).
suffix(L1, L2) :-
    append(_, L1, L2).

% sublists are prefixes of suffixes
sublist(L, R) :-
    suffix(S, L),
    prefix(R, S).


% reverse list 
% list can be traversed from head to tale,
% reversing list allows tail-head traversal

reverse([], []).

reverse([H|T], R) :-
    reverse(T, RT),
    append(RT, [H], R).

reverseacc([], L, L).

reverseacc([H|T], R, A) :-
    reverseacc(T, R, [H|A]).

areverse([H|T], R) :-
    reverseacc(T, R, [H]).


