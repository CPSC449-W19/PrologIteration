% Find all possible permutation combinations and store them within a list of lists
% Consulted the following sources:
%		False. "Permute into a list SWI-Prolog." StackOverflow, URL: https://stackoverflow.com/questions/8385423/permute-into-a-list-swi-prolog
%		CapelliC. "List Length in Prolog." StackOverflow, URL: https://stackoverflow.com/questions/19230594/list-length-in-prolog

% Facts:
list_length(0, []).

% Rules:
list_length(ListLength+1, [_|T]) :-
   list_length(ListLength, T).

permutations_getter(GivenList, Xs) :-
   bagof(X, permutation(GivenList, X), Xs).

% Following includes how to both generate the complete solutions master list, alongside debugging information
permutations_driver :-
   DefaultList = ['A','B','C','D','E','F','G','H'],
   permutations_getter(DefaultList, TheSolutions),
   list_length(X, TheSolutions), ListLength is X,
   write("The default list is: "), 
   write(DefaultList), 
   write(" the length of the master list is "), 
   write(ListLength), 
   write("; I will not print it out because it overflows the interactive compiler, though I have confirmed the contents of the master list."), 
   nl.