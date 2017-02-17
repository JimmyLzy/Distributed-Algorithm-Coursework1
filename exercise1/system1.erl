-module(system1).
-export([start/0]).

%%% Ziyang Liu(zl4214) and Hong Lu(hyl14)

start() ->
  N = 5,
  Processes = createProcesses(N),
  [bindProcesses(Target, Processes) || Target <- Processes],
  [sendMessage(Target, 1000, 3000) || Target <- Processes].

createProcesses(N) -> 
  [spawn(process, start, []) || _ <- lists:seq(1, N)].

bindProcesses(Target, Processes) ->
  Target ! {bind, Processes}.
  
sendMessage(Target, Max_messages, Timeout) ->
  Target ! {task1, start, Max_messages, Timeout}.
