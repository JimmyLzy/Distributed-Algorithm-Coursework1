-module(app3).
-export([start/0]).

%%% Ziyang Liu(zl4214) and Hong Lu(hyl14)

start() -> 
  receive 
    {bind, BEB, PLs} -> bind(PLs, BEB)
  end.

% Once process is binded, a sentMap and a receivedMap with all zero count
% are created. Also the process will start a timer which sends suspend
% after Timeout. Then the process starts receiving and broadcasting
% messages.
bind(Binded, BEB) ->

  receive
    {beb_deliver, {task1, start, Max_Messages, Timeout}} -> 
      Temp = [{Process, 0} || Process <- Binded],
      SentMap = maps:from_list(Temp),
      ReceivedMap = SentMap,
      timer:send_after(Timeout, self(), {suspend}),
      receivingNbroadcasting(Binded, Max_Messages, SentMap, ReceivedMap, BEB)
  end.

% If Max_Messages is intially 0, the Max_Messages will be keep at 0.
% Otherwise, it will decrease by 1 when broacasting a message to all
% processes. Note it will reduce from 1 to -1 to distinguish the
% difference between the state of Max_Message is initially 0.
% When the process recieves a hello messages, it will update its
% receivedMap. If the process receives a suspend message,
% it will print all the receivedMap and SentMap of all the processes.
% After receiving the message, after Wait time, the app will
% send a beb_broadcast request with Max_Message and pid to all the binded
% processes and then update its sentMap. If the Wait is 0, then the
% process will check if the message queue is empty. If wait is infinity,
% the app will stop sending beb_broadcast request.

receivingNbroadcasting(B, Max_Messages, SentMap, ReceivedMap, BEB) ->
  if Max_Messages == -1 ->
       Wait = infinity;
     true -> 
       Wait = 0
  end,
  receive
      {beb_deliver, {hello, From, _M}} ->
        I = maps:get(From, ReceivedMap),
        I1 = I + 1,
        NewReceivedMap = maps:update(From, I1, ReceivedMap),
        receivingNbroadcasting(B, Max_Messages, SentMap, NewReceivedMap, BEB);
      {suspend} -> printMaps([], B, SentMap, ReceivedMap)
  after Wait ->
      BEB ! {beb_broadcast, Max_Messages},
      NewSentMap = updateSentMap(B, SentMap, Max_Messages),
      if Max_Messages == 1 -> NewMax = - 1;
         Max_Messages == 0 -> NewMax = 0;
         true -> NewMax = Max_Messages - 1
      end,
      receivingNbroadcasting(B, NewMax, NewSentMap, ReceivedMap, BEB)
  end.

% Send to all the process a message with pid and Max_Message
% and update its sentMap.
updateSentMap([], SentMap, _Max_Messages) -> SentMap;
updateSentMap(Ps, SentMap, Max_Messages) ->
   [P | Rest] = Ps,
   J = maps:get(P, SentMap),
   J1 = J + 1,
   NewSentMap = maps:update(P, J1, SentMap),
   updateSentMap(Rest, NewSentMap, Max_Messages).

% Print the process pid and its sentMap and receivedMap.
printMaps(Output, [], _SentMap, _ReceivedMap) ->
  io:format("~p: ~p~n", [self(), Output]);

printMaps(Output, Bs, SentMap, ReceivedMap) ->
  [P | Rest] = Bs,
  S = maps:get(P, SentMap),
  R = maps:get(P, ReceivedMap),
  Tuple = {S, R},
  NewOutput = [Tuple] ++ Output,
  printMaps(NewOutput, Rest, SentMap, ReceivedMap).  







  
