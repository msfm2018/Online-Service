%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. 一月 2016 16:14
%%%-------------------------------------------------------------------
-author("Administrator").
-ifndef(SERVER_S2S_MSG_HRL).
-define(SERVER_S2S_MSG_HRL, true).

%%%%%%% 服务器群之间协议定义

-define(M_SERVER_ERROR, 0:16).                   %% 错误
-define(M_SERVER_ASK_GATEWAY, 1:16).             %% 获取可连接的网关信息
-define(M_SERVER_RETURN_GATEWAY, 2:16).          %% 返回可连接的网关信息
-define(M_SERVER_TCP_CONNECTED_REGISTER, 5:16).  %% 服务器之间tcp连接建立之后  第一条消息注册
-define(M_SERVER_PLAYER_LOGIN_MSG, 6:16).        %% 用户未登录时的消息打包
-define(M_SERVER_PLAYER_MSG, 7:16).              %% 用户消息打包
-define(M_SERVER_PLAYER_EXIT,8:16).              %% 用户退出消息
-define(M_SERVER_RETURN_EXIT_MSG, 9:16).         %% 返回给gc网关用户需要退出的消息 一般都是带的错误码消息
-define(M_SERVER_RETURN_REPLACE_MSG, 10:16).     %% 返回给gc网关用户被顶掉的消息
-define(M_SERVER_RETURN_MSG, 11:16).             %% 返回给gc消息
-define(M_SERVER_RETURN_LOGIN_MSG, 12:16).       %% 返回给gc网关用户登陆成功消息
-define(M_SERVER_RETURN_REGISTER_MSG, 13:16).    %% 返回给gc网关用户注册成功消息

-define(M_SERVER_RETURN_CAMPID_MSG,15:16).
%%%%%%% 服务器之间协议定义 end



-endif.