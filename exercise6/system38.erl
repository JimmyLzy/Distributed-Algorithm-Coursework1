-module(system38).
-export([start/0]).

%%% Ziyang Liu(zl4214) and Hong Lu(hyl14)

start() ->
  N = 5,
  _Processes = createProcesses(N),
  waitPLPid([], N).

waitPLPid(PLs, 0) ->
  [PL ! {bindPLs, PLs} || PL <- PLs],
  PL3 = lists:nth(3, PLs),
  [sendMessage(Target, 100000, 400000) || Target <- PLs, Target /= PL3],
  sendMessage(PL3, 20000, 400000);

waitPLPid(PLs, Remainder) ->
  receive 
    {hello, pid, PL} ->
       NewPLs = [PL] ++ PLs,
       waitPLPid(NewPLs, Remainder - 1)
  end.

createProcesses(N) -> 
  [spawn(process350, start, [self()]) || _ <- lists:seq(1, N)].

sendMessage(Target, Max_messages, Timeout) ->
  Target ! {deliver, {{task1, start, Max_messages, Timeout}, self()}}.
