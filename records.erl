-module(records).
-compile(export_all).

-record(robot, {name, 
                type="industrial", 
                hobbies, 
                details=[]}).

first_robot() -> 
        c = #robot{name="neo", 
                type=handmade, 
                details=["powered by solar energy"]}.
