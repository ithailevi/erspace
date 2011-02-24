
-record(reactor, {
 	status = functional,
	mode   = off,
	power  = 0.0,
	temp   = 29.0,
	output = 0.0
   }).


-record(power, {
		main  = [#reactor{},#reactor{},#reactor{},#reactor{}],
		aux  = [],
		mode = main, % or aux
		alloc = [ {engine, 50.0}, {ecosys, 10.0}]
	
	}).


