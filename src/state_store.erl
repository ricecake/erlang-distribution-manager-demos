-module(state_store).
-behaviour(dman_worker).
-define(SERVER, ?MODULE).

%% ------------------------------------------------------------------
%% API Function Exports
%% ------------------------------------------------------------------

-export([start_link/0]).

%% ------------------------------------------------------------------
%% gen_server Function Exports
%% ------------------------------------------------------------------

-export([init/1, handle_add/2, handle_list/2, handle_remove/2,
	 handle_status/2, handle_quorum_change/2, 
         terminate/2, code_change/3, handle_call/3, handle_cast/2, handle_info/2]).

%% ------------------------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------------------------

start_link() ->
    dman_worker:start_link(?MODULE, [], []).

%% ------------------------------------------------------------------
%% gen_server Function Definitions
%% ------------------------------------------------------------------

init([]) ->
    {ok, {dict:new(), dict:new()}}.

handle_add({Bucket, Key, Details}, {KeyDict, BucketDict})->
	NewKey    = dict:store(Key, Details, KeyDict),
	NewBucket = dict:append(Bucket, Key, BucketDict),
	State = {NewKey, NewBucket},
	io:format("~p~n",[State]),
	{ok, State}.
handle_remove(_,_)->ok.
handle_list(_,_)->ok.
handle_status(_,_)->ok.
handle_quorum_change(_,_)->ok.

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% ------------------------------------------------------------------
%% Internal Function Definitions
%% ------------------------------------------------------------------

