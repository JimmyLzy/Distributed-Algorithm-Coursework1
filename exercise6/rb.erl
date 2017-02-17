-module(rb).
-export([start/0]).

%%% Ziyang Liu(zl4214) and Hong Lu(hyl14)

start() ->
  receive 
    {bindBEBToRB, BEB, PLs} -> wait(BEB, PLs)
  end.

wait(BEB, PLs) ->
  receive
    {bindApp, App} -> 
      App ! {bind, self(), PLs}, working(BEB, App, [])
  end.

% If the message received is in the list of Delivered messages,
% then the process will drop the message. Otherwise it will
% forward the message to App and broadcast the message to BEB
% unit.

working(BEB, App, Delivered) ->
  receive 
    {rb_broadcast, Sender, M} -> 
       BEB ! {beb_broadcast, Sender, M}, 
       working(BEB, App, Delivered);
    {beb_deliver, {M, Sender}} ->
      case lists:member(M, Delivered) of
         true -> working(BEB, App, Delivered);
         false -> 
           App ! {rb_deliver, {M, Sender}},
           BEB ! {beb_broadcast, {M, Sender}},
           working(BEB, App, Delivered ++ [M])
      end
  end.
