-module(power).
-export([handle_power_cmd/2,update_power/1]).
-include("spacecraft.hrl").

update_power(S) ->
	S#spacecraft.power.

handle_main_power_cmd(shutdown, _Args, S) ->
	#spacecraft { power = Power } = S,
	#power { main = Reactors } = Power,
	Power#power { main = [ R#reactor { mode = off } || R <- Reactors] };

handle_main_power_cmd(start, _Args, S) ->
	Power = S#spacecraft.power,
	Reactors = Power#power.main,
	Power#power{ main = [ R#reactor { mode = on } || R <- Reactors] }.

handle_power_cmd(["alloc",Target,Percentile | Args],S) ->
	Power = S#spacecraft.power,
	Diff = 0,
	Temp100 = 0,
	Power#power { alloc = [ {engine,100.0} ] };
handle_power_cmd([DirectiveFor, "main" | Args],S) ->
	handle_main_power_cmd(list_to_atom(DirectiveFor), Args, S);
handle_power_cmd(["status" | _Args],_S) ->
	io:format("POWER").
