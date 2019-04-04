% File:    hard_constraint_1.pl
% Author:  Isha Afzaal (30016250)
% Course:  CPSC 449 - Winter 2019 - Assignment #3 - Prolog
% Date:    April 2, 2019
% Info:    Given a list of solutions, enforce the first hard constraint (forced partial assignment: any assignment that does not assign 
%		     a given task t to the indicated machine m is invalid). Create a new list of solutions that only includes solutions that pass 
%		     the forced partial assignment criteria (i.e. create new solutions list by process of elimination).
%
% Extra:   - Forced partial assignments will be given in the form of [[Int, Char]]
%		     - findall(Template, Goal, Bag) will return all the return values of the Goal given to it while unifying them to Bag
%		     - nth1(Ind, List, Elem) will bind the object at index Ind in list List to the variable Elem
%          - The include predicate is used for filtering: include(:Goal, +List1, ?List2) - Filter elements for which Goal succeeds. True if List2 contains
%            those elements Xi of List1 for which call(Goal, Xi) succeeds.
%
% Consulted the following sources:
%		   joel76. "Prolog, access specific member of list?" StackOverflow. URL: https://stackoverflow.com/questions/12939425/prolog-access-specific-member-of-list
%		   Pesto. "How do I find all solutions to a goal in Prolog?" StackOverflow. URL: https://stackoverflow.com/questions/1468150/how-do-i-find-all-solutions-to-a-goal-in-prolog
%		   dasblinkenlight. "Prolog-iterating through list." StackOverflow. URL: https://stackoverflow.com/questions/30800407/prolog-iterating-through-list
%		   Borla, Anthony. "Append the odd numbers from a given list to L2." SWI-Prolog. URL: http://swi-prolog.996271.n3.nabble.com/Append-the-odd-numbers-from-a-given-list-to-L2-td945.html/


% --- Clauses: ---

% Goal of Hard Constraint 1: For a given solution, the goal succeeds if and only if the assignment contains all given pairs in forced partial
hard_constraint_1_goal([], _).
hard_constraint_1_goal([[Mach | Task] | RestOfPairs], CandidateSolution) :-
   nth1(Mach, CandidateSolution, Elem),
   Task = [Elem],
   hard_constraint_1_goal(RestOfPairs, CandidateSolution).


% --- Testing Driver: ---
% hard_constraint_1_test contains how to use the forced partial assignment functionality
hard_constraint_1_test :-
   SolutionList = [['A','B','C','D','E','F','G','H'],['A','B','F','G','D','E','C','H'],['B','C','D','A','E','F','H','G'],['D','B','A','C','E','F','G','H']],
   ForcedList = [[1,'A'],[2,'B']],
   include(hard_constraint_1_goal(ForcedList), SolutionList, TheResult),
   write("The original solutions list was "),
   write(SolutionList),
   write(" and the forced partial assignment list was "),
   write(ForcedList),
   write(" and the resulting filtered solutions are "),
   write(TheResult),
   nl.