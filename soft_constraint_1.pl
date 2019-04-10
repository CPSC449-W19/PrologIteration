% File:    soft_constraint_1.pl
% Author:  Isha Afzaal (30016250)
% Course:  CPSC 449 - Winter 2019 - Assignment #3 - Prolog
% Date:    April 9, 2019
% Info:    Given a list of solutions, enforce the first soft constraint (machine penalties). 

% --- Clauses: ---
machpen_get_penalty([], [], _, _).
machpen_get_penalty(SolMach, SolTask, MachinePenalties, SolPenalty) :-
   nth1(SolMach, MachinePenalties, MachineRow),
   machpen_get_task(SolTask, TaskIndex),
   nth1(TaskIndex, MachineRow, Penalty),
   SolPenalty is Penalty.

machpen_get_task([]).
machpen_get_task(GivenTask, TaskIndex) :-
   (GivenTask = 'A') -> TaskIndex is 1;
   (GivenTask = 'B') -> TaskIndex is 2;
   (GivenTask = 'C') -> TaskIndex is 3;
   (GivenTask = 'D') -> TaskIndex is 4;
   (GivenTask = 'E') -> TaskIndex is 5;
   (GivenTask = 'F') -> TaskIndex is 6;
   (GivenTask = 'G') -> TaskIndex is 7;
   TaskIndex is 8.

machpen_get_candidate_penalty( [ Task1, Task2, Task3, Task4, Task5, Task6, Task7, Task8], MachinePenaltyList, PenaltyValue) :-
   machpen_get_penalty(1, Task1, MachinePenaltyList, Task1Penalty),
   machpen_get_penalty(2, Task2, MachinePenaltyList, Task2Penalty),
   machpen_get_penalty(3, Task3, MachinePenaltyList, Task3Penalty),
   machpen_get_penalty(4, Task4, MachinePenaltyList, Task4Penalty),
   machpen_get_penalty(5, Task5, MachinePenaltyList, Task5Penalty),
   machpen_get_penalty(6, Task6, MachinePenaltyList, Task6Penalty),
   machpen_get_penalty(7, Task7, MachinePenaltyList, Task7Penalty),
   machpen_get_penalty(8, Task8, MachinePenaltyList, Task8Penalty),
   PenaltyValue is Task1Penalty+Task2Penalty+Task3Penalty+Task4Penalty+Task5Penalty+Task6Penalty+Task7Penalty+Task8Penalty.

machpen_apply(MachPenList, CandidateSolution, Result) :-
   machpen_get_candidate_penalty(CandidateSolution, MachPenList, CandidatePenalty),
   append(CandidateSolution, [CandidatePenalty], Result).

% --- Delete this later ---
print_penalties([]).
print_penalties([CurrentSolution | TheRest]) :-
   nth1(9, CurrentSolution, CurrentPenalty),
   write("Solution: "), write(CurrentSolution),
   write("  Extracted Penalty: "), write(CurrentPenalty), nl,
   print_penalties(TheRest).
% --- End Delete ---

% --- Testing Driver: ---
machine_penalty_test :-
   SolutionList = [['A','B','C','D','E','F','G','H'],['A','B','F','G','D','E','C','H'],['B','C','D','A','E','F','H','G'],['D','B','A','C','E','F','G','H']],
   MachinePen = [ [1,1,1,1,1,1,1,1], [1,3,4,1,1,1,1,1], [1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1] ],
   maplist(machpen_apply(MachinePen), SolutionList, UpdatedSolutionList),
   write("The solution list was "), write(SolutionList), write("\nThe UpdatedSolutionList after applying the machine penalties is "),
   write(UpdatedSolutionList), nl,
   write("Accessing ninth element of each solution in UpdatedSolutionList: "), nl,
   print_penalties(UpdatedSolutionList).
