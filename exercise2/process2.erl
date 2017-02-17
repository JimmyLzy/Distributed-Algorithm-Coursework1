-module(process2).
-export([start/1]).

%%% Ziyang Liu(zl4214) and Hong Lu(hyl14)

start(System2) ->
  PL = spawn(pl, start, []),
  App = spawn(app, start, []),
  PL ! {bindApp, App},
  System2 ! {hello, pid, PL}.
