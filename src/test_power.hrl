power_start_main_should_set_reactor_mode_to_on_test() ->
	S = #spacecraft{},
	N = handle_cmd("power start main",S),
	#spacecraft{power = #power { main = Reactors } } = N,
	[ ?assertEqual(R#reactor.mode, on) || R <- Reactors ].

power_alloc_engine_100_should_provide_100_to_engine_test() ->
	S = #spacecraft{},
	N = handle_cmd("power alloc engine 100",S),
	#spacecraft { power = #power{ alloc = [{ engine, X }] }} = N,
	?assertEqual(X,100.0).

power_allocations_should_always_sum_100_test() ->
	done.
%after_60_seconds_from_start_reactors_temp_gt_100_test() ->
%				receive
%					none -> none
%				after 1000 ->
%						?assertEqual(1,1)
%				end.


power_stop_main_should_set_reactors_mode_to_off_test() ->
	S = handle_cmd("power shutdown main", #spacecraft{}),
	#spacecraft { power = #power { main = Reactors } } = S,
	[ ?assertEqual(R#reactor.mode, off) || R <- Reactors ].
	
	
