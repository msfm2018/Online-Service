-module(client_handle).

-behaviour(gen_server).
-include("common.hrl").
-compile(export_all).
-define(SERVER, ?MODULE).

-record(state, {
  is_websocket = false,
  websocket_binary = <<>>,
  data_list = [],
  call_back,
  socket
}).

-define(WEBSOCKET_CONNECT_STATE, 1).
-define(WEBSOCKET_CONNECTED_STATE, 2).


start(Option, Socket) ->
  gen_server:start(?MODULE, [Option, Socket], []).


pack_websocket_data(Data) ->
  Len = iolist_size(Data),
  BinLen = payload_length_to_binary(Len),
  [<< 1:1, 0:3, 2:4, 0:1, BinLen/bits>>, Data].


 %% 发送文本给Client
 pack_websocket_text_data( Data) ->
     Len = iolist_size(Data),
     BinLen = payload_length_to_binary(Len),
      [<< 1:1, 0:3, 1:4, 0:1, BinLen/bits >>, Data].




init([#t_tcp_sup_options{is_websocket = IsWebsocket, call_back = CallBack}, Socket]) ->
  inet:setopts(Socket, [{active, once}]),
  CallBack(Socket, {init}),
  {ok, #state{is_websocket = ?IF(IsWebsocket =:= false, false, ?WEBSOCKET_CONNECT_STATE), call_back = CallBack, socket = Socket}, ?CONNECTION_FIRST_DATA_TIME}.


handle_call(_Request, _From, State) ->
  {reply, ok, State}.


handle_cast(_Request, State) ->
  {noreply, State}.


handle_info({inet_reply, _, ok}, State) ->
  {noreply, State, ?HEART_BREAK_TIME};
handle_info({inet_reply, _S, _Error}, State) ->  % 主要面向用户，转发时调用其他socket发送，出现发送失败等，繁忙所以马上stop
  {stop, tcp_send_error, State};

%%client handle
handle_info({tcp, Socket, Data}, State=#state{websocket_binary = WebsocketBinary, socket=Socket}) ->
  inet:setopts(Socket, [{active, once}]),
  case State#state.is_websocket of
    false ->ok;

    _ ->  %% websocket
      websocket_handle_data(State#state{websocket_binary = <<WebsocketBinary/binary, Data/binary>>})
  end;

%wc handle
handle_info(Info, State=#state{socket = Socket, call_back = CallBack}) ->% handle wc data
  case CallBack(Socket, Info) of
    stop -> {stop, normal, State};
    _ -> {noreply, State, ?HEART_BREAK_TIME}
  end.


terminate(Reason, #state{socket=Socket, call_back = CallBack}) ->
  CallBack(Socket, {terminate, Reason}),
  catch gen_tcp:close(Socket),
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
%% websocket 先处理第一条数据  发握手
websocket_handle_data(#state{is_websocket = ?WEBSOCKET_CONNECT_STATE, socket = Socket, websocket_binary = FirstData} = State) ->
  Data = binary_to_list(FirstData),
  Key = list_to_binary(lists:last(string:tokens(hd(lists:filter(fun(S) -> lists:prefix("Sec-WebSocket-Key:", S) end, string:tokens(Data, "\r\n"))), ": "))),
  Sha1 = crypto:hash(sha,[Key, <<"258EAFA5-E914-47DA-95CA-C5AB0DC85B11">>]),
  Base64 = base64:encode(Sha1),
  Handshake = [
    <<"HTTP/1.1 101 Switching Protocols\r\n">>,
    <<"Upgrade: websocket\r\n">>,
    <<"Connection: Upgrade\r\n">>,
    <<"Sec-WebSocket-Accept: ">>, Base64, <<"\r\n">>,
    <<"\r\n">>
  ],
  gen_tcp:send(Socket, Handshake),
  {noreply, State#state{is_websocket = ?WEBSOCKET_CONNECTED_STATE, websocket_binary = <<>>}, ?HEART_BREAK_TIME};

websocket_handle_data(#state{is_websocket = ?WEBSOCKET_CONNECTED_STATE,websocket_binary = Binary, call_back = CallBack, socket = Socket} = State) ->
%%  utils:log(["Callback",CallBack]),
  case Binary of
    <<_:9, 126:7, Len:16, MaskKey:32, BinData:Len/binary, LastBinary/binary>> ->
      Bin = websocket_unmask(BinData, MaskKey, <<>>),
      case CallBack(Socket, Bin) of
        stop ->
          {stop, normal, State};
        _ ->
          websocket_handle_data(State#state{websocket_binary = LastBinary})
      end;
    <<_:9, 127:7, Len:64, MaskKey:32, BinData:Len/binary, LastBinary/binary>> ->
      Bin = websocket_unmask(BinData, MaskKey, <<>>),
      case CallBack(Socket, Bin) of
        stop ->
          {stop, normal, State};
        _ ->
          websocket_handle_data(State#state{websocket_binary = LastBinary})
      end;
    <<_:9, Len:7, MaskKey:32, BinData:Len/binary, LastBinary/binary>> ->
      Bin = websocket_unmask(BinData, MaskKey, <<>>),
      case CallBack(Socket, Bin) of
        stop ->
          {stop, normal, State};
        _ ->
          websocket_handle_data(State#state{websocket_binary = LastBinary})
      end;
    _ ->
      {noreply, State, ?HEART_BREAK_TIME}
  end.


websocket_unmask(<<>>, _, Unmasked) ->
  Unmasked;
websocket_unmask(<< O:32, Rest/bits >>, MaskKey, Acc) ->
  T = O bxor MaskKey,
  websocket_unmask(Rest, MaskKey, << Acc/binary, T:32 >>);

websocket_unmask(<< O:24 >>, MaskKey, Acc) ->
  << MaskKey2:24, _:8 >> = << MaskKey:32 >>,
  T = O bxor MaskKey2,
  << Acc/binary, T:24 >>;
websocket_unmask(<< O:16 >>, MaskKey, Acc) ->
  << MaskKey2:16, _:16 >> = << MaskKey:32 >>,
  T = O bxor MaskKey2,
  << Acc/binary, T:16 >>;
websocket_unmask(<< O:8 >>, MaskKey, Acc) ->
  << MaskKey2:8, _:24 >> = << MaskKey:32 >>,
  T = O bxor MaskKey2,
  << Acc/binary, T:8 >>.

payload_length_to_binary(N) ->
  case N of
    N when N =< 125 -> << N:7 >>;
    N when N =< 16#ffff -> << 126:7, N:16 >>;
    N when N =< 16#7fffffffffffffff -> << 127:7, N:64 >>
  end.




%http://book.51cto.com/art/201403/432187.htm
%  JS操作websocket接收的二进制，安全性能有保障，已经过一年实践考验：
%
%
%  [javascript] view plain copy
%  ws.onmessage = function(evt) {
%      if(typeof(evt.data)=="string"){
%          textHandler(JSON.parse(evt.data));
%      }else{
%          var reader = new FileReader();
%          reader.onload = function(evt){
%              if(evt.target.readyState == FileReader.DONE){
%                  var data = new Uint8Array(evt.target.result);
%                  handler(data);
%              }
%          }
%          reader.readAsArrayBuffer(evt.data);
%      }
%  };
%
%  [html] view plain copy
%  function handler(data){
%      switch(data[0]){
%      case 1:
%          getCard(data[1]);
%          break;
%
%  ...
%  JS操作websocket接收的图片，今天刚写的，也是用filereader实现。
%
%  [html] view plain copy
%  ws.onmessage = function(evt) {
%      if(typeof(evt.data)=="string"){
%          //textHandler(JSON.parse(evt.data));
%      }else{
%    var reader = new FileReader();
%          reader.onload = function(evt){
%              if(evt.target.readyState == FileReader.DONE){
%                  var url = evt.target.result;
%      alert(url);
%                  var img = document.getElementById("imgDiv");
%      img.innerHTML = "<img src = "+url+" />";
%              }
%          }
%          reader.readAsDataURL(evt.data);
%      }
%  };