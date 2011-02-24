-module(engine).
-export([handle_engine_cmd/2,update_engine/1]).
-include("spacecraft.hrl").


handle_turbine_cmd(start, _Args,S) ->
	E = S#spacecraft.engine,
	E#engine{ turbines = [ T#turbine { mode = on} || T <- E#engine.turbines ]}.

handle_engine_cmd(["status" | _Args],S) ->
	#spacecraft{ engine = #engine{ turbines = [T1,_T2,_T3,_T4] } } = S,
	io:format("engine: ~s~n",[T1#turbine.mode]),
	S#spacecraft.engine;

handle_engine_cmd([DirectiveFor, "turbine" | Args],S) ->
	handle_turbine_cmd(list_to_atom(DirectiveFor),Args,S).

update_engine(S) ->
	Engine = S#spacecraft.engine,
	#engine{torque = Engine#engine.torque+1}.


