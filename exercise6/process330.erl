-module(process330).
-export([start/1]).

%%% Ziyang Liu(zl4214) and Hong Lu(hyl14)

start(System3) ->
  Reliability = 30,
  PL = spawn(pl3, start, [Reliability]),
  App = spawn(app3, start, []),
  BEB = spawn(beb, start, []),
  RB = spawn(rb, start, []),

  PL ! {bindBEB, BEB},
  BEB ! {bindRB, RB},
  RB ! {bindApp, App},
  System3 ! {hello, pid, PL}.
