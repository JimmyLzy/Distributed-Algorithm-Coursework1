-module(beb).
-export([start/0]).

%%% Ziyang Liu(zl4214) and Hong Lu(hyl14)

start() ->
  receive  
    {bindPLsToBEB, PLs, PL} -> waitApp(PLs, PL)
  end.

waitApp(PLs, PL) ->
  receive
    {bindApp, App} -> 
       App ! {bind, self(), PLs},
       working(PLs, PL, App)
  end.

working(PLs, PL, App) ->

  receive
    {beb_broadcast, M} ->
        [PL ! {pl_sent, {hello, PL, M}, Target} || Target <- PLs];
    {pl_deliver, M} ->
        App ! {beb_deliver, M}
  end,
  working(PLs, PL, App).
