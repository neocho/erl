-module(substaddr). 
-export([helper/3, substaddr/3, hasGroupMembers/3, checker/3]). 
-include("salesdata.hrl"). 
-import(string,[equal/2]). 
-import(salesdata, [store/2, group/2]).

-spec checker(salesdata:salesdata(), string(), string()) -> salesdata:salesdata().
checker(X, New, Old) -> 
    if 
        is_record(X, group) == true -> 
            Result = [checker(Y, New, Old) || Y <- X#group.members], 
            X#group{gname=X#group.gname,members=Result};
        true -> 
            AddressName = X#store.address,
            
            Checker = equal(Old, AddressName),
            
            if 
                Checker -> 
                    X#store{address=New, amounts=X#store.amounts};
                true ->
                    X#store{address=AddressName, amounts=X#store.amounts}  
            end
    end.



-spec hasGroupMembers(list(), string(), string()) -> list().
hasGroupMembers(MemberList, New, Old) -> 
    [checker(X, New, Old) || X <- MemberList].
            
  

-spec helper(salesdata:salesdata(), string(), string()) -> salesdata:salesdata().
helper(SalesData, New, Old) -> 
    if 
        % if salesData is a group 
        is_record(SalesData, group) == true ->             
            GroupMembers = SalesData#group.members,
            MembersLength = length(GroupMembers),
                        
            % no members in a group, then return same group
            if 
                MembersLength == 0 -> 
                    SalesData;
                true -> 
                    % pass to helper function hasGroupMembers
                    Result = hasGroupMembers(GroupMembers, New, Old),
                    SalesData#group{gname=SalesData#group.gname,members=Result}
            end;
            
        true -> 
            % if salesData is a store             
            AddressName = SalesData#store.address,            
            Checker = equal(Old, AddressName),
            % check that given old address is the same as the sales data address
            
            if 
                Checker -> 
                    SalesData#store{address=New, amounts=SalesData#store.amounts};
                true ->
                    SalesData#store{address=AddressName, amounts=SalesData#store.amounts} 
            end
    end.

 
-spec substaddr(salesdata:salesdata(), string(), string()) -> salesdata:salesdata().
substaddr(SalesData, New, Old) ->
    helper(SalesData, New, Old). 

   
