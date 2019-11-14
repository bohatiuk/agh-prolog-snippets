% procedures on lists that use accumulator, will be prefixed with 'a' 
% (more efficient, less prologish)

% member of a list
% member of a list is its head or a member of tail
mem(X, [X|_]).
mem(X, [_|T]) :-
    mem(X, T).

% \+ (not provable)
% not(G) :- call(G), !, fail.
% not(_).
disjoint(L1, L2) :-
	\+ (mem(X, L1), mem(X, L2)).

len([], 0).
len([_|T], R) :-
    trace,
    len(T, TR),
    R is TR + 1.

% typical step for accumulator based procedure (reduce/fold)
% if stop condition is true, write accumulated value to result variable
% this is typical "tail-recursive procedure", because end value is being assigned at the end of 
% recursion call stack
len_acc([], A, A).
len_acc([_|T], R, A) :-
    TA is A + 1,
    len_acc(T, R, TA).

% to hide accumulator variable, facade is used
alen(L, R) :-
    trace,
    len_acc(L, R, 0).

ith(1, [H|_], H).
ith(I, [_|T], R) :- 
    TI is I - 1,
    ith(TI, T, R).
    
% other functional patterns:

% map

map_first_to_second(X, Y) :-
    string_lower(X, Y).

% e. map(['P','r','o','L','o','g'], X).
% X = ["p", "r", "o", "l", "o", "g"]
map([], []).
map([H1|T1], [H2|T2]) :-
    map_first_to_second(H1, H2),
    map(T1, T2).

% filter

satisfies_condition(X) :- 
    X >= 0. 

filter([], []).
% if H holds, add it to result
filter([H|T1], [H|T2]) :-
    satisfies_condition(H), 
    filter(T1, T2).
% else ignore
filter([H|T1], T2) :-
    \+ satisfies_condition(H),
    filter(T1, T2).

% concatanate two lists, (append/3 in prolog)
conc([], L, L).
conc([X|T1], L2, [X|TR]) :-
	conc(T1, L2, TR).

% adds elements to list 
% add(4, [1, 2, 3], R) -> R = [4, 1, 2, 3] or [1, 4, 2, 3] or .. [1, 2, 3, 4]  
add(X, L, [X|L]). % front insert to list L
add(X, [H|T], [H|RT]) :-
    add(X, T, RT).

% ! (cut atom) tells prolog, that its leftwords goals are 
% the only success branches in the search tree
% so after first successful unification of R, search tree will be punned
%
% prolog won’t try alternatives for:
% literals left to the cut
% nor the clause in which the cut is found
% cut evaluates to true
add_front(X, L, R) :-
    add(X, L, R), !. 

add_front_normal(X, L, [X|L]).

add_ith(1, X, L, [X|L]).
add_ith(I, X, [H|T], [H|RT]) :-
    TI is I - 1,
    add_ith(TI, X, T, RT).

% delete first occurence of X in list L = [X|T]
del(X, [X|T], T).
del(X, [H|T], [H|TR]) :-
    del(X, T, TR).

% delete all occurences of X
del_all(_, [], []).
del_all(X, [X|T], R) :-
    del_all(X, T, R).
del_all(X, [H|T], [H|RT]) :-
    X \= H,
    del_all(X, T, RT).


split(L, S1, S2) :-
    append(S1, S2, L).

% prefix of a list
pref(X, L) :-
    append(X, _, L).

% suffix of a list
suff(X, L) :-
    append(_, X, L).

ordered([_]). % every 1 element list is ordered
ordered([H1, H2|T]) :-
    H1 =< H2,
    ordered([H2|T]).

% true if first list contains seconds list (as contiguous members) 
contains([_|_], []).
% sublists of list are prefixes of all suffixes
contains(L, R) :-
  	suff(Sx, L),
  	pref(R, Sx),
  	R \= [].

% or:
% contains(L, R) :-
%     conc([_, R, _], L).

% thrue if first list contains elements of second list with respect to order of 
% of this elements in second list
sublist([], []).
sublist([H|T1], [H|T2]):-
    sublist(T1, T2).
sublist([_|T], L):-
    sublist(T, L).

