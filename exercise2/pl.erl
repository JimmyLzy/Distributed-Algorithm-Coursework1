-module(pl).
-export([start/0]).

%%% Ziyang Liu(zl4214) and Hong Lu(hyl14)

start() ->
  receive 
    {bindPLs, PLs} -> waitApp(PLs)
  end.

waitApp(PLs) ->
  receive
    {bindApp, App} -> 
       App ! {bindPLsToApp, PLs, self()},
       working(PLs, App)
  end.

working(PLs, App) ->
  
  receive
    {pl_deliver, Message} -> App ! Message;
    {pl_sent, Message, Target} ->
       Target ! {pl_deliver, Message}
  end,
  working(PLs, App).
