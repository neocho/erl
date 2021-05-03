-module(test).

-export([start/0, testFn/2]).

testFn(What, 0) -> 
	done;

testFn(What, Times) -> 
	io:format("~p~n", [What]), 
	testFn(What, Times-1).

start() -> 
	% Spawn returns a pid
	spawn(test, testFn, [hello, 3]),	
	spawn(test, testFn, [goodbye,4]).
