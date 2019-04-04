% File:    hard_constraint_2.pl
% Author:  Isha Afzaal (30016250)
% Course:  CPSC 449 - Winter 2019 - Assignment #3 - Prolog
% Date:    April 2, 2019
% Info:    Given a list of solutions, enforce the second hard constraint (forbidden machine: any assignment that assigns
%		     a given task t to the indicated machine m is invalid). Create a new list of solutions that only includes solutions that pass 
%		     the forbidden machine criteria (i.e. create new solutions list by process of elimination).

% --- Clauses: ---

% Goal of Hard Constraint 2: For a given solution, the goal succeeds if and only if the assignment does not contain any given forbidden pair
hard_constraint_2_goal([], _).
hard_constraint_2_goal([[Mach | Task] | RestOfPairs], CandidateSolution) :-
   nth1(Mach, CandidateSolution, Elem),
   Task \= [Elem],
   hard_constraint_2_goal(RestOfPairs, CandidateSolution).


% --- Testing Driver: ---
% hard_constraint_2_test contains how to use the forbidden machine functionality
hard_constraint_2_test :-
   SolutionList = [['A','B','C','D','E','F','G','H'],['A','B','F','G','D','E','C','H'],['B','C','D','A','E','F','H','G'],['D','B','A','C','E','F','G','H']],
   ForbiddenList = [[1,'A'],[2,'B']],
   include(hard_constraint_2_goal(ForbiddenList), SolutionList, TheResult),
   write("The original solutions list was "),
   write(SolutionList),
   write(" and the forbidden machine list was "),
   write(ForbiddenList),
   write(" and the resulting filtered solutions are "),
   write(TheResult),
   nl.