% divide list into 2 lists of (almost) equals sizes
bisect([], [], []).
bisect([H], [H], []). % first list will always be bigger if original list is of odd size
bisect([H1, H2 |T], [H1|R1], [H2|R2]) :-
    bisect(T, R1, R2).

subset([], _).
subset([H|T], L) :-
  	mem(H, L),
	del(H, L, TL),
	subset(T, TL).

sum([], 0).
sum([H|T], R) :-
    sum(T, TR),
    R is TR + H.

% generate all sublists of L, 
% such that sum of that lists are equal to S
% ex. subsum([1, 2, 3, 5, 4, 6, 10], 10, R).
% R = [1, 2, 3, 4]
% R = [1, 3, 6]
% R = [1, 4, 5]
% R = [2, 3, 5]
% R = [4, 6]
% R = [10]
subsum(L, S, R) :-
	subset(R, L),
	ordered(R), % sum([1,2]) = sum([2,1])
	sum(R, S).

reverse([], []).
reverse([H|T], R) :-
    reverse(T, RT),
    append(RT, [H], R).

reverse_acc([], L, L).
reverse_acc([H|T], R, A) :-
    reverse_acc(T, R, [H|A]).

areverse(L, R) :-
    reverse_acc(L, R, []).

% generate list of integers in inclusive range E..B
range(E, E, [E]) :- !.
range(B, E, [B|T]) :-
	B < E,
	N is B + 1,
	range(N, E, T).

palindrome(L) :-
    areverse(L, L).

% to premute a list, permute tail and add head to any position
permute([], []).
permute([H|T], R) :-
    permute(T, TR),
    add(H, TR, R).
    
% get flat list from nested list
% [[1, 2], [5, [6]]] -> [1, 2, 5, 6]
flatten([],[]).
flatten(X, [X]) :- \+ is_list(X).
flatten([H|T], R) :- flatten(H, FH), flatten(T, FT), append(FH, FT, R).

max([X], X).
max([H1, H2|T], R) :-
	H1 > H2, !, % this cut allows not to check if H1 <= H2 in next clause
	max([H1|T], R).
max([_, H2|T], R) :-
	max([H2|T], R).

max_acc([], A, A).
max_acc([H|T], R, A) :-
    H >= A, !, 
    max_acc(T, R, H).
max_acc([_|T], R, A) :-
    max_acc(T, R, A).

maxa(L, R) :-
    max_acc(L, R, 0).

min([X], X).
min([H1, H2|T], R) :-
	H2 > H1, !, % this cut allows not to check if H1 <= H2 in next clause
	min([H1|T], R).
min([_, H2|T], R) :-
	min([H2|T], R). % only evaluated if first condition in clause above it false 

min_acc([], A, A).
min_acc([H|T], R, A) :-
    A >= H, !, 
    min_acc(T, R, H).
min_acc([_|T], R, A) :-
    min_acc(T, R, A).
    
mina(L, R) :-
    maxa(L, M), 
    min_acc(L, R, M).


% generates from a list L, list R, such that
% R is a list of pairs [first_min, first_max, second_min, second_max] 
% ex. minmax([6,1,2,3,9,8,7,12], R)
% R = [1, 12, 2, 9, 3, 8, 6, 7]
minmax([], []) :- !.
minmax(R, [Min|MaxMin]) :-
	min(R, Min),
	del(Min, R, L),
	maxmin(L, MaxMin).

maxmin([],[]) :- !.
maxmin(R, [Max|MinMax]) :-
	max(R, Max),
	del(Max, R, L),
	minmax(L, MinMax).

% difference lists

is_empty_diff(L-T) :- L == T.

length_diff([H|T]-E, R) :- 
    \+ is_empty_diff([H|T]-E),
    length_diff(T-E, TR), 
    R is TR + 1.

add_diff(L1-E1,E1-E2,L1-E2).

member_diff(X, [X|T]-E) :- \+ is_empty_diff([X|T]-E).
member_diff(X, [H|T]-E) :-
    X \= H,
	\+ is_empty_diff([H|T]-E),
    member_diff(X, T-E).

% dictionary 

means(0, zero).
means(1, one).
means(2, two).

translate([], []).
translate([H|T], [M|RT]) :-
    means(H, M),
    translate(T, RT).

