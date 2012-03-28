-module(dbe).
-author("Konrad Gadek").
-include_lib("stdlib/include/ms_transform.hrl").

-export([new/0, destroy/1, write/3, delete/2, read/2, match/2]).

new() ->
    ets:new(?MODULE, [set]).

destroy(_DbRef) ->
    ets:delete(?MODULE),
    ok.

write(Key, Element, DbRef) ->
    ets:insert(DbRef, {Key, Element}),
    DbRef.

delete(Key, DbRef) ->
    ets:delete(DbRef, Key).

match(Element, DbRef) ->
    ets:select(DbRef, ets:fun2ms(fun({K, V}) when V == Element -> K end)).

read(Key, DbRef) ->
%    case ets:select(DbRef, ets:fun2ms(fun({K, V}) when K == Key -> V end)) of
%	[] ->
%	    {error, instance};
%	[F] ->
%	    {ok, F}
%    end.
    ets:lookup(DbRef, Key).
