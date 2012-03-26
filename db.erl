-module(db).
-author("Konrad Gadek").

-export([new/0, destroy/1, write/3, delete/2, read/2, match/2]).

new() ->
    [].

destroy(_DbRef) ->
    true.

write(Key, Element, [{Key, _Val}|Tail]) ->
    [{Key, Element} | Tail];
write(Key, Element, [Head|Tail]) ->
    [Head|write(Key, Element, Tail)];
write(Key, Element, []) ->
    [{Key, Element}].


delete(Key, [{Key,_Val}|Tail]) ->
    Tail;
delete(Key, [Head|Tail]) ->
    [Head|delete(Key, Tail)];
delete(_,[]) ->
    [].


match(Element, DbRef) ->
    match([], Element, DbRef).

match(Acc, _Element, []) ->
    Acc;
match(Acc, Element, [{Key, Element}|Tail]) ->
    match([Key|Acc], Element, Tail);
match(Acc, Element, [_|Tail]) ->
    match(Acc, Element, Tail).


read(Key, [{Key, Value}|_Tail]) ->
    {ok, Value};
read(Key, [_|Tail]) ->
    read(Key, Tail);
read(_, []) ->
    {error, instance}.
