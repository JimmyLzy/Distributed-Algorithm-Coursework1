-module(process30).
-export([start/1]).

%%% Ziyang Liu(zl4214) and Hong Lu(hyl14)

start(System3) ->
  Reliability = 0,
  PL = spawn(pl3, start, [Reliability]),
  App = spawn(app3, start, []),
  BEB = spawn(beb, start, []),
  PL ! {bindBEB, BEB},
  BEB ! {bindApp, App},
  System3 ! {hello, pid, PL}.
