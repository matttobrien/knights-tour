knightPuzzle(Size, Solution) :-
    % call recursive predicate
    path([1, 1], Size, [[1,1]], Solution).

path([_, _], Size, Path, Solution) :-
    length(Path, L),
    % base case when length of path == size of grid
    L =:= (Size * Size),
    % unify solution with path
    Solution = Path.
    
path([X, Y], Size, Path, Solution) :-
    length(Path, L),
    L =< (Size * Size - 1),
    move([X, Y], Size, Path, [NextX, NextY]),
    append(Path, [[NextX, NextY]], NewPath),
    path([NextX, NextY], Size, NewPath, Solution).

move([X, Y], Size, Path, [NextX, NextY]) :-
    % find valid move with lowest number of onward moves (Warnsdorff's rule)
    setof(
        (Num, NewX, NewY), (
              possibleMoves([X, Y], Size, Path, [NewX, NewY]),
              numberOfMovesFromThere([NewX, NewY], Size, [(NewX, NewY) | Path], Num)
                           ), [(_, NextX, NextY)|_]).
    
possibleMoves([X, Y], Size, Path, [NextX, NextY]) :-
    % brute force
    possibleMove([X, Y], [NextX, NextY]),
    % ensure move is valid on the grid
    NextX >= 1,
    NextX =< Size,
    NextY >= 1,
    NextY =< Size,
    % check if move has already been made
    \+ member([NextX, NextY], Path).

% all possible moves for a knight from [X, Y]
possibleMove([X, Y], [NewX, NewY]) :-
    NewX is X - 1, NewY is Y - 2;
    NewX is X - 1, NewY is Y + 2;
    NewX is X + 1, NewY is Y - 2;
    NewX is X + 1, NewY is Y + 2;
    NewX is X - 2, NewY is Y - 1; 
    NewX is X - 2, NewY is Y + 1;
    NewX is X + 2, NewY is Y - 1;
    NewX is X + 2, NewY is Y + 1.

numberOfMovesFromThere([X, Y], Size, Path, Num) :-
    % find all possible moves from [X, Y]
    findall(_, possibleMoves([X, Y], Size, Path, [_, _]), List),
    length(List, Num).
    
% check if X is a member of list
member(X,[X|_]). 
member(X,[_|R]) :- member(X,R).

% append/3
append([], L, L).
append([H|T], L, [H|R]) :-
    append(T, L, R).

% length/2
length([ ], 0).
length([_|T], I) :- 
    length(T, J), I is J + 1.