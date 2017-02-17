-module(beb).
-export([start/0]).

%%% Ziyang Liu(zl4214) and Hong Lu(hyl14)

start() ->
  receive  
    {bindPLsToBEB, PLs, PL} -> waitRB(PLs, PL)
  end.

waitRB(PLs, PL) ->
  receive
    {bindRB, RB} -> 
       RB ! {bindBEBToRB, self(), PLs},
       working(PLs, PL, RB)
  end.

working(PLs, PL, RB) ->
  receive
    {beb_broadcast, Sender,  M} ->
        [PL ! {pl_sent, {{hello, Sender, M}, PL}, Target} || Target <- PLs];
    {pl_deliver, M} ->
        RB ! {beb_deliver, M}
  end,
  working(PLs, PL, RB).
