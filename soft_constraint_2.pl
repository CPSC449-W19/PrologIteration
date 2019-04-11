% File:    soft_constraint_2.pl
% Author:  Isha Afzaal (30016250)
% Course:  CPSC 449 - Winter 2019 - Assignment #3 - Prolog
% Date:    April 10, 2019
% Info:    Given a list of solutions, enforce the second soft constraint (too-near penalties). 

% --- Clauses: ---

% --- Remove the last index of a list ---
remove_last([_], []).
remove_last([SolutionTask | Rest], [SolutionTask | RemoveLast]) :-
   remove_last(Rest, RemoveLast).

% --- Iterate through too-near penalties and tally candidate sum ---
toonearpen_getpen([], _, EndSum) :-
   EndSum is 0.
toonearpen_getpen([[Task1, Task2, Penalty] | RestOfPenalties], GivenSolution, Sum) :-
   toonearpen_getpen(RestOfPenalties, GivenSolution, NextSum),
   (check_for_pair_instance(Task1, Task2, GivenSolution, 0), not_in_the_rest(RestOfPenalties, Task1, Task2) -> Sum is Penalty+NextSum;
   Sum is 0+NextSum).

% --- Check if a given solution contains a given too-near pair ---
check_for_pair_instance([], [], _, _).
check_for_pair_instance(_, _, _, 8).
check_for_pair_instance(Task1, Task2, CheckSolution, CurrentIndex) :-
   nth0(CurrentIndex, CheckSolution, FirstElem),
   SecondInd is mod(CurrentIndex+1, 8),
   nth0(SecondInd, CheckSolution, SecondElem),
   ( (Task1 = FirstElem -> Task2 = SecondElem);
    ( NextCheck is CurrentIndex+1,
      check_for_pair_instance(Task1, Task2, CheckSolution, NextCheck) 
    ) 
   ).


% --- Apply too-near penalties to each solution ---
toonearpen_apply(TooNearPenalties, CandidateSolution, Result) :-
   toonearpen_getpen(TooNearPenalties, CandidateSolution, PenaltySum),
   nth1(9, CandidateSolution, OldPenaltyValue),
   NewPenaltyValue is OldPenaltyValue+PenaltySum,
   remove_last(CandidateSolution, UpdatedCandidate),
   append(UpdatedCandidate, [NewPenaltyValue], Result).


% --- Helper function ---
not_in_the_rest([], _, _).
not_in_the_rest([ [CheckTask1, CheckTask2, CheckPenalty]|TheRestOfPenalties ], Task1, Task2) :-
   ( (CheckTask1 \= Task1); (CheckTask2 \= Task2) ),
   CheckPenalty \= -1,
   not_in_the_rest(TheRestOfPenalties, Task1, Task2).

% --- Testing Driver: ---
toonear_penalty_test :-
   SolutionList = [['A','B','C','D','E','F','G','H',0],['A','B','F','G','D','E','C','H',0],['B','C','D','A','E','F','H','G',0],['D','B','A','C','E','F','G','H',0]],
   TooNearPenList = [['A','B',3], ['G','D',2], ['C','E',4], ['F','E',5], ['A','B',10]],
   maplist(toonearpen_apply(TooNearPenList), SolutionList, UpdatedSolutionList),
   write("The original solution list was: "), write(SolutionList), nl,
   write("The too-near penalty list was: "), write(TooNearPenList), nl,
   write("The UpdatedSolutionList is "), write(UpdatedSolutionList),
   nl, !.
