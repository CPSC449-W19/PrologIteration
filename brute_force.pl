% File:    brute_force.pl
% Author:  Isha Afzaal (30016250)
% Course:  CPSC 449 - Winter 2019 - Assignment #3 - Prolog
% Date:    April 10, 2019
% Info:    Using brute force, narrow down and determine the best machine-task assignment for the given
%	       penalty lists (enforce hard constraints 1 - 3 and soft constraints 1 - 2).
% Usage: 

% --- Load Required Files ---
:- [permutations, hard_constraint_1, hard_constraint_2, hard_constraint_3, soft_constraint_1, soft_constraint_2].

% --- Clauses ---
brute_force_check_if_empty([]).

% Find the solution with the least penalty value
brute_force_find_min([], _, _).
brute_force_find_min([CandidateSolution | RestOfSolutions], AllPossibleSolutions, MinimumSolution) :-
   confirm_minimum(CandidateSolution, AllPossibleSolutions) -> MinimumSolution = CandidateSolution;
   brute_force_find_min(RestOfSolutions, AllPossibleSolutions, MinimumSolution).

% Compare the given solution to every single solution in the filtered solution list
confirm_minimum(_, []).
confirm_minimum(SuspectSolution, [CurrentCheck | RestOfChecks]) :-
   nth1(9, SuspectSolution, SuspectPenalty),
   nth1(9, CurrentCheck, CurrentPenalty),
   ( (SuspectPenalty = CurrentPenalty) ; (SuspectPenalty < CurrentPenalty) ),
   confirm_minimum(SuspectSolution, RestOfChecks).


% --- Driver ---
brute_force_apply(Forced, Forbidden, TooNear, Machines, TooNearPens, TheTrueSolution) :-
   permutations_init(MasterList),
   Forced = [[1,'A'],[2,'B'], [3,'C'], [4,'D'], [5,'E']],
   hard_constraint_1_apply(MasterList, Forced, InterResult1),
   Forbidden = [[6,'F'],[7,'G']],
   hard_constraint_2_apply(InterResult1, Forbidden, InterResult2),
   TooNear = [['F','G']],
   hard_constraint_3_apply(InterResult2, TooNear, InterResult3),
   Machines = [ [1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1] ],
   machine_penalty_apply(InterResult3, Machines, InterResult4),
   TooNearPens = [['F','H',30]],
   too_near_penalty_apply(InterResult4, TooNearPens, FilteredList),
   write("Completed all applications, the remaining solutions are "), write(FilteredList), nl,
   (brute_force_check_if_empty(FilteredList) ->
 	   write("No valid solution possible!\n")
    ; write("In the fail.\n"),
       brute_force_find_min(FilteredList, FilteredList, TheTrueSolution),
       write("Solution "), write(TheTrueSolution), nl
   ).