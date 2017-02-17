-module(pl3).
-export([start/1]).

%%% Ziyang Liu(zl4214) and Hong Lu(hyl14)

start(Reliability) ->
  receive 
    {bindPLs, PLs} -> waitBEB(PLs, Reliability)
  end.

waitBEB(PLs, Reliability) ->
  receive
    {bindBEB, BEB} -> 
       BEB ! {bindPLsToBEB, PLs, self()},
       working(PLs, BEB, Reliability)
  end.

% We generate a random integer number called decision from 1 to 100. 
% We then compare this variable with Reliability. If Reliability is 
% bigger or equal to Decision, pl deliver the received message to
% other pls. Otherwise, pl drop the message sending request.

working(PLs, BEB, Reliability) ->
  
  Decision = random:uniform(100),
  receive
    {deliver, Message} -> BEB ! {pl_deliver, Message};
    {pl_sent, Message, Target} ->
       if Decision =< Reliability ->
         Target ! {deliver, Message};
         true -> working(PLs, BEB, Reliability)
       end
  end,
  working(PLs, BEB, Reliability).
