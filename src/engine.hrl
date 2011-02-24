-record(turbine, {
 	status = functional, % or failed, damaged, repair, replace 
	mode   = off,
	power = 100.0,
	rpm    = 0.0,
	temp   = 0.0
	}).

-record(radiator, {
	status = functional,
	mode = off,
	power = 100.0,
	pressure = 0.0,
	temp = 0.0
	}).


-record(engine, {
	turbines  = [#turbine{},#turbine{},#turbine{},#turbine{}],
	radiators = [#radiator{},#radiator{},#radiator{},#radiator{}],
	mode = cruise, % powermode, jump, each req diff tpower
	tpower = 40.0, % power percentile threshold
	power = 120.0,
	inertialStatus = functional,
	inertialMode = off,
	inertialTemp = 20.0,
	inertialCapacity = 100.0,
	torque=0}).

