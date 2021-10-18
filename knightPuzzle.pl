knightPuzzle(Size, Solution) :-
    % call recursive predicate
    path(Size, [1, 1], [[1,1]], Solution).

path(Size, [_, _], Path, Solution) :-
    length(Path, L),
    % base case when length of path == size of grid
    L =:= (Size * Size),
    % unify solution with path
    Solution = Path.
    
path(Size, [X, Y], Path, Solution) :-
    length(Path, L),
    % keep adding moves until length of path > size of gird - 1
    L =< (Size * Size - 1),
    move(Size, [X, Y], Path, [NextX, NextY]),
    % append new move to path
    append(Path, [[NextX, NextY]], NewPath),
    % recursive call
    path(Size, [NextX, NextY], NewPath, Solution).
    
move(Size, [X, Y], Path, [NextX, NextY]) :-
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
possibleMove([X, Y], [NextX, NextY]) :- NextX is X + 2, NextY is Y + 1.
possibleMove([X, Y], [NextX, NextY]) :- NextX is X + 1, NextY is Y + 2.
possibleMove([X, Y], [NextX, NextY]) :- NextX is X - 1, NextY is Y + 2.
possibleMove([X, Y], [NextX, NextY]) :- NextX is X - 2, NextY is Y + 1.
possibleMove([X, Y], [NextX, NextY]) :- NextX is X - 2, NextY is Y - 1.
possibleMove([X, Y], [NextX, NextY]) :- NextX is X - 1, NextY is Y + 2.
possibleMove([X, Y], [NextX, NextY]) :- NextX is X + 1, NextY is Y - 2.
possibleMove([X, Y], [NextX, NextY]) :- NextX is X + 2, NextY is Y - 1.

% check if X is a member of list
member(X,[X|_]). 
member(X,[_|R]) :- member(X,R).