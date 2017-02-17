-module(pl3).
-export([start/0]).

%%% Ziyang Liu(zl4214) and Hong Lu(hyl14)

start() ->
  receive 
    {bindPLs, PLs} -> waitBEB(PLs)
  end.

waitBEB(PLs) ->
  receive
    {bindBEB, BEB} -> 
       BEB ! {bindPLsToBEB, PLs, self()},
       working(PLs, BEB)
  end.

working(PLs, BEB) ->
  
  receive
    {deliver, Message} -> BEB ! {pl_deliver, Message};
    {pl_sent, Message, Target} ->
       Target ! {deliver, Message}
  end,
  working(PLs, BEB).
