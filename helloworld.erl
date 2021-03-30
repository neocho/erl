% hello world program 
-module(helloworld).
-export([start/0]).

start() ->
    io:fwrite("helloo, word!\n").