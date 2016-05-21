%%%% project 2, CS 314, Spring, 2016.  Prof. Louis Steinberg [version 2]

%%%% simulates a deterministic or a non-deterministic finite state
%%%% automaton (but does not handle epsilon moves).

%%% ================ representations

%%% input character string is represented as a list of symbols, e.g., [a, b, a, c]

%%% A state is represented using the functor state, whuch takes 3 arguments:
%%%   - name, a symbol: the name of this state
%%%   - transition list: a list of transition structures
%%%   - accepting:  the symbol yes or no

%%% a transition structure is represented using the functor transition,
%%% which takes 2 arguments:
%%%  - character 
%%%  - name of resulting state.

%%% There is no special structure or functor for an fsa.  It is just represented as a list of state structures, the
%%% first state structure in the list is the starting state of the fsa

%%% e.g., this fsa:

%   ___  0			 ___   0
%  |   |	 	   1 	|   |
%  \->  even <----------------odd <- //
%           \   	      ^	 |    
%      	     \----------------|  | 1
%	   1                     V
% State even is the		 foo
%   start state
% Even and foo are
%   accepting states.
%
%%% is represented as follows:
%%%   [state(even, [transition(0, even), transition(1, odd)], yes),
%%%    state(odd,[transition(1, foo), transition(0, odd), transition(1, even)], no),
%%%    state(foo, [ ], yes)]

%%% ================ predicates

%%% state_struct(+Name,  +States, -State_struct)
%%%   Name is a state name,
%%%   States a list of state structures, and
%%%   State_Struct the state structure from States with name Name

% define state_struct here
state_struct(Name, States, state(Name, Transition, Accept)):- 
	member(state(Name, Transition, Accept), States).
 
%%% next_state_name(+State_struct, +Characters, -Next_name, -Next_chars)
%%% [version 2 - next line fixed]
%%% find (the name of) a next state to transition to 
%%%   State_struct is the current state,
%%%   Characters is the list of characters currently left in the input,
%%%   Next_name is the name of the next state, and Next_chars is the
%%%     remaining list of input chars

% define next_state_name here
next_state_name(state(_, Transition, _), [X|Y], NName, Y) :- 
	member(transition(X, NName), Transition).

% accepts(+State_struct, +Fsa, +Chars) true if Fsa accepts character
% string Chars when starting from the state represented by State_struct

% define accepts here
accepts(state(_, _, yes), _, [ ]).

accepts(state(Name, [State1 | Rest], Accept), FSA, [X|Y]):-
	next_state_name(state(Name, [State1 | Rest], Accept), [X|Y], NName, Y), 
	state_struct(NName, FSA, NStruct),
	accepts(NStruct, FSA, Y).
										  
%%% run(Fsa, Chars) Fsa is a list of state stuctures representing
%%% a Fsa (so that the first state in the list is the start state of
%%% the fsa), Chars is a list of symbols and numbers representing
%%% the input to the fsa.  run succeeds if and only if the fsa
%%% would accept the sequence of characters

run([State1 | States], Chars):- accepts(State1,[State1 | States], Chars).

% demo1 and demo2 demonstrate calls to run.  They each specify a
% automaton and allow you to run that automaton with different input
% strings, by calling, e.g., demo1([1, 0]).
%

% demo1 and demo2 are here to show you how to call your code.  They
% are NOT intended to provide sufficient test data for your code

% demo1 shows a deterministic finite state automaton.
% demo1([ ]) should return true, as should demo1([1,1]), demo1([0,1,1]),
%     demo1([1,1,0,0,1,0,1]), etc (any string with an even number of 1's)
%     demo1([1]) should return false, as should demo1([1,0,1,1]) as should any
%     string with an odd number of 1's
demo1(Chars):- run([state(even,[ transition(0, even),transition(1, odd)], yes),
                    state(odd,[transition(0, odd), transition(1, even)], no)],
		   Chars).

% demo2 shows non-determinism:  there are transitions from state odd
%    both to even and to other for the character 1.  both demo2([1,1,0]). and demo2([1,1,2]).
%    should return true.
demo2(Chars):- run([state(even,[ transition(0, even),transition(1, odd)], yes),
                    state(odd,[transition(1, even), transition(1, other), transition(0, odd)], no),
		    state(other,[transition(2, otherb)],no),
		    state(otherb,[  ], yes)],
		    		  Chars).