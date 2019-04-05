% File:    hard_constraint_3.pl
% Author:  Isha Afzaal (30016250)
% Course:  CPSC 449 - Winter 2019 - Assignment #3 - Prolog
% Date:    April 2, 2019
% Info:    Given a list of solutions, enforce the third hard constraint (too-near tasks: any assignment that assigns
%		     given tasks t1 and t2 to adjacent machines is invalid). Create a new list of solutions that only includes solutions that pass 
%		     the too-near tasks criteria (i.e. create new solutions list by process of elimination).
% Consulted sources:
%          Sarkar, Salauddin. "How to merge lists in PROLOG?" StackOverflow. Website URL: https://stackoverflow.com/questions/15926034/how-to-merge-lists-in-prolog/15926279/

% --- Clauses: ---

% Concatenate two given lists and unify into the third argument
new_list([],List,List).
new_list([Head | Tail], List, [Head | Left]) :-
   new_list(Tail, List, Left).

% Goal of Hard Constraint 3: For a given solution, the goal succeeds if and only if the assignment does not contain any adjacent (task1, task2) pairs
hard_constraint_3_goal([], _).
hard_constraint_3_goal([TooNearPair | RestOfPairs], CandidateSolution) :-
   hard_constraint_3_find_pair(TooNearPair, CandidateSolution, 0),
   hard_constraint_3_goal(RestOfPairs, CandidateSolution).

hard_constraint_3_find_pair([], _, _).
hard_constraint_3_find_pair(_, _, 8).
hard_constraint_3_find_pair([Task1 | Task2], Candidate, Ind) :-
   nth0(Ind, Candidate, Elem),
   SecondInd is mod(Ind+1, 8),
   nth0(SecondInd, Candidate, SecondElem),
   (([Task1] \= [Elem]); ([Task1] = [Elem], Task2 \= [SecondElem])),
   NextCheck is Ind+1,
   new_list([Task1], Task2, PassList),
   hard_constraint_3_find_pair(PassList, Candidate, NextCheck).


% --- Testing Driver: ---
% hard_constraint_3_test contains how to use the forbidden machine functionality
hard_constraint_3_test :-
   SolutionList = [['A','B','C','D','E','F','G','H'],['A','B','F','G','D','E','C','H'],['B','C','D','A','E','F','H','G'],['D','B','A','C','E','F','G','H']],
   TooNearList = [['A','C'],['A','B']],
   include(hard_constraint_3_goal(TooNearList), SolutionList, TheResult),
   write("The original solutions list was "),
   write(SolutionList),
   write(" and the too-near task list was "),
   write(TooNearList),
   write(" and the Result was "),
   write(TheResult),
   nl.