%%% 负责处理所有tcp相关
-module(t_tcp_sup).

-behaviour(supervisor).
-include("common.hrl").
-compile(export_all).

start_child(Sup, #t_tcp_sup_options {t_tcp_sup_name = Name} = Options) ->
supervisor:start_child(Sup, {t_tcp_sup, {t_tcp_sup, start_link, [Options]}, transient, infinity, supervisor, []}).

start_link(T_tcp_sup_options) ->
  supervisor:start_link({local, t_tcp_sup}, ?MODULE, [T_tcp_sup_options]).

init([#t_tcp_sup_options{t_client_sup_name = Client_Name, t_accept_sup_name = Accept_Name, t_listen_server_name = Listen_Name} = T_tcp_options]) ->
  {ok,
    {
      {one_for_one, 3, 10},
      [
        {Accept_Name, {t_accept_sup, start_link, [T_tcp_options]}, transient, infinity, supervisor, [t_accept_sup]},
        {Listen_Name, {t_listen_server, start_link, [T_tcp_options]}, transient, 1000, worker, [t_listen_server]}

      ]
    }
  }.

