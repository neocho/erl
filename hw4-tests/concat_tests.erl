% $Id: concat_tests.erl,v 1.3 2015/03/12 13:50:59 leavens Exp leavens $
-module(concat_tests).
-import(testing,[dotests/2,eqTest/3]).
-export([main/0, tests/1]).
main() -> 
    compile:file(concat),
    dotests("concat_tests $Revision: 1.3 $", tests(fun concat:concat/1)).
-spec tests(CFun :: fun(([[T]]) -> [T])) -> testing:testCase([atom()]).
tests(CFun) ->
    [eqTest(CFun([]), "==", []),
     eqTest(CFun([[]]), "==", []),
     eqTest(CFun([[fee], [fie], [fo], [fum]]), "==", [fee, fie, fo, fum]),
     eqTest(CFun([[], [hmm], [], [okay]]), "==", [hmm, okay]),
     eqTest(CFun([[keep], [ancient, lands], [your, storied, pomp], [cries, she]]),
	    "==", [keep, ancient, lands, your, storied, pomp, cries, she]),
     eqTest(CFun([[four, score, nd, seven], [years, ago], [our, ancestors],
		  [brought, forth, on, this, continent], [a, new, nation]]),
	    "==", [four, score, nd, seven, years, ago, our, ancestors,
		   brought, forth, on, this, continent, a, new, nation]),
     eqTest(CFun([[[more],[nested]], [[than],[before]]]),
	    "==", [[more], [nested], [than], [before]])  
    ].
