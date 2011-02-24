-module(game).
-export([liftoff/0]).%,test_fun/0]).
-include("spacecraft.hrl").
-import(power).
-import(engine).

update_ecosys(S) ->
	EcoSys = S#spacecraft.ecosys, 
	#ecosys{gh_temp = EcoSys#ecosys.gh_temp + 0.2}.

update_spacecraft(S) ->
	#spacecraft{power = power:update_power(S),
				engine = engine:update_engine(S),
				ecosys = update_ecosys(S)}.

% handle_generic_cmd(status, Args, S) ->
% 	io:format("engine status is fine...~n").

handle_admin_cmd(["status" | _Args],_S) ->
	io:format("POWER").

handle_unit_cmd(engine, Args, S)  -> 
	S#spacecraft{ engine = engine:handle_engine_cmd(Args,S) };
handle_unit_cmd(power, Args, S)   -> 
	S#spacecraft{ power = power:handle_power_cmd(Args,S) };
handle_unit_cmd(admin, Args, S)   -> 
	S#spacecraft{ admin = handle_admin_cmd(Args,S) }.

handle_cmd(Arguments,S) ->
	[ Unit | Args ] = string:tokens(Arguments," "),
	handle_unit_cmd(list_to_atom(Unit), Args,S).

spacecraft(Id,S,LastUpdate) ->
	receive
		{ command, LineToParse } ->
			io:format("parsing ~s~n",[LineToParse]),
			N = handle_cmd(LineToParse,S),
			spacecraft(Id,N,LastUpdate);

		{ kill } ->
			io:format("got kill message~n")

	after 1000 ->
		spacecraft(Id,update_spacecraft(S),LastUpdate)
	end.

liftoff() ->
	spawn(fun() -> spacecraft(1,#spacecraft{},now()) end).




-ifdef(TEST).
-include_lib("unit.hrl").
-include_lib("test_power.hrl").
-endif.






%sector() ->
%	receive
%		{ checkin, Id } ->
%			done;
%		{ checkout, Id } ->
%			done
%	end.


%generate_cmd_handlers() ->
%	[
%		{ engine, 
%			[
%				{ turbine, fun handle_turbine_cmd/3 },
%				{ radiator, fun handle_turbine_cmd/3 },
%				{ ext, fun handle_turbine_cmd/3 },
%				{ x , fun handle_generic_cmd/3 }
%			] 
%		},
%		{ power,  
%			[ 
%				{ reactor, fun handle_turbine_cmd/3 } 
%			] 
%		}
%	].

%test_fun() ->
%	X = " xx",
%	Test = fun() ->
%			io:format(Y)
%		   end,
%	Y = "zz",
%	Test().


%handle_cmd_2(Arguments,S) ->
%	Units = generate_cmd_handlers(),
%	[ Unit | Tail ] = string:tokens(Arguments," "),
%	{ _ , Modules } = lists:keyfind(list_to_atom(Unit),1,Units),
%	[ Directive | Params ] = Tail,
%	[ Which | Attrs ] = Params,
%	{ _ , ModuleHandler } = lists:keyfind(list_to_atom(Which),1,Modules),
%	N = ModuleHandler(Directive, Attrs,S),
%	N.


