-module(concat).
-compile(export_all).

-spec concat(Lists :: [[T]]) -> [T].
concat([]) -> [];
concat([Front|Back]) -> Front ++ concat(Back).
    
