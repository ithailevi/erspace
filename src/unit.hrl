-include_lib("eunit/include/eunit.hrl").
engine_start_turbine_should_set_turbines_mode_to_on_test() ->
	S = #spacecraft{},
	N = handle_cmd("engine start turbine",S),
	#spacecraft{engine = #engine{ turbines = Turbines } } = N,
	[ ?assertEqual(T#turbine.mode,on) || T <- Turbines].

engine_status_should_print_status_test() ->
	S = #spacecraft{},
	_N = handle_cmd("engine status",S).

