-module(pingpong). 

-export([start/0, ping/2, pong/0]). 

ping(0, Pong_PID) -> 
	Pong_PID ! finished, 
	io:format("ping finished ~n", []);

ping(N, Pong_PID) -> 
	% self returns pid of process that called it 
	Pong_PID ! {ping, self()}, 
	receive 
		pong -> 
			io:format("Ping received pong ~n", []) 
	end, 
	ping(N-1, Pong_PID). 

pong() -> 
	% recieve construct waits for messages from input queue and will pattern match
	receive 
		finished -> 
			io:format("Pong finished~n", []); 
		{ping, Ping_PID} -> 
			io:format("Pong received ping~n", []), 
			% ! sending a process 
			% PID ! Message
			% Send message to PID 
			Ping_PID ! pong, 
			pong()
	end. 

start() -> 
	Pong_PID = spawn(pingpong, pong, []), 
	spawn(pingpong, ping, [3, Pong_PID]). 
