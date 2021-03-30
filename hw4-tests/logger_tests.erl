% $Id: logger_tests.erl,v 1.3 2015/03/12 13:50:59 leavens Exp leavens $
-module(logger_tests).
-import(logger,[start/0]).
-import(testing,[dotests/2,eqTest/3]).
-export([main/0,logThenFetch/2,log/2,fetch/1]).
main() -> 
    compile:file(logger),
    dotests("logger_tests $Revision: 1.3 $", tests()).
tests() ->
    L1 = logger:start(),
    L2 = logger:start(),
    [eqTest(fetch(L1),"==",[]),
     eqTest(fetch(L2),"==",[]),
     eqTest(logThenFetch(L1,[starting,middle,ending]),"==",[starting,middle,ending]),
     eqTest(logThenFetch(L2,[start,between,last]),"==",[start,between,last]),
     eqTest(logThenFetch(L1,[final]),"==",[starting,middle,ending,final]),
     eqTest(logThenFetch(L1,[really]),"==",[starting,middle,ending,final,really]),
     eqTest(logThenFetch(L2,[ultimate]),"==",[start,between,last,ultimate]),
     eqTest(fetch(L1),"==",[starting,middle,ending,final,really])
    ].
% helpers for testing (client functions), NOT for you to implement
logThenFetch(Logger, []) ->
    fetch(Logger);
logThenFetch(Logger, [Entry|Entries]) ->
    log(Logger, Entry),
    logThenFetch(Logger, Entries).
log(Logger, Entry) ->
    Logger ! {self(), log, Entry},
    receive {Logger, logged} -> logged end.
fetch(Logger) ->
    Logger ! {self(), fetch},
    receive {Logger, log_is, Entries} -> Entries end.
